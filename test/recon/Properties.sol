// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {Asserts} from "@chimera/Asserts.sol";
import {MockERC20} from "@recon/MockERC20.sol";
import {vm} from "@chimera/Hevm.sol";
import {ERC7540Properties} from "@properties-7540/ERC7540Properties.sol";
import {Math} from "@openzeppelin/contracts/utils/math/Math.sol";

import {
    ISuperVaultStrategy
} from "src/interfaces/SuperVault/ISuperVaultStrategy.sol";

import {OpType} from "test/recon/BeforeAfter.sol";
import {BeforeAfter} from "./BeforeAfter.sol";

abstract contract Properties is BeforeAfter, Asserts, ERC7540Properties {}
