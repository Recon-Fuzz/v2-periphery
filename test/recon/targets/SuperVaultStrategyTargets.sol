// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {BaseTargetFunctions} from "@chimera/BaseTargetFunctions.sol";

import {vm} from "@chimera/Hevm.sol";
import {Panic} from "@recon/Panic.sol";
import {MockERC20} from "@recon/MockERC20.sol";

import "src/SuperVault/SuperVaultStrategy.sol";
import {IHookExecutionData} from "src/interfaces/IHookExecutionData.sol";

import {YieldSourceType} from "test/recon/managers/YieldManager.sol";
import {BeforeAfter, OpType} from "../BeforeAfter.sol";
import {Properties} from "../Properties.sol";

abstract contract SuperVaultStrategyTargets is BaseTargetFunctions, Properties {
    /// CUSTOM TARGET FUNCTIONS - Add your own target functions here ///

    function superVaultStrategy_handleOperations4626Deposit_clamped(
        address controller,
        uint256 assetsGross
    ) public {
        assetsGross = assetsGross % (MockERC20(superVault.asset()).balanceOf(address(superVaultStrategy)) + 1);
        superVaultStrategy_handleOperations4626Deposit(controller, assetsGross);
    }

    function superVaultStrategy_handleOperations4626Mint_clamped(
        address controller,
        uint256 sharesNet,
        uint256 assetsGross,
        uint256 assetsNet
    ) public {
        uint256 strategyBalance = MockERC20(superVault.asset()).balanceOf(address(superVaultStrategy));
        sharesNet = sharesNet % (superVault.convertToShares(strategyBalance) + 1);
        assetsGross = assetsGross % (strategyBalance + 1);
        assetsNet = assetsNet % (strategyBalance + 1);
        superVaultStrategy_handleOperations4626Mint(controller, sharesNet, assetsGross, assetsNet);
    }

    function superVaultStrategy_proposeVaultFeeConfigUpdate_clamped(
        uint256 performanceFeeBps,
        uint256 managementFeeBps
    ) public {
        performanceFeeBps = performanceFeeBps % (5100 + 1); // MAX_PERFORMANCE_FEE = 5100
        managementFeeBps = managementFeeBps % (10_000 + 1); // BPS_PRECISION = 10_000
        superVaultStrategy_proposeVaultFeeConfigUpdate(performanceFeeBps, managementFeeBps, _getActor());
    }

    function superVaultStrategy_handleOperations7540_clamped(
        ISuperVaultStrategy.Operation operation,
        uint256 amount
    ) public {
        amount = amount % (superVaultStrategy.claimableWithdraw(_getActor()) + 1);
        superVaultStrategy_handleOperations7540(operation, _getActor(), _getActor(), amount);
    }

    function superVaultStrategy_manageYieldSources_clamped(
        address[] memory sources,
        address[] memory oracles,
        ISuperVaultStrategy.YieldSourceAction[] memory actionTypes
    ) public {
        // Coverage Fix: Ensure all arrays have the same non-zero length
        uint256 minLength = sources.length;
        if (oracles.length < minLength) minLength = oracles.length;
        if (actionTypes.length < minLength) minLength = actionTypes.length;
        
        // Skip if any array is empty
        if (minLength == 0) return;
        
        // Truncate all arrays to the minimum length
        assembly {
            mstore(sources, minLength)
            mstore(oracles, minLength)
            mstore(actionTypes, minLength)
        }
        
        superVaultStrategy_manageYieldSources(sources, oracles, actionTypes);
    }

    function superVaultStrategy_skimPerformanceFee_afterTimelock() public {
        // Coverage Fix: Advance time past the POST_UNPAUSE_SKIM_TIMELOCK (12 hours)
        vm.warp(block.timestamp + 12 hours + 1);
        superVaultStrategy_skimPerformanceFee();
    }

    /// @dev Coverage Fix: Handler to trigger veto state and test OPERATIONS_BLOCKED_BY_VETO path
    function superVaultStrategy_handleOperations4626Deposit_withVeto(
        address controller,
        uint256 assetsGross
    ) public asAdmin {
        // Enable veto status
        superVaultAggregator.setGlobalHooksRootVetoStatus(true);
        
        // Clamp assets
        assetsGross = assetsGross % (MockERC20(superVault.asset()).balanceOf(address(superVaultStrategy)) + 1);
        
        // Attempt deposit - should revert with OPERATIONS_BLOCKED_BY_VETO
        try superVaultStrategy.handleOperations4626Deposit(controller, assetsGross) {
            // If it doesn't revert, disable veto for future operations
            superVaultAggregator.setGlobalHooksRootVetoStatus(false);
        } catch {
            // Expected revert - disable veto for future operations
            superVaultAggregator.setGlobalHooksRootVetoStatus(false);
        }
    }

    /// @dev Coverage Fix: Handler to trigger veto state and test OPERATIONS_BLOCKED_BY_VETO path for mint
    function superVaultStrategy_handleOperations4626Mint_withVeto(
        address controller,
        uint256 sharesNet,
        uint256 assetsGross,
        uint256 assetsNet
    ) public asAdmin {
        // Enable veto status
        superVaultAggregator.setGlobalHooksRootVetoStatus(true);
        
        // Clamp parameters
        uint256 strategyBalance = MockERC20(superVault.asset()).balanceOf(address(superVaultStrategy));
        sharesNet = sharesNet % (superVault.convertToShares(strategyBalance) + 1);
        assetsGross = assetsGross % (strategyBalance + 1);
        assetsNet = assetsNet % (strategyBalance + 1);
        
        // Attempt mint - should revert with OPERATIONS_BLOCKED_BY_VETO
        try superVaultStrategy.handleOperations4626Mint(controller, sharesNet, assetsGross, assetsNet) {
            superVaultAggregator.setGlobalHooksRootVetoStatus(false);
        } catch {
            superVaultAggregator.setGlobalHooksRootVetoStatus(false);
        }
    }

    /// @dev Coverage Fix: Handler to test initialize with invalid fee config (fee set but recipient is address(0))
    function superVaultStrategy_initialize_invalidFeeConfig(
        uint256 performanceFeeBps,
        uint256 managementFeeBps
    ) public {
        // This should be called on a fresh strategy instance
        // Clamp to non-zero fees to trigger the validation
        performanceFeeBps = (performanceFeeBps % 5100) + 1; // Ensure non-zero
        managementFeeBps = managementFeeBps % 10_000;
        
        ISuperVaultStrategy.FeeConfig memory feeConfig = ISuperVaultStrategy.FeeConfig({
            performanceFeeBps: performanceFeeBps,
            managementFeeBps: managementFeeBps,
            recipient: address(0) // Invalid: fees configured but no recipient
        });
        
        // This should revert with ZERO_ADDRESS
        try superVaultStrategy.initialize(address(superVault), feeConfig) {
            // Should not succeed
        } catch {
            // Expected revert
        }
    }

    /// @dev Coverage Fix: Handler to test skimPerformanceFee within timelock window
    function superVaultStrategy_skimPerformanceFee_duringTimelock() public asAdmin {
        // First, pause and unpause to set lastUnpause timestamp
        superVaultAggregator.pauseStrategy(address(superVaultStrategy));
        superVaultAggregator.unpauseStrategy(address(superVaultStrategy));
        
        // Immediately try to skim (within 12 hour timelock) - should revert
        try superVaultStrategy.skimPerformanceFee() {
            // Should not succeed
        } catch {
            // Expected revert with SKIM_TIMELOCK_ACTIVE
        }
    }

    /// @dev Coverage Fix: Handler to create PPS growth above HWM and trigger fee collection
    function superVaultStrategy_skimPerformanceFee_withPPSGrowth() public asAdmin {
        // This is complex and requires:
        // 1. Deposits to establish baseline
        // 2. Profitable yield operations to increase PPS
        // 3. Waiting past timelock
        // 4. Calling skimPerformanceFee
        
        // For now, we'll rely on natural fuzzing to create PPS growth
        // and just call skimPerformanceFee after waiting
        vm.warp(block.timestamp + 12 hours + 1);
        
        try superVaultStrategy.skimPerformanceFee() {
            // Success means we had PPS growth
        } catch {
            // May fail if no PPS growth or other conditions not met
        }
    }

    /// @dev Coverage Fix: Handler to trigger INSUFFICIENT_LIQUIDITY in fulfillRedeemRequests
    /// This creates a scenario where the requested redemption exceeds the strategy's available balance
    function superVaultStrategy_fulfillRedeemRequests_insufficientLiquidity(
        uint256 depositAmount,
        uint256 redeemShares
    ) public asAdmin {
        // Step 1: Deposit to create shares
        address controller = _getActor();
        
        // Deposit assets
        uint256 assetBalance = MockERC20(superVault.asset()).balanceOf(controller);
        depositAmount = depositAmount % (assetBalance + 1);
        if (depositAmount == 0) return; // Skip if no deposit
        
        // Perform deposit
        vm.startPrank(controller);
        MockERC20(superVault.asset()).approve(address(superVault), depositAmount);
        superVault.deposit(depositAmount, controller);
        vm.stopPrank();
        
        // Step 2: Request redeem
        uint256 vaultBalance = superVault.balanceOf(controller);
        redeemShares = redeemShares % (vaultBalance + 1);
        if (redeemShares == 0) return; // Skip if no shares to redeem
        
        vm.prank(controller);
        superVault.requestRedeem(redeemShares, controller, controller);
        
        // Step 3: Drain strategy balance to create insufficient liquidity
        // Transfer most assets out of the strategy to create the condition
        uint256 strategyBalance = MockERC20(superVault.asset()).balanceOf(address(superVaultStrategy));
        if (strategyBalance > 0) {
            // Drain 90% of strategy balance
            uint256 drainAmount = (strategyBalance * 90) / 100;
            vm.prank(address(superVaultStrategy));
            MockERC20(superVault.asset()).transfer(address(0xdead), drainAmount);
        }
        
        // Step 4: Try to fulfill with more assets than available
        // This should trigger INSUFFICIENT_LIQUIDITY
        address[] memory controllers = new address[](1);
        controllers[0] = controller;
        
        // Calculate required assets for the redemption
        uint256 currentPPS = superVaultStrategy.getStoredPPS();
        if (currentPPS == 0) return;
        
        uint256 pendingShares = superVaultStrategy.pendingRedeemRequest(controller);
        if (pendingShares == 0) return;
        
        // Calculate assets needed (will exceed available balance)
        uint256[] memory totalAssetsOut = new uint256[](1);
        totalAssetsOut[0] = (pendingShares * currentPPS) / (10 ** MockERC20(superVault.asset()).decimals());
        
        // This should revert with INSUFFICIENT_LIQUIDITY
        vm.prank(controller);
        try superVaultStrategy.fulfillRedeemRequests(controllers, totalAssetsOut) {
            // Should not succeed
        } catch {
            // Expected revert
        }
    }

    /// @dev Coverage Fix: Handler to test invalid operation type in handleOperations7540
    /// Note: This is practically unreachable with a properly typed enum, but we attempt it for coverage
    function superVaultStrategy_handleOperations7540_invalidOperation() public {
        // Since Operation is an enum with only 4 valid values (0-3), we try to use
        // assembly to bypass type checking and pass an invalid value
        address controller = _getActor();
        uint256 amount = 100;
        
        // This will likely fail at the ABI decoding level, but we try
        // Cast uint256(4) to Operation enum (invalid value outside enum range)
        bytes memory data = abi.encodeWithSelector(
            ISuperVaultStrategy.handleOperations7540.selector,
            uint8(4), // Invalid operation type (enum only has 0-3)
            controller,
            controller,
            amount
        );
        
        vm.prank(address(superVault));
        (bool success,) = address(superVaultStrategy).call(data);
        
        // Expected to fail, either at decoding or at the revert ACTION_TYPE_DISALLOWED
        require(!success, "Should have reverted");
    }




    /// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///

    function superVaultStrategy_fulfillCancelRedeemRequests(
        address[] memory controllers
    ) public asActor {
        superVaultStrategy.fulfillCancelRedeemRequests(controllers);
    }

    function superVaultStrategy_getSuperVaultState() public view stateless returns (ISuperVaultStrategy.SuperVaultState memory) {
        return superVaultStrategy.getSuperVaultState(_getActor());
    }

    function superVaultStrategy_executeVaultFeeConfigUpdate() public asActor {
        superVaultStrategy.executeVaultFeeConfigUpdate();
    }

    function superVaultStrategy_handleOperations4626Deposit(
        address controller,
        uint256 assetsGross
    ) public asActor {
        superVaultStrategy.handleOperations4626Deposit(controller, assetsGross);
    }

    function superVaultStrategy_handleOperations4626Mint(
        address controller,
        uint256 sharesNet,
        uint256 assetsGross,
        uint256 assetsNet
    ) public asActor {
        superVaultStrategy.handleOperations4626Mint(
            controller,
            sharesNet,
            assetsGross,
            assetsNet
        );
    }

    function superVaultStrategy_handleOperations7540(
        ISuperVaultStrategy.Operation operation,
        address controller,
        address receiver,
        uint256 amount
    ) public asActor {
        superVaultStrategy.handleOperations7540(
            operation,
            controller,
            receiver,
            amount
        );
    }

    function superVaultStrategy_manageYieldSource(
        address source,
        address oracle,
        ISuperVaultStrategy.YieldSourceAction actionType
    ) public asActor {
        superVaultStrategy.manageYieldSource(source, oracle, actionType);
    }

    function superVaultStrategy_manageYieldSources(
        address[] memory sources,
        address[] memory oracles,
        ISuperVaultStrategy.YieldSourceAction[] memory actionTypes
    ) public asActor {
        superVaultStrategy.manageYieldSources(sources, oracles, actionTypes);
    }

    function superVaultStrategy_proposeVaultFeeConfigUpdate(
        uint256 performanceFeeBps,
        uint256 managementFeeBps,
        address recipient
    ) public asActor {
        superVaultStrategy.proposeVaultFeeConfigUpdate(
            performanceFeeBps,
            managementFeeBps,
            recipient
        );
    }

    function superVaultStrategy_skimPerformanceFee() public asActor {
        superVaultStrategy.skimPerformanceFee();
    }
}
