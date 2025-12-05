// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {FoundryAsserts} from "@chimera/FoundryAsserts.sol";
import {MockERC20} from "@recon/MockERC20.sol";
import {MockERC4626Tester} from "test/recon/mocks/MockERC4626Tester.sol";
import {Test, console2} from "forge-std/Test.sol";
import {Math} from "@openzeppelin/contracts/utils/math/Math.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {
    Deposit4626VaultHook
} from "lib/v2-core/src/hooks/vaults/4626/Deposit4626VaultHook.sol";
import {
    ApproveAndDeposit4626VaultHook
} from "lib/v2-core/src/hooks/vaults/4626/ApproveAndDeposit4626VaultHook.sol";
import {
    Redeem4626VaultHook
} from "lib/v2-core/src/hooks/vaults/4626/Redeem4626VaultHook.sol";
import {ISuperGovernor, FeeType} from "src/interfaces/ISuperGovernor.sol";

import {IECDSAPPSOracle} from "src/interfaces/oracles/IECDSAPPSOracle.sol";
import {
    ISuperVaultStrategy
} from "src/interfaces/SuperVault/ISuperVaultStrategy.sol";
import {
    ISuperVaultAggregator
} from "src/interfaces/SuperVault/ISuperVaultAggregator.sol";
import {YieldSourceType} from "test/recon/managers/YieldManager.sol";

import {MerkleTestHelper} from "./helpers/MerkleTestHelper.sol";
import {TargetFunctions} from "./TargetFunctions.sol";
import {MockERC4626Tester} from "./mocks/MockERC4626Tester.sol";
import {YieldSourceType} from "./managers/YieldManager.sol";

// forge test --match-contract CryticToFoundry -vv
contract CryticToFoundry is Test, TargetFunctions, FoundryAsserts {
    function setUp() public {
        setup();
        merkleHelper = new MerkleTestHelper();
    }
}
