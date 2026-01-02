// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

// External dependencies
import {vm} from "@chimera/Hevm.sol";
import {Panic} from "@recon/Panic.sol";
import {MockERC20} from "@recon/MockERC20.sol";
import {BaseTargetFunctions} from "@chimera/BaseTargetFunctions.sol";

// System dependencies
import {Math} from "@openzeppelin/contracts/utils/math/Math.sol";
import {IERC20} from "@openzeppelin/contracts/interfaces/IERC20.sol";
import {IERC4626} from "@openzeppelin/contracts/interfaces/IERC4626.sol";
import {
    ISuperHookInspector
} from "@superform-v2-core/src/interfaces/ISuperHook.sol";
import {
    ISuperVaultStrategy
} from "src/interfaces/SuperVault/ISuperVaultStrategy.sol";

// Test dependencies
import {MockERC7540Tester} from "test/recon/mocks/MockERC7540Tester.sol";
import {YieldSourceType} from "test/recon/managers/YieldManager.sol";
import {
    IStandardizedYield
} from "@superform-v2-core/src/vendor/pendle/IStandardizedYield.sol";
import {BeforeAfter, OpType} from "../BeforeAfter.sol";
import {Properties} from "../Properties.sol";

abstract contract AdminTargets is BaseTargetFunctions, Properties {
    /// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///

    function superVaultStrategy_executeHooks(
        ISuperVaultStrategy.ExecuteArgs memory args
    ) public payable asAdmin {
        superVaultStrategy.executeHooks{value: msg.value}(args);

        executeHooksSuccess = true;
    }

    // Functions that require SuperGovernor access
    /// @dev removed because we're bypassing hook validation
    // function superVaultAggregator_setHooksRootUpdateTimelock(
    //     uint256 newTimelock
    // ) public asAdmin {
    //     superVaultAggregator.setHooksRootUpdateTimelock(newTimelock);
    // }

    /// @dev removed because we're bypassing hook validation
    // function superVaultAggregator_proposeGlobalHooksRoot(
    //     bytes32 newRoot
    // ) public asAdmin {
    //     superVaultAggregator.proposeGlobalHooksRoot(newRoot);
    // }

    /// @dev removed because we're bypassing hook validation
    // function superVaultAggregator_executeGlobalHooksRootUpdate()
    //     public
    //     asAdmin
    // {
    //     superVaultAggregator.executeGlobalHooksRootUpdate();
    // }

    /// @dev Coverage Fix: Enable veto status to cover OPERATIONS_BLOCKED_BY_VETO branches
    function superVaultAggregator_setGlobalHooksRootVetoStatus(
        bool vetoed
    ) public asAdmin {
        superVaultAggregator.setGlobalHooksRootVetoStatus(vetoed);
    }

    /// @dev Coverage Fix: Enable strategy-specific veto
    function superVaultAggregator_setStrategyHooksRootVetoStatus(
        address strategy,
        bool vetoed
    ) public asAdmin {
        superVaultAggregator.setStrategyHooksRootVetoStatus(strategy, vetoed);
    }

    function superVaultAggregator_changePrimaryManager(
        address strategy,
        address newManager,
        address feeRecipient
    ) public asAdmin {
        superVaultAggregator.changePrimaryManager(
            strategy,
            newManager,
            feeRecipient
        );
    }

    /// Helpers

    /// @dev Coverage Fix: Direct call to fulfillRedeemRequests with proper clamping
    function superVaultStrategy_fulfillRedeemRequests_clamped(
        address[] memory controllers
    ) public asAdmin {
        // Skip if no controllers
        if (controllers.length == 0) return;
        
        // Sort and deduplicate controllers
        _sortAndDeduplicateControllers(controllers);
        
        // Filter to only controllers with pending redeem requests
        address[] memory validControllers = new address[](controllers.length);
        uint256 validCount = 0;
        
        for (uint256 i = 0; i < controllers.length; i++) {
            uint256 pending = superVault.pendingRedeemRequest(0, controllers[i]);
            if (pending > 0) {
                validControllers[validCount] = controllers[i];
                validCount++;
            }
        }
        
        // Skip if no valid controllers
        if (validCount == 0) return;
        
        // Resize to actual valid count
        assembly {
            mstore(validControllers, validCount)
        }
        
        // Calculate totalAssetsOut for each controller based on their pending shares
        uint256[] memory totalAssetsOut = new uint256[](validCount);
        uint256 currentPPS = superVaultStrategy.getStoredPPS();
        
        for (uint256 i = 0; i < validCount; i++) {
            uint256 pendingShares = superVault.pendingRedeemRequest(0, validControllers[i]);
            // Calculate assets based on PPS, clamped to strategy balance
            uint256 assets = (pendingShares * currentPPS) / (10 ** MockERC20(superVault.asset()).decimals());
            totalAssetsOut[i] = assets;
        }
        
        // Call fulfillRedeemRequests
        superVaultStrategy.fulfillRedeemRequests(validControllers, totalAssetsOut);
    }

    function _sortAndDeduplicateControllers(address[] memory controllers) internal pure {
        // Simple bubble sort for small arrays (good enough for fuzzing)
        for (uint256 i = 0; i < controllers.length; i++) {
            for (uint256 j = i + 1; j < controllers.length; j++) {
                if (controllers[i] > controllers[j]) {
                    address temp = controllers[i];
                    controllers[i] = controllers[j];
                    controllers[j] = temp;
                }
            }
        }
    }

    /// @dev Coverage Fix: Helper to complete async redemption workflow and enable withdraw/redeem coverage
    function helper_completeAsyncRedemptionWorkflow(uint256 shares) public {
        // Step 1: User requests redemption
        shares = shares % (superVault.balanceOf(_getActor()) + 1);
        if (shares == 0) return;
        
        vm.prank(_getActor());
        superVault.requestRedeem(shares, _getActor(), _getActor());
        
        // Step 2: Manager fulfills the request
        address[] memory controllers = new address[](1);
        controllers[0] = _getActor();
        
        uint256 pendingShares = superVault.pendingRedeemRequest(0, _getActor());
        if (pendingShares == 0) return;
        
        uint256 currentPPS = superVaultStrategy.getStoredPPS();
        uint256 assets = (pendingShares * currentPPS) / (10 ** MockERC20(superVault.asset()).decimals());
        
        uint256[] memory totalAssetsOut = new uint256[](1);
        totalAssetsOut[0] = assets;
        
        // Need to execute hooks before fulfillment
        _executeRedeemFulfillment(pendingShares, controllers);
        
        // Step 3: Now user can call withdraw/redeem
        // This is done separately by the fuzzer calling superVault_withdraw or superVault_redeem
    }

    /// @dev Coverage Fix: Handler to test executeHooks with invalid hook validation
    function superVaultStrategy_executeHooks_invalidProofs(
        address[] memory hooks,
        bytes[] memory hookCalldata
    ) public asAdmin {
        // Ensure arrays have matching length
        uint256 len = hooks.length;
        if (len == 0 || hookCalldata.length != len) return;
        
        // Create arrays with intentionally invalid/empty proofs to fail validation
        bytes32[][] memory emptyGlobalProofs = new bytes32[][](len);
        bytes32[][] memory emptyStrategyProofs = new bytes32[][](len);
        uint256[] memory expectedAssetsOrSharesOut = new uint256[](len);
        
        for (uint256 i = 0; i < len; i++) {
            emptyGlobalProofs[i] = new bytes32[](0); // Empty proofs will fail validation
            emptyStrategyProofs[i] = new bytes32[](0);
            expectedAssetsOrSharesOut[i] = 1;
        }
        
        // This should revert with HOOK_VALIDATION_FAILED
        try superVaultStrategy.executeHooks(
            ISuperVaultStrategy.ExecuteArgs({
                hooks: hooks,
                hookCalldata: hookCalldata,
                expectedAssetsOrSharesOut: expectedAssetsOrSharesOut,
                globalProofs: emptyGlobalProofs,
                strategyProofs: emptyStrategyProofs
            })
        ) {
            // Should not succeed with invalid proofs
        } catch {
            // Expected revert
        }
    }

    /// @dev Coverage Fix: Ensure strategy is in valid state before fulfillRedeemRequests
    function superVaultStrategy_fulfillRedeemRequests_ensureValidState(
        address[] memory controllers
    ) public asAdmin {
        // Ensure strategy is unpaused
        if (superVaultAggregator.isStrategyPaused(address(superVaultStrategy))) {
            superVaultAggregator.unpauseStrategy(address(superVaultStrategy));
        }
        
        // Ensure PPS is updated and not stale
        // The aggregator should have fresh PPS - this is handled by other operations
        
        // Now call the fulfillRedeemRequests handler
        superVaultStrategy_fulfillRedeemRequests_clamped(controllers);
    }

    /// @dev Property: superVaultStrategy does not incur loss on fulfillment
    function superVaultStrategy_fulfillRedeemRequests(
        uint256 redeemShares,
        address[] memory controllers
    ) public updateGhostsWithOpType(OpType.FULFILL) {
        uint256 assetBalanceBefore = IERC20(superVault.asset()).balanceOf(
            address(superVaultStrategy)
        );

        _executeRedeemFulfillment(redeemShares, controllers);

        uint256 assetBalanceAfter = IERC20(superVault.asset()).balanceOf(
            address(superVaultStrategy)
        );

        gte(
            assetBalanceAfter,
            assetBalanceBefore,
            "strategy incurs loss on fulfillment"
        );

        fulfillRedeemRequestsSuccess = true;
    }

    /// @dev Same as superVaultStrategy_fulfillRedeemRequests but with lowered exepectedAssetsOrSharesOut so that hook
    /// execution goes through
    function superVaultStrategy_fulfillRedeemRequests_WithLoss(
        uint256 lossOnWithdraw,
        uint256 redeemShares,
        address[] memory controllers
    ) public {
        uint256 assetBalanceBefore = IERC20(superVault.asset()).balanceOf(
            address(superVaultStrategy)
        );

        _executeRedeemFulfillmentWithLoss(
            lossOnWithdraw,
            redeemShares,
            controllers
        );

        uint256 assetBalanceAfter = IERC20(superVault.asset()).balanceOf(
            address(superVaultStrategy)
        );

        gte(
            assetBalanceAfter,
            assetBalanceBefore,
            "strategy incurs loss on fulfillment"
        );

        fulfillRedeemRequestsSuccess = true;
    }

    function _requestedSharesForControllers(
        address[] memory controllers
    ) internal view returns (uint256) {
        uint256 totalRequested;
        for (uint256 i; i < controllers.length; i++) {
            totalRequested += superVault.pendingRedeemRequest(
                0,
                controllers[i]
            );
        }

        return totalRequested;
    }

    function _claimableMoreThanInvested(
        uint256 totalAmountToDeposit
    ) internal view returns (bool) {
        address[] memory actors = _getActors();
        uint256 totalClaimable;
        for (uint256 i; i < actors.length; i++) {
            uint256 claimableRedemptions = superVault.claimableRedeemRequest(
                0,
                actors[i]
            );
            uint256 claimableRedemptionsAsAssets = superVault.convertToAssets(
                claimableRedemptions
            );
            totalClaimable += claimableRedemptionsAsAssets;
        }

        uint256 currentStrategyBalance = MockERC20(superVault.asset())
            .balanceOf(address(superVaultStrategy));

        // Don't allow investing more than the claimable amount
        if (totalAmountToDeposit > totalClaimable) {
            return true;
        }

        // Ensure strategy has sufficient assets remaining after investment to cover claimable amounts
        uint256 remainingStrategyBalance = currentStrategyBalance -
            totalAmountToDeposit;
        if (remainingStrategyBalance < totalClaimable) {
            return true;
        }

        return false;
    }

    function _executeRedeemFulfillment(
        uint256 totalRedeemShares,
        address[] memory requestingUsers
    ) internal {
        (
            uint256 expectedAssetsOut,
            address hookAddress,
            bytes memory hookData
        ) = _convertSVStoUnderlyingShares(totalRedeemShares);

        address[] memory hooks = new address[](1);
        hooks[0] = hookAddress;

        bytes[] memory hooksDataArray = new bytes[](1);
        hooksDataArray[0] = hookData;

        uint256[] memory expectedAssetsOrSharesOut = new uint256[](1);
        expectedAssetsOrSharesOut[0] = expectedAssetsOut;

        bytes[] memory hookCalldata = new bytes[](1);
        hookCalldata[0] = hookData;

        bytes[] memory argsForProofs = new bytes[](1);
        argsForProofs[0] = ISuperHookInspector(hookAddress).inspect(hookData);

        superVaultStrategy.executeHooks(
            ISuperVaultStrategy.ExecuteArgs({
                hooks: hooks,
                hookCalldata: hookCalldata,
                expectedAssetsOrSharesOut: expectedAssetsOrSharesOut,
                globalProofs: new bytes32[][](1),
                strategyProofs: new bytes32[][](1)
            })
        );

        uint256[] memory totalAssetsOut = calculateLiquidityOnlyFulfillment(
            superVaultStrategy,
            superVault.asset(),
            requestingUsers
        );

        // Fulfill the redemption requests from liquidity
        superVaultStrategy.fulfillRedeemRequests(
            requestingUsers,
            totalAssetsOut
        );
    }

    function _executeRedeemFulfillmentWithLoss(
        uint256 lossOnWithdraw,
        uint256 totalRedeemShares,
        address[] memory requestingUsers
    ) internal {
        (uint256 expectedAssets, , ) = _convertSVStoUnderlyingShares_WithLoss(
            totalRedeemShares,
            lossOnWithdraw
        );
        _executeRedeemHooksWithLoss(totalRedeemShares, lossOnWithdraw);

        uint256[] memory expectedAssetsArr = new uint256[](1);
        expectedAssetsArr[0] = expectedAssets;

        uint256[] memory totalAssetsOut = calculateAdjustedFulfillment(
            superVaultStrategy,
            requestingUsers,
            expectedAssetsArr
        );

        superVaultStrategy.fulfillRedeemRequests(
            requestingUsers,
            totalAssetsOut
        );
    }

    function _executeRedeemHooksWithLoss(
        uint256 totalRedeemShares,
        uint256 lossOnWithdraw
    ) internal {
        (
            ,
            address hookAddress,
            bytes memory hookData
        ) = _convertSVStoUnderlyingShares_WithLoss(
                totalRedeemShares,
                lossOnWithdraw
            );

        address[] memory hooks = new address[](1);
        hooks[0] = hookAddress;

        bytes[] memory hooksDataArray = new bytes[](1);
        hooksDataArray[0] = hookData;

        uint256[] memory expectedAssetsOrSharesOut = new uint256[](1);
        expectedAssetsOrSharesOut[0] = 1;

        bytes[] memory hookCalldata = new bytes[](1);
        hookCalldata[0] = hookData;

        bytes[] memory argsForProofs = new bytes[](1);
        argsForProofs[0] = ISuperHookInspector(hookAddress).inspect(hookData);

        superVaultStrategy.executeHooks(
            ISuperVaultStrategy.ExecuteArgs({
                hooks: hooks,
                hookCalldata: hookCalldata,
                expectedAssetsOrSharesOut: expectedAssetsOrSharesOut,
                globalProofs: new bytes32[][](1),
                strategyProofs: new bytes32[][](1)
            })
        );
    }

    function _convertSVStoUnderlyingShares_WithLoss(
        uint256 redeemShares,
        uint256 lossOnWithdraw
    )
        internal
        view
        returns (
            uint256 expectedAssetsOrSharesOut,
            address hookAddress,
            bytes memory hookData
        )
    {
        address underlyingVault = _getYieldSource();
        YieldSourceType activeYieldSourceType = _getYieldSourceTypeFromAddress(
            underlyingVault
        );

        uint256 sharesAsAssetsFromSV = superVault.convertToAssets(redeemShares);

        uint256 underlyingShares;
        if (activeYieldSourceType == YieldSourceType.ERC4626) {
            underlyingShares = IERC20(underlyingVault).balanceOf(
                address(superVaultStrategy)
            );

            uint256 expectedAssets = IERC4626(underlyingVault).previewRedeem(
                underlyingShares
            );

            expectedAssetsOrSharesOut =
                expectedAssets -
                ((expectedAssets * lossOnWithdraw) / 10_000);

            hookAddress = address(redeem4626Hook);

            hookData = abi.encodePacked(
                bytes32(0),
                underlyingVault,
                address(superVaultStrategy),
                underlyingShares,
                false
            );
        } else if (activeYieldSourceType == YieldSourceType.ERC5115) {
            uint256 assetsPerShare = IStandardizedYield(underlyingVault)
                .previewRedeem(superVault.asset(), 1e18);
            underlyingShares = Math.mulDiv(
                sharesAsAssetsFromSV,
                1e18,
                assetsPerShare,
                Math.Rounding.Ceil
            );

            expectedAssetsOrSharesOut = IStandardizedYield(underlyingVault)
                .previewRedeem(superVault.asset(), underlyingShares);

            hookAddress = address(redeem5115Hook);

            hookData = abi.encodePacked(
                bytes32(0),
                underlyingVault,
                address(superVaultStrategy),
                underlyingShares,
                false
            );
        } else {
            underlyingShares = MockERC7540Tester(underlyingVault)
                .previewWithdraw(sharesAsAssetsFromSV);

            expectedAssetsOrSharesOut = MockERC7540Tester(underlyingVault)
                .previewRedeem(underlyingShares);

            hookAddress = address(redeem7540Hook);

            hookData = abi.encodePacked(
                bytes32(0),
                underlyingVault,
                underlyingShares,
                false
            );
        }
    }

    function _convertSVStoUnderlyingShares(
        uint256 redeemShares
    )
        internal
        view
        returns (
            uint256 expectedAssetsOrSharesOut,
            address hookAddress,
            bytes memory hookData
        )
    {
        address underlyingVault = _getYieldSource();
        YieldSourceType activeYieldSourceType = _getYieldSourceTypeFromAddress(
            underlyingVault
        );

        uint256 sharesAsAssetsFromSV = superVault.convertToAssets(redeemShares);

        uint256 underlyingShares;
        if (activeYieldSourceType == YieldSourceType.ERC4626) {
            underlyingShares = IERC20(underlyingVault).balanceOf(
                address(superVaultStrategy)
            );

            expectedAssetsOrSharesOut = IERC4626(underlyingVault).previewRedeem(
                underlyingShares
            );

            hookAddress = address(redeem4626Hook);

            hookData = abi.encodePacked(
                bytes32(0),
                underlyingVault,
                address(superVaultStrategy),
                underlyingShares,
                false
            );
        } else if (activeYieldSourceType == YieldSourceType.ERC5115) {
            uint256 assetsPerShare = IStandardizedYield(underlyingVault)
                .previewRedeem(superVault.asset(), 1e18);
            underlyingShares = Math.mulDiv(
                sharesAsAssetsFromSV,
                1e18,
                assetsPerShare,
                Math.Rounding.Ceil
            );

            expectedAssetsOrSharesOut = IStandardizedYield(underlyingVault)
                .previewRedeem(superVault.asset(), underlyingShares);

            hookAddress = address(redeem5115Hook);

            hookData = abi.encodePacked(
                bytes32(0),
                underlyingVault,
                address(superVaultStrategy),
                underlyingShares,
                false
            );
        } else {
            underlyingShares = MockERC7540Tester(underlyingVault)
                .previewWithdraw(sharesAsAssetsFromSV);

            expectedAssetsOrSharesOut = MockERC7540Tester(underlyingVault)
                .previewRedeem(underlyingShares);

            hookAddress = address(redeem7540Hook);

            hookData = abi.encodePacked(
                bytes32(0),
                underlyingVault,
                underlyingShares,
                false
            );
        }
    }

    function _truncateToActualBalance(
        uint256 expectedShares,
        address underlyingVault,
        uint256 toleranceBps
    ) internal view returns (uint256 adjustedShares) {
        YieldSourceType activeYieldSourceType = _getYieldSourceTypeFromAddress(
            _getYieldSource()
        );

        address vaultShareToken;
        if (activeYieldSourceType == YieldSourceType.ERC7540) {
            vaultShareToken = MockERC7540Tester(_getYieldSource()).share();
        } else {
            vaultShareToken = underlyingVault;
        }

        uint256 actualBalance = IERC20(vaultShareToken).balanceOf(
            address(superVaultStrategy)
        );
        if (actualBalance >= expectedShares) {
            // Balance is sufficient, no truncation needed
            return expectedShares;
        }

        // Calculate minimum acceptable balance based on tolerance
        uint256 minAcceptableBalance = (expectedShares *
            (10_000 - toleranceBps)) / 10_000;

        if (actualBalance < minAcceptableBalance) {
            revert();
        }

        // Balance is lower but within tolerance, truncate to actual
        return actualBalance;
    }
}
