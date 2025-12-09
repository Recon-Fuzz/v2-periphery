// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {BaseTargetFunctions} from "@chimera/BaseTargetFunctions.sol";

import {vm} from "@chimera/Hevm.sol";
import {Panic} from "@recon/Panic.sol";
import {MockERC20} from "@recon/MockERC20.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

import "src/SuperVault/SuperVaultStrategy.sol";

import {YieldSourceType} from "test/recon/managers/YieldManager.sol";
import {BeforeAfter, OpType} from "../BeforeAfter.sol";
import {Properties} from "../Properties.sol";

abstract contract SuperVaultStrategyTargets is BaseTargetFunctions, Properties {
    /// CUSTOM TARGET FUNCTIONS - Add your own target functions here ///

    // Clamped handlers for SuperVaultStrategy functions
    function superVaultStrategy_handleOperations4626Deposit_clamped(address controller) public {
        uint256 assetsGross = IERC20(superVault.asset()).balanceOf(_getActor()) % (IERC20(superVault.asset()).balanceOf(_getActor()) + 1);
        MockERC20(superVault.asset()).approve(address(superVaultStrategy), assetsGross);
        superVaultStrategy_handleOperations4626Deposit(controller, assetsGross);
    }

    function superVaultStrategy_handleOperations4626Mint_clamped(address controller) public {
        uint256 actorAssetBalance = IERC20(superVault.asset()).balanceOf(_getActor());
        if (actorAssetBalance == 0) return;

        // Calculate shares to mint based on current PPS
        uint256 currentPPS = superVaultStrategy.getStoredPPS();
        if (currentPPS == 0) return;

        // Calculate a reasonable amount of shares to mint
        uint256 sharesNet = (actorAssetBalance * 1e18 / currentPPS) % ((actorAssetBalance * 1e18 / currentPPS) + 1);
        if (sharesNet == 0) return;

        // Calculate assets needed for these shares
        uint256 assetsNet = sharesNet * currentPPS / 1e18;
        if (assetsNet == 0 || assetsNet > actorAssetBalance) return;

        // Get the management fee from the strategy's fee config
        ISuperVaultStrategy.FeeConfig memory feeConfig = superVaultStrategy.getConfigInfo();
        uint256 feeBps = feeConfig.managementFeeBps;
        
        if (feeBps >= 10000) return; // Invalid fee
        
        uint256 assetsGross;
        if (feeBps > 0) {
            // Calculate gross using the fee formula: gross = net * BPS / (BPS - feeBps)
            assetsGross = assetsNet * 10000 / (10000 - feeBps);
            // Add 1 for rounding to ensure we have enough
            assetsGross += 1;
        } else {
            assetsGross = assetsNet;
        }
        
        if (assetsGross > actorAssetBalance) assetsGross = actorAssetBalance;

        MockERC20(superVault.asset()).approve(address(superVaultStrategy), assetsGross);
        superVaultStrategy_handleOperations4626Mint(controller, sharesNet, assetsGross, assetsNet);
    }

    function superVaultStrategy_handleOperations7540_clamped(
        ISuperVaultStrategy.Operation operation,
        address controller,
        address receiver
    ) public {
        uint256 amount = superVault.balanceOf(controller) % (superVault.balanceOf(controller) + 1);
        superVaultStrategy_handleOperations7540(operation, controller, receiver, amount);
    }

    function superVaultStrategy_proposeVaultFeeConfigUpdate_clamped(address recipient) public {
        uint256 performanceFeeBps = 5100; // Max from meaningful-values.json
        uint256 managementFeeBps = 10000; // Max from meaningful-values.json
        superVaultStrategy_proposeVaultFeeConfigUpdate(performanceFeeBps, managementFeeBps, recipient);
    }

    function superVaultStrategy_manageYieldSources_clamped() public {
        // Get current yield source and oracle
        address yieldSource = _getYieldSource();
        YieldSourceType sourceType = _getCurrentYieldSourceType();
        address oracle = _getYieldSourceOracleForType(sourceType);
        
        // Create arrays for batch operation with 2 actions: Add and UpdateOracle
        address[] memory sources = new address[](2);
        sources[0] = yieldSource;
        sources[1] = yieldSource;
        
        address[] memory oracles = new address[](2);
        oracles[0] = oracle;
        oracles[1] = oracle;
        
        ISuperVaultStrategy.YieldSourceAction[] memory actionTypes = new ISuperVaultStrategy.YieldSourceAction[](2);
        actionTypes[0] = ISuperVaultStrategy.YieldSourceAction.Add;
        actionTypes[1] = ISuperVaultStrategy.YieldSourceAction.UpdateOracle;
        
        superVaultStrategy_manageYieldSources(sources, oracles, actionTypes);
    }

    function superVaultStrategy_fulfillRedeemRequests_clamped(address controller) public {
        // Only fulfill if there's a pending redeem request
        uint256 pendingShares = superVaultStrategy.getSuperVaultState(controller).pendingRedeemRequest;
        if (pendingShares == 0) return;

        // Get current PPS to calculate assets out
        uint256 currentPPS = superVaultStrategy.getStoredPPS();
        if (currentPPS == 0) return;

        // Calculate theoretical assets based on current PPS
        uint256 theoreticalAssets = pendingShares * currentPPS / 1e18;

        // Get slippage parameters to calculate valid range
        ISuperVaultStrategy.SuperVaultState memory state = superVaultStrategy.getSuperVaultState(controller);
        uint16 slippageBps = state.redeemSlippageBps > 0 ? state.redeemSlippageBps : 500; // DEFAULT_REDEEM_SLIPPAGE_BPS
        
        // Calculate minAssetsOut based on average request PPS and slippage
        uint256 minAssetsOut;
        if (state.averageRequestPPS > 0) {
            // Use the same formula as in _processExactFulfillmentBatch
            uint256 baseAssets = pendingShares * state.averageRequestPPS / 1e18;
            minAssetsOut = baseAssets - (baseAssets * slippageBps / 10000);
        } else {
            // If no average request PPS, use theoretical with slippage
            minAssetsOut = theoreticalAssets - (theoreticalAssets * slippageBps / 10000);
        }

        // Clamp assetsOut to be within valid bounds [minAssetsOut, theoreticalAssets]
        // Use a value slightly above minAssetsOut to avoid edge cases
        uint256 assetsOut = minAssetsOut + ((theoreticalAssets - minAssetsOut) / 2);
        if (assetsOut > theoreticalAssets) assetsOut = theoreticalAssets;

        // Ensure strategy has enough balance
        uint256 strategyBalance = IERC20(superVault.asset()).balanceOf(address(superVaultStrategy));
        if (strategyBalance < assetsOut) return;

        address[] memory controllers = new address[](1);
        controllers[0] = controller;

        uint256[] memory totalAssetsOut = new uint256[](1);
        totalAssetsOut[0] = assetsOut;

        superVaultStrategy_fulfillRedeemRequests(controllers, totalAssetsOut);
    }

    /// @dev Test fulfillRedeemRequests with insufficient strategy balance
    /// Attempts to trigger INSUFFICIENT_LIQUIDITY revert at line 356
    function superVaultStrategy_fulfillRedeemRequests_insufficientLiquidity_clamped(address controller) public {
        // Only fulfill if there's a pending redeem request
        uint256 pendingShares = superVaultStrategy.getSuperVaultState(controller).pendingRedeemRequest;
        if (pendingShares == 0) return;

        // Get current PPS to calculate assets out
        uint256 currentPPS = superVaultStrategy.getStoredPPS();
        if (currentPPS == 0) return;

        // Calculate maximum theoretical assets needed
        uint256 theoreticalAssets = pendingShares * currentPPS / 1e18;
        
        // Get strategy balance
        uint256 strategyBalance = IERC20(superVault.asset()).balanceOf(address(superVaultStrategy));
        
        // Try to fulfill with more assets than available
        // This should trigger the INSUFFICIENT_LIQUIDITY revert
        uint256 assetsOut = theoreticalAssets;
        if (assetsOut <= strategyBalance) {
            // Increase to exceed balance
            assetsOut = strategyBalance + 1;
        }

        address[] memory controllers = new address[](1);
        controllers[0] = controller;

        uint256[] memory totalAssetsOut = new uint256[](1);
        totalAssetsOut[0] = assetsOut;

        // This should revert with INSUFFICIENT_LIQUIDITY
        vm.prank(address(this));
        try superVaultStrategy.fulfillRedeemRequests(controllers, totalAssetsOut) {} catch {}
    }

    /// @dev Combined handler: request redeem then immediately fulfill it
    /// This ensures the redeem workflow is properly exercised
    function superVaultStrategy_requestAndFulfillRedeem_clamped() public {
        address controller = _getActor();
        
        // Step 1: Request a redeem
        uint256 shares = superVault.balanceOf(controller);
        if (shares == 0) return;
        
        // Clamp to a reasonable amount
        shares = shares % (shares + 1);
        if (shares == 0) return;
        
        // Request the redeem
        vm.prank(controller);
        try superVault.requestRedeem(shares, controller, controller) {} catch {
            return;
        }
        
        // Step 2: Fulfill the redeem request
        superVaultStrategy_fulfillRedeemRequests_clamped(controller);
    }

    /// @dev Test fulfillRedeemRequests with out-of-bounds totalAssetsOut
    /// Attempts to trigger BOUNDS_EXCEEDED revert at line 808
    function superVaultStrategy_fulfillRedeemRequests_boundsExceeded_clamped(address controller, uint256 entropy) public {
        // Only fulfill if there's a pending redeem request
        uint256 pendingShares = superVaultStrategy.getSuperVaultState(controller).pendingRedeemRequest;
        if (pendingShares == 0) return;

        // Get current PPS to calculate theoretical assets
        uint256 currentPPS = superVaultStrategy.getStoredPPS();
        if (currentPPS == 0) return;

        uint256 theoreticalAssets = pendingShares * currentPPS / 1e18;

        // Get slippage parameters to calculate valid range
        ISuperVaultStrategy.SuperVaultState memory state = superVaultStrategy.getSuperVaultState(controller);
        uint16 slippageBps = state.redeemSlippageBps > 0 ? state.redeemSlippageBps : 500;
        
        // Calculate minAssetsOut
        uint256 minAssetsOut;
        if (state.averageRequestPPS > 0) {
            uint256 baseAssets = pendingShares * state.averageRequestPPS / 1e18;
            minAssetsOut = baseAssets - (baseAssets * slippageBps / 10000);
        } else {
            minAssetsOut = theoreticalAssets - (theoreticalAssets * slippageBps / 10000);
        }

        // Choose an assetsOut value that's out of bounds
        uint256 assetsOut;
        if (entropy % 2 == 0) {
            // Below minimum
            if (minAssetsOut > 0) {
                assetsOut = minAssetsOut - 1;
            } else {
                return;
            }
        } else {
            // Above theoretical
            assetsOut = theoreticalAssets + 1;
        }

        address[] memory controllers = new address[](1);
        controllers[0] = controller;

        uint256[] memory totalAssetsOut = new uint256[](1);
        totalAssetsOut[0] = assetsOut;

        // This should revert with BOUNDS_EXCEEDED
        vm.prank(address(this));
        try superVaultStrategy.fulfillRedeemRequests(controllers, totalAssetsOut) {} catch {}
    }

    /// @dev Test operations with veto status enabled
    /// Attempts to trigger OPERATIONS_BLOCKED_BY_VETO revert at lines 166, 214
    function superVaultStrategy_operationsWithVeto_clamped(address controller) public {
        // Step 1: Enable global hooks root veto
        vm.prank(address(superGovernor));
        superVaultAggregator.setGlobalHooksRootVetoStatus(true);
        
        // Step 2: Try to perform a deposit operation (should revert)
        uint256 assetsGross = IERC20(superVault.asset()).balanceOf(_getActor());
        if (assetsGross > 0) {
            assetsGross = assetsGross % (assetsGross + 1);
            if (assetsGross > 0) {
                MockERC20(superVault.asset()).approve(address(superVaultStrategy), assetsGross);
                vm.prank(address(superVault)); // Only vault can call this
                try superVaultStrategy.handleOperations4626Deposit(controller, assetsGross) {} catch {}
            }
        }
        
        // Step 3: Try to perform a mint operation (should also revert)
        uint256 currentPPS = superVaultStrategy.getStoredPPS();
        if (currentPPS > 0) {
            uint256 sharesNet = 1000e18;
            uint256 assetsNet = sharesNet * currentPPS / 1e18;
            uint256 assetsGross2 = assetsNet + 100; // Add some for fees
            
            vm.prank(address(superVault)); // Only vault can call this
            try superVaultStrategy.handleOperations4626Mint(controller, sharesNet, assetsGross2, assetsNet) {} catch {}
        }
        
        // Step 4: Disable veto for subsequent tests
        vm.prank(address(superGovernor));
        superVaultAggregator.setGlobalHooksRootVetoStatus(false);
    }

    /// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///

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

    function superVaultStrategy_fulfillRedeemRequests(
        address[] memory controllers,
        uint256[] memory totalAssetsOut
    ) public asActor {
        superVaultStrategy.fulfillRedeemRequests(controllers, totalAssetsOut);
    }
}
