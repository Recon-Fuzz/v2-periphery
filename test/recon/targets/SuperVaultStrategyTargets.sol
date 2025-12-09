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
        uint256 sharesNet = superVault.previewMint(actorAssetBalance) % (superVault.previewMint(actorAssetBalance) + 1);
        uint256 assetsGross = actorAssetBalance % (actorAssetBalance + 1);
        uint256 assetsNet = actorAssetBalance % (actorAssetBalance + 1);
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
}
