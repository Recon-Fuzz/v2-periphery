// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {BaseTargetFunctions} from "@chimera/BaseTargetFunctions.sol";
import {vm} from "@chimera/Hevm.sol";
import {Panic} from "@recon/Panic.sol";
import {MockERC20} from "@recon/MockERC20.sol";

import {
    ISuperVaultStrategy
} from "src/interfaces/SuperVault/ISuperVaultStrategy.sol";
import "src/SuperVault/SuperVaultAggregator.sol";

import {BeforeAfter} from "../BeforeAfter.sol";
import {Properties} from "../Properties.sol";

abstract contract SuperVaultAggregatorTargets is
    BaseTargetFunctions,
    Properties
{
    /// CUSTOM TARGET FUNCTIONS - Add your own target functions here ///

    function superVaultAggregator_claimUpkeep_clamped(uint256 amount) public {
        amount = amount % (superVaultAggregator.claimableUpkeep() + 1);
        superVaultAggregator_claimUpkeep(amount);
    }

    function superVaultAggregator_depositUpkeep_clamped(uint256 amount) public {
        amount = amount % (MockERC20(superGovernor.getAddress(superGovernor.UPKEEP_TOKEN())).balanceOf(_getActor()) + 1);
        MockERC20(superGovernor.getAddress(superGovernor.UPKEEP_TOKEN())).approve(address(superVaultAggregator), amount);
        superVaultAggregator_depositUpkeep(amount);
    }

    function superVaultAggregator_updateDeviationThreshold_clamped(
        uint256 deviationThreshold_
    ) public {
        deviationThreshold_ = deviationThreshold_ % (superVaultAggregator.getDeviationThreshold(address(superVaultStrategy)) + 1);
        superVaultAggregator_updateDeviationThreshold(address(superVaultStrategy), deviationThreshold_);
    }

    function superVaultAggregator_addSecondaryManager_clamped() public {
        superVaultAggregator_addSecondaryManager(address(superVaultStrategy), _getActor());
    }

    function superVaultAggregator_proposeChangePrimaryManager_clamped() public {
        superVaultAggregator_proposeChangePrimaryManager(address(superVaultStrategy), _getActor(), _getActor());
    }



    function superVaultAggregator_createVault_clamped(uint256 maxStaleness) public {
        maxStaleness = maxStaleness % (superGovernor.getMinStaleness() + 1);
        
        ISuperVaultAggregator.VaultCreationParams memory params = ISuperVaultAggregator.VaultCreationParams({
            asset: _getAsset(),
            name: "SuperVault",
            symbol: "SV",
            mainManager: _getActor(),
            secondaryManagers: new address[](0),
            minUpdateInterval: 5,
            maxStaleness: maxStaleness,
            feeConfig: ISuperVaultStrategy.FeeConfig({
                performanceFeeBps: 1000,
                managementFeeBps: 100,
                recipient: _getActor()
            })
        });
        
        superVaultAggregator_createVault(params);
    }

    function superVaultAggregator_cancelChangePrimaryManager_clamped() public {
        superVaultAggregator_cancelChangePrimaryManager(address(superVaultStrategy));
    }

    function superVaultAggregator_executeChangePrimaryManager_clamped() public {
        superVaultAggregator_executeChangePrimaryManager(address(superVaultStrategy));
    }

    function superVaultAggregator_proposeWithdrawUpkeep_clamped() public {
        superVaultAggregator_proposeWithdrawUpkeep(address(superVaultStrategy));
    }

    function superVaultAggregator_executeWithdrawUpkeep_clamped() public {
        superVaultAggregator_executeWithdrawUpkeep(address(superVaultStrategy));
    }

    /// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///

    function superVaultAggregator_claimableUpkeep() public view stateless returns (uint256) {
        return superVaultAggregator.claimableUpkeep();
    }

    function superVaultAggregator_addSecondaryManager(
        address strategy,
        address manager
    ) public asActor {
        superVaultAggregator.addSecondaryManager(strategy, manager);
    }

    /// @dev removed because only callable by oracle
    // function superVaultAggregator_batchForwardPPS(
    //     ISuperVaultAggregator.BatchForwardPPSArgs memory args
    // ) public asActor {
    //     superVaultAggregator.batchForwardPPS(args);
    // }

    /// @dev irrelevant for testing because we're bypassing hook validation
    // function superVaultAggregator_changeGlobalLeavesStatus(
    //     bytes32[] memory leaves,
    //     bool[] memory statuses,
    //     address strategy
    // ) public asActor {
    //     superVaultAggregator.changeGlobalLeavesStatus(
    //         leaves,
    //         statuses,
    //         strategy
    //     );
    // }

    function superVaultAggregator_claimUpkeep(uint256 amount) public asActor {
        superVaultAggregator.claimUpkeep(amount);
    }

    function superVaultAggregator_createVault(
        ISuperVaultAggregator.VaultCreationParams memory params
    ) public asActor {
        (
            address _superVault,
            address _strategy,
            address _escrow
        ) = superVaultAggregator.createVault(params);

        superVault = SuperVault(_superVault);
        superVaultStrategy = SuperVaultStrategy(payable(_strategy));
        superVaultEscrow = SuperVaultEscrow(_escrow);

        hasDeployedNewVault = true;
    }

    function superVaultAggregator_depositUpkeep(uint256 amount) public asActor {
        superVaultAggregator.depositUpkeep(_getActor(), amount);
    }

    function superVaultAggregator_executeChangePrimaryManager(
        address strategy
    ) public asActor {
        superVaultAggregator.executeChangePrimaryManager(strategy);
    }

    /// @dev removed because we're bypassing hook validation
    // function superVaultAggregator_executeStrategyHooksRootUpdate(
    //     address strategy
    // ) public asActor {
    //     superVaultAggregator.executeStrategyHooksRootUpdate(strategy);
    // }

    /// @dev removed because only callable by oracle
    // function superVaultAggregator_forwardPPS(
    //     address updateAuthority,
    //     ISuperVaultAggregator.ForwardPPSArgs memory args
    // ) public asActor {
    //     superVaultAggregator.forwardPPS(updateAuthority, args);
    // }

    function superVaultAggregator_proposeChangePrimaryManager(
        address strategy,
        address newManager,
        address feeRecipient
    ) public asActor {
        superVaultAggregator.proposeChangePrimaryManager(
            strategy,
            newManager,
            feeRecipient
        );
    }

    function superVaultAggregator_cancelChangePrimaryManager(
        address strategy
    ) public asActor {
        superVaultAggregator.cancelChangePrimaryManager(strategy);
    }

    /// @dev removed because we're bypassing hook validation
    // function superVaultAggregator_proposeStrategyHooksRoot(
    //     address strategy,
    //     bytes32 newRoot
    // ) public asActor {
    //     superVaultAggregator.proposeStrategyHooksRoot(strategy, newRoot);
    // }

    function superVaultAggregator_removeSecondaryManager(
        address strategy,
        address manager
    ) public asActor {
        superVaultAggregator.removeSecondaryManager(strategy, manager);
    }

    function superVaultAggregator_updateDeviationThreshold(
        address strategy,
        uint256 deviationThreshold_
    ) public asActor {
        superVaultAggregator.updateDeviationThreshold(
            strategy,
            deviationThreshold_
        );
    }

    function superVaultAggregator_proposeWithdrawUpkeep(
        address strategy
    ) public asActor {
        superVaultAggregator.proposeWithdrawUpkeep(strategy);
    }

    function superVaultAggregator_executeWithdrawUpkeep(
        address strategy
    ) public asActor {
        superVaultAggregator.executeWithdrawUpkeep(strategy);
    }
}
