// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

// Recon deps
import {BaseTargetFunctions} from "@chimera/BaseTargetFunctions.sol";
import {vm} from "@chimera/Hevm.sol";
import {Panic} from "@recon/Panic.sol";
import {MockERC20} from "@recon/MockERC20.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

import "src/SuperVault/SuperVault.sol";

import {BeforeAfter, OpType} from "test/recon/BeforeAfter.sol";
import {Properties} from "../Properties.sol";

/// @dev All receivers are inherently clamped to actors to make checking properties easier
abstract contract SuperVaultTargets is BaseTargetFunctions, Properties {
    /// CUSTOM TARGET FUNCTIONS - Add your own target functions here ///

    // Clamped handlers for SuperVault functions
    function superVault_approve_clamped(address spender) public {
        uint256 value = superVault.balanceOf(_getActor()) % (superVault.balanceOf(_getActor()) + 1);
        superVault_approve(spender, value);
    }

    function superVault_burnShares_clamped() public {
        uint256 amount = superVault.balanceOf(address(superVaultEscrow)) % (superVault.balanceOf(address(superVaultEscrow)) + 1);
        superVault_burnShares(amount);
    }

    function superVault_deposit_clamped() public {
        uint256 assets = IERC20(superVault.asset()).balanceOf(_getActor()) % (IERC20(superVault.asset()).balanceOf(_getActor()) + 1);
        MockERC20(superVault.asset()).approve(address(superVault), assets);
        superVault_deposit(assets);
    }

    function superVault_mint_clamped() public {
        address actor = _getActor();
        uint256 actorBalance = IERC20(superVault.asset()).balanceOf(actor);
        if (actorBalance == 0) return;

        // Calculate reasonable shares to mint based on balance
        // Use previewDeposit to get shares for our balance, then clamp
        uint256 maxShares = superVault.previewDeposit(actorBalance);
        if (maxShares == 0) return;
        
        uint256 shares = maxShares % (maxShares + 1);
        if (shares == 0) return;

        // Get the gross assets required for minting these shares
        uint256 assetsRequired = superVault.previewMint(shares);
        if (assetsRequired == 0 || assetsRequired > actorBalance) return;

        // Approve and mint
        MockERC20(superVault.asset()).approve(address(superVault), assetsRequired);
        superVault_mint(shares);
    }

    function superVault_redeem_clamped() public {
        address actor = _getActor();
        uint256 maxRedeemable = superVault.maxRedeem(actor);
        if (maxRedeemable == 0) return;
        
        uint256 shares = maxRedeemable % (maxRedeemable + 1);
        if (shares == 0) return;
        
        superVault_redeem(shares);
    }

    function superVault_withdraw_clamped() public {
        address actor = _getActor();
        uint256 maxWithdrawable = superVault.maxWithdraw(actor);
        if (maxWithdrawable == 0) return;
        
        uint256 assets = maxWithdrawable % (maxWithdrawable + 1);
        if (assets == 0) return;
        
        superVault_withdraw(assets);
    }

    /// @dev Complete redeem flow: deposit -> request redeem -> fulfill -> redeem
    /// This ensures all steps in the redeem process are covered
    function superVault_completeRedeemFlow_clamped() public {
        address actor = _getActor();
        
        // Step 1: Deposit assets to get shares
        uint256 assets = IERC20(superVault.asset()).balanceOf(actor);
        if (assets == 0) return;
        
        assets = assets % (assets + 1);
        if (assets == 0) return;
        
        MockERC20(superVault.asset()).approve(address(superVault), assets);
        vm.prank(actor);
        try superVault.deposit(assets, actor) {} catch {
            return;
        }
        
        // Step 2: Request redeem
        uint256 shares = superVault.balanceOf(actor);
        if (shares == 0) return;
        
        shares = shares % (shares + 1);
        if (shares == 0) return;
        
        vm.prank(actor);
        try superVault.requestRedeem(shares, actor, actor) {} catch {
            return;
        }
        
        // Step 3: Fulfill the redeem request (as manager)
        uint256 pendingShares = superVaultStrategy.getSuperVaultState(actor).pendingRedeemRequest;
        if (pendingShares == 0) return;
        
        uint256 currentPPS = superVaultStrategy.getStoredPPS();
        if (currentPPS == 0) return;
        
        uint256 assetsOut = pendingShares * currentPPS / 1e18;
        uint256 strategyBalance = IERC20(superVault.asset()).balanceOf(address(superVaultStrategy));
        if (strategyBalance < assetsOut) return;
        
        address[] memory controllers = new address[](1);
        controllers[0] = actor;
        
        uint256[] memory totalAssetsOut = new uint256[](1);
        totalAssetsOut[0] = assetsOut;
        
        // Manager fulfills the request
        vm.prank(address(this));
        try superVaultStrategy.fulfillRedeemRequests(controllers, totalAssetsOut) {} catch {
            return;
        }
        
        // Step 4: Claim the redeemed assets
        uint256 maxRedeemable = superVault.maxRedeem(actor);
        if (maxRedeemable > 0) {
            vm.prank(actor);
            try superVault.redeem(maxRedeemable, actor, actor) {} catch {}
        }
    }

    /// @dev Complete withdraw flow: similar to redeem but uses withdraw instead
    function superVault_completeWithdrawFlow_clamped() public {
        address actor = _getActor();
        
        // Step 1: Deposit assets to get shares
        uint256 assets = IERC20(superVault.asset()).balanceOf(actor);
        if (assets == 0) return;
        
        assets = assets % (assets + 1);
        if (assets == 0) return;
        
        MockERC20(superVault.asset()).approve(address(superVault), assets);
        vm.prank(actor);
        try superVault.deposit(assets, actor) {} catch {
            return;
        }
        
        // Step 2: Request redeem
        uint256 shares = superVault.balanceOf(actor);
        if (shares == 0) return;
        
        shares = shares % (shares + 1);
        if (shares == 0) return;
        
        vm.prank(actor);
        try superVault.requestRedeem(shares, actor, actor) {} catch {
            return;
        }
        
        // Step 3: Fulfill the redeem request (as manager)
        uint256 pendingShares = superVaultStrategy.getSuperVaultState(actor).pendingRedeemRequest;
        if (pendingShares == 0) return;
        
        uint256 currentPPS = superVaultStrategy.getStoredPPS();
        if (currentPPS == 0) return;
        
        uint256 assetsOut = pendingShares * currentPPS / 1e18;
        uint256 strategyBalance = IERC20(superVault.asset()).balanceOf(address(superVaultStrategy));
        if (strategyBalance < assetsOut) return;
        
        address[] memory controllers = new address[](1);
        controllers[0] = actor;
        
        uint256[] memory totalAssetsOut = new uint256[](1);
        totalAssetsOut[0] = assetsOut;
        
        // Manager fulfills the request
        vm.prank(address(this));
        try superVaultStrategy.fulfillRedeemRequests(controllers, totalAssetsOut) {} catch {
            return;
        }
        
        // Step 4: Withdraw the assets
        uint256 maxWithdrawable = superVault.maxWithdraw(actor);
        if (maxWithdrawable > 0) {
            vm.prank(actor);
            try superVault.withdraw(maxWithdrawable, actor, actor) {} catch {}
        }
    }

    function superVault_requestRedeem_clamped() public {
        uint256 shares = superVault.balanceOf(_getActor()) % (superVault.balanceOf(_getActor()) + 1);
        superVault_requestRedeem(shares);
    }

    function superVault_transfer_clamped(uint256 entropy) public {
        uint256 value = superVault.balanceOf(_getActor()) % (superVault.balanceOf(_getActor()) + 1);
        superVault_transfer(entropy, value);
    }

    function superVault_transferFrom_clamped(uint256 entropyFrom, uint256 entropyTo) public {
        address from = _getRandomActor(entropyFrom);
        uint256 value = superVault.balanceOf(from) % (superVault.balanceOf(from) + 1);
        superVault_transferFrom(entropyFrom, entropyTo, value);
    }

    /// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///

    function superVault_approve(address spender, uint256 value) public asActor {
        superVault.approve(spender, value);
    }

    function superVault_burnShares(uint256 amount) public asActor {
        superVault.burnShares(amount);
    }

    /// @dev Property: pendingRedeemRequest should be 0 after a user calls cancelRedeem
    /// @dev Property: averageRequestPPS should be 0 after a user calls cancelRedeem
    /// @dev Property: user shouldn't receive more than convertToAssets(pendingRedeemRequest) after cancelRedeem
    function superVault_cancelRedeem()
        public
        updateGhostsWithOpType(OpType.CANCEL)
    {
        uint256 pendingRedeemRequestsBefore = superVault.pendingRedeemRequest(
            0,
            _getActor()
        );
        uint256 pendingRedeemRequestsAsAssets = superVault.convertToAssets(
            pendingRedeemRequestsBefore
        );
        uint256 balanceBefore = MockERC20(superVault.asset()).balanceOf(
            _getActor()
        );

        vm.prank(_getActor());
        superVault.cancelRedeemRequest(0, _getActor());

        address[] memory controllers = new address[](1);
        controllers[0] = _getActor();

        superVaultStrategy.fulfillCancelRedeemRequests(controllers);

        uint256 pendingRedeemRequestsAfter = superVault.pendingRedeemRequest(
            0,
            _getActor()
        );
        uint256 averageRequestPPS = superVaultStrategy
            .getSuperVaultState(_getActor())
            .averageRequestPPS;
        uint256 balanceAfter = MockERC20(superVault.asset()).balanceOf(
            _getActor()
        );

        // Checks
        eq(
            pendingRedeemRequestsAfter,
            0,
            "pendingRedeemRequests should be 0 after cancelling a redemption"
        );
        eq(
            averageRequestPPS,
            0,
            "averageRequestPPS should be 0 after cancelling a redemption"
        );
        lte(
            balanceAfter - balanceBefore,
            pendingRedeemRequestsAsAssets,
            "user shouldn't receive more than convertToAssets(pendingRedeemRequest) after cancelRedeem"
        );
    }

    /// @dev Property: previewDeposit returns the correct amounts compared to executing a deposit
    function superVault_deposit(
        uint256 assets
    ) public updateGhostsWithOpType(OpType.ADD) {
        uint256 previewShares = superVault.previewDeposit(assets);

        vm.prank(_getActor());
        uint256 shares = superVault.deposit(assets, _getActor());

        eq(
            previewShares,
            shares,
            "previewDeposit returns the correct amounts compared to executing a deposit"
        );
    }

    /// @dev Property: previewMint returns the correct amounts compared to executing a mint
    function superVault_mint(
        uint256 shares
    ) public updateGhostsWithOpType(OpType.ADD) {
        uint256 previewMint = superVault.previewMint(shares);

        vm.prank(_getActor());
        uint256 assets = superVault.mint(shares, _getActor());

        eq(
            assets,
            previewMint,
            "previewMint returns the correct amounts compared to executing a mint"
        );
    }

    function superVault_invalidateNonce(bytes32 nonce) public asActor {
        superVault.invalidateNonce(nonce);
    }

    function superVault_redeem(
        uint256 shares
    ) public updateGhostsWithOpType(OpType.REMOVE) asActor {
        superVault.redeem(shares, _getActor(), _getActor());
    }

    function superVault_withdraw(
        uint256 assets
    ) public updateGhostsWithOpType(OpType.REMOVE) asActor {
        superVault.withdraw(assets, _getActor(), _getActor());
    }

    function superVault_requestRedeem(
        uint256 shares
    ) public updateGhostsWithOpType(OpType.REQUEST) asActor {
        superVault.requestRedeem(shares, _getActor(), _getActor());
    }

    function superVault_setOperator(
        uint256 entropy,
        bool approved
    ) public asActor {
        address operator = _getRandomActor(entropy);
        superVault.setOperator(operator, approved);
    }

    /// @dev Propery: _update should never revert
    // NOTE: _update only gets called on transfer of Vault shares
    function superVault_transfer(
        uint256 entropy,
        uint256 value
    ) public updateGhostsWithOpType(OpType.TRANSFER) {
        address to = _getRandomActor(entropy);

        vm.prank(_getActor());
        try superVault.transfer(to, value) {} catch (bytes memory err) {
            bool expectedError;
            expectedError = checkError(
                err,
                "ERC20InsufficientBalance(address,uint256,uint256)"
            );
            t(expectedError, "_update should never revert in transfer");
        }
    }

    /// @dev Propery: _update should never revert
    // NOTE: _update only gets called on transfer of Vault shares
    function superVault_transferFrom(
        uint256 entropyFrom,
        uint256 entropyTo,
        uint256 value
    ) public updateGhostsWithOpType(OpType.TRANSFER) {
        address from = _getRandomActor(entropyFrom);
        address to = _getRandomActor(entropyTo);

        vm.prank(_getActor());
        try superVault.transferFrom(from, to, value) {} catch (
            bytes memory err
        ) {
            bool expectedError;
            expectedError =
                checkError(
                    err,
                    "ERC20InsufficientBalance(address,uint256,uint256)"
                ) ||
                checkError(
                    err,
                    "ERC20InsufficientAllowance(address,uint256,uint256)"
                );
            t(expectedError, "_update should never revert in transferFrom");
        }
    }
}
