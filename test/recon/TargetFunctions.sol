// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

// Chimera deps
import { vm } from "@chimera/Hevm.sol";

// Helpers
import { Panic } from "@recon/Panic.sol";
import { MockERC20 } from "@recon/MockERC20.sol";

// Interfaces
import { FeeType } from "src/interfaces/ISuperGovernor.sol";

// Targets
// NOTE: Always import and apply them in alphabetical order, so much easier to debug!
import { AdminTargets } from "./targets/AdminTargets.sol";
import { DoomsdayTargets } from "./targets/DoomsdayTargets.sol";
import { ManagersTargets } from "./targets/ManagersTargets.sol";
import { OracleTargets } from "./targets/OracleTargets.sol";
import { SuperVaultTargets } from "./targets/SuperVaultTargets.sol";
import { SuperVaultAggregatorTargets } from "./targets/SuperVaultAggregatorTargets.sol";
import { SuperVaultEscrowTargets } from "./targets/SuperVaultEscrowTargets.sol";
import { SuperVaultStrategyTargets } from "./targets/SuperVaultStrategyTargets.sol";
import { SuperGovernorTargets } from "./targets/SuperGovernorTargets.sol";
import { YieldSourceTargets } from "./targets/YieldSourceTargets.sol";

abstract contract TargetFunctions is
    AdminTargets,
    DoomsdayTargets,
    ManagersTargets,
    OracleTargets,
    SuperVaultTargets,
    SuperVaultAggregatorTargets,
    SuperVaultEscrowTargets,
    SuperVaultStrategyTargets,
    SuperGovernorTargets,
    YieldSourceTargets
{
    /// CUSTOM TARGET FUNCTIONS - Add your own target functions here ///
    
    // ============================================================================
    // SHORTCUT HANDLERS - Phase 2: Creating Shortcut Handlers
    // ============================================================================
    // These shortcuts combine prerequisite functions with target functions to help
    // the fuzzer reach specific execution paths more efficiently.
    
    // ----------------------------------------------------------------------------
    // Shortcuts for: escrowShares
    // Prerequisite: deposit
    // ----------------------------------------------------------------------------
    
    /// @notice Shortcut: deposit -> escrowShares
    function shortcut_escrowShares_afterDeposit(uint256 depositAmount, uint256 escrowAmount) public {
        // Call prerequisite using CLAMPED handler
        superVault_deposit_clamped(depositAmount);
        
        // Read state to determine exact values
        uint256 balance = superVault.balanceOf(_getActor());
        escrowAmount = escrowAmount % (balance + 1);
        
        // Call target with exact value
        vm.prank(address(superVault));
        superVaultEscrow.escrowShares(_getActor(), escrowAmount);
    }
    
    // ----------------------------------------------------------------------------
    // Shortcuts for: executeFeeUpdate
    // Prerequisite: proposeFee
    // ----------------------------------------------------------------------------
    
    /// @notice Shortcut: proposeFee -> warp time -> executeFeeUpdate
    function shortcut_executeFeeUpdate_afterProposal(uint256 feeTypeEntropy, uint256 value) public {
        FeeType feeType = FeeType(feeTypeEntropy % 2);
        
        // Call prerequisite using CLAMPED handler
        superGovernor_proposeFee_clamped(feeType, value);
        
        // Warp time to make execution valid
        vm.warp(block.timestamp + 7 days + 1);
        
        // Call target
        superGovernor_executeFeeUpdate(feeType);
    }
    
    // ----------------------------------------------------------------------------
    // Shortcuts for: fulfillRedeemRequests
    // Prerequisite: requestRedeem
    // ----------------------------------------------------------------------------
    
    /// @notice Shortcut: deposit -> requestRedeem -> fulfillRedeemRequests
    function shortcut_fulfillRedeemRequests_singleUser(uint256 depositAmount, uint256 redeemShares) public {
        // Setup: deposit first
        superVault_deposit_clamped(depositAmount);
        
        // Prerequisite: request redeem
        superVault_requestRedeem_clamped(redeemShares);
        
        // Call target
        address[] memory controllers = new address[](1);
        controllers[0] = _getActor();
        
        superVaultStrategy_fulfillRedeemRequests(0, controllers);
    }
    
    /// @notice Shortcut: deposit -> requestRedeem (multiple users) -> fulfillRedeemRequests
    function shortcut_fulfillRedeemRequests_multiUser(
        uint256 depositAmount1,
        uint256 depositAmount2,
        uint256 redeemShares1,
        uint256 redeemShares2
    ) public {
        address actor1 = _getActor();
        
        // User 1: deposit and request redeem
        superVault_deposit_clamped(depositAmount1);
        superVault_requestRedeem_clamped(redeemShares1);
        
        // User 2: deposit and request redeem
        switchActor(1);
        address actor2 = _getActor();
        superVault_deposit_clamped(depositAmount2);
        superVault_requestRedeem_clamped(redeemShares2);
        
        // Fulfill for both users
        address[] memory controllers = new address[](2);
        controllers[0] = actor1;
        controllers[1] = actor2;
        
        superVaultStrategy_fulfillRedeemRequests(0, controllers);
        
        switchActor(0);
    }
    
    // ----------------------------------------------------------------------------
    // Shortcuts for: removeSecondaryManager
    // Prerequisite: addSecondaryManager
    // ----------------------------------------------------------------------------
    
    /// @notice Shortcut: addSecondaryManager -> removeSecondaryManager
    function shortcut_removeSecondaryManager_afterAdd(uint256 managerEntropy) public {
        address manager = _getRandomActor(managerEntropy);
        
        // Prerequisite: add secondary manager
        vm.prank(address(this));
        superVaultAggregator.addSecondaryManager(address(superVaultStrategy), manager);
        
        // Call target
        vm.prank(address(this));
        superVaultAggregator.removeSecondaryManager(address(superVaultStrategy), manager);
    }
    
    // ----------------------------------------------------------------------------
    // Shortcuts for: transfer
    // Prerequisite: deposit
    // ----------------------------------------------------------------------------
    
    /// @notice Shortcut: deposit -> transfer
    function shortcut_transfer_afterDeposit(uint256 depositAmount, uint256 transferAmount, uint256 recipientEntropy) public {
        // Prerequisite: deposit to get shares
        superVault_deposit_clamped(depositAmount);
        
        // Read state and clamp transfer amount
        uint256 balance = superVault.balanceOf(_getActor());
        transferAmount = transferAmount % (balance + 1);
        
        // Call target
        superVault_transfer(recipientEntropy, transferAmount);
    }
    
    // ----------------------------------------------------------------------------
    // Shortcuts for: returnShares
    // Prerequisites: deposit, escrowShares
    // ----------------------------------------------------------------------------
    
    /// @notice Shortcut: deposit -> escrowShares -> returnShares
    function shortcut_returnShares_afterEscrow(
        uint256 depositAmount,
        uint256 escrowAmount,
        uint256 returnAmount
    ) public {
        // Prerequisite 1: deposit
        superVault_deposit_clamped(depositAmount);
        
        // Prerequisite 2: escrow shares
        uint256 balance = superVault.balanceOf(_getActor());
        escrowAmount = escrowAmount % (balance + 1);
        
        vm.prank(address(superVault));
        superVaultEscrow.escrowShares(_getActor(), escrowAmount);
        
        // Call target: return shares
        uint256 escrowBalance = superVault.balanceOf(address(superVaultEscrow));
        returnAmount = returnAmount % (escrowBalance + 1);
        
        vm.prank(address(superVault));
        superVaultEscrow.returnShares(_getActor(), returnAmount);
    }
    
    // ----------------------------------------------------------------------------
    // Shortcuts for: executeUpkeepPaymentsChange
    // Prerequisite: proposeUpkeepPaymentsChange
    // ----------------------------------------------------------------------------
    
    /// @notice Shortcut: proposeUpkeepPaymentsChange -> warp -> executeUpkeepPaymentsChange
    function shortcut_executeUpkeepPaymentsChange_afterProposal(bool enable) public {
        // Prerequisite: propose change
        vm.prank(address(this));
        superGovernor.proposeUpkeepPaymentsChange(enable);
        
        // Warp time
        vm.warp(block.timestamp + 7 days + 1);
        
        // Call target
        vm.prank(address(this));
        superGovernor.executeUpkeepPaymentsChange();
    }
    
    // ----------------------------------------------------------------------------
    // Shortcuts for: executeMinStalenessChange
    // Prerequisite: proposeMinStaleness
    // ----------------------------------------------------------------------------
    
    /// @notice Shortcut: proposeMinStaleness -> warp -> executeMinStalenessChange
    function shortcut_executeMinStalenessChange_afterProposal(uint256 newStaleness) public {
        newStaleness = newStaleness % (365 days + 1);
        
        // Prerequisite: propose
        vm.prank(address(this));
        superGovernor.proposeMinStaleness(newStaleness);
        
        // Warp time
        vm.warp(block.timestamp + 7 days + 1);
        
        // Call target
        vm.prank(address(this));
        superGovernor.executeMinStalenessChange();
    }
    
    // ----------------------------------------------------------------------------
    // Shortcuts for: executeWithdrawUpkeep
    // Prerequisites: depositUpkeep, proposeWithdrawUpkeep
    // ----------------------------------------------------------------------------
    
    /// @notice Shortcut: depositUpkeep -> proposeWithdrawUpkeep -> warp -> executeWithdrawUpkeep
    function shortcut_executeWithdrawUpkeep_afterProposal(uint256 depositAmount) public {
        // Prerequisite 1: deposit upkeep
        superVaultAggregator_depositUpkeep_clamped(depositAmount);
        
        // Prerequisite 2: propose withdraw
        vm.prank(address(this));
        superVaultAggregator.proposeWithdrawUpkeep(address(superVaultStrategy));
        
        // Warp time
        vm.warp(block.timestamp + 7 days + 1);
        
        // Call target
        vm.prank(address(this));
        superVaultAggregator.executeWithdrawUpkeep(address(superVaultStrategy));
    }
    
    // ----------------------------------------------------------------------------
    // Shortcuts for: claimUpkeep
    // Prerequisite: depositUpkeep
    // ----------------------------------------------------------------------------
    
    /// @notice Shortcut: depositUpkeep -> claimUpkeep
    function shortcut_claimUpkeep_afterDeposit(uint256 depositAmount, uint256 claimAmount) public {
        // Prerequisite: deposit upkeep
        superVaultAggregator_depositUpkeep_clamped(depositAmount);
        
        // Call target
        superGovernor_executeUpkeepClaim_clamped(claimAmount);
    }
    
    // ----------------------------------------------------------------------------
    // Shortcuts for: skimPerformanceFee
    // Prerequisite: deposit
    // ----------------------------------------------------------------------------
    
    /// @notice Shortcut: deposit -> simulate gain -> warp -> skimPerformanceFee
    function shortcut_skimPerformanceFee_afterGain(uint256 depositAmount, uint256 gainAmount) public {
        // Prerequisite: deposit to create shares
        superVault_deposit_clamped(depositAmount);
        
        // Simulate gain in yield source using yieldSource_simulateGain
        yieldSource_simulateGain(gainAmount);
        
        // Warp time past skim timelock
        vm.warp(block.timestamp + 1 days + 1);
        
        // Call target
        superVaultStrategy_skimPerformanceFee();
    }
    
    // ----------------------------------------------------------------------------
    // Shortcuts for: redeem
    // Prerequisite: deposit
    // ----------------------------------------------------------------------------
    
    /// @notice Shortcut: deposit -> redeem (full balance)
    function shortcut_redeem_full(uint256 depositAmount) public {
        // Prerequisite: deposit
        superVault_deposit_clamped(depositAmount);
        
        // Read exact balance for full redemption
        uint256 shares = superVault.balanceOf(_getActor());
        
        // Call target
        vm.prank(_getActor());
        superVault.redeem(shares, _getActor(), _getActor());
    }
    
    /// @notice Shortcut: deposit -> redeem (partial)
    function shortcut_redeem_partial(uint256 depositAmount, uint256 redeemShares) public {
        // Prerequisite: deposit
        superVault_deposit_clamped(depositAmount);
        
        // Clamp to partial amount
        superVault_redeem_clamped(redeemShares);
    }
    
    // ----------------------------------------------------------------------------
    // Shortcuts for: transferFrom
    // Prerequisites: deposit, approve
    // ----------------------------------------------------------------------------
    
    /// @notice Shortcut: deposit -> approve -> transferFrom
    function shortcut_transferFrom_afterApprove(
        uint256 depositAmount,
        uint256 approveAmount,
        uint256 transferAmount,
        uint256 recipientEntropy
    ) public {
        // Prerequisite 1: deposit (from actor owns shares)
        superVault_deposit_clamped(depositAmount);
        
        // Prerequisite 2: approve spender
        address fromActor = _getActor();
        switchActor(1);
        address spender = _getActor();
        
        vm.prank(fromActor);
        superVault.approve(spender, approveAmount);
        
        // Call target: transferFrom
        address to = _getRandomActor(recipientEntropy);
        uint256 balance = superVault.balanceOf(fromActor);
        transferAmount = transferAmount % (balance + 1);
        
        vm.prank(spender);
        superVault.transferFrom(fromActor, to, transferAmount);
        
        switchActor(0);
    }
    
    // ----------------------------------------------------------------------------
    // Shortcuts for: burnShares
    // Prerequisites: requestRedeem, fulfillRedeemRequests
    // ----------------------------------------------------------------------------
    
    /// @notice Shortcut: deposit -> requestRedeem -> fulfillRedeemRequests -> burnShares
    function shortcut_burnShares_afterFulfill(
        uint256 depositAmount,
        uint256 redeemShares,
        uint256 burnAmount
    ) public {
        // Setup: deposit
        superVault_deposit_clamped(depositAmount);
        
        // Prerequisite 1: request redeem
        superVault_requestRedeem_clamped(redeemShares);
        
        // Prerequisite 2: fulfill requests
        address[] memory controllers = new address[](1);
        controllers[0] = _getActor();
        
        superVaultStrategy_fulfillRedeemRequests(0, controllers);
        
        // Call target: burn shares from escrow
        superVault_burnShares_clamped(burnAmount);
    }
    
    // ----------------------------------------------------------------------------
    // Shortcuts for: cancelRedeemRequest
    // Prerequisite: requestRedeem
    // ----------------------------------------------------------------------------
    
    /// @notice Shortcut: deposit -> requestRedeem -> cancelRedeemRequest
    function shortcut_cancelRedeemRequest_afterRequest(uint256 depositAmount, uint256 redeemShares) public {
        // Setup: deposit
        superVault_deposit_clamped(depositAmount);
        
        // Prerequisite: request redeem
        superVault_requestRedeem_clamped(redeemShares);
        
        // Call target
        vm.prank(_getActor());
        superVault.cancelRedeemRequest(0, _getActor());
    }
    
    // ----------------------------------------------------------------------------
    // Shortcuts for: fulfillCancelRedeemRequests
    // Prerequisites: requestRedeem, cancelRedeemRequest
    // ----------------------------------------------------------------------------
    
    /// @notice Shortcut: deposit -> requestRedeem -> cancelRedeemRequest -> fulfillCancelRedeemRequests
    function shortcut_fulfillCancelRedeemRequests_afterCancel(uint256 depositAmount, uint256 redeemShares) public {
        // Setup: deposit
        superVault_deposit_clamped(depositAmount);
        
        // Prerequisite 1: request redeem
        superVault_requestRedeem_clamped(redeemShares);
        
        // Prerequisite 2: cancel request
        vm.prank(_getActor());
        superVault.cancelRedeemRequest(0, _getActor());
        
        // Call target
        address[] memory controllers = new address[](1);
        controllers[0] = _getActor();
        
        vm.prank(address(this));
        superVaultStrategy.fulfillCancelRedeemRequests(controllers);
    }
    
    // ----------------------------------------------------------------------------
    // Shortcuts for: claimCancelRedeemRequest
    // Prerequisites: requestRedeem, cancelRedeemRequest, fulfillCancelRedeemRequests
    // ----------------------------------------------------------------------------
    
    /// @notice Shortcut: deposit -> requestRedeem -> cancelRedeemRequest -> fulfillCancelRedeemRequests -> claimCancelRedeemRequest
    function shortcut_claimCancelRedeemRequest_afterFulfill(uint256 depositAmount, uint256 redeemShares) public {
        // Setup: deposit
        superVault_deposit_clamped(depositAmount);
        
        // Prerequisite 1: request redeem
        superVault_requestRedeem_clamped(redeemShares);
        
        // Prerequisite 2: cancel request
        vm.prank(_getActor());
        superVault.cancelRedeemRequest(0, _getActor());
        
        // Prerequisite 3: fulfill cancel
        address[] memory controllers = new address[](1);
        controllers[0] = _getActor();
        
        vm.prank(address(this));
        superVaultStrategy.fulfillCancelRedeemRequests(controllers);
        
        // Call target
        vm.prank(_getActor());
        superVault.claimCancelRedeemRequest(0, _getActor(), _getActor());
    }
    
    // ----------------------------------------------------------------------------
    // Shortcuts for: executeChangePrimaryManager
    // Prerequisite: proposeChangePrimaryManager
    // ----------------------------------------------------------------------------
    
    /// @notice Shortcut: addSecondaryManager -> proposeChangePrimaryManager -> warp -> executeChangePrimaryManager
    function shortcut_executeChangePrimaryManager_afterProposal(
        uint256 secondaryManagerEntropy,
        uint256 newManagerEntropy,
        uint256 feeRecipientEntropy
    ) public {
        address secondaryManager = _getRandomActor(secondaryManagerEntropy);
        address newManager = _getRandomActor(newManagerEntropy);
        address newFeeRecipient = _getRandomActor(feeRecipientEntropy);
        
        // Setup: add secondary manager
        vm.prank(address(this));
        superVaultAggregator.addSecondaryManager(address(superVaultStrategy), secondaryManager);
        
        // Prerequisite: propose change
        vm.prank(secondaryManager);
        superVaultAggregator.proposeChangePrimaryManager(address(superVaultStrategy), newManager, newFeeRecipient);
        
        // Warp time
        vm.warp(block.timestamp + 7 days + 1);
        
        // Call target
        vm.prank(address(this));
        superVaultAggregator.executeChangePrimaryManager(address(superVaultStrategy));
    }
    
    // ----------------------------------------------------------------------------
    // Shortcuts for: cancelChangePrimaryManager
    // Prerequisite: proposeChangePrimaryManager
    // ----------------------------------------------------------------------------
    
    /// @notice Shortcut: addSecondaryManager -> proposeChangePrimaryManager -> cancelChangePrimaryManager
    function shortcut_cancelChangePrimaryManager_afterProposal(
        uint256 secondaryManagerEntropy,
        uint256 newManagerEntropy,
        uint256 feeRecipientEntropy
    ) public {
        address secondaryManager = _getRandomActor(secondaryManagerEntropy);
        address newManager = _getRandomActor(newManagerEntropy);
        address newFeeRecipient = _getRandomActor(feeRecipientEntropy);
        
        // Setup: add secondary manager
        vm.prank(address(this));
        superVaultAggregator.addSecondaryManager(address(superVaultStrategy), secondaryManager);
        
        // Prerequisite: propose change
        vm.prank(secondaryManager);
        superVaultAggregator.proposeChangePrimaryManager(address(superVaultStrategy), newManager, newFeeRecipient);
        
        // Call target
        vm.prank(address(this));
        superVaultAggregator.cancelChangePrimaryManager(address(superVaultStrategy));
    }
    
    // ----------------------------------------------------------------------------
    // Shortcuts for: executeVaultFeeConfigUpdate
    // Prerequisite: proposeVaultFeeConfigUpdate
    // ----------------------------------------------------------------------------
    
    /// @notice Shortcut: proposeVaultFeeConfigUpdate -> warp -> executeVaultFeeConfigUpdate
    function shortcut_executeVaultFeeConfigUpdate_afterProposal(
        uint256 performanceFeeBps,
        uint256 managementFeeBps,
        uint256 recipientEntropy
    ) public {
        address recipient = _getRandomActor(recipientEntropy);
        
        // Prerequisite: propose fee config update
        vm.prank(address(this));
        superVaultStrategy.proposeVaultFeeConfigUpdate(
            performanceFeeBps,
            managementFeeBps,
            recipient
        );
        
        // Warp time
        vm.warp(block.timestamp + 7 days + 1);
        
        // Call target
        vm.prank(address(this));
        superVaultStrategy.executeVaultFeeConfigUpdate();
    }
    
    /// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///

    }
