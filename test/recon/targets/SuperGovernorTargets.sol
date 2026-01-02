// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {BaseTargetFunctions} from "@chimera/BaseTargetFunctions.sol";
import {Properties} from "../Properties.sol";

import {SuperGovernor, FeeType} from "src/SuperGovernor.sol";

abstract contract SuperGovernorTargets is BaseTargetFunctions, Properties {
    /// CUSTOM TARGET FUNCTIONS - Add your own target functions here ///

    function superGovernor_proposeFee_clamped(uint256 value) public {
        value = value % (10_000 + 1); // BPS_MAX = 10_000
        superGovernor_proposeFee(FeeType.REVENUE_SHARE, value);
    }

    function superGovernor_executeUpkeepClaim_clamped(uint256 amount) public {
        amount = amount % (superVaultAggregator.claimableUpkeep() + 1);
        superGovernor_executeUpkeepClaim(amount);
    }

    function superGovernor_proposeMinStaleness_clamped(uint256 newMinStaleness) public {
        newMinStaleness = newMinStaleness % (superGovernor.getMinStaleness() + 1);
        superGovernor_proposeMinStaleness(newMinStaleness);
    }

    function superGovernor_proposeUpkeepPaymentsChange_clamped() public {
        bool enabled = superGovernor.isUpkeepPaymentsEnabled();
        superGovernor_proposeUpkeepPaymentsChange(enabled);
    }

    function superGovernor_proposeGlobalHooksRoot_clamped() public {
        bytes32 newRoot = bytes32(uint256(1));
        superGovernor_proposeGlobalHooksRoot(newRoot);
    }

    /// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///

    function superGovernor_proposeFee(
        FeeType feeType,
        uint256 value
    ) public asAdmin {
        superGovernor.proposeFee(feeType, value);
    }

    function superGovernor_executeFeeUpdate(FeeType feeType) public asAdmin {
        superGovernor.executeFeeUpdate(feeType);
    }

    function superGovernor_proposeMinStaleness(
        uint256 newMinStaleness
    ) public asAdmin {
        superGovernor.proposeMinStaleness(newMinStaleness);
    }

    function superGovernor_executeMinStalenessChange() public asAdmin {
        superGovernor.executeMinStalenessChange();
    }

    function superGovernor_executeUpkeepClaim(uint256 amount) public asAdmin {
        superGovernor.executeUpkeepClaim(amount);
    }

    function superGovernor_proposeUpkeepPaymentsChange(
        bool enabled
    ) public asAdmin {
        superGovernor.proposeUpkeepPaymentsChange(enabled);
    }

    function superGovernor_executeUpkeepPaymentsChange() public asAdmin {
        superGovernor.executeUpkeepPaymentsChange();
    }

    function superGovernor_proposeGlobalHooksRoot(
        bytes32 newRoot
    ) public asAdmin {
        superGovernor.proposeGlobalHooksRoot(newRoot);
    }
}
