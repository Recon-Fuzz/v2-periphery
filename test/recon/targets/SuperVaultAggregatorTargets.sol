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

    /// @dev Create vault with secondary managers to cover that path
    function superVaultAggregator_createVault_withSecondaryManagers_clamped(uint256 numManagers) public {
        uint256 minStaleness = superGovernor.getMinStaleness();
        
        // Clamp number of secondary managers (0 to 3)
        numManagers = numManagers % 4;
        
        address[] memory secondaryManagers = new address[](numManagers);
        for (uint256 i = 0; i < numManagers; i++) {
            secondaryManagers[i] = _getRandomActor(i + 1);
            // Ensure no zero addresses
            if (secondaryManagers[i] == address(0)) {
                secondaryManagers[i] = address(uint160(0x1000 + i));
            }
        }
        
        ISuperVaultAggregator.VaultCreationParams memory params = ISuperVaultAggregator.VaultCreationParams({
            asset: _getAsset(),
            name: "SuperVault2",
            symbol: "SV2",
            mainManager: _getActor(),
            secondaryManagers: secondaryManagers,
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
        // Ensure newManager is not zero address
        if (newManager == address(0)) {
            newManager = _getRandomActor(1);
        }
        
        // Ensure newFeeRecipient is valid
        if (newFeeRecipient == address(0)) {
            newFeeRecipient = feeRecipient;
        }
        
        // First add current actor as a secondary manager if they're not already
        address currentActor = _getActor();
        
        // Use try-catch to handle case where actor is already a secondary manager
        vm.prank(address(this)); // Setup (this) is the main manager
        try superVaultAggregator.addSecondaryManager(address(superVaultStrategy), currentActor) {} catch {}
        
        // Now propose the change as a secondary manager
        superVaultAggregator_proposeChangePrimaryManager(address(superVaultStrategy), newManager, newFeeRecipient);
    }

    function superVaultAggregator_executeChangePrimaryManager_clamped() public {
        // First propose a change (requires being a secondary manager)
        address newManager = _getRandomActor(1);
        if (newManager == address(0)) newManager = address(0x999);
        
        address newFeeRecipient = _getRandomActor(2);
        if (newFeeRecipient == address(0)) newFeeRecipient = feeRecipient;
        
        // Add current actor as secondary manager
        address currentActor = _getActor();
        vm.prank(address(this)); // Setup (this) is the main manager
        try superVaultAggregator.addSecondaryManager(address(superVaultStrategy), currentActor) {} catch {}
        
        // Propose the change
        vm.prank(currentActor);
        try superVaultAggregator.proposeChangePrimaryManager(address(superVaultStrategy), newManager, newFeeRecipient) {} catch {
            return;
        }
        
        // Fast forward time to pass the timelock (7 days)
        vm.warp(block.timestamp + 7 days + 1);
        
        // Execute the change (can be called by anyone)
        vm.prank(currentActor);
        try superVaultAggregator.executeChangePrimaryManager(address(superVaultStrategy)) {} catch {}
    }

    function superVaultAggregator_cancelChangePrimaryManager_clamped() public {
        // First propose a change
        address newManager = _getRandomActor(1);
        if (newManager == address(0)) newManager = address(0x999);
        
        address newFeeRecipient = _getRandomActor(2);
        if (newFeeRecipient == address(0)) newFeeRecipient = feeRecipient;
        
        // Add current actor as secondary manager
        address currentActor = _getActor();
        vm.prank(address(this)); // Setup (this) is the main manager
        try superVaultAggregator.addSecondaryManager(address(superVaultStrategy), currentActor) {} catch {}
        
        // Propose the change
        vm.prank(currentActor);
        try superVaultAggregator.proposeChangePrimaryManager(address(superVaultStrategy), newManager, newFeeRecipient) {} catch {
            return;
        }
        
        // Now cancel it as the main manager (address(this) in setup)
        vm.prank(address(this));
        try superVaultAggregator.cancelChangePrimaryManager(address(superVaultStrategy)) {} catch {}
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

    /// @dev Add multiple secondary managers to test the MAX limit
    function superVaultAggregator_addSecondaryManagers_toLimitClamped() public {
        // Try to add 6 secondary managers (max is 5)
        for (uint256 i = 0; i < 6; i++) {
            address manager = address(uint160(0x2000 + i));
            
            // Main manager adds secondary managers
            vm.prank(address(this));
            try superVaultAggregator.addSecondaryManager(address(superVaultStrategy), manager) {} catch {
                // Expected to fail on the 6th one
                break;
            }
        }
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

    /// @dev Add and then remove a secondary manager to cover both paths
    function superVaultAggregator_addAndRemoveSecondaryManager_clamped() public {
        address manager = _getRandomActor(1);
        if (manager == address(0)) manager = address(0x3000);
        
        // Main manager adds a secondary manager
        vm.prank(address(this));
        try superVaultAggregator.addSecondaryManager(address(superVaultStrategy), manager) {} catch {
            return;
        }
        
        // Then remove it
        vm.prank(address(this));
        try superVaultAggregator.removeSecondaryManager(address(superVaultStrategy), manager) {} catch {}
    }

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
