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

        uint256 sharesNet = superVault.previewMint(actorAssetBalance) % (superVault.previewMint(actorAssetBalance) + 1);
        if (sharesNet == 0) return;

        // Calculate assets with management fee applied
        // assetsGross should be higher than assetsNet to trigger fee collection
        uint256 assetsNet = actorAssetBalance % (actorAssetBalance + 1);
        // Add a small fee (1% for example) to make assetsGross > assetsNet
        uint256 assetsGross = assetsNet + (assetsNet / 100);
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

        // Calculate assets based on pending shares
        uint256 assetsOut = pendingShares * currentPPS / 1e18;

        // Ensure strategy has enough balance
        uint256 strategyBalance = IERC20(superVault.asset()).balanceOf(address(superVaultStrategy));
        if (strategyBalance < assetsOut) return;

        address[] memory controllers = new address[](1);
        controllers[0] = controller;

        uint256[] memory totalAssetsOut = new uint256[](1);
        totalAssetsOut[0] = assetsOut;

        superVaultStrategy_fulfillRedeemRequests(controllers, totalAssetsOut);
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
