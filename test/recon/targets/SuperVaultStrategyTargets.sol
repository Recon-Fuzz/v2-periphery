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
