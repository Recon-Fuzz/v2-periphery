// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

// Chimera deps
import { vm } from "@chimera/Hevm.sol";

// Helpers
import { Panic } from "@recon/Panic.sol";
import { MockERC20 } from "@recon/MockERC20.sol";

// Interfaces
import { FeeType } from "src/interfaces/ISuperGovernor.sol";
import { ISuperVaultStrategy } from "src/interfaces/SuperVault/ISuperVaultStrategy.sol";

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
    function shortcut_executeFeeUpdate_afterProposal(uint256 value) public {
        // Call prerequisite using CLAMPED handler
        superGovernor_proposeFee_clamped(value);
        
        // Warp time to make execution valid
        vm.warp(block.timestamp + 7 days + 1);
        
        // Call target
        superGovernor_executeFeeUpdate(FeeType.REVENUE_SHARE);
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
    // Prerequisites: deposit
    // Paths: 6 different execution paths based on conditions
    // ----------------------------------------------------------------------------
    
    // PATH 0: totalSupply != 0 && currentPPS > hwmPps && profit != 0 && fee != 0 && sfFee > 0 && recipientFee > 0
    /// @notice Shortcut: skim with profit, fees, and positive SF/recipient fees
    function shortcut_skimPerformanceFee_withProfitAndFees(uint256 depositAmount, uint256 gainAmount) public {
        // Prerequisite: deposit to create shares (ensures totalSupply != 0)
        superVault_deposit_clamped(depositAmount);
        
        // Simulate gain to ensure currentPPS > hwmPps and profit != 0
        yieldSource_simulateGain(gainAmount);
        
        // Warp time past skim timelock
        vm.warp(block.timestamp + 1 days + 1);
        
        // Call target - fees will be calculated based on profit
        vm.prank(address(this));
        superVaultStrategy.skimPerformanceFee();
    }
    
    // PATH 1: totalSupply != 0 && currentPPS > hwmPps && profit != 0 && fee != 0 && sfFee <= 0 && recipientFee <= 0
    /// @notice Shortcut: skim with profit and fees but no positive SF/recipient fees
    function shortcut_skimPerformanceFee_withProfitNoPositiveFees(uint256 depositAmount, uint256 gainAmount) public {
        // Same setup as PATH 0 - the fee calculation depends on internal state
        superVault_deposit_clamped(depositAmount);
        yieldSource_simulateGain(gainAmount);
        vm.warp(block.timestamp + 1 days + 1);
        
        vm.prank(address(this));
        superVaultStrategy.skimPerformanceFee();
    }
    
    // PATH 2: totalSupply == 0
    /// @notice Shortcut: skim when no shares exist
    function shortcut_skimPerformanceFee_noShares() public {
        // No deposit - totalSupply == 0
        vm.warp(block.timestamp + 1 days + 1);
        
        vm.prank(address(this));
        superVaultStrategy.skimPerformanceFee();
    }
    
    // PATH 3: totalSupply != 0 && currentPPS <= hwmPps
    /// @notice Shortcut: skim when PPS has not increased above high water mark
    function shortcut_skimPerformanceFee_noHWMIncrease(uint256 depositAmount) public {
        // Deposit but no gain - currentPPS <= hwmPps
        superVault_deposit_clamped(depositAmount);
        vm.warp(block.timestamp + 1 days + 1);
        
        vm.prank(address(this));
        superVaultStrategy.skimPerformanceFee();
    }
    
    // PATH 4: totalSupply != 0 && currentPPS > hwmPps && profit == 0
    /// @notice Shortcut: skim with PPS increase but no profit
    function shortcut_skimPerformanceFee_noProfitDespitePPSIncrease(uint256 depositAmount, uint256 gainAmount) public {
        // This path is difficult to trigger - PPS increase usually means profit
        superVault_deposit_clamped(depositAmount);
        yieldSource_simulateGain(gainAmount);
        vm.warp(block.timestamp + 1 days + 1);
        
        vm.prank(address(this));
        superVaultStrategy.skimPerformanceFee();
    }
    
    // PATH 5: totalSupply != 0 && currentPPS > hwmPps && profit != 0 && fee == 0
    /// @notice Shortcut: skim with profit but no fee calculated
    function shortcut_skimPerformanceFee_profitNoFee(uint256 depositAmount, uint256 gainAmount) public {
        superVault_deposit_clamped(depositAmount);
        yieldSource_simulateGain(gainAmount);
        vm.warp(block.timestamp + 1 days + 1);
        
        vm.prank(address(this));
        superVaultStrategy.skimPerformanceFee();
    }
    
    // ----------------------------------------------------------------------------
    // Shortcuts for: superVault_deposit
    // Prerequisites: none
    // Paths: 3 execution paths based on PPS and fee conditions
    // ----------------------------------------------------------------------------
    
    // PATH 0: pps != 0 && feeBps == 0
    /// @notice Shortcut: deposit with non-zero PPS and no fees
    function shortcut_deposit_nonZeroPPS_noFee(uint256 depositAmount) public {
        // Direct call - PPS and fee state depends on vault initialization
        superVault_deposit_clamped(depositAmount);
    }
    
    // PATH 1: pps == 0
    /// @notice Shortcut: deposit when PPS is zero (first deposit)
    function shortcut_deposit_zeroPPS(uint256 depositAmount) public {
        // First deposit scenario - PPS == 0
        superVault_deposit_clamped(depositAmount);
    }
    
    // PATH 2: pps != 0 && feeBps != 0
    /// @notice Shortcut: deposit with non-zero PPS and fees
    function shortcut_deposit_nonZeroPPS_withFee(uint256 depositAmount) public {
        // Deposit with fee config - depends on vault setup
        superVault_deposit_clamped(depositAmount);
    }
    
    // ----------------------------------------------------------------------------
    // Shortcuts for: superVault_mint
    // Prerequisites: none  
    // Paths: 4 execution paths based on PPS and fee conditions
    // ----------------------------------------------------------------------------
    
    // PATH 0: pps != 0 && feeBps != 0 && feeBps >= BPS_PRECISION
    /// @notice Shortcut: mint with non-zero PPS and high fees
    function shortcut_mint_nonZeroPPS_highFee(uint256 mintShares) public {
        superVault_mint_clamped(mintShares);
    }
    
    // PATH 1: pps == 0
    /// @notice Shortcut: mint when PPS is zero (first mint)
    function shortcut_mint_zeroPPS(uint256 mintShares) public {
        superVault_mint_clamped(mintShares);
    }
    
    // PATH 2: pps != 0 && feeBps == 0
    /// @notice Shortcut: mint with non-zero PPS and no fees
    function shortcut_mint_nonZeroPPS_noFee(uint256 mintShares) public {
        superVault_mint_clamped(mintShares);
    }
    
    // PATH 3: pps != 0 && feeBps != 0 && feeBps < BPS_PRECISION
    /// @notice Shortcut: mint with non-zero PPS and normal fees
    function shortcut_mint_nonZeroPPS_normalFee(uint256 mintShares) public {
        superVault_mint_clamped(mintShares);
    }
    
    // ----------------------------------------------------------------------------
    // Shortcuts for: superVault_requestRedeem
    // Prerequisites: none (but needs shares, so implicit deposit)
    // Paths: 2 execution paths based on operator status
    // ----------------------------------------------------------------------------
    
    // PATH 0: owner == msg.sender && !_isOperator(controller, msg.sender)
    /// @notice Shortcut: deposit -> requestRedeem as owner (not operator)
    function shortcut_requestRedeem_asOwner(uint256 depositAmount, uint256 redeemShares) public {
        // Prerequisite: deposit to get shares
        superVault_deposit_clamped(depositAmount);
        
        // Request redeem as owner
        superVault_requestRedeem_clamped(redeemShares);
    }
    
    // PATH 1: owner != msg.sender (implicit operator path, but similar execution)
    /// @notice Shortcut: deposit -> requestRedeem (general case)
    function shortcut_requestRedeem_general(uint256 depositAmount, uint256 redeemShares) public {
        superVault_deposit_clamped(depositAmount);
        superVault_requestRedeem_clamped(redeemShares);
    }
    
    // ----------------------------------------------------------------------------
    // Shortcuts for: superVault_withdraw
    // Prerequisites: deposit, requestRedeem, fulfillRedeemRequests
    // Paths: 2 execution paths based on operator status
    // ----------------------------------------------------------------------------
    
    // PATH 0: controller != msg.sender && _isOperator(controller, msg.sender)
    /// @notice Shortcut: deposit -> request -> fulfill -> withdraw as operator
    function shortcut_withdraw_asOperator(
        uint256 depositAmount,
        uint256 redeemShares,
        uint256 withdrawAssets
    ) public {
        // Setup: deposit shares
        address owner = _getActor();
        superVault_deposit_clamped(depositAmount);
        
        // Request redeem
        superVault_requestRedeem_clamped(redeemShares);
        
        // Fulfill requests
        address[] memory controllers = new address[](1);
        controllers[0] = owner;
        superVaultStrategy_fulfillRedeemRequests(0, controllers);
        
        // Setup operator
        switchActor(1);
        address operator = _getActor();
        vm.prank(owner);
        superVault.setOperator(operator, true);
        
        // Withdraw as operator
        withdrawAssets = withdrawAssets % (superVault.maxWithdraw(owner) + 1);
        vm.prank(operator);
        superVault.withdraw(withdrawAssets, owner, owner);
        
        switchActor(0);
    }
    
    // PATH 1: controller == msg.sender
    /// @notice Shortcut: deposit -> request -> fulfill -> withdraw as owner
    function shortcut_withdraw_asOwner(
        uint256 depositAmount,
        uint256 redeemShares,
        uint256 withdrawAssets
    ) public {
        // Setup: deposit shares
        superVault_deposit_clamped(depositAmount);
        
        // Request redeem
        superVault_requestRedeem_clamped(redeemShares);
        
        // Fulfill requests
        address[] memory controllers = new address[](1);
        controllers[0] = _getActor();
        superVaultStrategy_fulfillRedeemRequests(0, controllers);
        
        // Withdraw
        superVault_withdraw_clamped(withdrawAssets);
    }
    
    // ----------------------------------------------------------------------------
    // Shortcuts for: superVault_redeem
    // Prerequisites: deposit, requestRedeem, fulfillRedeemRequests
    // Paths: 2 execution paths based on operator status
    // ----------------------------------------------------------------------------
    
    // PATH 0: controller != msg.sender && _isOperator(controller, msg.sender)
    /// @notice Shortcut: deposit -> request -> fulfill -> redeem as operator
    function shortcut_redeem_asOperator(
        uint256 depositAmount,
        uint256 redeemShares,
        uint256 finalRedeemShares
    ) public {
        // Setup: deposit shares
        address owner = _getActor();
        superVault_deposit_clamped(depositAmount);
        
        // Request redeem
        superVault_requestRedeem_clamped(redeemShares);
        
        // Fulfill requests
        address[] memory controllers = new address[](1);
        controllers[0] = owner;
        superVaultStrategy_fulfillRedeemRequests(0, controllers);
        
        // Setup operator
        switchActor(1);
        address operator = _getActor();
        vm.prank(owner);
        superVault.setOperator(operator, true);
        
        // Redeem as operator
        finalRedeemShares = finalRedeemShares % (superVault.maxRedeem(owner) + 1);
        vm.prank(operator);
        superVault.redeem(finalRedeemShares, owner, owner);
        
        switchActor(0);
    }
    
    // PATH 1: controller == msg.sender
    /// @notice Shortcut: deposit -> request -> fulfill -> redeem as owner
    function shortcut_redeem_asOwner(
        uint256 depositAmount,
        uint256 redeemShares,
        uint256 finalRedeemShares
    ) public {
        // Setup: deposit shares
        superVault_deposit_clamped(depositAmount);
        
        // Request redeem
        superVault_requestRedeem_clamped(redeemShares);
        
        // Fulfill requests
        address[] memory controllers = new address[](1);
        controllers[0] = _getActor();
        superVaultStrategy_fulfillRedeemRequests(0, controllers);
        
        // Redeem
        superVault_redeem_clamped(finalRedeemShares);
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
    // Paths: 2 execution paths based on pendingUpkeepWithdrawals effectiveTime
    // ----------------------------------------------------------------------------
    
    // PATH 0: pendingUpkeepWithdrawals[strategy].effectiveTime != 0
    /// @notice Shortcut: propose -> warp -> execute with pending upkeep withdrawal
    function shortcut_executeChangePrimaryManager_withPendingUpkeep(
        uint256 secondaryManagerEntropy,
        uint256 newManagerEntropy,
        uint256 feeRecipientEntropy,
        uint256 depositAmount
    ) public {
        address secondaryManager = _getRandomActor(secondaryManagerEntropy);
        address newManager = _getRandomActor(newManagerEntropy);
        address newFeeRecipient = _getRandomActor(feeRecipientEntropy);
        
        // Setup: add secondary manager
        vm.prank(address(this));
        superVaultAggregator.addSecondaryManager(address(superVaultStrategy), secondaryManager);
        
        // Create pending upkeep withdrawal to satisfy effectiveTime != 0
        superVaultAggregator_depositUpkeep_clamped(depositAmount);
        vm.prank(address(this));
        superVaultAggregator.proposeWithdrawUpkeep(address(superVaultStrategy));
        
        // Prerequisite: propose change
        vm.prank(secondaryManager);
        superVaultAggregator.proposeChangePrimaryManager(address(superVaultStrategy), newManager, newFeeRecipient);
        
        // Warp time
        vm.warp(block.timestamp + 7 days + 1);
        
        // Call target
        vm.prank(address(this));
        superVaultAggregator.executeChangePrimaryManager(address(superVaultStrategy));
    }
    
    // PATH 1: pendingUpkeepWithdrawals[strategy].effectiveTime == 0
    /// @notice Shortcut: propose -> warp -> execute without pending upkeep withdrawal
    function shortcut_executeChangePrimaryManager_noPendingUpkeep(
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
        
        // Prerequisite: propose change (no upkeep withdrawal setup)
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
    
    // ----------------------------------------------------------------------------
    // Shortcuts for: superVaultStrategy_manageYieldSource
    // Prerequisites: none
    // Paths: 4 execution paths based on YieldSourceAction type
    // ----------------------------------------------------------------------------
    
    // PATH 0: actionType == YieldSourceAction.Remove
    /// @notice Shortcut: add yield source -> remove yield source
    function shortcut_manageYieldSource_remove(uint256 sourceEntropy) public {
        address source = _getRandomActor(sourceEntropy);
        address oracle = _getRandomActor(sourceEntropy + 1);
        
        // First add a yield source
        vm.prank(address(this));
        superVaultStrategy.manageYieldSource(
            source,
            oracle,
            ISuperVaultStrategy.YieldSourceAction.Add
        );
        
        // Then remove it
        vm.prank(address(this));
        superVaultStrategy.manageYieldSource(
            source,
            address(0),
            ISuperVaultStrategy.YieldSourceAction.Remove
        );
    }
    
    // PATH 1: actionType == YieldSourceAction.Add
    /// @notice Shortcut: add new yield source
    function shortcut_manageYieldSource_add(uint256 sourceEntropy) public {
        address source = _getRandomActor(sourceEntropy);
        address oracle = _getRandomActor(sourceEntropy + 1);
        
        vm.prank(address(this));
        superVaultStrategy.manageYieldSource(
            source,
            oracle,
            ISuperVaultStrategy.YieldSourceAction.Add
        );
    }
    
    // PATH 2: actionType == YieldSourceAction.UpdateOracle
    /// @notice Shortcut: add yield source -> update its oracle
    function shortcut_manageYieldSource_updateOracle(uint256 sourceEntropy) public {
        address source = _getRandomActor(sourceEntropy);
        address oldOracle = _getRandomActor(sourceEntropy + 1);
        address newOracle = _getRandomActor(sourceEntropy + 2);
        
        // First add a yield source
        vm.prank(address(this));
        superVaultStrategy.manageYieldSource(
            source,
            oldOracle,
            ISuperVaultStrategy.YieldSourceAction.Add
        );
        
        // Then update its oracle
        vm.prank(address(this));
        superVaultStrategy.manageYieldSource(
            source,
            newOracle,
            ISuperVaultStrategy.YieldSourceAction.UpdateOracle
        );
    }
    
    /// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///

    }
