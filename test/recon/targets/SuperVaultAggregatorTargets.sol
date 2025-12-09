// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {BaseTargetFunctions} from "@chimera/BaseTargetFunctions.sol";
import {vm} from "@chimera/Hevm.sol";
import {Panic} from "@recon/Panic.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

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

    // Clamped handlers for SuperVaultAggregator functions
    function superVaultAggregator_depositUpkeep_clamped() public {
        address upkeepToken = superGovernor.getAddress(superGovernor.UPKEEP_TOKEN());
        uint256 balance = IERC20(upkeepToken).balanceOf(_getActor());
        if (balance == 0) return;

        uint256 amount = balance % (balance + 1);
        if (amount == 0) return;

        // Need to approve the aggregator to spend the upkeep tokens
        vm.prank(_getActor());
        IERC20(upkeepToken).approve(address(superVaultAggregator), amount);

        // Use the strategy address (which should be valid)
        superVaultAggregator_depositUpkeep(amount);
    }

    function superVaultAggregator_claimUpkeep_clamped() public {
        uint256 amount = superVaultAggregator.claimableUpkeep() % (superVaultAggregator.claimableUpkeep() + 1);
        superVaultAggregator_claimUpkeep(amount);
    }

    function superVaultAggregator_createVault_clamped() public {
        uint256 minStaleness = superGovernor.getMinStaleness();
        
        ISuperVaultAggregator.VaultCreationParams memory params = ISuperVaultAggregator.VaultCreationParams({
            asset: _getAsset(),
            name: "SuperVault",
            symbol: "SV",
            mainManager: _getActor(),
            secondaryManagers: new address[](0),
            minUpdateInterval: minStaleness % (minStaleness + 1),
            maxStaleness: minStaleness,
            feeConfig: ISuperVaultStrategy.FeeConfig({
                performanceFeeBps: 1000,
                managementFeeBps: 100,
                recipient: feeRecipient
            })
        });
        
        superVaultAggregator_createVault(params);
    }

    function superVaultAggregator_proposeChangePrimaryManager_clamped(address newManager, address newFeeRecipient) public {
        // First add current actor as a secondary manager if they're not already
        address currentActor = _getActor();
        
        // Use try-catch to handle case where actor is already a secondary manager
        vm.prank(address(superVaultStrategy)); // Main manager can add secondary managers
        try superVaultAggregator.addSecondaryManager(address(superVaultStrategy), currentActor) {} catch {}
        
        // Now propose the change as a secondary manager
        superVaultAggregator_proposeChangePrimaryManager(address(superVaultStrategy), newManager, newFeeRecipient);
    }

    function superVaultAggregator_executeChangePrimaryManager_clamped() public {
        // First propose a change (requires being a secondary manager)
        address newManager = _getRandomActor(1);
        address newFeeRecipient = _getRandomActor(2);
        
        superVaultAggregator_proposeChangePrimaryManager_clamped(newManager, newFeeRecipient);
        
        // Fast forward time to pass the timelock
        vm.warp(block.timestamp + 7 days + 1);
        
        // Execute the change
        superVaultAggregator_executeChangePrimaryManager(address(superVaultStrategy));
    }

    function superVaultAggregator_cancelChangePrimaryManager_clamped() public {
        // First propose a change
        address newManager = _getRandomActor(1);
        address newFeeRecipient = _getRandomActor(2);
        
        superVaultAggregator_proposeChangePrimaryManager_clamped(newManager, newFeeRecipient);
        
        // Now cancel it as the main manager
        // The main manager needs to call this, so we need to get the main manager address
        // For now, this might not work perfectly but it sets up the flow
        superVaultAggregator_cancelChangePrimaryManager(address(superVaultStrategy));
    }

    function superVaultAggregator_proposeWithdrawUpkeep_clamped() public {
        // First deposit some upkeep
        superVaultAggregator_depositUpkeep_clamped();
        
        // Then propose to withdraw it
        superVaultAggregator_proposeWithdrawUpkeep(address(superVaultStrategy));
    }

    function superVaultAggregator_executeWithdrawUpkeep_clamped() public {
        // First propose withdrawal
        superVaultAggregator_proposeWithdrawUpkeep_clamped();
        
        // Fast forward time to pass the timelock
        vm.warp(block.timestamp + 7 days + 1);
        
        // Execute the withdrawal
        superVaultAggregator_executeWithdrawUpkeep(address(superVaultStrategy));
    }

    /// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///

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
        superVaultAggregator.depositUpkeep(address(superVaultStrategy), amount);
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
