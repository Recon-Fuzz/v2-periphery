// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

// Chimera deps
import { vm } from "@chimera/Hevm.sol";

// Helpers
import { Panic } from "@recon/Panic.sol";

// Interfaces
import { ISuperVaultStrategy } from "src/interfaces/SuperVault/ISuperVaultStrategy.sol";
import { IECDSAPPSOracle } from "src/interfaces/oracles/IECDSAPPSOracle.sol";

// Managers
import { YieldSourceType } from "./managers/YieldManager.sol";

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

    // ============ SHORTCUT FUNCTIONS ============
    // These functions combine multiple prerequisite calls to help the fuzzer
    // reach interesting states more quickly

    /// @dev Shortcut to deposit into SuperVault after creating a vault and minting assets
    function shortcut_deposit(uint256 depositAmount) public {
        // Create a new vault if one doesn't exist
        if (!hasDeployedNewVault) {
            superVaultAggregator_createVault_clamped();
        }
        
        // Mint assets to current actor
        uint256 mintAmount = depositAmount % (type(uint256).max / 2) + 1;
        asset_mint(_getActor(), uint128(mintAmount));
        
        // Deposit into the vault
        superVault_deposit_clamped();
    }

    /// @dev Shortcut to mint shares in SuperVault after creating vault and minting assets
    function shortcut_mint(uint256 mintAmount) public {
        // Create a new vault if one doesn't exist
        if (!hasDeployedNewVault) {
            superVaultAggregator_createVault_clamped();
        }
        
        // Mint assets to current actor
        uint256 assetAmount = mintAmount % (type(uint256).max / 2) + 1;
        asset_mint(_getActor(), uint128(assetAmount));
        
        // Mint shares
        superVault_mint_clamped();
    }

    /// @dev Shortcut to redeem from SuperVault after depositing first
    function shortcut_redeem(uint256 depositAmount) public {
        // Create vault and deposit assets first
        if (!hasDeployedNewVault) {
            superVaultAggregator_createVault_clamped();
        }
        
        // Mint and deposit assets
        uint256 mintAmount = depositAmount % (type(uint256).max / 2) + 1;
        asset_mint(_getActor(), uint128(mintAmount));
        superVault_deposit_clamped();
        
        // Redeem shares
        superVault_redeem_clamped();
    }

    /// @dev Shortcut to withdraw from SuperVault after depositing first
    function shortcut_withdraw(uint256 depositAmount) public {
        // Create vault and deposit assets first
        if (!hasDeployedNewVault) {
            superVaultAggregator_createVault_clamped();
        }
        
        // Mint and deposit assets
        uint256 mintAmount = depositAmount % (type(uint256).max / 2) + 1;
        asset_mint(_getActor(), uint128(mintAmount));
        superVault_deposit_clamped();
        
        // Withdraw assets
        superVault_withdraw_clamped();
    }

    /// @dev Shortcut to request redemption after depositing shares
    function shortcut_requestRedeem(uint256 depositAmount) public {
        // Create vault and deposit assets first
        if (!hasDeployedNewVault) {
            superVaultAggregator_createVault_clamped();
        }
        
        // Mint and deposit assets to get shares
        uint256 mintAmount = depositAmount % (type(uint256).max / 2) + 1;
        asset_mint(_getActor(), uint128(mintAmount));
        superVault_deposit_clamped();
        
        // Request redemption
        superVault_requestRedeem_clamped();
    }

    /// @dev Shortcut to cancel redeem request after creating one
    function shortcut_cancelRedeem(uint256 depositAmount) public {
        // Create vault, deposit, and request redemption
        if (!hasDeployedNewVault) {
            superVaultAggregator_createVault_clamped();
        }
        
        // Mint and deposit assets
        uint256 mintAmount = depositAmount % (type(uint256).max / 2) + 1;
        asset_mint(_getActor(), uint128(mintAmount));
        superVault_deposit_clamped();
        
        // Request redemption first
        superVault_requestRedeem_clamped();
        
        // Cancel the redemption request
        superVault_cancelRedeem();
    }

    /// @dev Shortcut to fulfill redeem requests after multiple users request redemption
    function shortcut_fulfillRedeemRequests(uint256 depositAmount, uint256 redeemShares) public {
        // Create vault if needed
        if (!hasDeployedNewVault) {
            superVaultAggregator_createVault_clamped();
        }
        
        // Have multiple actors deposit and request redemption
        address[] memory controllers = new address[](3);
        
        for (uint256 i = 0; i < 3; i++) {
            switchActor(i);
            uint256 mintAmount = depositAmount % (type(uint256).max / 6) + 1;
            asset_mint(_getActor(), uint128(mintAmount));
            superVault_deposit_clamped();
            superVault_requestRedeem_clamped();
            controllers[i] = _getActor();
        }
        
        // Fulfill the redeem requests
        switchActor(0);
        superVaultStrategy_fulfillRedeemRequests(redeemShares, controllers);
    }

    /// @dev Shortcut to execute hooks after creating vault and depositing
    /// Note: This uses the existing AdminTargets implementation which properly sets up hooks
    function shortcut_executeHooks(uint256 depositAmount) public {
        // Create vault if needed
        if (!hasDeployedNewVault) {
            superVaultAggregator_createVault_clamped();
        }
        
        // Mint and deposit assets into vault
        uint256 mintAmount = depositAmount % (type(uint256).max / 2) + 1;
        asset_mint(_getActor(), uint128(mintAmount));
        superVault_deposit_clamped();
        
        // The hook execution is complex and is better handled by the existing
        // AdminTargets functions like superVaultStrategy_fulfillRedeemRequests
        // which properly set up and execute hooks
    }

    /// @dev Shortcut to handle 4626 deposit operations after vault setup
    function shortcut_handleOperations4626Deposit(uint256 depositAmount, address controller) public {
        // Create vault if needed
        if (!hasDeployedNewVault) {
            superVaultAggregator_createVault_clamped();
        }
        
        // Mint assets to actor
        uint256 mintAmount = depositAmount % (type(uint256).max / 2) + 1;
        asset_mint(_getActor(), uint128(mintAmount));
        
        // Handle the 4626 deposit operation
        superVaultStrategy_handleOperations4626Deposit_clamped(controller);
    }

    /// @dev Shortcut to handle 4626 mint operations after vault setup
    function shortcut_handleOperations4626Mint(uint256 mintAmount, address controller) public {
        // Create vault if needed
        if (!hasDeployedNewVault) {
            superVaultAggregator_createVault_clamped();
        }
        
        // Mint assets to actor
        uint256 assetAmount = mintAmount % (type(uint256).max / 2) + 1;
        asset_mint(_getActor(), uint128(assetAmount));
        
        // Handle the 4626 mint operation
        superVaultStrategy_handleOperations4626Mint_clamped(controller);
    }

    /// @dev Shortcut to handle 7540 operations after vault setup and depositing
    function shortcut_handleOperations7540(
        ISuperVaultStrategy.Operation operation,
        uint256 depositAmount,
        address controller,
        address receiver
    ) public {
        // Create vault if needed
        if (!hasDeployedNewVault) {
            superVaultAggregator_createVault_clamped();
        }
        
        // Mint and deposit assets to have shares
        uint256 mintAmount = depositAmount % (type(uint256).max / 2) + 1;
        asset_mint(controller, uint128(mintAmount));
        switchActor(0); // Ensure we're acting as the right actor
        superVault_deposit_clamped();
        
        // Handle the 7540 operation
        superVaultStrategy_handleOperations7540_clamped(operation, controller, receiver);
    }

    /// @dev Shortcut to transfer vault shares after depositing
    function shortcut_transfer(uint256 depositAmount, uint256 entropyTo) public {
        // Create vault if needed
        if (!hasDeployedNewVault) {
            superVaultAggregator_createVault_clamped();
        }
        
        // Mint and deposit to get shares
        uint256 mintAmount = depositAmount % (type(uint256).max / 2) + 1;
        asset_mint(_getActor(), uint128(mintAmount));
        superVault_deposit_clamped();
        
        // Transfer shares to another actor
        superVault_transfer_clamped(entropyTo);
    }

    /// @dev Shortcut to update PPS through oracle and verify vault state
    function shortcut_updatePPS(uint256 newPPS, uint256 depositAmount) public {
        // Create vault if needed
        if (!hasDeployedNewVault) {
            superVaultAggregator_createVault_clamped();
        }
        
        // Mint and deposit assets
        uint256 mintAmount = depositAmount % (type(uint256).max / 2) + 1;
        asset_mint(_getActor(), uint128(mintAmount));
        superVault_deposit_clamped();
        
        // Update PPS through oracle
        address[] memory strategies = new address[](1);
        strategies[0] = address(superVaultStrategy);
        bytes[][] memory proofsArray = new bytes[][](1);
        proofsArray[0] = new bytes[](1);
        proofsArray[0][0] = new bytes(0);
        uint256[] memory ppss = new uint256[](1);
        ppss[0] = newPPS % (type(uint256).max / 2) + 1;
        uint256[] memory timestamps = new uint256[](1);
        timestamps[0] = block.timestamp;
        
        IECDSAPPSOracle.UpdatePPSArgs memory args = IECDSAPPSOracle.UpdatePPSArgs({
            strategies: strategies,
            proofsArray: proofsArray,
            ppss: ppss,
            timestamps: timestamps
        });
        ECDSAPPSOracle_updatePPS(args);
    }

    /// @dev Shortcut to deposit upkeep tokens after creating vault
    function shortcut_depositUpkeep(uint256 upkeepAmount) public {
        // Create vault if needed
        if (!hasDeployedNewVault) {
            superVaultAggregator_createVault_clamped();
        }
        
        // Mint upkeep tokens to actor
        address upkeepToken = superGovernor.getAddress(superGovernor.UPKEEP_TOKEN());
        asset_mint(_getActor(), uint128(upkeepAmount % (type(uint256).max / 2) + 1));
        
        // Deposit upkeep
        superVaultAggregator_depositUpkeep_clamped();
    }

    /// @dev Shortcut to propose and execute primary manager change
    function shortcut_changePrimaryManager(address newManager, address newFeeRecipient) public {
        // Create vault if needed
        if (!hasDeployedNewVault) {
            superVaultAggregator_createVault_clamped();
        }
        
        // Propose manager change
        superVaultAggregator_proposeChangePrimaryManager(
            address(superVaultStrategy),
            newManager,
            newFeeRecipient
        );
        
        // Advance time to pass timelock
        vm.warp(block.timestamp + 7 days);
        
        // Execute the manager change
        superVaultAggregator_executeChangePrimaryManager(address(superVaultStrategy));
    }

    /// @dev Shortcut to propose and execute fee config update
    function shortcut_updateVaultFeeConfig(address recipient) public {
        // Create vault if needed
        if (!hasDeployedNewVault) {
            superVaultAggregator_createVault_clamped();
        }
        
        // Propose fee config update
        superVaultStrategy_proposeVaultFeeConfigUpdate_clamped(recipient);
        
        // Advance time to pass timelock
        vm.warp(block.timestamp + 7 days);
        
        // Execute fee config update
        superVaultStrategy_executeVaultFeeConfigUpdate();
    }

    /// @dev Shortcut to escrow and return shares
    function shortcut_escrowAndReturnShares(uint256 depositAmount, address from, address to) public {
        // Create vault if needed
        if (!hasDeployedNewVault) {
            superVaultAggregator_createVault_clamped();
        }
        
        // Mint and deposit to get shares
        switchActor(0);
        uint256 mintAmount = depositAmount % (type(uint256).max / 2) + 1;
        asset_mint(from, uint128(mintAmount));
        superVault_deposit_clamped();
        
        // Escrow shares
        superVaultEscrow_escrowShares_clamped(from);
        
        // Return shares
        superVaultEscrow_returnShares_clamped(to);
    }

    /// @dev Shortcut to request, fulfill, and then withdraw/redeem from SuperVault
    /// This helps cover the withdraw/redeem functions which require averageWithdrawPrice to be set
    function shortcut_fulfillAndWithdraw(uint256 depositAmount) public {
        // Create vault if needed
        if (!hasDeployedNewVault) {
            superVaultAggregator_createVault_clamped();
        }
        
        // Mint and deposit assets to get shares
        uint256 mintAmount = depositAmount % (type(uint256).max / 2) + 1;
        asset_mint(_getActor(), uint128(mintAmount));
        superVault_deposit_clamped();
        
        // Request redemption
        superVault_requestRedeem_clamped();
        
        // Fulfill the redemption request (as manager)
        address[] memory controllers = new address[](1);
        controllers[0] = _getActor();
        superVaultStrategy_fulfillRedeemRequests(depositAmount, controllers);
        
        // Now withdraw or redeem assets
        superVault_withdraw_clamped();
    }

    /// @dev Shortcut to request, fulfill, and then redeem from SuperVault
    function shortcut_fulfillAndRedeem(uint256 depositAmount) public {
        // Create vault if needed
        if (!hasDeployedNewVault) {
            superVaultAggregator_createVault_clamped();
        }
        
        // Mint and deposit assets to get shares
        uint256 mintAmount = depositAmount % (type(uint256).max / 2) + 1;
        asset_mint(_getActor(), uint128(mintAmount));
        superVault_deposit_clamped();
        
        // Request redemption
        superVault_requestRedeem_clamped();
        
        // Fulfill the redemption request (as manager)
        address[] memory controllers = new address[](1);
        controllers[0] = _getActor();
        superVaultStrategy_fulfillRedeemRequests(depositAmount, controllers);
        
        // Now redeem shares
        superVault_redeem_clamped();
    }

    /// @dev Shortcut to request, cancel, fulfill cancel, and claim canceled redemption
    /// This helps cover _handleClaimCancelRedeem in SuperVaultStrategy and returnShares in SuperVaultEscrow
    function shortcut_cancelRedeemAndClaim(uint256 depositAmount) public {
        // Create vault if needed
        if (!hasDeployedNewVault) {
            superVaultAggregator_createVault_clamped();
        }
        
        // Mint and deposit assets
        uint256 mintAmount = depositAmount % (type(uint256).max / 2) + 1;
        asset_mint(_getActor(), uint128(mintAmount));
        superVault_deposit_clamped();
        
        // Request redemption first
        superVault_requestRedeem_clamped();
        
        // Cancel the redemption request
        vm.prank(_getActor());
        superVault.cancelRedeemRequest(0, _getActor());
        
        // Fulfill the cancel request (as manager)
        address[] memory controllers = new address[](1);
        controllers[0] = _getActor();
        vm.prank(_getActor());
        try superVaultStrategy.fulfillCancelRedeemRequests(controllers) {} catch {}
        
        // Claim the canceled request - this will call returnShares
        vm.prank(_getActor());
        try superVault.claimCancelRedeemRequest(0, _getActor(), _getActor()) {} catch {}
    }

    /// @dev Shortcut to handle operations 4626 mint with fee configuration
    /// This helps cover the fee handling paths in handleOperations4626Mint
    function shortcut_mintWithFees(uint256 mintAmount) public {
        // Create vault if needed
        if (!hasDeployedNewVault) {
            superVaultAggregator_createVault_clamped();
        }
        
        // Propose fee config with non-zero management fee
        superVaultStrategy_proposeVaultFeeConfigUpdate_clamped(feeRecipient);
        
        // Advance time to pass timelock
        vm.warp(block.timestamp + 7 days);
        
        // Execute fee config update
        vm.prank(_getActor());
        try superVaultStrategy.executeVaultFeeConfigUpdate() {} catch {}
        
        // Mint assets to actor
        uint256 assetAmount = mintAmount % (type(uint256).max / 2) + 1;
        asset_mint(_getActor(), uint128(assetAmount));
        
        // Handle mint operation with fees
        superVaultStrategy_handleOperations4626Mint_clamped(_getActor());
    }

    /// @dev Shortcut to add and remove yield sources
    /// This helps cover manageYieldSources batch operations
    function shortcut_manageYieldSourcesBatch() public {
        // Create vault if needed
        if (!hasDeployedNewVault) {
            superVaultAggregator_createVault_clamped();
        }
        
        // Get current yield source and oracle
        address yieldSource = _getYieldSource();
        YieldSourceType sourceType = _getCurrentYieldSourceType();
        address oracle = _getYieldSourceOracleForType(sourceType);
        
        // Create arrays for batch operation
        address[] memory sources = new address[](2);
        sources[0] = yieldSource;
        sources[1] = yieldSource;
        
        address[] memory oracles = new address[](2);
        oracles[0] = oracle;
        oracles[1] = oracle;
        
        ISuperVaultStrategy.YieldSourceAction[] memory actionTypes = new ISuperVaultStrategy.YieldSourceAction[](2);
        actionTypes[0] = ISuperVaultStrategy.YieldSourceAction.Add;
        actionTypes[1] = ISuperVaultStrategy.YieldSourceAction.Remove;
        
        // Execute batch operation
        vm.prank(_getActor());
        try superVaultStrategy.manageYieldSources(sources, oracles, actionTypes) {} catch {}
    }

    /// @dev Shortcut to propose, wait, and execute upkeep withdrawal
    /// This helps cover depositUpkeep and executeWithdrawUpkeep paths
    function shortcut_proposeAndExecuteUpkeepWithdrawal(uint256 upkeepAmount) public {
        // Create vault if needed
        if (!hasDeployedNewVault) {
            superVaultAggregator_createVault_clamped();
        }
        
        // First deposit upkeep tokens
        address upkeepToken = superGovernor.getAddress(superGovernor.UPKEEP_TOKEN());
        uint256 depositAmount = upkeepAmount % (type(uint256).max / 2) + 1;
        asset_mint(_getActor(), uint128(depositAmount));
        superVaultAggregator_depositUpkeep_clamped();
        
        // Propose upkeep withdrawal
        vm.prank(_getActor());
        try superVaultAggregator.proposeWithdrawUpkeep(address(superVaultStrategy)) {} catch {}
        
        // Advance time to pass timelock
        vm.warp(block.timestamp + 7 days);
        
        // Execute the withdrawal
        vm.prank(_getActor());
        try superVaultAggregator.executeWithdrawUpkeep(address(superVaultStrategy)) {} catch {}
    }

    /// @dev Shortcut to propose, cancel, and execute primary manager change
    /// This helps cover all manager change paths
    function shortcut_managerChangeFlow(address newManager, address newFeeRecipient) public {
        // Create vault if needed
        if (!hasDeployedNewVault) {
            superVaultAggregator_createVault_clamped();
        }
        
        // Propose manager change
        vm.prank(_getActor());
        try superVaultAggregator.proposeChangePrimaryManager(
            address(superVaultStrategy),
            newManager,
            newFeeRecipient
        ) {} catch {}
        
        // Try to cancel (might fail if not authorized, but helps coverage)
        vm.prank(_getActor());
        try superVaultAggregator.cancelChangePrimaryManager(address(superVaultStrategy)) {} catch {}
        
        // Propose again
        vm.prank(_getActor());
        try superVaultAggregator.proposeChangePrimaryManager(
            address(superVaultStrategy),
            newManager,
            newFeeRecipient
        ) {} catch {}
        
        // Advance time to pass timelock
        vm.warp(block.timestamp + 7 days);
        
        // Execute the manager change
        vm.prank(_getActor());
        try superVaultAggregator.executeChangePrimaryManager(address(superVaultStrategy)) {} catch {}
    }

    /// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///

    }
