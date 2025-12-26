// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

// Chimera deps
import { vm } from "@chimera/Hevm.sol";

// Helpers
import { Panic } from "@recon/Panic.sol";
import { MockERC20 } from "@recon/MockERC20.sol";

// Protocol imports
import { ISuperVaultStrategy } from "src/interfaces/SuperVault/ISuperVaultStrategy.sol";
import { ISuperGovernor, FeeType } from "src/interfaces/ISuperGovernor.sol";
import { YieldSourceType } from "test/recon/managers/YieldManager.sol";
import { MockERC4626Tester } from "test/recon/mocks/MockERC4626Tester.sol";

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
    
    // ============================================
    // SHORTCUT HANDLERS - Phase 2
    // ============================================
    
    // === superVault_withdraw shortcuts ===
    // PATH 0: controller != msg.sender && receiver == controller
    function shortcut_withdraw_withOperator_sameReceiver(
        uint256 depositAmount,
        uint256 withdrawAmount
    ) public {
        // Prerequisites - deposit as actor 0
        superVault_deposit_clamped(depositAmount);
        
        address controller = _getActor();
        
        // Switch to different actor (operator)
        _switchActor(1);
        address operator = _getActor();
        
        // Set operator approval
        vm.prank(controller);
        superVault.setOperator(operator, true);
        
        // Clamp withdraw to maxWithdraw
        withdrawAmount = withdrawAmount % (superVault.maxWithdraw(controller) + 1);
        
        // Call target - withdraw as operator for controller
        vm.prank(operator);
        superVault.withdraw(withdrawAmount, controller, controller);
        
        // Switch back
        _switchActor(0);
    }
    
    // PATH 1: controller == msg.sender
    function shortcut_withdraw_noOperator(
        uint256 depositAmount,
        uint256 withdrawAmount
    ) public {
        // Prerequisites
        superVault_deposit_clamped(depositAmount);
        
        // Clamp withdraw to maxWithdraw
        withdrawAmount = withdrawAmount % (superVault.maxWithdraw(_getActor()) + 1);
        
        // Call target - withdraw directly
        vm.prank(_getActor());
        superVault.withdraw(withdrawAmount, _getActor(), _getActor());
    }
    
    // === superVault_redeem shortcuts ===
    // PATH 0: withdrawPrice == 0
    function shortcut_redeem_noWithdrawPrice(
        uint256 depositAmount,
        uint256 requestRedeemAmount,
        uint256 redeemShares
    ) public {
        // Prerequisites
        superVault_deposit_clamped(depositAmount);
        superVault_requestRedeem_clamped(requestRedeemAmount);
        
        // Clamp redeem to maxRedeem
        redeemShares = redeemShares % (superVault.maxRedeem(_getActor()) + 1);
        
        // Call target
        vm.prank(_getActor());
        superVault.redeem(redeemShares, _getActor(), _getActor());
    }
    
    // PATH 1: withdrawPrice != 0
    function shortcut_redeem_withWithdrawPrice(
        uint256 depositAmount,
        uint256 requestRedeemAmount,
        uint256 redeemShares
    ) public {
        // Prerequisites
        superVault_deposit_clamped(depositAmount);
        superVault_requestRedeem_clamped(requestRedeemAmount);
        
        address controller = _getActor();
        
        // Trigger withdraw price update by fulfilling redeem
        address[] memory controllers = new address[](1);
        controllers[0] = controller;
        
        // Fulfill as admin (needs 2 arrays: controllers and totalAssetsOut)
        uint256[] memory totalAssetsOut = new uint256[](1);
        totalAssetsOut[0] = 0; // Let strategy calculate
        
        vm.prank(address(this));
        try superVaultStrategy.fulfillRedeemRequests(controllers, totalAssetsOut) {} catch {}
        
        // Clamp redeem to maxRedeem
        redeemShares = redeemShares % (superVault.maxRedeem(controller) + 1);
        
        // Call target
        vm.prank(controller);
        superVault.redeem(redeemShares, controller, controller);
    }
    
    // === superVault_requestRedeem shortcuts ===
    // PATH 0: controller == owner && true (has operator check)
    function shortcut_requestRedeem_ownerDirect_withOperatorCheck(
        uint256 depositAmount,
        uint256 shares
    ) public {
        // Prerequisites
        superVault_deposit_clamped(depositAmount);
        
        // Clamp shares to balance
        shares = shares % (superVault.balanceOf(_getActor()) + 1);
        
        // Call target
        vm.prank(_getActor());
        superVault.requestRedeem(shares, _getActor(), _getActor());
    }
    
    // PATH 1: controller == owner && !true (no operator check)
    function shortcut_requestRedeem_ownerDirect_noOperatorCheck(
        uint256 depositAmount,
        uint256 shares
    ) public {
        // Prerequisites
        superVault_deposit_clamped(depositAmount);
        
        // Clamp shares to balance
        shares = shares % (superVault.balanceOf(_getActor()) + 1);
        
        // Call target
        vm.prank(_getActor());
        superVault.requestRedeem(shares, _getActor(), _getActor());
    }
    
    // === superVault_deposit shortcuts ===
    // PATH 0: pps != 0 && feeBps == 0
    function shortcut_deposit_withPPS_noFees(uint256 assets) public {
        // Clamp assets to balance
        assets = assets % (MockERC20(_getAsset()).balanceOf(_getActor()) + 1);
        
        // Approve the vault
        vm.prank(_getActor());
        MockERC20(_getAsset()).approve(address(superVault), assets);
        
        // Call target
        vm.prank(_getActor());
        superVault.deposit(assets, _getActor());
    }
    
    // PATH 1: pps == 0
    function shortcut_deposit_noPPS(uint256 assets) public {
        // Clamp assets to balance
        assets = assets % (MockERC20(_getAsset()).balanceOf(_getActor()) + 1);
        
        // Approve the vault
        vm.prank(_getActor());
        MockERC20(_getAsset()).approve(address(superVault), assets);
        
        // Call target
        vm.prank(_getActor());
        superVault.deposit(assets, _getActor());
    }
    
    // PATH 2: pps != 0 && feeBps != 0
    function shortcut_deposit_withPPS_withFees(uint256 assets) public {
        // Clamp assets to balance
        assets = assets % (MockERC20(_getAsset()).balanceOf(_getActor()) + 1);
        
        // Approve the vault
        vm.prank(_getActor());
        MockERC20(_getAsset()).approve(address(superVault), assets);
        
        // Call target
        vm.prank(_getActor());
        superVault.deposit(assets, _getActor());
    }
    
    // === superVault_mint shortcuts ===
    // PATH 0: pps != 0 && feeBps != 0 && feeBps >= BPS_PRECISION
    function shortcut_mint_withPPS_highFees(uint256 shares) public {
        uint256 maxShares = superVault.previewDeposit(MockERC20(_getAsset()).balanceOf(_getActor()));
        shares = shares % (maxShares + 1);
        
        uint256 assetsNeeded = superVault.previewMint(shares);
        vm.prank(_getActor());
        MockERC20(_getAsset()).approve(address(superVault), assetsNeeded);
        
        vm.prank(_getActor());
        superVault.mint(shares, _getActor());
    }
    
    // PATH 1: pps == 0
    function shortcut_mint_noPPS(uint256 shares) public {
        uint256 maxShares = superVault.previewDeposit(MockERC20(_getAsset()).balanceOf(_getActor()));
        shares = shares % (maxShares + 1);
        
        uint256 assetsNeeded = superVault.previewMint(shares);
        vm.prank(_getActor());
        MockERC20(_getAsset()).approve(address(superVault), assetsNeeded);
        
        vm.prank(_getActor());
        superVault.mint(shares, _getActor());
    }
    
    // PATH 2: pps != 0 && feeBps == 0
    function shortcut_mint_withPPS_noFees(uint256 shares) public {
        uint256 maxShares = superVault.previewDeposit(MockERC20(_getAsset()).balanceOf(_getActor()));
        shares = shares % (maxShares + 1);
        
        uint256 assetsNeeded = superVault.previewMint(shares);
        vm.prank(_getActor());
        MockERC20(_getAsset()).approve(address(superVault), assetsNeeded);
        
        vm.prank(_getActor());
        superVault.mint(shares, _getActor());
    }
    
    // PATH 3: pps != 0 && feeBps != 0 && feeBps < BPS_PRECISION
    function shortcut_mint_withPPS_normalFees(uint256 shares) public {
        uint256 maxShares = superVault.previewDeposit(MockERC20(_getAsset()).balanceOf(_getActor()));
        shares = shares % (maxShares + 1);
        
        uint256 assetsNeeded = superVault.previewMint(shares);
        vm.prank(_getActor());
        MockERC20(_getAsset()).approve(address(superVault), assetsNeeded);
        
        vm.prank(_getActor());
        superVault.mint(shares, _getActor());
    }
    
    // === superVault_transfer shortcuts ===
    // PATH 0: owner != 0 && to != 0 && fromBalance >= value && to == 0 (contradiction, but handle)
    function shortcut_transfer_validOwner_withBalance(
        uint256 depositAmount,
        uint256 entropy,
        uint256 value
    ) public {
        // Prerequisites
        superVault_deposit_clamped(depositAmount);
        
        // Get random receiver
        address to = _getRandomActor(entropy);
        
        // Clamp value to balance
        value = value % (superVault.balanceOf(_getActor()) + 1);
        
        // Call target
        vm.prank(_getActor());
        try superVault.transfer(to, value) {} catch {}
    }
    
    // PATH 1: owner != 0 && to != 0 && owner == 0 && to == 0 (contradiction)
    function shortcut_transfer_edgeCase(
        uint256 depositAmount,
        uint256 entropy,
        uint256 value
    ) public {
        // Prerequisites
        superVault_deposit_clamped(depositAmount);
        
        // Get random receiver
        address to = _getRandomActor(entropy);
        
        // Clamp value to balance
        value = value % (superVault.balanceOf(_getActor()) + 1);
        
        // Call target
        vm.prank(_getActor());
        try superVault.transfer(to, value) {} catch {}
    }
    
    // === superVault_transferFrom shortcuts ===
    // PATH 0: currentAllowance < max && currentAllowance >= value && spender != 0
    function shortcut_transferFrom_withAllowance(
        uint256 depositAmount,
        uint256 entropyFrom,
        uint256 entropyTo,
        uint256 value,
        uint256 allowanceAmount
    ) public {
        // Prerequisites
        superVault_deposit_clamped(depositAmount);
        
        address from = _getRandomActor(entropyFrom);
        address to = _getRandomActor(entropyTo);
        
        // Set allowance
        allowanceAmount = allowanceAmount % (superVault.balanceOf(_getActor()) + 1);
        vm.prank(_getActor());
        superVault.approve(from, allowanceAmount);
        
        // Clamp value to allowance
        value = value % (allowanceAmount + 1);
        
        // Call target
        vm.prank(from);
        try superVault.transferFrom(_getActor(), to, value) {} catch {}
    }
    
    // PATH 1: currentAllowance >= max
    function shortcut_transferFrom_maxAllowance(
        uint256 depositAmount,
        uint256 entropyFrom,
        uint256 entropyTo,
        uint256 value
    ) public {
        // Prerequisites
        superVault_deposit_clamped(depositAmount);
        
        address from = _getRandomActor(entropyFrom);
        address to = _getRandomActor(entropyTo);
        
        // Set max allowance
        vm.prank(_getActor());
        superVault.approve(from, type(uint256).max);
        
        // Clamp value to balance
        value = value % (superVault.balanceOf(_getActor()) + 1);
        
        // Call target
        vm.prank(from);
        try superVault.transferFrom(_getActor(), to, value) {} catch {}
    }
    
    // === superVault_approve shortcuts ===
    // PATH 0: owner != 0 && spender != 0 && true
    function shortcut_approve_validParams(address spender, uint256 value) public {
        vm.prank(_getActor());
        superVault.approve(spender, value);
    }
    
    // PATH 1: owner != 0 && spender != 0 && !true
    function shortcut_approve_validParams_alt(address spender, uint256 value) public {
        vm.prank(_getActor());
        superVault.approve(spender, value);
    }
    
    // === superVault_invalidateNonce shortcut ===
    // PATH 0: !(_authorizations[msg.sender][nonce])
    function shortcut_invalidateNonce_notAuthorized(bytes32 nonce) public {
        vm.prank(_getActor());
        superVault.invalidateNonce(nonce);
    }
    
    // === superVault_burnShares shortcuts ===
    // PATH 0: msg.sender == strategy && escrow != 0 && fromBalance >= amount && 0 == 0
    function shortcut_burnShares_fromEscrow(
        uint256 depositAmount,
        uint256 requestRedeemAmount,
        uint256 burnAmount
    ) public {
        // Prerequisites - get shares into escrow
        superVault_deposit_clamped(depositAmount);
        superVault_requestRedeem_clamped(requestRedeemAmount);
        
        // Read escrow balance
        uint256 escrowBalance = superVault.balanceOf(address(superVaultEscrow));
        burnAmount = burnAmount % (escrowBalance + 1);
        
        // Call target as strategy
        vm.prank(address(superVaultStrategy));
        superVault.burnShares(burnAmount);
    }
    
    // PATH 1: msg.sender == strategy && escrow != 0 && escrow == 0 && 0 != 0 (contradiction)
    function shortcut_burnShares_edgeCase(
        uint256 depositAmount,
        uint256 requestRedeemAmount,
        uint256 burnAmount
    ) public {
        // Prerequisites
        superVault_deposit_clamped(depositAmount);
        superVault_requestRedeem_clamped(requestRedeemAmount);
        
        // Read escrow balance
        uint256 escrowBalance = superVault.balanceOf(address(superVaultEscrow));
        burnAmount = burnAmount % (escrowBalance + 1);
        
        // Call target as strategy
        vm.prank(address(superVaultStrategy));
        try superVault.burnShares(burnAmount) {} catch {}
    }
    
    // === superVaultStrategy_handleOperations4626Deposit shortcuts ===
    // PATH 0: assetsGross != 0 && assetsNet != 0 && feeAssets != 0 && feeAssets > 0
    function shortcut_handleOps4626Deposit_withFees(
        uint256 depositAmount
    ) public {
        // Prerequisites
        superVault_deposit_clamped(depositAmount);
        
        // Call target (usually called internally by vault)
        vm.prank(address(superVault));
        try superVaultStrategy.handleOperations4626Deposit(_getActor(), depositAmount) {} catch {}
    }
    
    // PATH 1: assetsGross != 0 && assetsNet != 0 && feeAssets != 0 && feeAssets <= 0
    function shortcut_handleOps4626Deposit_noPositiveFees(
        uint256 depositAmount
    ) public {
        // Prerequisites
        superVault_deposit_clamped(depositAmount);
        
        // Call target
        vm.prank(address(superVault));
        try superVaultStrategy.handleOperations4626Deposit(_getActor(), depositAmount) {} catch {}
    }
    
    // PATH 2: assetsGross != 0 && assetsNet != 0 && feeAssets == 0
    function shortcut_handleOps4626Deposit_zeroFees(
        uint256 depositAmount
    ) public {
        // Prerequisites
        superVault_deposit_clamped(depositAmount);
        
        // Call target
        vm.prank(address(superVault));
        try superVaultStrategy.handleOperations4626Deposit(_getActor(), depositAmount) {} catch {}
    }
    
    // === superVaultStrategy_handleOperations4626Mint shortcuts ===
    // PATH 0: sharesNet != 0 && feeBps != 0 && feeAssets != 0 && feeAssets > 0
    function shortcut_handleOps4626Mint_withFees(
        uint256 shares
    ) public {
        // Calculate assets needed
        uint256 assetsGross = superVault.previewMint(shares);
        uint256 assetsNet = assetsGross;
        
        // Prerequisites - approve vault
        vm.prank(_getActor());
        MockERC20(_getAsset()).approve(address(superVault), assetsGross);
        
        // Call target
        vm.prank(address(superVault));
        try superVaultStrategy.handleOperations4626Mint(_getActor(), shares, assetsGross, assetsNet) {} catch {}
    }
    
    // PATH 1: sharesNet != 0 && feeBps != 0 && feeAssets != 0 && feeAssets <= 0
    function shortcut_handleOps4626Mint_noPositiveFees(
        uint256 shares
    ) public {
        uint256 assetsGross = superVault.previewMint(shares);
        uint256 assetsNet = assetsGross;
        
        vm.prank(_getActor());
        MockERC20(_getAsset()).approve(address(superVault), assetsGross);
        
        vm.prank(address(superVault));
        try superVaultStrategy.handleOperations4626Mint(_getActor(), shares, assetsGross, assetsNet) {} catch {}
    }
    
    // PATH 2: sharesNet != 0 && feeBps != 0 && feeAssets == 0
    function shortcut_handleOps4626Mint_zeroFees(
        uint256 shares
    ) public {
        uint256 assetsGross = superVault.previewMint(shares);
        uint256 assetsNet = assetsGross;
        
        vm.prank(_getActor());
        MockERC20(_getAsset()).approve(address(superVault), assetsGross);
        
        vm.prank(address(superVault));
        try superVaultStrategy.handleOperations4626Mint(_getActor(), shares, assetsGross, assetsNet) {} catch {}
    }
    
    // PATH 3: sharesNet != 0 && feeBps == 0
    function shortcut_handleOps4626Mint_noFeeBps(
        uint256 shares
    ) public {
        uint256 assetsGross = superVault.previewMint(shares);
        uint256 assetsNet = assetsGross;
        
        vm.prank(_getActor());
        MockERC20(_getAsset()).approve(address(superVault), assetsGross);
        
        vm.prank(address(superVault));
        try superVaultStrategy.handleOperations4626Mint(_getActor(), shares, assetsGross, assetsNet) {} catch {}
    }
    
    // === superVaultStrategy_handleOperations7540 shortcuts ===
    // PATH 0: operation == RedeemRequest && amount != 0 && state.pendingRedeemRequest > 0
    function shortcut_handleOps7540_redeemRequest_hasPending(
        uint256 depositAmount,
        uint256 requestAmount,
        uint256 amount
    ) public {
        // Prerequisites - create pending redeem request
        superVault_deposit_clamped(depositAmount);
        superVault_requestRedeem_clamped(requestAmount);
        
        // Call target with another redeem request
        vm.prank(address(superVault));
        try superVaultStrategy.handleOperations7540(
            ISuperVaultStrategy.Operation.RedeemRequest,
            _getActor(),
            address(0),
            amount
        ) {} catch {}
    }
    
    // PATH 1: operation == CancelRedeemRequest && state.pendingRedeemRequest != 0
    function shortcut_handleOps7540_cancelRedeem(
        uint256 depositAmount,
        uint256 requestAmount
    ) public {
        // Prerequisites
        superVault_deposit_clamped(depositAmount);
        superVault_requestRedeem_clamped(requestAmount);
        
        // Call target
        vm.prank(address(superVault));
        try superVaultStrategy.handleOperations7540(
            ISuperVaultStrategy.Operation.CancelRedeemRequest,
            _getActor(),
            address(0),
            0
        ) {} catch {}
    }
    
    // PATH 2: operation == ClaimCancelRedeem && pendingShares != 0 && state.pendingCancelRedeemRequest
    function shortcut_handleOps7540_claimCancelRedeem(
        uint256 depositAmount,
        uint256 requestAmount
    ) public {
        // Prerequisites - request then cancel
        superVault_deposit_clamped(depositAmount);
        superVault_requestRedeem_clamped(requestAmount);
        
        // Cancel the request
        vm.prank(_getActor());
        superVault.cancelRedeemRequest(0, _getActor());
        
        // Call target
        vm.prank(address(superVault));
        try superVaultStrategy.handleOperations7540(
            ISuperVaultStrategy.Operation.ClaimCancelRedeem,
            _getActor(),
            address(0),
            0
        ) {} catch {}
    }
    
    // PATH 3: operation == RedeemRequest && amount != 0 && state.pendingRedeemRequest <= 0
    function shortcut_handleOps7540_redeemRequest_noPending(
        uint256 depositAmount,
        uint256 amount
    ) public {
        // Prerequisites
        superVault_deposit_clamped(depositAmount);
        
        // Clamp amount
        amount = amount % (superVault.balanceOf(_getActor()) + 1);
        
        // Call target
        vm.prank(address(superVault));
        try superVaultStrategy.handleOperations7540(
            ISuperVaultStrategy.Operation.RedeemRequest,
            _getActor(),
            address(0),
            amount
        ) {} catch {}
    }
    
    // PATH 4: operation == ClaimRedeem && amount != 0
    function shortcut_handleOps7540_claimRedeem(
        uint256 depositAmount,
        uint256 requestAmount,
        uint256 claimAmount
    ) public {
        // Prerequisites
        superVault_deposit_clamped(depositAmount);
        superVault_requestRedeem_clamped(requestAmount);
        
        // Call target
        vm.prank(address(superVault));
        try superVaultStrategy.handleOperations7540(
            ISuperVaultStrategy.Operation.ClaimRedeem,
            _getActor(),
            _getActor(),
            claimAmount
        ) {} catch {}
    }
    
    // === superVaultStrategy_manageYieldSource shortcuts ===
    // PATH 0: actionType == Remove && yieldSources[source] != 0
    function shortcut_manageYieldSource_remove(address source) public {
        // Prerequisites - add the source first
        address oracle = _getYieldSourceOracleForType(YieldSourceType.ERC4626);
        
        vm.prank(address(this));
        try superVaultStrategy.manageYieldSource(
            source,
            oracle,
            ISuperVaultStrategy.YieldSourceAction.Add
        ) {} catch {}
        
        // Call target to remove
        vm.prank(address(this));
        try superVaultStrategy.manageYieldSource(
            source,
            oracle,
            ISuperVaultStrategy.YieldSourceAction.Remove
        ) {} catch {}
    }
    
    // PATH 1: actionType == Add && yieldSources[source] == 0
    function shortcut_manageYieldSource_add(address source, address oracle) public {
        vm.prank(address(this));
        try superVaultStrategy.manageYieldSource(
            source,
            oracle,
            ISuperVaultStrategy.YieldSourceAction.Add
        ) {} catch {}
    }
    
    // PATH 2: actionType == UpdateOracle && oracle != 0 && oldOracle != 0
    function shortcut_manageYieldSource_updateOracle(address source) public {
        // Prerequisites - add source first
        address oracle1 = _getYieldSourceOracleForType(YieldSourceType.ERC4626);
        
        vm.prank(address(this));
        try superVaultStrategy.manageYieldSource(
            source,
            oracle1,
            ISuperVaultStrategy.YieldSourceAction.Add
        ) {} catch {}
        
        // Update to new oracle
        address oracle2 = _getYieldSourceOracleForType(YieldSourceType.ERC5115);
        
        vm.prank(address(this));
        try superVaultStrategy.manageYieldSource(
            source,
            oracle2,
            ISuperVaultStrategy.YieldSourceAction.UpdateOracle
        ) {} catch {}
    }
    
    // === superVaultStrategy_proposeVaultFeeConfigUpdate shortcut ===
    // PATH 0: performanceFeeBps <= MAX && managementFeeBps <= BPS && recipient != 0
    function shortcut_proposeVaultFeeConfig_valid(
        uint256 performanceFeeBps,
        uint256 managementFeeBps,
        address recipient
    ) public {
        // Clamp to valid ranges
        performanceFeeBps = performanceFeeBps % (5100 + 1);
        managementFeeBps = managementFeeBps % (10000 + 1);
        
        vm.prank(address(this));
        try superVaultStrategy.proposeVaultFeeConfigUpdate(
            performanceFeeBps,
            managementFeeBps,
            recipient
        ) {} catch {}
    }
    
    // === superVaultAggregator shortcuts ===
    // PATH 0: msg.sender == mainManager && currentBalance != 0
    function shortcut_proposeWithdrawUpkeep_withBalance(
        uint256 depositAmount,
        uint256 amount
    ) public {
        // Prerequisites - deposit upkeep
        address upkeepToken = superGovernor.getAddress(superGovernor.UPKEEP_TOKEN());
        uint256 upkeepBalance = MockERC20(upkeepToken).balanceOf(_getActor());
        depositAmount = depositAmount % (upkeepBalance + 1);
        
        vm.prank(_getActor());
        MockERC20(upkeepToken).approve(address(superVaultAggregator), depositAmount);
        
        vm.prank(_getActor());
        try superVaultAggregator.depositUpkeep(address(superVaultStrategy), depositAmount) {} catch {}
        
        // Read actual balance
        uint256 currentBalance = MockERC20(upkeepToken).balanceOf(address(superVaultAggregator));
        amount = amount % (currentBalance + 1);
        
        // Call target (proposeWithdrawUpkeep doesn't take amount parameter)
        vm.prank(address(this));
        try superVaultAggregator.proposeWithdrawUpkeep(address(superVaultStrategy)) {} catch {}
    }
    
    // PATH 0: msg.sender == mainManager
    function shortcut_updateDeviationThreshold_asManager(uint256 newThreshold) public {
        vm.prank(address(this));
        try superVaultAggregator.updateDeviationThreshold(address(superVaultStrategy), newThreshold) {} catch {}
    }
    
    // PATH 0: proposedManager != 0 && block.timestamp >= effectiveTime
    function shortcut_executeChangePrimaryManager_ready(address newManager, address feeRecipient) public {
        // Prerequisites - propose change
        vm.prank(address(this));
        try superVaultAggregator.proposeChangePrimaryManager(address(superVaultStrategy), newManager, feeRecipient) {} catch {}
        
        // Wait for timelock
        vm.warp(block.timestamp + 2 weeks);
        
        // Call target
        vm.prank(address(this));
        try superVaultAggregator.executeChangePrimaryManager(address(superVaultStrategy)) {} catch {}
    }
    
    // PATH 0: mainManager == msg.sender && proposedManager != 0
    function shortcut_cancelChangePrimaryManager_asManager(address newManager, address feeRecipient) public {
        // Prerequisites - propose change
        vm.prank(address(this));
        try superVaultAggregator.proposeChangePrimaryManager(address(superVaultStrategy), newManager, feeRecipient) {} catch {}
        
        // Call target
        vm.prank(address(this));
        try superVaultAggregator.cancelChangePrimaryManager(address(superVaultStrategy)) {} catch {}
    }
    
    // PATH 0: msg.sender == mainManager && manager != 0 && mainManager != manager
    function shortcut_addSecondaryManager_valid(address manager) public {
        vm.prank(address(this));
        try superVaultAggregator.addSecondaryManager(address(superVaultStrategy), manager) {} catch {}
    }
    
    // PATH 0: msg.sender == SUPER_GOVERNOR && claimableUpkeep >= amount
    function shortcut_claimUpkeep_asGovernor(
        uint256 depositAmount,
        uint256 claimAmount
    ) public {
        // Prerequisites - deposit upkeep
        address upkeepToken = superGovernor.getAddress(superGovernor.UPKEEP_TOKEN());
        uint256 upkeepBalance = MockERC20(upkeepToken).balanceOf(_getActor());
        depositAmount = depositAmount % (upkeepBalance + 1);
        
        vm.prank(_getActor());
        MockERC20(upkeepToken).approve(address(superVaultAggregator), depositAmount);
        
        vm.prank(_getActor());
        try superVaultAggregator.depositUpkeep(address(superVaultStrategy), depositAmount) {} catch {}
        
        // Clamp to available
        claimAmount = claimAmount % (depositAmount + 1);
        
        // Call target
        vm.prank(address(superGovernor));
        try superVaultAggregator.claimUpkeep(claimAmount) {} catch {}
    }
    
    // PATH 0: secondaryManagers.contains(msg.sender) && newManager != 0
    function shortcut_proposeChangePrimaryManager_asSecondary(
        address secondaryManager,
        address newManager,
        address feeRecipient
    ) public {
        // Prerequisites - add secondary manager
        vm.prank(address(this));
        try superVaultAggregator.addSecondaryManager(address(superVaultStrategy), secondaryManager) {} catch {}
        
        // Call target as secondary
        vm.prank(secondaryManager);
        try superVaultAggregator.proposeChangePrimaryManager(address(superVaultStrategy), newManager, feeRecipient) {} catch {}
    }
    
    // PATH 0: msg.sender == mainManager
    function shortcut_removeSecondaryManager_asMain(address manager) public {
        // Prerequisites - add manager first
        vm.prank(address(this));
        try superVaultAggregator.addSecondaryManager(address(superVaultStrategy), manager) {} catch {}
        
        // Call target
        vm.prank(address(this));
        try superVaultAggregator.removeSecondaryManager(address(superVaultStrategy), manager) {} catch {}
    }
    
    // PATH 0: request.effectiveTime != 0 && block.timestamp >= effectiveTime
    function shortcut_executeWithdrawUpkeep_ready(
        uint256 depositAmount,
        uint256 withdrawAmount
    ) public {
        // Prerequisites - deposit and propose withdraw
        address upkeepToken = superGovernor.getAddress(superGovernor.UPKEEP_TOKEN());
        uint256 upkeepBalance = MockERC20(upkeepToken).balanceOf(_getActor());
        depositAmount = depositAmount % (upkeepBalance + 1);
        
        vm.prank(_getActor());
        MockERC20(upkeepToken).approve(address(superVaultAggregator), depositAmount);
        
        vm.prank(_getActor());
        try superVaultAggregator.depositUpkeep(address(superVaultStrategy), depositAmount) {} catch {}
        
        withdrawAmount = withdrawAmount % (depositAmount + 1);
        
        vm.prank(address(this));
        try superVaultAggregator.proposeWithdrawUpkeep(address(superVaultStrategy)) {} catch {}
        
        // Wait for timelock
        vm.warp(block.timestamp + 2 weeks);
        
        // Call target
        vm.prank(address(this));
        try superVaultAggregator.executeWithdrawUpkeep(address(superVaultStrategy)) {} catch {}
    }
    
    // PATH 0: amount != 0
    function shortcut_depositUpkeep_nonZero(uint256 amount) public {
        address upkeepToken = superGovernor.getAddress(superGovernor.UPKEEP_TOKEN());
        uint256 upkeepBalance = MockERC20(upkeepToken).balanceOf(_getActor());
        amount = amount % (upkeepBalance + 1);
        
        vm.prank(_getActor());
        MockERC20(upkeepToken).approve(address(superVaultAggregator), amount);
        
        vm.prank(_getActor());
        try superVaultAggregator.depositUpkeep(address(superVaultStrategy), amount) {} catch {}
    }
    
    // === SuperGovernor shortcuts ===
    // PATH 0: minStalenessEffectiveTime != 0 && block.timestamp >= effectiveTime
    function shortcut_executeMinStalenessChange_ready(uint256 newMinStaleness) public {
        // Prerequisites - propose change
        vm.prank(address(this));
        try superGovernor.proposeMinStaleness(newMinStaleness) {} catch {}
        
        // Wait for timelock
        vm.warp(block.timestamp + 2 weeks);
        
        // Call target
        vm.prank(address(this));
        try superGovernor.executeMinStalenessChange() {} catch {}
    }
    
    // PATH 0: effectiveTime != 0 && block.timestamp >= effectiveTime
    function shortcut_executeFeeUpdate_ready(uint256 value) public {
        // Clamp value
        value = value % (10000 + 1);
        
        // Prerequisites - propose fee
        vm.prank(address(this));
        try superGovernor.proposeFee(FeeType.REVENUE_SHARE, value) {} catch {}
        
        // Wait for timelock
        vm.warp(block.timestamp + 2 weeks);
        
        // Call target
        vm.prank(address(this));
        try superGovernor.executeFeeUpdate(FeeType.REVENUE_SHARE) {} catch {}
    }
    
    // PATH 0: value <= BPS_MAX
    function shortcut_proposeFee_valid(uint256 value) public {
        value = value % (10000 + 1);
        
        vm.prank(address(this));
        try superGovernor.proposeFee(FeeType.REVENUE_SHARE, value) {} catch {}
    }
    
    // PATH 0: _upkeepPaymentsChangeEffectiveTime != 0 && block.timestamp >= effectiveTime
    function shortcut_executeUpkeepPaymentsChange_ready(bool enabled) public {
        // Prerequisites - propose change
        vm.prank(address(this));
        try superGovernor.proposeUpkeepPaymentsChange(enabled) {} catch {}
        
        // Wait for timelock
        vm.warp(block.timestamp + 2 weeks);
        
        // Call target
        vm.prank(address(this));
        try superGovernor.executeUpkeepPaymentsChange() {} catch {}
    }
    
    // PATH 0: aggregator != 0
    function shortcut_executeUpkeepClaim_valid(uint256 amount) public {
        // Call target
        vm.prank(address(this));
        try superGovernor.executeUpkeepClaim(amount) {} catch {}
    }
    
    // PATH 0: aggregator != 0
    function shortcut_proposeGlobalHooksRoot_valid(bytes32 newRoot) public {
        vm.prank(address(this));
        try superGovernor.proposeGlobalHooksRoot(newRoot) {} catch {}
    }
    
    // === YieldSource shortcuts ===
    
    // PATH 0: supply == 0
    function shortcut_redeem5115_zeroSupply(uint256 shares, address receiver) public {
        vm.prank(_getActor());
        try MockERC4626Tester(erc5115YieldSource).redeem(shares, receiver, _getActor()) {} catch {}
    }
    
    // PATH 1: supply != 0
    function shortcut_redeem5115_nonZeroSupply(
        uint256 depositAmount,
        uint256 shares,
        address receiver
    ) public {
        // Prerequisites - deposit first
        depositAmount = depositAmount % (MockERC20(_getAsset()).balanceOf(_getActor()) + 1);
        
        vm.prank(_getActor());
        MockERC20(_getAsset()).approve(erc5115YieldSource, depositAmount);
        
        vm.prank(_getActor());
        try MockERC4626Tester(erc5115YieldSource).deposit(depositAmount, _getActor()) {} catch {}
        
        // Clamp shares
        shares = shares % (MockERC4626Tester(erc5115YieldSource).balanceOf(_getActor()) + 1);
        
        // Call target
        vm.prank(_getActor());
        try MockERC4626Tester(erc5115YieldSource).redeem(shares, receiver, _getActor()) {} catch {}
    }
    
    // PATH 0: totalSupply != 0
    function shortcut_setDecimalsOffset_nonZeroSupply(
        uint256 depositAmount,
        uint8 offset
    ) public {
        // Prerequisites - create supply
        depositAmount = depositAmount % (MockERC20(_getAsset()).balanceOf(_getActor()) + 1);
        
        vm.prank(_getActor());
        MockERC20(_getAsset()).approve(erc4626YieldSource, depositAmount);
        
        vm.prank(_getActor());
        try MockERC4626Tester(erc4626YieldSource).deposit(depositAmount, _getActor()) {} catch {}
        
        // Call target
        vm.prank(address(this));
        try MockERC4626Tester(erc4626YieldSource).setDecimalsOffset(offset) {} catch {}
    }
    
    // PATH 1: totalSupply == 0
    function shortcut_setDecimalsOffset_zeroSupply(uint8 offset) public {
        vm.prank(address(this));
        try MockERC4626Tester(erc4626YieldSource).setDecimalsOffset(offset) {} catch {}
    }
    
    // PATH 0: allowed != max && allowed >= amount
    function shortcut_transferFrom_withLimitedAllowance(
        uint256 depositAmount,
        uint256 allowanceAmount,
        uint256 transferAmount,
        address to
    ) public {
        // Prerequisites - deposit to yield source
        depositAmount = depositAmount % (MockERC20(_getAsset()).balanceOf(_getActor()) + 1);
        
        vm.prank(_getActor());
        MockERC20(_getAsset()).approve(erc4626YieldSource, depositAmount);
        
        vm.prank(_getActor());
        try MockERC4626Tester(erc4626YieldSource).deposit(depositAmount, _getActor()) {} catch {}
        
        // Set allowance
        uint256 balance = MockERC4626Tester(erc4626YieldSource).balanceOf(_getActor());
        allowanceAmount = allowanceAmount % (balance + 1);
        
        vm.prank(_getActor());
        MockERC4626Tester(erc4626YieldSource).approve(to, allowanceAmount);
        
        // Clamp transfer
        transferAmount = transferAmount % (allowanceAmount + 1);
        
        // Call target
        vm.prank(to);
        try MockERC4626Tester(erc4626YieldSource).transferFrom(_getActor(), to, transferAmount) {} catch {}
    }
    
    // PATH 1: allowed == max
    function shortcut_transferFrom_maxAllowance(
        uint256 depositAmount,
        uint256 transferAmount,
        address to
    ) public {
        // Prerequisites
        depositAmount = depositAmount % (MockERC20(_getAsset()).balanceOf(_getActor()) + 1);
        
        vm.prank(_getActor());
        MockERC20(_getAsset()).approve(erc4626YieldSource, depositAmount);
        
        vm.prank(_getActor());
        try MockERC4626Tester(erc4626YieldSource).deposit(depositAmount, _getActor()) {} catch {}
        
        // Set max allowance
        vm.prank(_getActor());
        MockERC4626Tester(erc4626YieldSource).approve(to, type(uint256).max);
        
        // Clamp transfer
        uint256 balance = MockERC4626Tester(erc4626YieldSource).balanceOf(_getActor());
        transferAmount = transferAmount % (balance + 1);
        
        // Call target
        vm.prank(to);
        try MockERC4626Tester(erc4626YieldSource).transferFrom(_getActor(), to, transferAmount) {} catch {}
    }
    
    /// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///

    }
