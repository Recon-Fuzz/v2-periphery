// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

// External dependencies
import {BaseTargetFunctions} from "@chimera/BaseTargetFunctions.sol";
import {vm} from "@chimera/Hevm.sol";
import {Panic} from "@recon/Panic.sol";

// Source dependencies
import {IECDSAPPSOracle} from "src/interfaces/oracles/IECDSAPPSOracle.sol";
import "test/mocks/MockYieldSourceOracle.sol";
import "../mocks/MockERC4626YieldSourceOracle.sol";
import "../mocks/MockERC5115YieldSourceOracle.sol";

// Test suite dependencies
import {Properties} from "../Properties.sol";

abstract contract OracleTargets is BaseTargetFunctions, Properties {
    /// CUSTOM TARGET FUNCTIONS - Add your own target functions here ///

    function mockERC4626YieldSourceOracle_setValidAsset(
        address asset,
        bool isValid
    ) public asActor {
        MockERC4626YieldSourceOracle(address(erc4626YieldSourceOracle))
            .setValidAsset(asset, isValid);
    }

    function mockERC5115YieldSourceOracle_setValidAsset(
        address asset,
        bool isValid
    ) public asActor {
        MockERC5115YieldSourceOracle(address(erc5115YieldSourceOracle))
            .setValidAsset(asset, isValid);
    }

    /// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///
    function ECDSAPPSOracle_updatePPS(
        IECDSAPPSOracle.UpdatePPSArgs memory args
    ) public asActor {
        ECDSAPPSOracle.updatePPS(args);

        hasUpdatedPPS = true;
    }
}
