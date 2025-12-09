# Function: test_SuperBank_TokenBridge_BaseToETH()

**Contract**: [test/integration/SuperVault/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_SuperBank_TokenBridge_BaseToETH()`
- **Visibility**: public
- **Source Range**: 151794:752:580

## Implementation

```solidity
function test_SuperBank_TokenBridge_BaseToETH() public {
    (address assetBase, address assetETH, uint256 superBankEthBefore) = _setupBridgeTestAssets();
    (SuperVault bTVault, SuperVaultStrategy bTStrategy, SuperGovernor govBase, SuperVaultAggregator aggregatorBase) = _setupBridgeTestVault(assetBase);
    _performBridgeTestDeposits(assetBase, bTVault, bTStrategy);
    _processBridgeTestRedemption(bTVault, bTStrategy, govBase, aggregatorBase);
    _executeBridgeAndVerify(assetBase, assetETH, superBankEthBefore);
}
```

## Related Implementations

### _setupBridgeTestAssets()

- **Kind**: internal
- **Source**: 152552:455:580
- **Link**: `test/integration/SuperVault/SuperVault.t.sol:SuperVaultTest:_setupBridgeTestAssets()`

```solidity
function _setupBridgeTestAssets() internal returns (address assetBase, address assetETH, uint256 superBankEthBefore) {
    vm.selectFork(FORKS[ETH]);
    assetETH = existingUnderlyingTokens[ETH][USDC_KEY];
    address superBankETH = _getContract(ETH, SUPER_BANK_KEY);
    superBankEthBefore = IERC20(assetETH).balanceOf(superBankETH);
    vm.selectFork(FORKS[BASE]);
    assetBase = existingUnderlyingTokens[BASE][USDC_KEY];
}
```

### _getContract(uint64,string)

- **Kind**: internal
- **Source**: 20955:162:480
- **Link**: `lib/v2-core/test/BaseTest.t.sol:BaseTest:_getContract(uint64,string)`

```solidity
function _getContract(uint64 chainId, string memory contractName) internal view returns (address) {
    return contractAddresses[chainId][contractName];
}
```

### _setupBridgeTestVault(address)

- **Kind**: internal
- **Source**: 157144:2279:580
- **Link**: `test/integration/SuperVault/SuperVault.t.sol:SuperVaultTest:_setupBridgeTestVault(address)`

```solidity
function _setupBridgeTestVault(address assetBridgeTest) internal returns (SuperVault bridgeTestVault, SuperVaultStrategy bridgeTestStrategy, SuperGovernor govBase, SuperVaultAggregator aggregatorBase) {
    vm.selectFork(FORKS[BASE]);
    (address bridgeTestVaultAddr, address bridgeTestStrategyAddr, ) = _deployVaultOnBase(assetBridgeTest, "svBridgeTest");
    vm.label(bridgeTestVaultAddr, "BridgeTestVault");
    vm.label(bridgeTestStrategyAddr, "BridgeTestStrategy");
    bridgeTestVault = SuperVault(bridgeTestVaultAddr);
    bridgeTestStrategy = SuperVaultStrategy(payable(bridgeTestStrategyAddr));
    address superBankBase = _getContract(BASE, SUPER_BANK_KEY);
    vm.startPrank(MANAGER);
    bridgeTestStrategy.proposeVaultFeeConfigUpdate(5000, 5000, superBankBase);
    vm.warp(block.timestamp + 1 weeks);
    bridgeTestStrategy.executeVaultFeeConfigUpdate();
    vm.stopPrank();
    address morphoVaultAddr = realVaultAddresses[BASE][ERC4626_VAULT_KEY][MORPHO_GAUNTLET_USDC_PRIME_KEY][USDC_KEY];
    vm.prank(MANAGER);
    bridgeTestStrategy.manageYieldSource(morphoVaultAddr, _getContract(BASE, ERC4626_YIELD_SOURCE_ORACLE_KEY), ISuperVaultStrategy.YieldSourceAction.Add);
    _updateSuperVaultBasePPS(bridgeTestStrategyAddr, bridgeTestVaultAddr);
    govBase = SuperGovernor(_getContract(BASE, SUPER_GOVERNOR_KEY));
    govBase.setAddress(govBase.UPKEEP_TOKEN(), assetBridgeTest);
    govBase.setAddress(govBase.SUPER_BANK(), superBankBase);
    address aggregatorBaseAddr = _getContract(BASE, SUPER_VAULT_AGGREGATOR_KEY);
    aggregatorBase = SuperVaultAggregator(aggregatorBaseAddr);
    deal(assetBridgeTest, MANAGER, 200_000e6);
    vm.startPrank(MANAGER);
    IERC20(assetBridgeTest).approve(aggregatorBaseAddr, 100_000e6);
    aggregatorBase.depositUpkeep(bridgeTestStrategyAddr, 100_000e6);
    vm.stopPrank();
    return (bridgeTestVault, bridgeTestStrategy, govBase, aggregatorBase);
}
```

### _deployVaultOnBase(address,string)

- **Kind**: internal
- **Source**: 14876:1421:576
- **Link**: `test/integration/SuperVault/BaseSuperVaultTest.t.sol:BaseSuperVaultTest:_deployVaultOnBase(address,string)`

```solidity
///  @notice Deploys a new SuperVault on Basewith default configuration
///  @return vaultAddr The address of the deployed SuperVault
///  @return strategyAddr The address of the deployed SuperVaultStrategy
///  @return escrowAddr The address of the deployed SuperVaultEscrow
function _deployVaultOnBase(address _asset, string memory _superVaultSymbol) internal returns (address vaultAddr, address strategyAddr, address escrowAddr) {
    vm.selectFork(FORKS[BASE]);
    vm.startPrank(SV_MANAGER);
    SuperVaultAggregator aggregatorBase = SuperVaultAggregator(_getContract(BASE, SUPER_VAULT_AGGREGATOR_KEY));
    (vaultAddr, strategyAddr, escrowAddr) = aggregatorBase.createVault(ISuperVaultAggregator.VaultCreationParams({asset: _asset, name: "SuperVault", symbol: _superVaultSymbol, mainManager: MANAGER, secondaryManagers: new address[](0), minUpdateInterval: 5, maxStaleness: 1 weeks, feeConfig: ISuperVaultStrategy.FeeConfig({performanceFeeBps: 500, managementFeeBps: 0, recipient: address(this)})}));
    vm.label(vaultAddr, string.concat("SuperVault ", _superVaultSymbol));
    vm.label(strategyAddr, string.concat("SuperVaultStrategy ", _superVaultSymbol));
    vm.label(escrowAddr, string.concat("SuperVaultEscrow ", _superVaultSymbol));
    vm.stopPrank();
    return (vaultAddr, strategyAddr, escrowAddr);
}
```

### _updateSuperVaultBasePPS(address,address)

- **Kind**: internal
- **Source**: 116695:3051:576
- **Link**: `test/integration/SuperVault/BaseSuperVaultTest.t.sol:BaseSuperVaultTest:_updateSuperVaultBasePPS(address,address)`

```solidity
///  @notice Updates the PPS (Price Per Share) using TotalAssetHelper
///  @return pps The calculated and updated price per share value
///  @dev This function uses TotalAssetHelper to get totalAssets, calculates PPS,
///       creates a signature, and updates the PPS through the ECDSAPPSOracle contract
function _updateSuperVaultBasePPS(address strategyAddr, address vault_) internal returns (uint256 pps) {
    UpdatePPSVars memory vars;
    TotalAssetHelper tempTotalAssetHelper = new TotalAssetHelper();
    vars.totalSupplyAmount = SuperVault(vault_).totalSupply();
    (vars.currentTotalAssets, ) = tempTotalAssetHelper.totalAssets(strategyAddr);
    vars.precision = SuperVault(vault_).PRECISION();
    if (vars.totalSupplyAmount == 0) {
        vars.pps = vars.precision;
    } else {
        vars.pps = vars.currentTotalAssets.mulDiv(vars.precision, vars.totalSupplyAmount, Math.Rounding.Floor);
    }
    vars.timestamp = block.timestamp;
    ECDSAPPSOracle baseOracle = ECDSAPPSOracle(_getContract(BASE, ECDSAPPS_ORACLE_KEY));
    bytes32 structHash = keccak256(abi.encodePacked(baseOracle.UPDATE_PPS_TYPEHASH(), strategyAddr, vars.pps, vars.timestamp, baseOracle.noncePerStrategy(strategyAddr)));
    vars.ethSignedMessageHash = MessageHashUtils.toTypedDataHash(baseOracle.domainSeparator(), structHash);
    (vars.v, vars.r, vars.s) = vm.sign(VALIDATOR_KEY, vars.ethSignedMessageHash);
    vars.signature = abi.encodePacked(vars.r, vars.s, vars.v);
    vars.proofs = new bytes[](1);
    vars.proofs[0] = vars.signature;
    address[] memory strategies = new address[](1);
    strategies[0] = strategyAddr;
    bytes[][] memory proofsArray = new bytes[][](1);
    proofsArray[0] = vars.proofs;
    uint256[] memory ppss = new uint256[](1);
    ppss[0] = vars.pps;
    uint256[] memory timestamps = new uint256[](1);
    timestamps[0] = vars.timestamp;
    baseOracle.updatePPS(IECDSAPPSOracle.UpdatePPSArgs({strategies: strategies, proofsArray: proofsArray, ppss: ppss, timestamps: timestamps}));
    console2.log("Updated PPS for strategy", strategyAddr, vars.pps);
    pps = vars.pps;
    return pps;
}
```

### mulDiv(uint256,uint256,uint256,enum Math.Rounding)

- **Kind**: internal
- **Source**: 11054:238:60
- **Link**: `lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:mulDiv(uint256,uint256,uint256,enum Math.Rounding)`

```solidity
///  @dev Calculates x * y / denominator with full precision, following the selected rounding direction.
function mulDiv(uint256 x, uint256 y, uint256 denominator, Rounding rounding) internal pure returns (uint256) {
    return mulDiv(x, y, denominator) + SafeCast.toUint(unsignedRoundsUp(rounding) && (mulmod(x, y, denominator) > 0));
}
```

### toUint(bool)

- **Kind**: internal
- **Source**: 34795:145:61
- **Link**: `lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/SafeCast.sol:SafeCast:toUint(bool)`

```solidity
///  @dev Cast a boolean (false or true) to a uint256 (0 or 1) with no jump.
function toUint(bool b) internal pure returns (uint256 u) {
    assembly ("memory-safe") {
        u := iszero(iszero(b))
    }
}
```

### unsignedRoundsUp(enum Math.Rounding)

- **Kind**: internal
- **Source**: 32020:122:60
- **Link**: `lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:unsignedRoundsUp(enum Math.Rounding)`

```solidity
///  @dev Returns whether a provided rounding mode is considered rounding up for unsigned integers.
function unsignedRoundsUp(Rounding rounding) internal pure returns (bool) {
    return (uint8(rounding) % 2) == 1;
}
```

### mulDiv(uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 7242:3683:60
- **Link**: `lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:mulDiv(uint256,uint256,uint256)`

```solidity
///  @dev Calculates floor(x * y / denominator) with full precision. Throws if result overflows a uint256 or
///  denominator == 0.
///  Original credit to Remco Bloemen under MIT license (https://xn--2-umb.com/21/muldiv) with further edits by
///  Uniswap Labs also under MIT license.
function mulDiv(uint256 x, uint256 y, uint256 denominator) internal pure returns (uint256 result) {
    unchecked {
        (uint256 high, uint256 low) = mul512(x, y);
        if (high == 0) {
            return low / denominator;
        }
        if (denominator <= high) {
            Panic.panic(ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW));
        }
        uint256 remainder;
        assembly ("memory-safe") {
            remainder := mulmod(x, y, denominator)
            high := sub(high, gt(remainder, low))
            low := sub(low, remainder)
        }
        uint256 twos = denominator & (0 - denominator);
        assembly ("memory-safe") {
            denominator := div(denominator, twos)
            low := div(low, twos)
            twos := add(div(sub(0, twos), twos), 1)
        }
        low |= high * twos;
        uint256 inverse = (3 * denominator) ^ 2;
        inverse *= 2 - (denominator * inverse);
        inverse *= 2 - (denominator * inverse);
        inverse *= 2 - (denominator * inverse);
        inverse *= 2 - (denominator * inverse);
        inverse *= 2 - (denominator * inverse);
        inverse *= 2 - (denominator * inverse);
        result = low * inverse;
        return result;
    }
}
```

### mul512(uint256,uint256)

- **Kind**: internal
- **Source**: 1027:550:60
- **Link**: `lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:mul512(uint256,uint256)`

```solidity
///  @dev Return the 512-bit multiplication of two uint256.
///  The result is stored in two 256 variables such that product = high * 2²⁵⁶ + low.
function mul512(uint256 a, uint256 b) internal pure returns (uint256 high, uint256 low) {
    assembly ("memory-safe") {
        let mm := mulmod(a, b, not(0))
        low := mul(a, b)
        high := sub(sub(mm, low), lt(mm, low))
    }
}
```

### panic(uint256)

- **Kind**: internal
- **Source**: 1776:194:55
- **Link**: `lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/Panic.sol:Panic:panic(uint256)`

```solidity
/// @dev Reverts with a panic code. Recommended to use with
///  the internal constants with predefined codes.
function panic(uint256 code) internal pure {
    assembly ("memory-safe") {
        mstore(0x00, 0x4e487b71)
        mstore(0x20, code)
        revert(0x1c, 0x24)
    }
}
```

### ternary(bool,uint256,uint256)

- **Kind**: internal
- **Source**: 5071:294:60
- **Link**: `lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:ternary(bool,uint256,uint256)`

```solidity
///  @dev Branchless ternary evaluation for `a ? b : c`. Gas costs are constant.
///  IMPORTANT: This function may reduce bytecode size and consume less gas when used standalone.
///  However, the compiler may optimize Solidity ternary operations (i.e. `a ? b : c`) to only compute
///  one branch when needed, making this function more expensive.
function ternary(bool condition, uint256 a, uint256 b) internal pure returns (uint256) {
    unchecked {
        return b ^ ((a ^ b) * SafeCast.toUint(condition));
    }
}
```

### toTypedDataHash(bytes32,bytes32)

- **Kind**: internal
- **Source**: 3874:374:58
- **Link**: `lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/cryptography/MessageHashUtils.sol:MessageHashUtils:toTypedDataHash(bytes32,bytes32)`

```solidity
///  @dev Returns the keccak256 digest of an EIP-712 typed data (ERC-191 version `0x01`).
///  The digest is calculated from a `domainSeparator` and a `structHash`, by prefixing them with
///  `\x19\x01` and hashing the result. It corresponds to the hash signed by the
///  https://eips.ethereum.org/EIPS/eip-712[`eth_signTypedData`] JSON-RPC method as part of EIP-712.
///  See {ECDSA-recover}.
function toTypedDataHash(bytes32 domainSeparator, bytes32 structHash) internal pure returns (bytes32 digest) {
    assembly ("memory-safe") {
        let ptr := mload(0x40)
        mstore(ptr, "\u0019\u0001")
        mstore(add(ptr, 0x02), domainSeparator)
        mstore(add(ptr, 0x22), structHash)
        digest := keccak256(ptr, 0x42)
    }
}
```

### log(string,address,uint256)

- **Kind**: internal
- **Source**: 13838:169:26
- **Link**: `lib/forge-std/src/console.sol:console:log(string,address,uint256)`

```solidity
function log(string memory p0, address p1, uint256 p2) internal pure {
    _sendLogPayload(abi.encodeWithSignature("log(string,address,uint256)", p0, p1, p2));
}
```

### _sendLogPayload(bytes)

- **Kind**: internal
- **Source**: 8891:133:23
- **Link**: `lib/forge-std/src/StdUtils.sol:StdUtils:_sendLogPayload(bytes)`

```solidity
function _sendLogPayload(bytes memory payload) internal pure {
    _castLogPayloadViewToPure(_sendLogPayloadView)(payload);
}
```

### _castLogPayloadViewToPure(function (bytes)

- **Kind**: internal
- **Source**: 8650:235:23
- **Link**: `lib/forge-std/src/StdUtils.sol:StdUtils:_castLogPayloadViewToPure(function (bytes) view)`

```solidity
function _castLogPayloadViewToPure(function(bytes memory) internal view fnIn) internal pure returns (function(bytes memory) internal pure fnOut) {
    assembly {
        fnOut := fnIn
    }
}
```

### deal(address,address,uint256)

- **Kind**: internal
- **Source**: 27270:117:14
- **Link**: `lib/forge-std/src/StdCheats.sol:StdCheats:deal(address,address,uint256)`

```solidity
function deal(address token, address to, uint256 give) virtual internal {
    deal(token, to, give, false);
}
```

### deal(address,address,uint256,bool)

- **Kind**: internal
- **Source**: 27666:837:14
- **Link**: `lib/forge-std/src/StdCheats.sol:StdCheats:deal(address,address,uint256,bool)`

```solidity
function deal(address token, address to, uint256 give, bool adjust) virtual internal {
    (, bytes memory balData) = token.staticcall(abi.encodeWithSelector(0x70a08231, to));
    uint256 prevBal = abi.decode(balData, (uint256));
    stdstore.target(token).sig(0x70a08231).with_key(to).checked_write(give);
    if (adjust) {
        (, bytes memory totSupData) = token.staticcall(abi.encodeWithSelector(0x18160ddd));
        uint256 totSup = abi.decode(totSupData, (uint256));
        if (give < prevBal) {
            totSup -= (prevBal - give);
        } else {
            totSup += (give - prevBal);
        }
        stdstore.target(token).sig(0x18160ddd).checked_write(totSup);
    }
}
```

### target(struct StdStorage,address)

- **Kind**: internal
- **Source**: 13254:156:20
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorage:target(struct StdStorage,address)`

```solidity
function target(StdStorage storage self, address _target) internal returns (StdStorage storage) {
    return stdStorageSafe.target(self, _target);
}
```

### target(struct StdStorage,address)

- **Kind**: internal
- **Source**: 6743:156:20
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:target(struct StdStorage,address)`

```solidity
function target(StdStorage storage self, address _target) internal returns (StdStorage storage) {
    self._target = _target;
    return self;
}
```

### sig(struct StdStorage,bytes4)

- **Kind**: internal
- **Source**: 13416:143:20
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorage:sig(struct StdStorage,bytes4)`

```solidity
function sig(StdStorage storage self, bytes4 _sig) internal returns (StdStorage storage) {
    return stdStorageSafe.sig(self, _sig);
}
```

### sig(struct StdStorage,bytes4)

- **Kind**: internal
- **Source**: 6905:143:20
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:sig(struct StdStorage,bytes4)`

```solidity
function sig(StdStorage storage self, bytes4 _sig) internal returns (StdStorage storage) {
    self._sig = _sig;
    return self;
}
```

### with_key(struct StdStorage,address)

- **Kind**: internal
- **Source**: 13721:152:20
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorage:with_key(struct StdStorage,address)`

```solidity
function with_key(StdStorage storage self, address who) internal returns (StdStorage storage) {
    return stdStorageSafe.with_key(self, who);
}
```

### with_key(struct StdStorage,address)

- **Kind**: internal
- **Source**: 7396:179:20
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:with_key(struct StdStorage,address)`

```solidity
function with_key(StdStorage storage self, address who) internal returns (StdStorage storage) {
    self._keys.push(bytes32(uint256(uint160(who))));
    return self;
}
```

### checked_write(struct StdStorage,uint256)

- **Kind**: internal
- **Source**: 14942:120:20
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorage:checked_write(struct StdStorage,uint256)`

```solidity
function checked_write(StdStorage storage self, uint256 amt) internal {
    checked_write(self, bytes32(amt));
}
```

### checked_write(struct StdStorage,bytes32)

- **Kind**: internal
- **Source**: 15434:1484:20
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorage:checked_write(struct StdStorage,bytes32)`

```solidity
function checked_write(StdStorage storage self, bytes32 set) internal {
    address who = self._target;
    bytes4 fsig = self._sig;
    uint256 field_depth = self._depth;
    bytes memory params = stdStorageSafe.getCallParams(self);
    if (!self.finds[who][fsig][keccak256(abi.encodePacked(params, field_depth))].found) {
        find(self, false);
    }
    FindData storage data = self.finds[who][fsig][keccak256(abi.encodePacked(params, field_depth))];
    if ((data.offsetLeft + data.offsetRight) > 0) {
        uint256 maxVal = 2 ** (256 - (data.offsetLeft + data.offsetRight));
        require(uint256(set) < maxVal, string(abi.encodePacked("stdStorage find(StdStorage): Packed slot. We can't fit value greater than ", vm.toString(maxVal))));
    }
    bytes32 curVal = vm.load(who, bytes32(data.slot));
    bytes32 valToSet = stdStorageSafe.getUpdatedSlotValue(curVal, uint256(set), data.offsetLeft, data.offsetRight);
    vm.store(who, bytes32(data.slot), valToSet);
    (bool success, bytes32 callResult) = stdStorageSafe.callTarget(self);
    if ((!success) || (callResult != set)) {
        vm.store(who, bytes32(data.slot), curVal);
        revert("stdStorage find(StdStorage): Failed to write value.");
    }
    clear(self);
}
```

### getCallParams(struct StdStorage)

- **Kind**: internal
- **Source**: 953:236:20
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:getCallParams(struct StdStorage)`

```solidity
function getCallParams(StdStorage storage self) internal view returns (bytes memory) {
    if (self._calldata.length == 0) {
        return flatten(self._keys);
    } else {
        return self._calldata;
    }
}
```

### flatten(bytes32[])

- **Kind**: internal
- **Source**: 11182:393:20
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:flatten(bytes32[])`

```solidity
function flatten(bytes32[] memory b) private pure returns (bytes memory) {
    bytes memory result = new bytes(b.length * 32);
    for (uint256 i = 0; i < b.length; i++) {
        bytes32 k = b[i];
        /// @solidity memory-safe-assembly
        assembly {
            mstore(add(result, add(32, mul(32, i))), k)
        }
    }
    return result;
}
```

### find(struct StdStorage,bool)

- **Kind**: internal
- **Source**: 13107:141:20
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorage:find(struct StdStorage,bool)`

```solidity
function find(StdStorage storage self, bool _clear) internal returns (uint256) {
    return stdStorageSafe.find(self, _clear).slot;
}
```

### find(struct StdStorage,bool)

- **Kind**: internal
- **Source**: 4245:2492:20
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:find(struct StdStorage,bool)`

```solidity
/// @notice find an arbitrary storage slot given a function sig, input data, address of the contract and a value to check against
function find(StdStorage storage self, bool _clear) internal returns (FindData storage) {
    address who = self._target;
    bytes4 fsig = self._sig;
    uint256 field_depth = self._depth;
    bytes memory params = getCallParams(self);
    if (self.finds[who][fsig][keccak256(abi.encodePacked(params, field_depth))].found) {
        if (_clear) {
            clear(self);
        }
        return self.finds[who][fsig][keccak256(abi.encodePacked(params, field_depth))];
    }
    vm.record();
    (, bytes32 callResult) = callTarget(self);
    (bytes32[] memory reads, ) = vm.accesses(address(who));
    if (reads.length == 0) {
        revert("stdStorage find(StdStorage): No storage use detected for target.");
    } else {
        for (uint256 i = reads.length; (--i) >= 0; ) {
            bytes32 prev = vm.load(who, reads[i]);
            if (prev == bytes32(0)) {
                emit WARNING_UninitedSlot(who, uint256(reads[i]));
            }
            if (!checkSlotMutatesCall(self, reads[i])) {
                continue;
            }
            (uint256 offsetLeft, uint256 offsetRight) = (0, 0);
            if (self._enable_packed_slots) {
                bool found;
                (found, offsetLeft, offsetRight) = findOffsets(self, reads[i]);
                if (!found) {
                    continue;
                }
            }
            uint256 curVal = (uint256(prev) & getMaskByOffsets(offsetLeft, offsetRight)) >> offsetRight;
            if (uint256(callResult) != curVal) {
                continue;
            }
            emit SlotFound(who, fsig, keccak256(abi.encodePacked(params, field_depth)), uint256(reads[i]));
            self.finds[who][fsig][keccak256(abi.encodePacked(params, field_depth))] = FindData(uint256(reads[i]), offsetLeft, offsetRight, true);
            break;
        }
    }
    require(self.finds[who][fsig][keccak256(abi.encodePacked(params, field_depth))].found, "stdStorage find(StdStorage): Slot(s) not found.");
    if (_clear) {
        clear(self);
    }
    return self.finds[who][fsig][keccak256(abi.encodePacked(params, field_depth))];
}
```

### clear(struct StdStorage)

- **Kind**: internal
- **Source**: 11581:239:20
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:clear(struct StdStorage)`

```solidity
function clear(StdStorage storage self) internal {
    delete self._target;
    delete self._sig;
    delete self._keys;
    delete self._depth;
    delete self._enable_packed_slots;
    delete self._calldata;
}
```

### callTarget(struct StdStorage)

- **Kind**: internal
- **Source**: 1251:339:20
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:callTarget(struct StdStorage)`

```solidity
function callTarget(StdStorage storage self) internal view returns (bool, bytes32) {
    bytes memory cd = abi.encodePacked(self._sig, getCallParams(self));
    (bool success, bytes memory rdat) = self._target.staticcall(cd);
    bytes32 result = bytesToBytes32(rdat, 32 * self._depth);
    return (success, result);
}
```

### bytesToBytes32(bytes,uint256)

- **Kind**: internal
- **Source**: 10872:304:20
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:bytesToBytes32(bytes,uint256)`

```solidity
function bytesToBytes32(bytes memory b, uint256 offset) private pure returns (bytes32) {
    bytes32 out;
    uint256 max = (b.length > 32) ? 32 : b.length;
    for (uint256 i = 0; i < max; i++) {
        out |= bytes32(b[offset + i] & 0xFF) >> (i * 8);
    }
    return out;
}
```

### checkSlotMutatesCall(struct StdStorage,bytes32)

- **Kind**: internal
- **Source**: 1847:546:20
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:checkSlotMutatesCall(struct StdStorage,bytes32)`

```solidity
function checkSlotMutatesCall(StdStorage storage self, bytes32 slot) internal returns (bool) {
    bytes32 prevSlotValue = vm.load(self._target, slot);
    (bool success, bytes32 prevReturnValue) = callTarget(self);
    bytes32 testVal = (prevReturnValue == bytes32(0)) ? bytes32(UINT256_MAX) : bytes32(0);
    vm.store(self._target, slot, testVal);
    (, bytes32 newReturnValue) = callTarget(self);
    vm.store(self._target, slot, prevSlotValue);
    return (success && (prevReturnValue != newReturnValue));
}
```

### findOffsets(struct StdStorage,bytes32)

- **Kind**: internal
- **Source**: 3076:534:20
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:findOffsets(struct StdStorage,bytes32)`

```solidity
function findOffsets(StdStorage storage self, bytes32 slot) internal returns (bool, uint256, uint256) {
    bytes32 prevSlotValue = vm.load(self._target, slot);
    (bool foundLeft, uint256 offsetLeft) = findOffset(self, slot, true);
    (bool foundRight, uint256 offsetRight) = findOffset(self, slot, false);
    vm.store(self._target, slot, prevSlotValue);
    return (foundLeft && foundRight, offsetLeft, offsetRight);
}
```

### findOffset(struct StdStorage,bytes32,bool)

- **Kind**: internal
- **Source**: 2556:514:20
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:findOffset(struct StdStorage,bytes32,bool)`

```solidity
function findOffset(StdStorage storage self, bytes32 slot, bool left) internal returns (bool, uint256) {
    for (uint256 offset = 0; offset < 256; offset++) {
        uint256 valueToPut = left ? (1 << (255 - offset)) : (1 << offset);
        vm.store(self._target, slot, bytes32(valueToPut));
        (bool success, bytes32 data) = callTarget(self);
        if (success && (uint256(data) > 0)) {
            return (true, offset);
        }
    }
    return (false, 0);
}
```

### getMaskByOffsets(uint256,uint256)

- **Kind**: internal
- **Source**: 12013:376:20
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:getMaskByOffsets(uint256,uint256)`

```solidity
function getMaskByOffsets(uint256 offsetLeft, uint256 offsetRight) internal pure returns (uint256 mask) {
    assembly {
        mask := shl(offsetRight, sub(shl(sub(256, add(offsetRight, offsetLeft)), 1), 1))
    }
}
```

### getUpdatedSlotValue(bytes32,uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 12451:300:20
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:getUpdatedSlotValue(bytes32,uint256,uint256,uint256)`

```solidity
function getUpdatedSlotValue(bytes32 curValue, uint256 varValue, uint256 offsetLeft, uint256 offsetRight) internal pure returns (bytes32 newValue) {
    return bytes32((uint256(curValue) & (~getMaskByOffsets(offsetLeft, offsetRight))) | (varValue << offsetRight));
}
```

### clear(struct StdStorage)

- **Kind**: internal
- **Source**: 14700:92:20
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorage:clear(struct StdStorage)`

```solidity
function clear(StdStorage storage self) internal {
    stdStorageSafe.clear(self);
}
```

### _performBridgeTestDeposits(address,contract SuperVault,contract SuperVaultStrategy)

- **Kind**: internal
- **Source**: 153013:1149:580
- **Link**: `test/integration/SuperVault/SuperVault.t.sol:SuperVaultTest:_performBridgeTestDeposits(address,contract SuperVault,contract SuperVaultStrategy)`

```solidity
function _performBridgeTestDeposits(address assetBase, SuperVault bTVault, SuperVaultStrategy bTStrategy) internal {
    uint256 depositAmount = 100_000e6;
    AccountInstance memory accountBase = makeAccountInstance("accountBase");
    AccountInstance memory accountBase1 = makeAccountInstance("accountBase1");
    deal(assetBase, accountBase.account, depositAmount);
    deal(assetBase, accountBase1.account, depositAmount);
    vm.startPrank(accountBase.account);
    IERC20(assetBase).approve(address(bTVault), depositAmount);
    bTVault.deposit(depositAmount, accountBase.account);
    vm.stopPrank();
    vm.startPrank(accountBase1.account);
    IERC20(assetBase).approve(address(bTVault), depositAmount);
    bTVault.deposit(depositAmount, accountBase1.account);
    vm.stopPrank();
    address morphoVaultAddr = realVaultAddresses[BASE][ERC4626_VAULT_KEY][MORPHO_GAUNTLET_USDC_PRIME_KEY][USDC_KEY];
    _depositIntoUnderlyingOnBase(assetBase, morphoVaultAddr, address(bTStrategy), depositAmount);
    _updateSuperVaultBasePPS(address(bTStrategy), address(bTVault));
}
```

### makeAccountInstance(bytes32)

- **Kind**: internal
- **Source**: 11712:1136:233
- **Link**: `lib/v2-core/lib/modulekit/src/test/RhinestoneModuleKit.sol:RhinestoneModuleKit:makeAccountInstance(bytes32)`

```solidity
/// @notice Create an account instance with the provided salt
///  @param salt The salt used to create the account
///  @return instance The account instance
function makeAccountInstance(bytes32 salt) internal initializeModuleKit() returns (AccountInstance memory instance) {
    (AccountType env, address accountFactoryAddress, address accountHelper) = ModuleKitHelpers.getAccountEnv();
    IAccountFactory accountFactory = IAccountFactory(accountFactoryAddress);
    bytes memory initData = accountFactory.getInitData(address(_defaultValidator), "");
    address account = accountFactory.getAddress(salt, initData);
    bytes memory initCode = abi.encodePacked(address(accountFactory), abi.encodeCall(accountFactory.createAccount, (salt, initData)));
    label(address(account), toString(salt));
    deal(account, 10 ether);
    instance = _makeAccountInstance({salt: salt, accountType: env, helper: accountHelper, account: account, initCode: initCode, validator: address(_defaultValidator), accountFactory: address(accountFactory), sessionValidator: address(_defaultSessionValidator)});
}
```

### getAccountEnv()

- **Kind**: internal
- **Source**: 29353:871:232
- **Link**: `lib/v2-core/lib/modulekit/src/test/ModuleKitHelpers.sol:ModuleKitHelpers:getAccountEnv()`

```solidity
/// @notice Gets the account environment from storage
function getAccountEnv() internal view returns (AccountType env, address, address) {
    (bytes32 envHash, address factory, address helper) = getAccountEnvFromStorage();
    if (envHash == keccak256(abi.encodePacked(DEFAULT))) {
        return (AccountType.DEFAULT, factory, helper);
    } else if (envHash == keccak256(abi.encodePacked(SAFE))) {
        return (AccountType.SAFE, factory, helper);
    } else if (envHash == keccak256(abi.encodePacked(KERNEL))) {
        return (AccountType.KERNEL, factory, helper);
    } else if (envHash == keccak256(abi.encodePacked(CUSTOM))) {
        return (AccountType.CUSTOM, factory, helper);
    } else if (envHash == keccak256(abi.encodePacked(NEXUS))) {
        return (AccountType.NEXUS, factory, helper);
    } else {
        revert InvalidAccountType();
    }
}
```

### getAccountEnv()

- **Kind**: free-function
- **Source**: 3246:404:243
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Storage.sol:getAccountEnv()`

```solidity
function getAccountEnv() view returns (bytes32 env, address factory, address helper) {
    bytes32 envSlot = keccak256("ModuleKit.AccountTypeSlot");
    bytes32 factorySlot = keccak256("ModuleKit.AccountFactorySlot");
    bytes32 helperSlot = keccak256("ModuleKit.HelperSlot");
    assembly {
        env := sload(envSlot)
        factory := sload(factorySlot)
        helper := sload(helperSlot)
    }
}
```

### label(address,string)

- **Kind**: free-function
- **Source**: 971:93:244
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Vm.sol:label(address,string)`

```solidity
function label(address _addr, string memory _label) {
    Vm(VM_ADDR).label(_addr, _label);
}
```

### toString(bytes32)

- **Kind**: free-function
- **Source**: 4142:208:244
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Vm.sol:toString(bytes32)`

```solidity
function toString(bytes32 input) pure returns (string memory) {
    bytes memory _bytes = new bytes(32);
    for (uint256 i = 0; i < 32; i++) {
        _bytes[i] = input[i];
    }
    return string(_bytes);
}
```

### deal(address,uint256)

- **Kind**: internal
- **Source**: 27055:91:14
- **Link**: `lib/forge-std/src/StdCheats.sol:StdCheats:deal(address,uint256)`

```solidity
function deal(address to, uint256 give) virtual internal {
    vm.deal(to, give);
}
```

### _makeAccountInstance(bytes32,address,bytes,address,address,address,enum AccountType,address)

- **Kind**: internal
- **Source**: 18993:828:233
- **Link**: `lib/v2-core/lib/modulekit/src/test/RhinestoneModuleKit.sol:RhinestoneModuleKit:_makeAccountInstance(bytes32,address,bytes,address,address,address,enum AccountType,address)`

```solidity
/// @notice Create an account instance with the provided salt, account, init code, account
///          factory, validator, session validator, account type, and helper
///  @param salt The salt used to create the account
///  @param account The address of the account
///  @param initCode The init code used to create the account
///  @param accountFactory The address of the account factory
///  @param validator The address of the validator
///  @param sessionValidator The address of the session validator
///  @param accountType The type of the account
///  @param helper The address of the account helper
///  @return instance The account instance
function _makeAccountInstance(bytes32 salt, address account, bytes memory initCode, address accountFactory, address validator, address sessionValidator, AccountType accountType, address helper) internal view returns (AccountInstance memory instance) {
    instance = AccountInstance({accountType: accountType, accountHelper: helper, account: account, aux: auxiliary, salt: salt, defaultValidator: IERC7579Validator(validator), initCode: initCode, accountFactory: accountFactory, smartSession: ISmartSession(SMARTSESSION_ADDR), defaultSessionValidator: ISessionValidator(sessionValidator)});
}
```

### initializeModuleKit()

- **Kind**: modifier
- **Source**: 20107:202:233
- **Link**: `lib/v2-core/lib/modulekit/src/test/RhinestoneModuleKit.sol:RhinestoneModuleKit:initializeModuleKit()`

```solidity
/// @dev Initialize the module kit with the provided environment if it has not been initialized
modifier initializeModuleKit() {
    if (!isInit[block.chainid]) {
        string memory _env = envOr("ACCOUNT_TYPE", DEFAULT);
        _initializeModuleKit(_env);
    }
    _;
}
```

### envOr(string,string)

- **Kind**: internal
- **Source**: 4081:166:500
- **Link**: `lib/v2-core/test/utils/Helpers.sol:Helpers:envOr(string,string)`

```solidity
function envOr(string memory name, string memory defaultValue) public view returns (string memory value) {
    return Vm(VM_ADDR).envOr(name, defaultValue);
}
```

### _initializeModuleKit(string)

- **Kind**: internal
- **Source**: 8404:2950:233
- **Link**: `lib/v2-core/lib/modulekit/src/test/RhinestoneModuleKit.sol:RhinestoneModuleKit:_initializeModuleKit(string)`

```solidity
/// @notice Initialize the module kit with the provided environment, deploy the factories,
///          helpers, and validators, and stake them on the entrypoint
function _initializeModuleKit(string memory _env) internal {
    super.init();
    isInit[block.chainid] = true;
    writeFactory(address(new ERC7579Factory()), DEFAULT);
    writeFactory(address(new SafeFactory()), SAFE);
    writeFactory(address(new KernelFactory()), KERNEL);
    writeFactory(address(new NexusFactory()), NEXUS);
    writeFactory(address(new ERC7579Factory()), CUSTOM);
    writeHelper(address(new ERC7579Helpers()), DEFAULT);
    writeHelper(address(new SafeHelpers()), SAFE);
    writeHelper(address(new KernelHelpers()), KERNEL);
    writeHelper(address(new NexusHelpers()), NEXUS);
    writeHelper(address(new ERC7579Helpers()), CUSTOM);
    IAccountFactory safeFactory = IAccountFactory(getFactory(SAFE));
    IAccountFactory kernelFactory = IAccountFactory(getFactory(KERNEL));
    IAccountFactory erc7579Factory = IAccountFactory(getFactory(DEFAULT));
    IAccountFactory nexusFactory = IAccountFactory(getFactory(NEXUS));
    IAccountFactory customFactory = IAccountFactory(getFactory(CUSTOM));
    safeFactory.init();
    kernelFactory.init();
    erc7579Factory.init();
    nexusFactory.init();
    customFactory.init();
    label(address(safeFactory), "SafeFactory");
    label(address(kernelFactory), "KernelFactory");
    label(address(erc7579Factory), "ERC7579Factory");
    label(address(nexusFactory), "NexusFactory");
    label(address(customFactory), "CustomFactory");
    deal(address(safeFactory), 10 ether);
    deal(address(kernelFactory), 10 ether);
    deal(address(erc7579Factory), 10 ether);
    deal(address(nexusFactory), 10 ether);
    deal(address(customFactory), 10 ether);
    prank(address(safeFactory));
    IStakeManager(ENTRYPOINT_ADDR).addStake{value: 10 ether}(100_000);
    prank(address(kernelFactory));
    IStakeManager(ENTRYPOINT_ADDR).addStake{value: 10 ether}(100_000);
    prank(address(erc7579Factory));
    IStakeManager(ENTRYPOINT_ADDR).addStake{value: 10 ether}(100_000);
    prank(address(nexusFactory));
    IStakeManager(ENTRYPOINT_ADDR).addStake{value: 10 ether}(100_000);
    ModuleKitHelpers.setAccountEnv(_env);
    IAccountFactory accountFactory = IAccountFactory(getFactory(_env));
    label(address(accountFactory), "AccountFactory");
    _defaultValidator = new MockValidator();
    label(address(_defaultValidator), "DefaultValidator");
    _defaultSessionValidator = new MockStatelessValidator();
    label(address(_defaultSessionValidator), "SessionValidator");
}
```

### init()

- **Kind**: internal
- **Source**: 1861:543:231
- **Link**: `lib/v2-core/lib/modulekit/src/test/Auxiliary.sol:AuxiliaryFactory:init()`

```solidity
/// @notice Initializes and labels all the auxiliary contracts.
function init() virtual internal {
    auxiliary.mockFactory = new MockFactory();
    label(address(auxiliary.mockFactory), "Mock Factory");
    auxiliary.gasSimulation = new UserOpGasLog();
    auxiliary.entrypoint = etchEntrypoint();
    label(address(auxiliary.entrypoint), "EntryPoint");
    auxiliary.registry = etchRegistry();
    label(address(auxiliary.registry), "ERC7484Registry");
    auxiliary.smartSession = etchSmartSessions();
    label(address(auxiliary.smartSession), "SmartSession");
}
```

### etchEntrypoint()

- **Kind**: free-function
- **Source**: 1312:297:187
- **Link**: `lib/v2-core/lib/modulekit/src/deployment/predeploy/EntryPoint.sol:etchEntrypoint()`

```solidity
function etchEntrypoint() returns (IEntryPoint) {
    address payable entryPoint = payable(address(new EntryPointSimulationsPatch()));
    etch(ENTRYPOINT_ADDR, entryPoint.code);
    EntryPointSimulationsPatch(payable(ENTRYPOINT_ADDR)).init(entryPoint);
    return IEntryPoint(ENTRYPOINT_ADDR);
}
```

### etch(address,bytes)

- **Kind**: free-function
- **Source**: 859:110:244
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Vm.sol:etch(address,bytes)`

```solidity
function etch(address target, bytes memory runtimeBytecode) {
    Vm(VM_ADDR).etch(target, runtimeBytecode);
}
```

### etchRegistry()

- **Kind**: free-function
- **Source**: 357:176:189
- **Link**: `lib/v2-core/lib/modulekit/src/deployment/predeploy/Registry.sol:etchRegistry()`

```solidity
function etchRegistry() returns (IERC7484) {
    address _registry = address(new MockRegistry());
    etch(REGISTRY_ADDR, _registry.code);
    return IERC7484(REGISTRY_ADDR);
}
```

### etchSmartSessions()

- **Kind**: free-function
- **Source**: 378:172:186
- **Link**: `lib/v2-core/lib/modulekit/src/deployment/precompiles/SmartSessionsPrecompiles.sol:etchSmartSessions()`

```solidity
function etchSmartSessions() returns (ISmartSession) {
    etch(address(SMARTSESSION_ADDR), SMART_SESSION_DEPLOYED_BYTECODE);
    return ISmartSession(SMARTSESSION_ADDR);
}
```

### writeFactory(address,string)

- **Kind**: free-function
- **Source**: 4416:204:243
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Storage.sol:writeFactory(address,string)`

```solidity
function writeFactory(address factory, string memory factoryType) {
    bytes32 slot = keccak256(abi.encode("ModuleKit.", factoryType, "FactorySlot"));
    assembly {
        sstore(slot, factory)
    }
}
```

### writeHelper(address,string)

- **Kind**: free-function
- **Source**: 5007:198:243
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Storage.sol:writeHelper(address,string)`

```solidity
function writeHelper(address helper, string memory helperType) {
    bytes32 slot = keccak256(abi.encode("ModuleKit.", helperType, "HelperSlot"));
    assembly {
        sstore(slot, helper)
    }
}
```

### getFactory(string)

- **Kind**: free-function
- **Source**: 4622:217:243
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Storage.sol:getFactory(string)`

```solidity
function getFactory(string memory factoryType) view returns (address factory) {
    bytes32 slot = keccak256(abi.encode("ModuleKit.", factoryType, "FactorySlot"));
    assembly {
        factory := sload(slot)
    }
}
```

### prank(address)

- **Kind**: free-function
- **Source**: 1619:63:244
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Vm.sol:prank(address)`

```solidity
function prank(address _addr) {
    Vm(VM_ADDR).prank(_addr);
}
```

### setAccountEnv(string)

- **Kind**: internal
- **Source**: 26858:87:232
- **Link**: `lib/v2-core/lib/modulekit/src/test/ModuleKitHelpers.sol:ModuleKitHelpers:setAccountEnv(string)`

```solidity
/// @notice Sets the account type in storage from a string
///  @param env The string to set
function setAccountEnv(string memory env) internal {
    _setAccountEnv(env);
}
```

### _setAccountEnv(string)

- **Kind**: internal
- **Source**: 28352:937:232
- **Link**: `lib/v2-core/lib/modulekit/src/test/ModuleKitHelpers.sol:ModuleKitHelpers:_setAccountEnv(string)`

```solidity
/// @notice Sets the account type in storage from a string
function _setAccountEnv(string memory env) private {
    address factory = getFactory(env);
    address helper = getHelperFromStorage(env);
    if (keccak256(abi.encodePacked(env)) == keccak256(abi.encodePacked(DEFAULT))) {
        writeAccountEnv(env, factory, helper);
    } else if (keccak256(abi.encodePacked(env)) == keccak256(abi.encodePacked(SAFE))) {
        writeAccountEnv(env, factory, helper);
    } else if (keccak256(abi.encodePacked(env)) == keccak256(abi.encodePacked(KERNEL))) {
        writeAccountEnv(env, factory, helper);
    } else if (keccak256(abi.encodePacked(env)) == keccak256(abi.encodePacked(CUSTOM))) {
        writeAccountEnv(env, factory, helper);
    } else if (keccak256(abi.encodePacked(env)) == keccak256(abi.encodePacked(NEXUS))) {
        writeAccountEnv(env, factory, helper);
    } else {
        revert InvalidAccountType();
    }
}
```

### getHelper(string)

- **Kind**: free-function
- **Source**: 5207:211:243
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Storage.sol:getHelper(string)`

```solidity
function getHelper(string memory helperType) view returns (address helper) {
    bytes32 slot = keccak256(abi.encode("ModuleKit.", helperType, "HelperSlot"));
    assembly {
        helper := sload(slot)
    }
}
```

### writeAccountEnv(string,address,address)

- **Kind**: free-function
- **Source**: 2791:453:243
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Storage.sol:writeAccountEnv(string,address,address)`

```solidity
function writeAccountEnv(string memory env, address factory, address helper) {
    bytes32 envSlot = keccak256("ModuleKit.AccountTypeSlot");
    bytes32 factorySlot = keccak256("ModuleKit.AccountFactorySlot");
    bytes32 helperSlot = keccak256("ModuleKit.HelperSlot");
    bytes32 envHash = keccak256(abi.encodePacked(env));
    assembly {
        sstore(envSlot, envHash)
        sstore(factorySlot, factory)
        sstore(helperSlot, helper)
    }
}
```

### _depositIntoUnderlyingOnBase(address,address,address,uint256)

- **Kind**: internal
- **Source**: 159782:2860:580
- **Link**: `test/integration/SuperVault/SuperVault.t.sol:SuperVaultTest:_depositIntoUnderlyingOnBase(address,address,address,uint256)`

```solidity
///  @notice Helper function to deposit into underlying vault on Base chain with merkle proofs
///  @param assetOnBase The asset to deposit
///  @param baseUnderlying The underlying vault to deposit into
///  @param bridgeTestStrategy The strategy executing the deposit
///  @param depositAmount The amount of asset to deposit
function _depositIntoUnderlyingOnBase(address assetOnBase, address baseUnderlying, address bridgeTestStrategy, uint256 depositAmount) internal {
    address depositHookAddress = _getHookAddress(BASE, APPROVE_AND_DEPOSIT_4626_VAULT_HOOK_KEY);
    address[] memory fulfillHooksAddresses = new address[](1);
    fulfillHooksAddresses[0] = depositHookAddress;
    bytes[] memory fulfillHooksData = new bytes[](1);
    fulfillHooksData[0] = _createApproveAndDeposit4626HookData(_getYieldSourceOracleId(bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), MANAGER), baseUnderlying, assetOnBase, depositAmount, false, address(0), 0);
    uint256[] memory expectedAssetsOrSharesOut = new uint256[](1);
    expectedAssetsOrSharesOut[0] = IERC4626(address(baseUnderlying)).previewDeposit(depositAmount / 2);
    bytes[] memory argsForProofs = new bytes[](1);
    argsForProofs[0] = ISuperHookInspector(fulfillHooksAddresses[0]).inspect(fulfillHooksData[0]);
    address baseAggregatorAddress = _getContract(BASE, SUPER_VAULT_AGGREGATOR_KEY);
    SuperVaultAggregator baseAggregator = SuperVaultAggregator(baseAggregatorAddress);
    bytes32 baseHooksMerkleRoot;
    vm.mockCall(baseAggregatorAddress, abi.encodeWithSelector(ISuperVaultAggregator.validateHook.selector), abi.encode(true));
    try this._tryGetBaseMerkleRoot() returns (bytes32 root) {
        baseHooksMerkleRoot = root;
    } catch {
        bytes32 leaf = keccak256(bytes.concat(keccak256(abi.encode(depositHookAddress, fulfillHooksData))));
        baseHooksMerkleRoot = leaf;
    }
    vm.startPrank(MANAGER);
    baseAggregator.proposeStrategyHooksRoot(bridgeTestStrategy, baseHooksMerkleRoot);
    vm.warp((block.timestamp + 24 hours) + 1);
    baseAggregator.executeStrategyHooksRootUpdate(bridgeTestStrategy);
    SuperVaultStrategy(payable(bridgeTestStrategy)).executeHooks(ISuperVaultStrategy.ExecuteArgs({hooks: fulfillHooksAddresses, hookCalldata: fulfillHooksData, expectedAssetsOrSharesOut: expectedAssetsOrSharesOut, globalProofs: _tryGetBaseMerkleProofs(fulfillHooksAddresses, argsForProofs), strategyProofs: new bytes32[][](fulfillHooksAddresses.length)}));
    vm.stopPrank();
}
```

### _getHookAddress(uint64,string)

- **Kind**: internal
- **Source**: 21123:153:480
- **Link**: `lib/v2-core/test/BaseTest.t.sol:BaseTest:_getHookAddress(uint64,string)`

```solidity
function _getHookAddress(uint64 chainId, string memory hookName) internal view returns (address) {
    return hookAddresses[chainId][hookName];
}
```

### _createApproveAndDeposit4626HookData(bytes32,address,address,uint256,bool,address,uint256)

- **Kind**: internal
- **Source**: 12335:449:501
- **Link**: `lib/v2-core/test/utils/InternalHelpers.sol:InternalHelpers:_createApproveAndDeposit4626HookData(bytes32,address,address,uint256,bool,address,uint256)`

```solidity
function _createApproveAndDeposit4626HookData(bytes32 yieldSourceOracleId, address vault, address token, uint256 amount, bool usePrevHookAmount, address vaultBank, uint256 dstChainId) internal pure returns (bytes memory hookData) {
    hookData = abi.encodePacked(yieldSourceOracleId, vault, token, amount, usePrevHookAmount, vaultBank, dstChainId);
}
```

### _getYieldSourceOracleId(bytes32,address)

- **Kind**: internal
- **Source**: 4752:156:501
- **Link**: `lib/v2-core/test/utils/InternalHelpers.sol:InternalHelpers:_getYieldSourceOracleId(bytes32,address)`

```solidity
function _getYieldSourceOracleId(bytes32 id, address sender) internal pure returns (bytes32) {
    return keccak256(abi.encodePacked(id, sender));
}
```

### _tryGetBaseMerkleProofs(address[],bytes[])

- **Kind**: internal
- **Source**: 167755:691:580
- **Link**: `test/integration/SuperVault/SuperVault.t.sol:SuperVaultTest:_tryGetBaseMerkleProofs(address[],bytes[])`

```solidity
///  @notice Try to get Base chain merkle proofs, with fallback to empty arrays
///  @param hookAddresses Array of hook addresses
///  @param argsForProofs Array of encoded arguments
///  @return proofs Array of merkle proofs, or empty arrays on failure
function _tryGetBaseMerkleProofs(address[] memory hookAddresses, bytes[] memory argsForProofs) internal returns (bytes32[][] memory proofs) {
    try this._tryGetBaseMerkleProofsForChain(hookAddresses, argsForProofs) returns (bytes32[][] memory validProofs) {
        return validProofs;
    } catch {
        proofs = new bytes32[][](hookAddresses.length);
        for (uint256 i = 0; i < hookAddresses.length; i++) {
            proofs[i] = new bytes32[](0);
        }
        return proofs;
    }
}
```

### _processBridgeTestRedemption(contract SuperVault,contract SuperVaultStrategy,contract SuperGovernor,contract SuperVaultAggregator)

- **Kind**: internal
- **Source**: 154168:1475:580
- **Link**: `test/integration/SuperVault/SuperVault.t.sol:SuperVaultTest:_processBridgeTestRedemption(contract SuperVault,contract SuperVaultStrategy,contract SuperGovernor,contract SuperVaultAggregator)`

```solidity
function _processBridgeTestRedemption(SuperVault bTVault, SuperVaultStrategy bTStrategy, SuperGovernor govBase, SuperVaultAggregator aggregatorBase) internal {
    AccountInstance memory accountBase = makeAccountInstance("accountBase");
    AccountInstance memory accountBase1 = makeAccountInstance("accountBase1");
    uint256 accShares = bTVault.balanceOf(accountBase.account);
    vm.prank(MANAGER);
    bTStrategy.skimPerformanceFee();
    _updateSuperVaultBasePPS(address(bTStrategy), address(bTVault));
    vm.startPrank(accountBase.account);
    bTStrategy.setRedeemSlippage(9900);
    bTVault.requestRedeem(accShares, accountBase.account, accountBase.account);
    vm.stopPrank();
    vm.startPrank(accountBase1.account);
    bTStrategy.setRedeemSlippage(9900);
    bTVault.requestRedeem(accShares, accountBase1.account, accountBase1.account);
    vm.stopPrank();
    address morphoVaultAddr = realVaultAddresses[BASE][ERC4626_VAULT_KEY][MORPHO_GAUNTLET_USDC_PRIME_KEY][USDC_KEY];
    _redeemFromUnderlyingOnBase(morphoVaultAddr, address(bTStrategy));
    _updateSuperVaultBasePPS(address(bTStrategy), address(bTVault));
    _fulfillRedeemRequestsOnBase(accountBase.account, accountBase1.account, address(bTStrategy));
    uint256 claimableUpkeep = aggregatorBase.claimableUpkeep();
    vm.prank(address(govBase));
    aggregatorBase.claimUpkeep(claimableUpkeep);
}
```

### _redeemFromUnderlyingOnBase(address,address)

- **Kind**: internal
- **Source**: 162896:2900:580
- **Link**: `test/integration/SuperVault/SuperVault.t.sol:SuperVaultTest:_redeemFromUnderlyingOnBase(address,address)`

```solidity
///  @notice Helper function to redeem from underlying vault on Base chain with merkle proofs
///  @param baseUnderlying The underlying vault to redeem from
///  @param bridgeTestStrategy The strategy executing the redemption
function _redeemFromUnderlyingOnBase(address baseUnderlying, address bridgeTestStrategy) internal {
    address redeemHookAddress = _getHookAddress(BASE, REDEEM_4626_VAULT_HOOK_KEY);
    address[] memory fulfillHooksAddresses = new address[](1);
    fulfillHooksAddresses[0] = redeemHookAddress;
    uint256 redeemAmount = IERC4626(baseUnderlying).balanceOf(bridgeTestStrategy);
    bytes[] memory fulfillHooksData = new bytes[](1);
    fulfillHooksData[0] = _createRedeem4626HookData(_getYieldSourceOracleId(bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), MANAGER), baseUnderlying, bridgeTestStrategy, redeemAmount, false);
    uint256[] memory expectedAssetsOrSharesOut = new uint256[](1);
    expectedAssetsOrSharesOut[0] = IERC4626(address(baseUnderlying)).previewRedeem(redeemAmount);
    bytes[] memory argsForProofs = new bytes[](1);
    argsForProofs[0] = ISuperHookInspector(fulfillHooksAddresses[0]).inspect(fulfillHooksData[0]);
    address baseAggregatorAddress = _getContract(BASE, SUPER_VAULT_AGGREGATOR_KEY);
    SuperVaultAggregator baseAggregator = SuperVaultAggregator(baseAggregatorAddress);
    bytes32 baseHooksMerkleRoot;
    vm.mockCall(baseAggregatorAddress, abi.encodeWithSelector(ISuperVaultAggregator.validateHook.selector), abi.encode(true));
    try this._tryGetBaseMerkleRoot() returns (bytes32 root) {
        baseHooksMerkleRoot = root;
    } catch {
        bytes32 redeemLeaf = keccak256(bytes.concat(keccak256(abi.encode(redeemHookAddress, fulfillHooksData[0]))));
        baseHooksMerkleRoot = redeemLeaf;
    }
    vm.startPrank(MANAGER);
    baseAggregator.proposeStrategyHooksRoot(bridgeTestStrategy, baseHooksMerkleRoot);
    vm.warp((block.timestamp + 24 hours) + 1);
    baseAggregator.executeStrategyHooksRootUpdate(bridgeTestStrategy);
    SuperVaultStrategy(payable(bridgeTestStrategy)).executeHooks(ISuperVaultStrategy.ExecuteArgs({hooks: fulfillHooksAddresses, hookCalldata: fulfillHooksData, expectedAssetsOrSharesOut: expectedAssetsOrSharesOut, globalProofs: _tryGetBaseMerkleProofs(fulfillHooksAddresses, argsForProofs), strategyProofs: new bytes32[][](fulfillHooksAddresses.length)}));
    vm.stopPrank();
}
```

### _createRedeem4626HookData(bytes32,address,address,uint256,bool)

- **Kind**: internal
- **Source**: 13305:360:501
- **Link**: `lib/v2-core/test/utils/InternalHelpers.sol:InternalHelpers:_createRedeem4626HookData(bytes32,address,address,uint256,bool)`

```solidity
function _createRedeem4626HookData(bytes32 yieldSourceOracleId, address vault, address owner, uint256 shares, bool usePrevHookAmount) internal pure returns (bytes memory hookData) {
    hookData = abi.encodePacked(yieldSourceOracleId, vault, owner, shares, usePrevHookAmount);
}
```

### _fulfillRedeemRequestsOnBase(address,address,address)

- **Kind**: internal
- **Source**: 166111:928:580
- **Link**: `test/integration/SuperVault/SuperVault.t.sol:SuperVaultTest:_fulfillRedeemRequestsOnBase(address,address,address)`

```solidity
///  @notice Helper function to fulfill redeem requests on Base chain
///  @param accountBase The account to fulfill the redeem request for
///  @param accountBase1 The account to fulfill the redeem request for
///  @param bridgeTestStrategy The strategy executing the redeem requests
function _fulfillRedeemRequestsOnBase(address accountBase, address accountBase1, address bridgeTestStrategy) internal {
    address[] memory requestingUsers = new address[](2);
    requestingUsers[0] = accountBase;
    requestingUsers[1] = accountBase1;
    requestingUsers = _sortAndUniqueControllers(requestingUsers);
    uint256[] memory totalAssetsOut = calculateLiquidityOnlyFulfillment(ISuperVaultStrategy(bridgeTestStrategy), existingUnderlyingTokens[BASE][USDC_KEY], requestingUsers);
    vm.startPrank(MANAGER);
    SuperVaultStrategy(payable(bridgeTestStrategy)).fulfillRedeemRequests(requestingUsers, totalAssetsOut);
    vm.stopPrank();
}
```

### _sortAndUniqueControllers(address[])

- **Kind**: internal
- **Source**: 139422:377:576
- **Link**: `test/integration/SuperVault/BaseSuperVaultTest.t.sol:BaseSuperVaultTest:_sortAndUniqueControllers(address[])`

```solidity
/// @notice Helper function to sort controllers and ensure uniqueness for fulfillRedeemRequests
///  @param controllers Array of controller addresses to sort and deduplicate
///  @return sortedControllers Sorted and deduplicated array
function _sortAndUniqueControllers(address[] memory controllers) internal pure returns (address[] memory sortedControllers) {
    if (controllers.length == 0) return controllers;
    controllers.insertionSort();
    controllers.uniquifySorted();
    return controllers;
}
```

### insertionSort(address[])

- **Kind**: internal
- **Source**: 2133:100:321
- **Link**: `lib/v2-core/lib/solady/src/utils/LibSort.sol:LibSort:insertionSort(address[])`

```solidity
/// @dev Sorts the array in-place with insertion sort.
function insertionSort(address[] memory a) internal pure {
    insertionSort(_toUints(a));
}
```

### insertionSort(uint256[])

- **Kind**: internal
- **Source**: 840:1020:321
- **Link**: `lib/v2-core/lib/solady/src/utils/LibSort.sol:LibSort:insertionSort(uint256[])`

```solidity
/// @dev Sorts the array in-place with insertion sort.
function insertionSort(uint256[] memory a) internal pure {
    /// @solidity memory-safe-assembly
    assembly {
        let n := mload(a)
        mstore(a, 0)
        let h := add(a, shl(5, n))
        let w := not(0x1f)
        for {
            let i := add(a, 0x20)
        } 1 {} {
            i := add(i, 0x20)
            if gt(i, h) {
                break
            }
            let k := mload(i)
            let j := add(i, w)
            let v := mload(j)
            if iszero(gt(v, k)) {
                continue
            }
            for {} 1 {} {
                mstore(add(j, 0x20), v)
                j := add(j, w)
                v := mload(j)
                if iszero(gt(v, k)) {
                    break
                }
            }
            mstore(add(j, 0x20), k)
        }
        mstore(a, n)
    }
}
```

### _toUints(address[])

- **Kind**: internal
- **Source**: 28279:415:321
- **Link**: `lib/v2-core/lib/solady/src/utils/LibSort.sol:LibSort:_toUints(address[])`

```solidity
/// @dev Reinterpret cast to an uint256 array.
function _toUints(address[] memory a) private pure returns (uint256[] memory casted) {
    /// @solidity memory-safe-assembly
    assembly {
        casted := a
    }
}
```

### uniquifySorted(address[])

- **Kind**: internal
- **Source**: 9420:102:321
- **Link**: `lib/v2-core/lib/solady/src/utils/LibSort.sol:LibSort:uniquifySorted(address[])`

```solidity
/// @dev Removes duplicate elements from a ascendingly sorted memory array.
function uniquifySorted(address[] memory a) internal pure {
    uniquifySorted(_toUints(a));
}
```

### uniquifySorted(uint256[])

- **Kind**: internal
- **Source**: 8425:722:321
- **Link**: `lib/v2-core/lib/solady/src/utils/LibSort.sol:LibSort:uniquifySorted(uint256[])`

```solidity
/// @dev Removes duplicate elements from a ascendingly sorted memory array.
function uniquifySorted(uint256[] memory a) internal pure {
    /// @solidity memory-safe-assembly
    assembly {
        if iszero(lt(mload(a), 2)) {
            let x := add(a, 0x20)
            let y := add(a, 0x40)
            let end := add(a, shl(5, add(mload(a), 1)))
            for {} 1 {} {
                if iszero(eq(mload(x), mload(y))) {
                    x := add(x, 0x20)
                    mstore(x, mload(y))
                }
                y := add(y, 0x20)
                if eq(y, end) {
                    break
                }
            }
            mstore(a, shr(5, sub(x, a)))
        }
    }
}
```

### calculateLiquidityOnlyFulfillment(contract ISuperVaultStrategy,address,address[])

- **Kind**: internal
- **Source**: 9108:1178:575
- **Link**: `test/integration/SuperVault/AssetAdjustmentHelper.t.sol:AssetAdjustmentHelper:calculateLiquidityOnlyFulfillment(contract ISuperVaultStrategy,address,address[])`

```solidity
///  @notice Calculate adjusted netAssetsOut for liquidity-only fulfillment (no executeHooks)
///  @dev This function handles cases where fulfillRedeemRequests is called directly from
///       strategy asset balance without prior executeHooks call. It uses the strategy's
///       current asset balance as the available liquidity and adjusts theoretical amounts
///       accordingly to prevent INSUFFICIENT_LIQUIDITY errors.
///       Use this function for tests that:
///       - Have free assets sitting in strategy balance
///       - Don't call executeHooks before fulfillment
///       - Want to fulfill from strategy liquidity directly
///  @param strategy The SuperVault strategy contract
///  @param asset The underlying asset contract
///  @param controllers Sorted/unique controller addresses with pending redemptions
///  @return fulfillRedeemTotalAssetsOut Final totalAssetsOut array for fulfillRedeemRequests call
function calculateLiquidityOnlyFulfillment(ISuperVaultStrategy strategy, address asset, address[] memory controllers) internal view returns (uint256[] memory fulfillRedeemTotalAssetsOut) {
    if (controllers.length == 0) {
        revert EMPTY_ARRAYS();
    }
    uint256 strategyBalance = IERC20(asset).balanceOf(address(strategy));
    (uint256 totalTheoretical, uint256[] memory theoreticalAssets) = strategy.previewExactRedeemBatch(controllers);
    if (strategyBalance >= totalTheoretical) {
        return theoreticalAssets;
    }
    fulfillRedeemTotalAssetsOut = calculateFulfillRedeemTotalAssetsOut(controllers, theoreticalAssets, totalTheoretical, strategyBalance);
    return fulfillRedeemTotalAssetsOut;
}
```

### calculateFulfillRedeemTotalAssetsOut(address[],uint256[],uint256,uint256)

- **Kind**: internal
- **Source**: 2792:2430:575
- **Link**: `test/integration/SuperVault/AssetAdjustmentHelper.t.sol:AssetAdjustmentHelper:calculateFulfillRedeemTotalAssetsOut(address[],uint256[],uint256,uint256)`

```solidity
///  @notice Adjusts netAssetsOut arrays to match actual available assets from executeHooks
///  @dev This function handles the precision mismatch between theoretical fulfillment amounts
///       (calculated at current PPS) and actual assets obtained from executeHooks (which may
///       have rounding losses). The shortfall is distributed pro-rata based on each controller's
///       theoretical redemption amount.
///       Example scenario:
///       - Controller A: 800 theoretical assets (80% of total)
///       - Controller B: 200 theoretical assets (20% of total)
///       - Total theoretical: 1000 assets
///       - Available from hooks: 998 assets (2 wei loss)
///       - Adjusted A: 798.4 → 798 assets (1.6 wei loss)
///       - Adjusted B: 199.6 → 199 assets (0.4 wei loss)
///  @param controllers Array of controller addresses (must be sorted/unique)
///  @param theoreticalAssets Array of theoretical assets per controller from previewExactRedeem
///  @param totalTheoreticalAssets Total theoretical assets (sum of theoreticalAssets, from
///  previewExactRedeemBatch)
///  @param totalAvailableAssets Actual assets available from executeHooks (sum of expectedAssetsOrSharesOut)
///  @return fulfillRedeemTotalAssetsOut Array adjusted to match available liquidity, sum <= totalAvailableAssets
function calculateFulfillRedeemTotalAssetsOut(address[] memory controllers, uint256[] memory theoreticalAssets, uint256 totalTheoreticalAssets, uint256 totalAvailableAssets) internal pure returns (uint256[] memory fulfillRedeemTotalAssetsOut) {
    if ((controllers.length == 0) || (theoreticalAssets.length == 0)) {
        revert EMPTY_ARRAYS();
    }
    if (controllers.length != theoreticalAssets.length) {
        revert ARRAY_LENGTH_MISMATCH();
    }
    fulfillRedeemTotalAssetsOut = new uint256[](controllers.length);
    if (totalTheoreticalAssets == 0) {
        revert ZERO_TOTAL_THEORETICAL();
    }
    if (totalAvailableAssets >= totalTheoreticalAssets) {
        return theoreticalAssets;
    }
    if (totalAvailableAssets > totalTheoreticalAssets) {
        revert INSUFFICIENT_AVAILABLE_ASSETS();
    }
    console2.log("Adjusting assets: Theoretical=%s, Available=%s", totalTheoreticalAssets, totalAvailableAssets);
    uint256 totalAdjusted = 0;
    for (uint256 i = 0; i < theoreticalAssets.length; i++) {
        fulfillRedeemTotalAssetsOut[i] = theoreticalAssets[i].mulDiv(totalAvailableAssets, totalTheoreticalAssets, Math.Rounding.Floor);
        totalAdjusted += fulfillRedeemTotalAssetsOut[i];
    }
    uint256 remainder = totalAvailableAssets - totalAdjusted;
    if (remainder > 0) {
        console2.log("Remainder kept in vault as free assets:", remainder);
    }
    return fulfillRedeemTotalAssetsOut;
}
```

### log(string,uint256,uint256)

- **Kind**: internal
- **Source**: 11745:169:26
- **Link**: `lib/forge-std/src/console.sol:console:log(string,uint256,uint256)`

```solidity
function log(string memory p0, uint256 p1, uint256 p2) internal pure {
    _sendLogPayload(abi.encodeWithSignature("log(string,uint256,uint256)", p0, p1, p2));
}
```

### mulDiv(uint256,uint256,uint256,enum Math.Rounding)

- **Kind**: internal
- **Source**: 11054:238:294
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:mulDiv(uint256,uint256,uint256,enum Math.Rounding)`

```solidity
///  @dev Calculates x * y / denominator with full precision, following the selected rounding direction.
function mulDiv(uint256 x, uint256 y, uint256 denominator, Rounding rounding) internal pure returns (uint256) {
    return mulDiv(x, y, denominator) + SafeCast.toUint(unsignedRoundsUp(rounding) && (mulmod(x, y, denominator) > 0));
}
```

### toUint(bool)

- **Kind**: internal
- **Source**: 34795:145:295
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/math/SafeCast.sol:SafeCast:toUint(bool)`

```solidity
///  @dev Cast a boolean (false or true) to a uint256 (0 or 1) with no jump.
function toUint(bool b) internal pure returns (uint256 u) {
    assembly ("memory-safe") {
        u := iszero(iszero(b))
    }
}
```

### unsignedRoundsUp(enum Math.Rounding)

- **Kind**: internal
- **Source**: 32020:122:294
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:unsignedRoundsUp(enum Math.Rounding)`

```solidity
///  @dev Returns whether a provided rounding mode is considered rounding up for unsigned integers.
function unsignedRoundsUp(Rounding rounding) internal pure returns (bool) {
    return (uint8(rounding) % 2) == 1;
}
```

### mulDiv(uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 7242:3683:294
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:mulDiv(uint256,uint256,uint256)`

```solidity
///  @dev Calculates floor(x * y / denominator) with full precision. Throws if result overflows a uint256 or
///  denominator == 0.
///  Original credit to Remco Bloemen under MIT license (https://xn--2-umb.com/21/muldiv) with further edits by
///  Uniswap Labs also under MIT license.
function mulDiv(uint256 x, uint256 y, uint256 denominator) internal pure returns (uint256 result) {
    unchecked {
        (uint256 high, uint256 low) = mul512(x, y);
        if (high == 0) {
            return low / denominator;
        }
        if (denominator <= high) {
            Panic.panic(ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW));
        }
        uint256 remainder;
        assembly ("memory-safe") {
            remainder := mulmod(x, y, denominator)
            high := sub(high, gt(remainder, low))
            low := sub(low, remainder)
        }
        uint256 twos = denominator & (0 - denominator);
        assembly ("memory-safe") {
            denominator := div(denominator, twos)
            low := div(low, twos)
            twos := add(div(sub(0, twos), twos), 1)
        }
        low |= high * twos;
        uint256 inverse = (3 * denominator) ^ 2;
        inverse *= 2 - (denominator * inverse);
        inverse *= 2 - (denominator * inverse);
        inverse *= 2 - (denominator * inverse);
        inverse *= 2 - (denominator * inverse);
        inverse *= 2 - (denominator * inverse);
        inverse *= 2 - (denominator * inverse);
        result = low * inverse;
        return result;
    }
}
```

### mul512(uint256,uint256)

- **Kind**: internal
- **Source**: 1027:550:294
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:mul512(uint256,uint256)`

```solidity
///  @dev Return the 512-bit multiplication of two uint256.
///  The result is stored in two 256 variables such that product = high * 2²⁵⁶ + low.
function mul512(uint256 a, uint256 b) internal pure returns (uint256 high, uint256 low) {
    assembly ("memory-safe") {
        let mm := mulmod(a, b, not(0))
        low := mul(a, b)
        high := sub(sub(mm, low), lt(mm, low))
    }
}
```

### panic(uint256)

- **Kind**: internal
- **Source**: 1776:194:281
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/Panic.sol:Panic:panic(uint256)`

```solidity
/// @dev Reverts with a panic code. Recommended to use with
///  the internal constants with predefined codes.
function panic(uint256 code) internal pure {
    assembly ("memory-safe") {
        mstore(0x00, 0x4e487b71)
        mstore(0x20, code)
        revert(0x1c, 0x24)
    }
}
```

### ternary(bool,uint256,uint256)

- **Kind**: internal
- **Source**: 5071:294:294
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:ternary(bool,uint256,uint256)`

```solidity
///  @dev Branchless ternary evaluation for `a ? b : c`. Gas costs are constant.
///  IMPORTANT: This function may reduce bytecode size and consume less gas when used standalone.
///  However, the compiler may optimize Solidity ternary operations (i.e. `a ? b : c`) to only compute
///  one branch when needed, making this function more expensive.
function ternary(bool condition, uint256 a, uint256 b) internal pure returns (uint256) {
    unchecked {
        return b ^ ((a ^ b) * SafeCast.toUint(condition));
    }
}
```

### log(string,uint256)

- **Kind**: internal
- **Source**: 7139:145:26
- **Link**: `lib/forge-std/src/console.sol:console:log(string,uint256)`

```solidity
function log(string memory p0, uint256 p1) internal pure {
    _sendLogPayload(abi.encodeWithSignature("log(string,uint256)", p0, p1));
}
```

### _executeBridgeAndVerify(address,address,uint256)

- **Kind**: internal
- **Source**: 155649:1489:580
- **Link**: `test/integration/SuperVault/SuperVault.t.sol:SuperVaultTest:_executeBridgeAndVerify(address,address,uint256)`

```solidity
function _executeBridgeAndVerify(address assetBase, address assetETH, uint256 superBankEthBefore) internal {
    address superBankBase = _getContract(BASE, SUPER_BANK_KEY);
    uint256 bankBalanceBaseBefore = IERC20(assetBase).balanceOf(address(superBankBase));
    _bridgeToSuperBankOnETH(assetBase, assetETH, bankBalanceBaseBefore);
    uint256 bankBalanceBaseAfter = IERC20(assetBase).balanceOf(address(superBankBase));
    assertLt(bankBalanceBaseAfter, bankBalanceBaseBefore, "Funds should have been transferred from SuperBank Base");
    console2.log("Bridge hook execution completed successfully");
    console2.log("SuperBank Base balance before: ", bankBalanceBaseBefore);
    console2.log("SuperBank Base balance after: ", bankBalanceBaseAfter);
    vm.selectFork(FORKS[ETH]);
    address superBankETH = _getContract(ETH, SUPER_BANK_KEY);
    uint256 bankBalanceETHAfter = IERC20(assetETH).balanceOf(superBankETH);
    console2.log("SuperBank ETH balance before: ", superBankEthBefore);
    console2.log("SuperBank ETH balance after: ", bankBalanceETHAfter);
    assertEq(bankBalanceETHAfter, bankBalanceBaseBefore, "Funds should have been transferred from SuperBank Base to SuperBank ETH");
}
```

### _bridgeToSuperBankOnETH(address,address,uint256)

- **Kind**: internal
- **Source**: 169223:2683:580
- **Link**: `test/integration/SuperVault/SuperVault.t.sol:SuperVaultTest:_bridgeToSuperBankOnETH(address,address,uint256)`

```solidity
///  @notice Helper function to bridge funds from Base to SuperBank on ETH using Across
///  @param assetOnBase The asset to bridge from Base
///  @param assetOnETH The expected asset on ETH
///  @param bridgeAmount The amount to bridge
function _bridgeToSuperBankOnETH(address assetOnBase, address assetOnETH, uint256 bridgeAmount) internal {
    address approveHookAddress = _getHookAddress(BASE, APPROVE_ERC20_HOOK_KEY);
    address acrossHookAddress = _getHookAddress(BASE, ACROSS_SEND_FUNDS_AND_EXECUTE_ON_DST_HOOK_KEY);
    address spokedPoolV3 = SPOKE_POOL_V3_ADDRESSES[BASE];
    address[] memory fulfillHooksAddresses = new address[](2);
    fulfillHooksAddresses[0] = approveHookAddress;
    fulfillHooksAddresses[1] = acrossHookAddress;
    bytes[] memory fulfillHooksData = new bytes[](2);
    fulfillHooksData[0] = _createApproveHookData(assetOnBase, spokedPoolV3, bridgeAmount, false);
    address superBankETH = _getContract(ETH, SUPER_BANK_KEY);
    fulfillHooksData[1] = _createAcrossV3ReceiveFundsNoExecution(superBankETH, assetOnBase, assetOnETH, bridgeAmount, bridgeAmount, ETH, false, "");
    address payable superBankBase = payable(_getContract(BASE, SUPER_BANK_KEY));
    SuperGovernor govBase = SuperGovernor(_getContract(BASE, SUPER_GOVERNOR_KEY));
    _setupSuperBankHookMerkleRoots(govBase, fulfillHooksAddresses, fulfillHooksData);
    bytes32[][] memory merkleProofs = _createSuperBankMerkleProofs(fulfillHooksAddresses);
    IHookExecutionData.HookExecutionData memory executionData = IHookExecutionData.HookExecutionData({hooks: fulfillHooksAddresses, data: fulfillHooksData, merkleProofs: merkleProofs, expectedAssetsOrSharesOut: new uint256[](fulfillHooksAddresses.length)});
    SuperBank(superBankBase).executeHooks(executionData);
    AcrossV3Helper acrossV3Helper = AcrossV3Helper(_getContract(BASE, ACROSS_V3_HELPER_KEY));
    acrossV3Helper.help(SPOKE_POOL_V3_ADDRESSES[BASE], SPOKE_POOL_V3_ADDRESSES[ETH], ACROSS_RELAYER, block.timestamp, FORKS[ETH], ETH, BASE, vm.getRecordedLogs());
}
```

### _createApproveHookData(address,address,uint256,bool)

- **Kind**: internal
- **Source**: 11180:303:501
- **Link**: `lib/v2-core/test/utils/InternalHelpers.sol:InternalHelpers:_createApproveHookData(address,address,uint256,bool)`

```solidity
function _createApproveHookData(address token, address spender, uint256 amount, bool usePrevHookAmount) internal pure returns (bytes memory hookData) {
    hookData = abi.encodePacked(token, spender, amount, usePrevHookAmount);
}
```

### _createAcrossV3ReceiveFundsNoExecution(address,address,address,uint256,uint256,uint64,bool,bytes)

- **Kind**: internal
- **Source**: 104814:769:480
- **Link**: `lib/v2-core/test/BaseTest.t.sol:BaseTest:_createAcrossV3ReceiveFundsNoExecution(address,address,address,uint256,uint256,uint64,bool,bytes)`

```solidity
function _createAcrossV3ReceiveFundsNoExecution(address receiver, address inputToken, address outputToken, uint256 inputAmount, uint256 outputAmount, uint64 destinationChainId, bool usePrevHookAmount, bytes memory data) internal pure returns (bytes memory hookData) {
    hookData = abi.encodePacked(uint256(0), receiver, inputToken, outputToken, inputAmount, outputAmount, uint256(destinationChainId), address(0), uint32(10 minutes), uint32(0), usePrevHookAmount, data);
}
```

### _setupSuperBankHookMerkleRoots(contract SuperGovernor,address[],bytes[])

- **Kind**: internal
- **Source**: 172126:1158:580
- **Link**: `test/integration/SuperVault/SuperVault.t.sol:SuperVaultTest:_setupSuperBankHookMerkleRoots(contract SuperGovernor,address[],bytes[])`

```solidity
/// @notice Helper function to set up merkle roots for SuperBank hooks
///  @param govBase The SuperGovernor instance
///  @param hooks Array of hook addresses
///  @param hooksData Array of hook data
function _setupSuperBankHookMerkleRoots(SuperGovernor govBase, address[] memory hooks, bytes[] memory hooksData) internal {
    for (uint256 i = 0; i < hooks.length; i++) {
        address hookAddress = hooks[i];
        bytes memory hookData = hooksData[i];
        bytes memory hookArgs = ISuperHookInspector(hookAddress).inspect(hookData);
        bytes32 leaf = keccak256(bytes.concat(keccak256(abi.encode(hookAddress, hookArgs))));
        bytes32 merkleRoot = leaf;
        govBase.proposeSuperBankHookMerkleRoot(hookAddress, merkleRoot);
        vm.warp((block.timestamp + 7 days) + 1);
        govBase.executeSuperBankHookMerkleRootUpdate(hookAddress);
    }
}
```

### _createSuperBankMerkleProofs(address[])

- **Kind**: internal
- **Source**: 173493:416:580
- **Link**: `test/integration/SuperVault/SuperVault.t.sol:SuperVaultTest:_createSuperBankMerkleProofs(address[])`

```solidity
/// @notice Helper function to create merkle proofs for SuperBank hooks
///  @param hooks Array of hook addresses
///  @return merkleProofs Array of merkle proofs (empty for single-leaf trees)
function _createSuperBankMerkleProofs(address[] memory hooks) internal pure returns (bytes32[][] memory merkleProofs) {
    merkleProofs = new bytes32[][](hooks.length);
    for (uint256 i = 0; i < hooks.length; i++) {
        merkleProofs[i] = new bytes32[](0);
    }
    return merkleProofs;
}
```

### assertLt(uint256,uint256,string)

- **Kind**: internal
- **Source**: 13439:177:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertLt(uint256,uint256,string)`

```solidity
function assertLt(uint256 left, uint256 right, string memory err) virtual internal pure {
    if (left >= right) {
        vm.assertLt(left, right, err);
    }
}
```

### log(string)

- **Kind**: internal
- **Source**: 6191:121:26
- **Link**: `lib/forge-std/src/console.sol:console:log(string)`

```solidity
function log(string memory p0) internal pure {
    _sendLogPayload(abi.encodeWithSignature("log(string)", p0));
}
```

### assertEq(uint256,uint256,string)

- **Kind**: internal
- **Source**: 2823:177:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256,string)`

```solidity
function assertEq(uint256 left, uint256 right, string memory err) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right, err);
    }
}
```

## State Variable Reads

- **contractAddresses** (`mapping(uint64 => mapping(string => address))`)
- **stdstore** (`struct StdStorage`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]
- **UINT256_MAX** (`uint256`)
- **_defaultValidator** (`contract MockValidator`) [lib/v2-core/lib/modulekit/src/module-bases/mocks/MockValidator.sol/contract_MockValidator.md]
- **_defaultSessionValidator** (`contract MockStatelessValidator`) [lib/v2-core/lib/modulekit/src/module-bases/mocks/MockStatelessValidator.sol/contract_MockStatelessValidator.md]
- **isInit** (`mapping(uint256 => bool)`)
- **VM_ADDR** (`address`)
- **auxiliary** (`struct Auxiliary`)
- **hookAddresses** (`mapping(uint64 => mapping(string => address))`)

## State Variable Writes

- **isInit** (`mapping(uint256 => bool)`)
- **_defaultValidator** (`contract MockValidator`) [lib/v2-core/lib/modulekit/src/module-bases/mocks/MockValidator.sol/contract_MockValidator.md]
- **_defaultSessionValidator** (`contract MockStatelessValidator`) [lib/v2-core/lib/modulekit/src/module-bases/mocks/MockStatelessValidator.sol/contract_MockStatelessValidator.md]
- **auxiliary** (`struct Auxiliary`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_SuperBank_TokenBridge_BaseToETH() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: SuperVaultTest._setupBridgeTestAssets() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: BaseTest._getContract(uint64,string) (NodeID: 2)
  │     💬 Args: [ETH, SUPER_BANK_KEY]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: SuperVaultTest._setupBridgeTestVault(address) (NodeID: 3)
  │   💬 Args: [assetBase]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseSuperVaultTest._deployVaultOnBase(address,string) (NodeID: 4)
  │ │   💬 Args: [assetBridgeTest, "svBridgeTest"]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: BaseTest._getContract(uint64,string) (NodeID: 5)
  │ │     💬 Args: [BASE, SUPER_VAULT_AGGREGATOR_KEY]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseTest._getContract(uint64,string) (NodeID: 6)
  │ │   💬 Args: [BASE, SUPER_BANK_KEY]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseTest._getContract(uint64,string) (NodeID: 7)
  │ │   💬 Args: [BASE, ERC4626_YIELD_SOURCE_ORACLE_KEY]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseSuperVaultTest._updateSuperVaultBasePPS(address,address) (NodeID: 8)
  │ │   💬 Args: [bridgeTestStrategyAddr, bridgeTestVaultAddr]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256,enum Math.Rounding) (NodeID: 9)
  │ │ │   💬 Args: [vars.currentTotalAssets, vars.precision, vars.totalSupplyAmount, Math.Rounding.Floor]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 10)
  │ │ │ │   💬 Args: [unsignedRoundsUp(rounding) && (mulmod(x, y, denominator) > 0)]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.unsignedRoundsUp(enum Math.Rounding) (NodeID: 11)
  │ │ │ │     💬 Args: [rounding]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 12)
  │ │ │     💬 Args: [x, y, denominator]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 13)
  │ │ │   │   💬 Args: [x, y]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 14)
  │ │ │       💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │ │ │       👁️  Def: internal
  │ │ │     └─ [6] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 15)
  │ │ │         💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │ │ │         👁️  Def: internal
  │ │ │       └─ [7] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 16)
  │ │ │           💬 Args: [condition]
  │ │ │           👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: BaseTest._getContract(uint64,string) (NodeID: 17)
  │ │ │   💬 Args: [BASE, ECDSAPPS_ORACLE_KEY]
  │ │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: MessageHashUtils.toTypedDataHash(bytes32,bytes32) (NodeID: 18)
  │ │ │   💬 Args: [baseOracle.domainSeparator(), structHash]
  │ │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: console.log(string,address,uint256) (NodeID: 19)
  │ │     💬 Args: ["Updated PPS for strategy", strategyAddr, vars.pps]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 20)
  │ │       💬 Args: [abi.encodeWithSignature("log(string,address,uint256)", p0, p1, p2)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 21)
  │ │         💬 Args: [_sendLogPayloadView]
  │ │         👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseTest._getContract(uint64,string) (NodeID: 22)
  │ │   💬 Args: [BASE, SUPER_GOVERNOR_KEY]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseTest._getContract(uint64,string) (NodeID: 23)
  │ │   💬 Args: [BASE, SUPER_VAULT_AGGREGATOR_KEY]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdCheats.deal(address,address,uint256) (NodeID: 24)
  │     💬 Args: [assetBridgeTest, MANAGER, 200_000e6]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdCheats.deal(address,address,uint256,bool) (NodeID: 25)
  │       💬 Args: [token, to, give, false]
  │       👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: stdStorage.target(struct StdStorage,address) (NodeID: 26)
  │     │   💬 Args: [stdstore, token]
  │     │   👁️  Def: internal
  │     │ └─ [5] ⚙️ FUNCTION: stdStorageSafe.target(struct StdStorage,address) (NodeID: 27)
  │     │     💬 Args: [self, _target]
  │     │     👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: stdStorage.sig(struct StdStorage,bytes4) (NodeID: 28)
  │     │   💬 Args: [stdstore.target(token), 0x70a08231]
  │     │   👁️  Def: internal
  │     │ └─ [5] ⚙️ FUNCTION: stdStorageSafe.sig(struct StdStorage,bytes4) (NodeID: 29)
  │     │     💬 Args: [self, _sig]
  │     │     👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: stdStorage.with_key(struct StdStorage,address) (NodeID: 30)
  │     │   💬 Args: [stdstore.target(token).sig(0x70a08231), to]
  │     │   👁️  Def: internal
  │     │ └─ [5] ⚙️ FUNCTION: stdStorageSafe.with_key(struct StdStorage,address) (NodeID: 31)
  │     │     💬 Args: [self, who]
  │     │     👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,uint256) (NodeID: 32)
  │     │   💬 Args: [stdstore.target(token).sig(0x70a08231).with_key(to), give]
  │     │   👁️  Def: internal
  │     │ └─ [5] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,bytes32) (NodeID: 33)
  │     │     💬 Args: [self, bytes32(amt)]
  │     │     👁️  Def: internal
  │     │   ├─ [6] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 34)
  │     │   │   💬 Args: [self]
  │     │   │   👁️  Def: internal
  │     │   │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 35)
  │     │   │     💬 Args: [self._keys]
  │     │   │     👁️  Def: private
  │     │   ├─ [6] ⚙️ FUNCTION: stdStorage.find(struct StdStorage,bool) (NodeID: 36)
  │     │   │   💬 Args: [self, false]
  │     │   │   👁️  Def: internal
  │     │   │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.find(struct StdStorage,bool) (NodeID: 37)
  │     │   │     💬 Args: [self, _clear]
  │     │   │     👁️  Def: internal
  │     │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 38)
  │     │   │   │   💬 Args: [self]
  │     │   │   │   👁️  Def: internal
  │     │   │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 39)
  │     │   │   │     💬 Args: [self._keys]
  │     │   │   │     👁️  Def: private
  │     │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 40)
  │     │   │   │   💬 Args: [self]
  │     │   │   │   👁️  Def: internal
  │     │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 41)
  │     │   │   │   💬 Args: [self]
  │     │   │   │   👁️  Def: internal
  │     │   │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 42)
  │     │   │   │ │   💬 Args: [self]
  │     │   │   │ │   👁️  Def: internal
  │     │   │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 43)
  │     │   │   │ │     💬 Args: [self._keys]
  │     │   │   │ │     👁️  Def: private
  │     │   │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 44)
  │     │   │   │     💬 Args: [rdat, 32 * self._depth]
  │     │   │   │     👁️  Def: private
  │     │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.checkSlotMutatesCall(struct StdStorage,bytes32) (NodeID: 45)
  │     │   │   │   💬 Args: [self, reads[i]]
  │     │   │   │   👁️  Def: internal
  │     │   │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 46)
  │     │   │   │ │   💬 Args: [self]
  │     │   │   │ │   👁️  Def: internal
  │     │   │   │ │ ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 47)
  │     │   │   │ │ │   💬 Args: [self]
  │     │   │   │ │ │   👁️  Def: internal
  │     │   │   │ │ │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 48)
  │     │   │   │ │ │     💬 Args: [self._keys]
  │     │   │   │ │ │     👁️  Def: private
  │     │   │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 49)
  │     │   │   │ │     💬 Args: [rdat, 32 * self._depth]
  │     │   │   │ │     👁️  Def: private
  │     │   │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 50)
  │     │   │   │     💬 Args: [self]
  │     │   │   │     👁️  Def: internal
  │     │   │   │   ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 51)
  │     │   │   │   │   💬 Args: [self]
  │     │   │   │   │   👁️  Def: internal
  │     │   │   │   │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 52)
  │     │   │   │   │     💬 Args: [self._keys]
  │     │   │   │   │     👁️  Def: private
  │     │   │   │   └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 53)
  │     │   │   │       💬 Args: [rdat, 32 * self._depth]
  │     │   │   │       👁️  Def: private
  │     │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.findOffsets(struct StdStorage,bytes32) (NodeID: 54)
  │     │   │   │   💬 Args: [self, reads[i]]
  │     │   │   │   👁️  Def: internal
  │     │   │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 55)
  │     │   │   │ │   💬 Args: [self, slot, true]
  │     │   │   │ │   👁️  Def: internal
  │     │   │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 56)
  │     │   │   │ │     💬 Args: [self]
  │     │   │   │ │     👁️  Def: internal
  │     │   │   │ │   ├─ [11] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 57)
  │     │   │   │ │   │   💬 Args: [self]
  │     │   │   │ │   │   👁️  Def: internal
  │     │   │   │ │   │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 58)
  │     │   │   │ │   │     💬 Args: [self._keys]
  │     │   │   │ │   │     👁️  Def: private
  │     │   │   │ │   └─ [11] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 59)
  │     │   │   │ │       💬 Args: [rdat, 32 * self._depth]
  │     │   │   │ │       👁️  Def: private
  │     │   │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 60)
  │     │   │   │     💬 Args: [self, slot, false]
  │     │   │   │     👁️  Def: internal
  │     │   │   │   └─ [10] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 61)
  │     │   │   │       💬 Args: [self]
  │     │   │   │       👁️  Def: internal
  │     │   │   │     ├─ [11] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 62)
  │     │   │   │     │   💬 Args: [self]
  │     │   │   │     │   👁️  Def: internal
  │     │   │   │     │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 63)
  │     │   │   │     │     💬 Args: [self._keys]
  │     │   │   │     │     👁️  Def: private
  │     │   │   │     └─ [11] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 64)
  │     │   │   │         💬 Args: [rdat, 32 * self._depth]
  │     │   │   │         👁️  Def: private
  │     │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 65)
  │     │   │   │   💬 Args: [offsetLeft, offsetRight]
  │     │   │   │   👁️  Def: internal
  │     │   │   └─ [8] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 66)
  │     │   │       💬 Args: [self]
  │     │   │       👁️  Def: internal
  │     │   ├─ [6] ⚙️ FUNCTION: stdStorageSafe.getUpdatedSlotValue(bytes32,uint256,uint256,uint256) (NodeID: 67)
  │     │   │   💬 Args: [curVal, uint256(set), data.offsetLeft, data.offsetRight]
  │     │   │   👁️  Def: internal
  │     │   │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 68)
  │     │   │     💬 Args: [offsetLeft, offsetRight]
  │     │   │     👁️  Def: internal
  │     │   ├─ [6] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 69)
  │     │   │   💬 Args: [self]
  │     │   │   👁️  Def: internal
  │     │   │ ├─ [7] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 70)
  │     │   │ │   💬 Args: [self]
  │     │   │ │   👁️  Def: internal
  │     │   │ │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 71)
  │     │   │ │     💬 Args: [self._keys]
  │     │   │ │     👁️  Def: private
  │     │   │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 72)
  │     │   │     💬 Args: [rdat, 32 * self._depth]
  │     │   │     👁️  Def: private
  │     │   └─ [6] ⚙️ FUNCTION: stdStorage.clear(struct StdStorage) (NodeID: 73)
  │     │       💬 Args: [self]
  │     │       👁️  Def: internal
  │     │     └─ [7] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 74)
  │     │         💬 Args: [self]
  │     │         👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: stdStorage.target(struct StdStorage,address) (NodeID: 75)
  │     │   💬 Args: [stdstore, token]
  │     │   👁️  Def: internal
  │     │ └─ [5] ⚙️ FUNCTION: stdStorageSafe.target(struct StdStorage,address) (NodeID: 76)
  │     │     💬 Args: [self, _target]
  │     │     👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: stdStorage.sig(struct StdStorage,bytes4) (NodeID: 77)
  │     │   💬 Args: [stdstore.target(token), 0x18160ddd]
  │     │   👁️  Def: internal
  │     │ └─ [5] ⚙️ FUNCTION: stdStorageSafe.sig(struct StdStorage,bytes4) (NodeID: 78)
  │     │     💬 Args: [self, _sig]
  │     │     👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,uint256) (NodeID: 79)
  │         💬 Args: [stdstore.target(token).sig(0x18160ddd), totSup]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,bytes32) (NodeID: 80)
  │           💬 Args: [self, bytes32(amt)]
  │           👁️  Def: internal
  │         ├─ [6] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 81)
  │         │   💬 Args: [self]
  │         │   👁️  Def: internal
  │         │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 82)
  │         │     💬 Args: [self._keys]
  │         │     👁️  Def: private
  │         ├─ [6] ⚙️ FUNCTION: stdStorage.find(struct StdStorage,bool) (NodeID: 83)
  │         │   💬 Args: [self, false]
  │         │   👁️  Def: internal
  │         │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.find(struct StdStorage,bool) (NodeID: 84)
  │         │     💬 Args: [self, _clear]
  │         │     👁️  Def: internal
  │         │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 85)
  │         │   │   💬 Args: [self]
  │         │   │   👁️  Def: internal
  │         │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 86)
  │         │   │     💬 Args: [self._keys]
  │         │   │     👁️  Def: private
  │         │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 87)
  │         │   │   💬 Args: [self]
  │         │   │   👁️  Def: internal
  │         │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 88)
  │         │   │   💬 Args: [self]
  │         │   │   👁️  Def: internal
  │         │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 89)
  │         │   │ │   💬 Args: [self]
  │         │   │ │   👁️  Def: internal
  │         │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 90)
  │         │   │ │     💬 Args: [self._keys]
  │         │   │ │     👁️  Def: private
  │         │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 91)
  │         │   │     💬 Args: [rdat, 32 * self._depth]
  │         │   │     👁️  Def: private
  │         │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.checkSlotMutatesCall(struct StdStorage,bytes32) (NodeID: 92)
  │         │   │   💬 Args: [self, reads[i]]
  │         │   │   👁️  Def: internal
  │         │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 93)
  │         │   │ │   💬 Args: [self]
  │         │   │ │   👁️  Def: internal
  │         │   │ │ ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 94)
  │         │   │ │ │   💬 Args: [self]
  │         │   │ │ │   👁️  Def: internal
  │         │   │ │ │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 95)
  │         │   │ │ │     💬 Args: [self._keys]
  │         │   │ │ │     👁️  Def: private
  │         │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 96)
  │         │   │ │     💬 Args: [rdat, 32 * self._depth]
  │         │   │ │     👁️  Def: private
  │         │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 97)
  │         │   │     💬 Args: [self]
  │         │   │     👁️  Def: internal
  │         │   │   ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 98)
  │         │   │   │   💬 Args: [self]
  │         │   │   │   👁️  Def: internal
  │         │   │   │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 99)
  │         │   │   │     💬 Args: [self._keys]
  │         │   │   │     👁️  Def: private
  │         │   │   └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 100)
  │         │   │       💬 Args: [rdat, 32 * self._depth]
  │         │   │       👁️  Def: private
  │         │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.findOffsets(struct StdStorage,bytes32) (NodeID: 101)
  │         │   │   💬 Args: [self, reads[i]]
  │         │   │   👁️  Def: internal
  │         │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 102)
  │         │   │ │   💬 Args: [self, slot, true]
  │         │   │ │   👁️  Def: internal
  │         │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 103)
  │         │   │ │     💬 Args: [self]
  │         │   │ │     👁️  Def: internal
  │         │   │ │   ├─ [11] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 104)
  │         │   │ │   │   💬 Args: [self]
  │         │   │ │   │   👁️  Def: internal
  │         │   │ │   │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 105)
  │         │   │ │   │     💬 Args: [self._keys]
  │         │   │ │   │     👁️  Def: private
  │         │   │ │   └─ [11] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 106)
  │         │   │ │       💬 Args: [rdat, 32 * self._depth]
  │         │   │ │       👁️  Def: private
  │         │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 107)
  │         │   │     💬 Args: [self, slot, false]
  │         │   │     👁️  Def: internal
  │         │   │   └─ [10] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 108)
  │         │   │       💬 Args: [self]
  │         │   │       👁️  Def: internal
  │         │   │     ├─ [11] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 109)
  │         │   │     │   💬 Args: [self]
  │         │   │     │   👁️  Def: internal
  │         │   │     │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 110)
  │         │   │     │     💬 Args: [self._keys]
  │         │   │     │     👁️  Def: private
  │         │   │     └─ [11] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 111)
  │         │   │         💬 Args: [rdat, 32 * self._depth]
  │         │   │         👁️  Def: private
  │         │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 112)
  │         │   │   💬 Args: [offsetLeft, offsetRight]
  │         │   │   👁️  Def: internal
  │         │   └─ [8] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 113)
  │         │       💬 Args: [self]
  │         │       👁️  Def: internal
  │         ├─ [6] ⚙️ FUNCTION: stdStorageSafe.getUpdatedSlotValue(bytes32,uint256,uint256,uint256) (NodeID: 114)
  │         │   💬 Args: [curVal, uint256(set), data.offsetLeft, data.offsetRight]
  │         │   👁️  Def: internal
  │         │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 115)
  │         │     💬 Args: [offsetLeft, offsetRight]
  │         │     👁️  Def: internal
  │         ├─ [6] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 116)
  │         │   💬 Args: [self]
  │         │   👁️  Def: internal
  │         │ ├─ [7] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 117)
  │         │ │   💬 Args: [self]
  │         │ │   👁️  Def: internal
  │         │ │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 118)
  │         │ │     💬 Args: [self._keys]
  │         │ │     👁️  Def: private
  │         │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 119)
  │         │     💬 Args: [rdat, 32 * self._depth]
  │         │     👁️  Def: private
  │         └─ [6] ⚙️ FUNCTION: stdStorage.clear(struct StdStorage) (NodeID: 120)
  │             💬 Args: [self]
  │             👁️  Def: internal
  │           └─ [7] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 121)
  │               💬 Args: [self]
  │               👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: SuperVaultTest._performBridgeTestDeposits(address,contract SuperVault,contract SuperVaultStrategy) (NodeID: 122)
  │   💬 Args: [assetBase, bTVault, bTStrategy]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: RhinestoneModuleKit.makeAccountInstance(bytes32) (NodeID: 123)
  │ │   💬 Args: ["accountBase"]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: ModuleKitHelpers.getAccountEnv() (NodeID: 124)
  │ │ │   💬 Args: [no args]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Unknown.getAccountEnv() (NodeID: 125)
  │ │ │     💬 Args: [no args]
  │ │ │     👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 126)
  │ │ │   💬 Args: [address(account), toString(salt)]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Unknown.toString(bytes32) (NodeID: 127)
  │ │ │     💬 Args: [salt]
  │ │ │     👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StdCheats.deal(address,uint256) (NodeID: 128)
  │ │ │   💬 Args: [account, 10 ether]
  │ │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: RhinestoneModuleKit._makeAccountInstance(bytes32,address,bytes,address,address,address,enum AccountType,address) (NodeID: 129)
  │ │ │   💬 Args: [salt, env, accountHelper, account, initCode, address(_defaultValidator), address(accountFactory), address(_defaultSessionValidator)]
  │ │ │   👁️  Def: internal
  │ │ └─ [3] 🔒 MODIFIER: RhinestoneModuleKit.initializeModuleKit() (NodeID: 130)
  │ │     💬 Args: [no args]
  │ │   ├─ [4] ⚙️ FUNCTION: Helpers.envOr(string,string) (NodeID: 131)
  │ │   │   💬 Args: ["ACCOUNT_TYPE", DEFAULT]
  │ │   │   👁️  Def: public
  │ │   └─ [4] ⚙️ FUNCTION: RhinestoneModuleKit._initializeModuleKit(string) (NodeID: 132)
  │ │       💬 Args: [_env]
  │ │       👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: AuxiliaryFactory.init() (NodeID: 133)
  │ │     │   💬 Args: [no args]
  │ │     │   👁️  Def: internal
  │ │     │ ├─ [6] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 134)
  │ │     │ │   💬 Args: [address(auxiliary.mockFactory), "Mock Factory"]
  │ │     │ │   👁️  Def: internal
  │ │     │ ├─ [6] ⚙️ FUNCTION: Unknown.etchEntrypoint() (NodeID: 135)
  │ │     │ │   💬 Args: [no args]
  │ │     │ │   👁️  Def: internal
  │ │     │ │ └─ [7] ⚙️ FUNCTION: Unknown.etch(address,bytes) (NodeID: 136)
  │ │     │ │     💬 Args: [ENTRYPOINT_ADDR, entryPoint.code]
  │ │     │ │     👁️  Def: internal
  │ │     │ ├─ [6] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 137)
  │ │     │ │   💬 Args: [address(auxiliary.entrypoint), "EntryPoint"]
  │ │     │ │   👁️  Def: internal
  │ │     │ ├─ [6] ⚙️ FUNCTION: Unknown.etchRegistry() (NodeID: 138)
  │ │     │ │   💬 Args: [no args]
  │ │     │ │   👁️  Def: internal
  │ │     │ │ └─ [7] ⚙️ FUNCTION: Unknown.etch(address,bytes) (NodeID: 139)
  │ │     │ │     💬 Args: [REGISTRY_ADDR, _registry.code]
  │ │     │ │     👁️  Def: internal
  │ │     │ ├─ [6] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 140)
  │ │     │ │   💬 Args: [address(auxiliary.registry), "ERC7484Registry"]
  │ │     │ │   👁️  Def: internal
  │ │     │ ├─ [6] ⚙️ FUNCTION: Unknown.etchSmartSessions() (NodeID: 141)
  │ │     │ │   💬 Args: [no args]
  │ │     │ │   👁️  Def: internal
  │ │     │ │ └─ [7] ⚙️ FUNCTION: Unknown.etch(address,bytes) (NodeID: 142)
  │ │     │ │     💬 Args: [address(SMARTSESSION_ADDR), SMART_SESSION_DEPLOYED_BYTECODE]
  │ │     │ │     👁️  Def: internal
  │ │     │ └─ [6] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 143)
  │ │     │     💬 Args: [address(auxiliary.smartSession), "SmartSession"]
  │ │     │     👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.writeFactory(address,string) (NodeID: 144)
  │ │     │   💬 Args: [address(new ERC7579Factory()), DEFAULT]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.writeFactory(address,string) (NodeID: 145)
  │ │     │   💬 Args: [address(new SafeFactory()), SAFE]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.writeFactory(address,string) (NodeID: 146)
  │ │     │   💬 Args: [address(new KernelFactory()), KERNEL]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.writeFactory(address,string) (NodeID: 147)
  │ │     │   💬 Args: [address(new NexusFactory()), NEXUS]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.writeFactory(address,string) (NodeID: 148)
  │ │     │   💬 Args: [address(new ERC7579Factory()), CUSTOM]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.writeHelper(address,string) (NodeID: 149)
  │ │     │   💬 Args: [address(new ERC7579Helpers()), DEFAULT]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.writeHelper(address,string) (NodeID: 150)
  │ │     │   💬 Args: [address(new SafeHelpers()), SAFE]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.writeHelper(address,string) (NodeID: 151)
  │ │     │   💬 Args: [address(new KernelHelpers()), KERNEL]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.writeHelper(address,string) (NodeID: 152)
  │ │     │   💬 Args: [address(new NexusHelpers()), NEXUS]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.writeHelper(address,string) (NodeID: 153)
  │ │     │   💬 Args: [address(new ERC7579Helpers()), CUSTOM]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.getFactory(string) (NodeID: 154)
  │ │     │   💬 Args: [SAFE]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.getFactory(string) (NodeID: 155)
  │ │     │   💬 Args: [KERNEL]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.getFactory(string) (NodeID: 156)
  │ │     │   💬 Args: [DEFAULT]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.getFactory(string) (NodeID: 157)
  │ │     │   💬 Args: [NEXUS]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.getFactory(string) (NodeID: 158)
  │ │     │   💬 Args: [CUSTOM]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 159)
  │ │     │   💬 Args: [address(safeFactory), "SafeFactory"]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 160)
  │ │     │   💬 Args: [address(kernelFactory), "KernelFactory"]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 161)
  │ │     │   💬 Args: [address(erc7579Factory), "ERC7579Factory"]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 162)
  │ │     │   💬 Args: [address(nexusFactory), "NexusFactory"]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 163)
  │ │     │   💬 Args: [address(customFactory), "CustomFactory"]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: StdCheats.deal(address,uint256) (NodeID: 164)
  │ │     │   💬 Args: [address(safeFactory), 10 ether]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: StdCheats.deal(address,uint256) (NodeID: 165)
  │ │     │   💬 Args: [address(kernelFactory), 10 ether]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: StdCheats.deal(address,uint256) (NodeID: 166)
  │ │     │   💬 Args: [address(erc7579Factory), 10 ether]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: StdCheats.deal(address,uint256) (NodeID: 167)
  │ │     │   💬 Args: [address(nexusFactory), 10 ether]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: StdCheats.deal(address,uint256) (NodeID: 168)
  │ │     │   💬 Args: [address(customFactory), 10 ether]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.prank(address) (NodeID: 169)
  │ │     │   💬 Args: [address(safeFactory)]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.prank(address) (NodeID: 170)
  │ │     │   💬 Args: [address(kernelFactory)]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.prank(address) (NodeID: 171)
  │ │     │   💬 Args: [address(erc7579Factory)]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.prank(address) (NodeID: 172)
  │ │     │   💬 Args: [address(nexusFactory)]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: ModuleKitHelpers.setAccountEnv(string) (NodeID: 173)
  │ │     │   💬 Args: [_env]
  │ │     │   👁️  Def: internal
  │ │     │ └─ [6] ⚙️ FUNCTION: ModuleKitHelpers._setAccountEnv(string) (NodeID: 174)
  │ │     │     💬 Args: [env]
  │ │     │     👁️  Def: private
  │ │     │   ├─ [7] ⚙️ FUNCTION: Unknown.getFactory(string) (NodeID: 175)
  │ │     │   │   💬 Args: [env]
  │ │     │   │   👁️  Def: internal
  │ │     │   ├─ [7] ⚙️ FUNCTION: Unknown.getHelper(string) (NodeID: 176)
  │ │     │   │   💬 Args: [env]
  │ │     │   │   👁️  Def: internal
  │ │     │   ├─ [7] ⚙️ FUNCTION: Unknown.writeAccountEnv(string,address,address) (NodeID: 177)
  │ │     │   │   💬 Args: [env, factory, helper]
  │ │     │   │   👁️  Def: internal
  │ │     │   ├─ [7] ⚙️ FUNCTION: Unknown.writeAccountEnv(string,address,address) (NodeID: 178)
  │ │     │   │   💬 Args: [env, factory, helper]
  │ │     │   │   👁️  Def: internal
  │ │     │   ├─ [7] ⚙️ FUNCTION: Unknown.writeAccountEnv(string,address,address) (NodeID: 179)
  │ │     │   │   💬 Args: [env, factory, helper]
  │ │     │   │   👁️  Def: internal
  │ │     │   ├─ [7] ⚙️ FUNCTION: Unknown.writeAccountEnv(string,address,address) (NodeID: 180)
  │ │     │   │   💬 Args: [env, factory, helper]
  │ │     │   │   👁️  Def: internal
  │ │     │   └─ [7] ⚙️ FUNCTION: Unknown.writeAccountEnv(string,address,address) (NodeID: 181)
  │ │     │       💬 Args: [env, factory, helper]
  │ │     │       👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.getFactory(string) (NodeID: 182)
  │ │     │   💬 Args: [_env]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 183)
  │ │     │   💬 Args: [address(accountFactory), "AccountFactory"]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 184)
  │ │     │   💬 Args: [address(_defaultValidator), "DefaultValidator"]
  │ │     │   👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 185)
  │ │         💬 Args: [address(_defaultSessionValidator), "SessionValidator"]
  │ │         👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: RhinestoneModuleKit.makeAccountInstance(bytes32) (NodeID: 186)
  │ │   💬 Args: ["accountBase1"]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: ModuleKitHelpers.getAccountEnv() (NodeID: 187)
  │ │ │   💬 Args: [no args]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Unknown.getAccountEnv() (NodeID: 188)
  │ │ │     💬 Args: [no args]
  │ │ │     👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 189)
  │ │ │   💬 Args: [address(account), toString(salt)]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Unknown.toString(bytes32) (NodeID: 190)
  │ │ │     💬 Args: [salt]
  │ │ │     👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StdCheats.deal(address,uint256) (NodeID: 191)
  │ │ │   💬 Args: [account, 10 ether]
  │ │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: RhinestoneModuleKit._makeAccountInstance(bytes32,address,bytes,address,address,address,enum AccountType,address) (NodeID: 192)
  │ │ │   💬 Args: [salt, env, accountHelper, account, initCode, address(_defaultValidator), address(accountFactory), address(_defaultSessionValidator)]
  │ │ │   👁️  Def: internal
  │ │ └─ [3] 🔒 MODIFIER: RhinestoneModuleKit.initializeModuleKit() (NodeID: 193)
  │ │     💬 Args: [no args]
  │ │   ├─ [4] ⚙️ FUNCTION: Helpers.envOr(string,string) (NodeID: 194)
  │ │   │   💬 Args: ["ACCOUNT_TYPE", DEFAULT]
  │ │   │   👁️  Def: public
  │ │   └─ [4] ⚙️ FUNCTION: RhinestoneModuleKit._initializeModuleKit(string) (NodeID: 195)
  │ │       💬 Args: [_env]
  │ │       👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: AuxiliaryFactory.init() (NodeID: 196)
  │ │     │   💬 Args: [no args]
  │ │     │   👁️  Def: internal
  │ │     │ ├─ [6] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 197)
  │ │     │ │   💬 Args: [address(auxiliary.mockFactory), "Mock Factory"]
  │ │     │ │   👁️  Def: internal
  │ │     │ ├─ [6] ⚙️ FUNCTION: Unknown.etchEntrypoint() (NodeID: 198)
  │ │     │ │   💬 Args: [no args]
  │ │     │ │   👁️  Def: internal
  │ │     │ │ └─ [7] ⚙️ FUNCTION: Unknown.etch(address,bytes) (NodeID: 199)
  │ │     │ │     💬 Args: [ENTRYPOINT_ADDR, entryPoint.code]
  │ │     │ │     👁️  Def: internal
  │ │     │ ├─ [6] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 200)
  │ │     │ │   💬 Args: [address(auxiliary.entrypoint), "EntryPoint"]
  │ │     │ │   👁️  Def: internal
  │ │     │ ├─ [6] ⚙️ FUNCTION: Unknown.etchRegistry() (NodeID: 201)
  │ │     │ │   💬 Args: [no args]
  │ │     │ │   👁️  Def: internal
  │ │     │ │ └─ [7] ⚙️ FUNCTION: Unknown.etch(address,bytes) (NodeID: 202)
  │ │     │ │     💬 Args: [REGISTRY_ADDR, _registry.code]
  │ │     │ │     👁️  Def: internal
  │ │     │ ├─ [6] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 203)
  │ │     │ │   💬 Args: [address(auxiliary.registry), "ERC7484Registry"]
  │ │     │ │   👁️  Def: internal
  │ │     │ ├─ [6] ⚙️ FUNCTION: Unknown.etchSmartSessions() (NodeID: 204)
  │ │     │ │   💬 Args: [no args]
  │ │     │ │   👁️  Def: internal
  │ │     │ │ └─ [7] ⚙️ FUNCTION: Unknown.etch(address,bytes) (NodeID: 205)
  │ │     │ │     💬 Args: [address(SMARTSESSION_ADDR), SMART_SESSION_DEPLOYED_BYTECODE]
  │ │     │ │     👁️  Def: internal
  │ │     │ └─ [6] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 206)
  │ │     │     💬 Args: [address(auxiliary.smartSession), "SmartSession"]
  │ │     │     👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.writeFactory(address,string) (NodeID: 207)
  │ │     │   💬 Args: [address(new ERC7579Factory()), DEFAULT]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.writeFactory(address,string) (NodeID: 208)
  │ │     │   💬 Args: [address(new SafeFactory()), SAFE]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.writeFactory(address,string) (NodeID: 209)
  │ │     │   💬 Args: [address(new KernelFactory()), KERNEL]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.writeFactory(address,string) (NodeID: 210)
  │ │     │   💬 Args: [address(new NexusFactory()), NEXUS]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.writeFactory(address,string) (NodeID: 211)
  │ │     │   💬 Args: [address(new ERC7579Factory()), CUSTOM]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.writeHelper(address,string) (NodeID: 212)
  │ │     │   💬 Args: [address(new ERC7579Helpers()), DEFAULT]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.writeHelper(address,string) (NodeID: 213)
  │ │     │   💬 Args: [address(new SafeHelpers()), SAFE]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.writeHelper(address,string) (NodeID: 214)
  │ │     │   💬 Args: [address(new KernelHelpers()), KERNEL]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.writeHelper(address,string) (NodeID: 215)
  │ │     │   💬 Args: [address(new NexusHelpers()), NEXUS]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.writeHelper(address,string) (NodeID: 216)
  │ │     │   💬 Args: [address(new ERC7579Helpers()), CUSTOM]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.getFactory(string) (NodeID: 217)
  │ │     │   💬 Args: [SAFE]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.getFactory(string) (NodeID: 218)
  │ │     │   💬 Args: [KERNEL]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.getFactory(string) (NodeID: 219)
  │ │     │   💬 Args: [DEFAULT]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.getFactory(string) (NodeID: 220)
  │ │     │   💬 Args: [NEXUS]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.getFactory(string) (NodeID: 221)
  │ │     │   💬 Args: [CUSTOM]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 222)
  │ │     │   💬 Args: [address(safeFactory), "SafeFactory"]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 223)
  │ │     │   💬 Args: [address(kernelFactory), "KernelFactory"]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 224)
  │ │     │   💬 Args: [address(erc7579Factory), "ERC7579Factory"]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 225)
  │ │     │   💬 Args: [address(nexusFactory), "NexusFactory"]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 226)
  │ │     │   💬 Args: [address(customFactory), "CustomFactory"]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: StdCheats.deal(address,uint256) (NodeID: 227)
  │ │     │   💬 Args: [address(safeFactory), 10 ether]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: StdCheats.deal(address,uint256) (NodeID: 228)
  │ │     │   💬 Args: [address(kernelFactory), 10 ether]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: StdCheats.deal(address,uint256) (NodeID: 229)
  │ │     │   💬 Args: [address(erc7579Factory), 10 ether]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: StdCheats.deal(address,uint256) (NodeID: 230)
  │ │     │   💬 Args: [address(nexusFactory), 10 ether]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: StdCheats.deal(address,uint256) (NodeID: 231)
  │ │     │   💬 Args: [address(customFactory), 10 ether]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.prank(address) (NodeID: 232)
  │ │     │   💬 Args: [address(safeFactory)]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.prank(address) (NodeID: 233)
  │ │     │   💬 Args: [address(kernelFactory)]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.prank(address) (NodeID: 234)
  │ │     │   💬 Args: [address(erc7579Factory)]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.prank(address) (NodeID: 235)
  │ │     │   💬 Args: [address(nexusFactory)]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: ModuleKitHelpers.setAccountEnv(string) (NodeID: 236)
  │ │     │   💬 Args: [_env]
  │ │     │   👁️  Def: internal
  │ │     │ └─ [6] ⚙️ FUNCTION: ModuleKitHelpers._setAccountEnv(string) (NodeID: 237)
  │ │     │     💬 Args: [env]
  │ │     │     👁️  Def: private
  │ │     │   ├─ [7] ⚙️ FUNCTION: Unknown.getFactory(string) (NodeID: 238)
  │ │     │   │   💬 Args: [env]
  │ │     │   │   👁️  Def: internal
  │ │     │   ├─ [7] ⚙️ FUNCTION: Unknown.getHelper(string) (NodeID: 239)
  │ │     │   │   💬 Args: [env]
  │ │     │   │   👁️  Def: internal
  │ │     │   ├─ [7] ⚙️ FUNCTION: Unknown.writeAccountEnv(string,address,address) (NodeID: 240)
  │ │     │   │   💬 Args: [env, factory, helper]
  │ │     │   │   👁️  Def: internal
  │ │     │   ├─ [7] ⚙️ FUNCTION: Unknown.writeAccountEnv(string,address,address) (NodeID: 241)
  │ │     │   │   💬 Args: [env, factory, helper]
  │ │     │   │   👁️  Def: internal
  │ │     │   ├─ [7] ⚙️ FUNCTION: Unknown.writeAccountEnv(string,address,address) (NodeID: 242)
  │ │     │   │   💬 Args: [env, factory, helper]
  │ │     │   │   👁️  Def: internal
  │ │     │   ├─ [7] ⚙️ FUNCTION: Unknown.writeAccountEnv(string,address,address) (NodeID: 243)
  │ │     │   │   💬 Args: [env, factory, helper]
  │ │     │   │   👁️  Def: internal
  │ │     │   └─ [7] ⚙️ FUNCTION: Unknown.writeAccountEnv(string,address,address) (NodeID: 244)
  │ │     │       💬 Args: [env, factory, helper]
  │ │     │       👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.getFactory(string) (NodeID: 245)
  │ │     │   💬 Args: [_env]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 246)
  │ │     │   💬 Args: [address(accountFactory), "AccountFactory"]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 247)
  │ │     │   💬 Args: [address(_defaultValidator), "DefaultValidator"]
  │ │     │   👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 248)
  │ │         💬 Args: [address(_defaultSessionValidator), "SessionValidator"]
  │ │         👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StdCheats.deal(address,address,uint256) (NodeID: 249)
  │ │   💬 Args: [assetBase, accountBase.account, depositAmount]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdCheats.deal(address,address,uint256,bool) (NodeID: 250)
  │ │     💬 Args: [token, to, give, false]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: stdStorage.target(struct StdStorage,address) (NodeID: 251)
  │ │   │   💬 Args: [stdstore, token]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: stdStorageSafe.target(struct StdStorage,address) (NodeID: 252)
  │ │   │     💬 Args: [self, _target]
  │ │   │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: stdStorage.sig(struct StdStorage,bytes4) (NodeID: 253)
  │ │   │   💬 Args: [stdstore.target(token), 0x70a08231]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: stdStorageSafe.sig(struct StdStorage,bytes4) (NodeID: 254)
  │ │   │     💬 Args: [self, _sig]
  │ │   │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: stdStorage.with_key(struct StdStorage,address) (NodeID: 255)
  │ │   │   💬 Args: [stdstore.target(token).sig(0x70a08231), to]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: stdStorageSafe.with_key(struct StdStorage,address) (NodeID: 256)
  │ │   │     💬 Args: [self, who]
  │ │   │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,uint256) (NodeID: 257)
  │ │   │   💬 Args: [stdstore.target(token).sig(0x70a08231).with_key(to), give]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,bytes32) (NodeID: 258)
  │ │   │     💬 Args: [self, bytes32(amt)]
  │ │   │     👁️  Def: internal
  │ │   │   ├─ [6] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 259)
  │ │   │   │   💬 Args: [self]
  │ │   │   │   👁️  Def: internal
  │ │   │   │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 260)
  │ │   │   │     💬 Args: [self._keys]
  │ │   │   │     👁️  Def: private
  │ │   │   ├─ [6] ⚙️ FUNCTION: stdStorage.find(struct StdStorage,bool) (NodeID: 261)
  │ │   │   │   💬 Args: [self, false]
  │ │   │   │   👁️  Def: internal
  │ │   │   │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.find(struct StdStorage,bool) (NodeID: 262)
  │ │   │   │     💬 Args: [self, _clear]
  │ │   │   │     👁️  Def: internal
  │ │   │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 263)
  │ │   │   │   │   💬 Args: [self]
  │ │   │   │   │   👁️  Def: internal
  │ │   │   │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 264)
  │ │   │   │   │     💬 Args: [self._keys]
  │ │   │   │   │     👁️  Def: private
  │ │   │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 265)
  │ │   │   │   │   💬 Args: [self]
  │ │   │   │   │   👁️  Def: internal
  │ │   │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 266)
  │ │   │   │   │   💬 Args: [self]
  │ │   │   │   │   👁️  Def: internal
  │ │   │   │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 267)
  │ │   │   │   │ │   💬 Args: [self]
  │ │   │   │   │ │   👁️  Def: internal
  │ │   │   │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 268)
  │ │   │   │   │ │     💬 Args: [self._keys]
  │ │   │   │   │ │     👁️  Def: private
  │ │   │   │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 269)
  │ │   │   │   │     💬 Args: [rdat, 32 * self._depth]
  │ │   │   │   │     👁️  Def: private
  │ │   │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.checkSlotMutatesCall(struct StdStorage,bytes32) (NodeID: 270)
  │ │   │   │   │   💬 Args: [self, reads[i]]
  │ │   │   │   │   👁️  Def: internal
  │ │   │   │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 271)
  │ │   │   │   │ │   💬 Args: [self]
  │ │   │   │   │ │   👁️  Def: internal
  │ │   │   │   │ │ ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 272)
  │ │   │   │   │ │ │   💬 Args: [self]
  │ │   │   │   │ │ │   👁️  Def: internal
  │ │   │   │   │ │ │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 273)
  │ │   │   │   │ │ │     💬 Args: [self._keys]
  │ │   │   │   │ │ │     👁️  Def: private
  │ │   │   │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 274)
  │ │   │   │   │ │     💬 Args: [rdat, 32 * self._depth]
  │ │   │   │   │ │     👁️  Def: private
  │ │   │   │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 275)
  │ │   │   │   │     💬 Args: [self]
  │ │   │   │   │     👁️  Def: internal
  │ │   │   │   │   ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 276)
  │ │   │   │   │   │   💬 Args: [self]
  │ │   │   │   │   │   👁️  Def: internal
  │ │   │   │   │   │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 277)
  │ │   │   │   │   │     💬 Args: [self._keys]
  │ │   │   │   │   │     👁️  Def: private
  │ │   │   │   │   └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 278)
  │ │   │   │   │       💬 Args: [rdat, 32 * self._depth]
  │ │   │   │   │       👁️  Def: private
  │ │   │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.findOffsets(struct StdStorage,bytes32) (NodeID: 279)
  │ │   │   │   │   💬 Args: [self, reads[i]]
  │ │   │   │   │   👁️  Def: internal
  │ │   │   │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 280)
  │ │   │   │   │ │   💬 Args: [self, slot, true]
  │ │   │   │   │ │   👁️  Def: internal
  │ │   │   │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 281)
  │ │   │   │   │ │     💬 Args: [self]
  │ │   │   │   │ │     👁️  Def: internal
  │ │   │   │   │ │   ├─ [11] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 282)
  │ │   │   │   │ │   │   💬 Args: [self]
  │ │   │   │   │ │   │   👁️  Def: internal
  │ │   │   │   │ │   │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 283)
  │ │   │   │   │ │   │     💬 Args: [self._keys]
  │ │   │   │   │ │   │     👁️  Def: private
  │ │   │   │   │ │   └─ [11] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 284)
  │ │   │   │   │ │       💬 Args: [rdat, 32 * self._depth]
  │ │   │   │   │ │       👁️  Def: private
  │ │   │   │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 285)
  │ │   │   │   │     💬 Args: [self, slot, false]
  │ │   │   │   │     👁️  Def: internal
  │ │   │   │   │   └─ [10] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 286)
  │ │   │   │   │       💬 Args: [self]
  │ │   │   │   │       👁️  Def: internal
  │ │   │   │   │     ├─ [11] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 287)
  │ │   │   │   │     │   💬 Args: [self]
  │ │   │   │   │     │   👁️  Def: internal
  │ │   │   │   │     │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 288)
  │ │   │   │   │     │     💬 Args: [self._keys]
  │ │   │   │   │     │     👁️  Def: private
  │ │   │   │   │     └─ [11] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 289)
  │ │   │   │   │         💬 Args: [rdat, 32 * self._depth]
  │ │   │   │   │         👁️  Def: private
  │ │   │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 290)
  │ │   │   │   │   💬 Args: [offsetLeft, offsetRight]
  │ │   │   │   │   👁️  Def: internal
  │ │   │   │   └─ [8] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 291)
  │ │   │   │       💬 Args: [self]
  │ │   │   │       👁️  Def: internal
  │ │   │   ├─ [6] ⚙️ FUNCTION: stdStorageSafe.getUpdatedSlotValue(bytes32,uint256,uint256,uint256) (NodeID: 292)
  │ │   │   │   💬 Args: [curVal, uint256(set), data.offsetLeft, data.offsetRight]
  │ │   │   │   👁️  Def: internal
  │ │   │   │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 293)
  │ │   │   │     💬 Args: [offsetLeft, offsetRight]
  │ │   │   │     👁️  Def: internal
  │ │   │   ├─ [6] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 294)
  │ │   │   │   💬 Args: [self]
  │ │   │   │   👁️  Def: internal
  │ │   │   │ ├─ [7] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 295)
  │ │   │   │ │   💬 Args: [self]
  │ │   │   │ │   👁️  Def: internal
  │ │   │   │ │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 296)
  │ │   │   │ │     💬 Args: [self._keys]
  │ │   │   │ │     👁️  Def: private
  │ │   │   │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 297)
  │ │   │   │     💬 Args: [rdat, 32 * self._depth]
  │ │   │   │     👁️  Def: private
  │ │   │   └─ [6] ⚙️ FUNCTION: stdStorage.clear(struct StdStorage) (NodeID: 298)
  │ │   │       💬 Args: [self]
  │ │   │       👁️  Def: internal
  │ │   │     └─ [7] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 299)
  │ │   │         💬 Args: [self]
  │ │   │         👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: stdStorage.target(struct StdStorage,address) (NodeID: 300)
  │ │   │   💬 Args: [stdstore, token]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: stdStorageSafe.target(struct StdStorage,address) (NodeID: 301)
  │ │   │     💬 Args: [self, _target]
  │ │   │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: stdStorage.sig(struct StdStorage,bytes4) (NodeID: 302)
  │ │   │   💬 Args: [stdstore.target(token), 0x18160ddd]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: stdStorageSafe.sig(struct StdStorage,bytes4) (NodeID: 303)
  │ │   │     💬 Args: [self, _sig]
  │ │   │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,uint256) (NodeID: 304)
  │ │       💬 Args: [stdstore.target(token).sig(0x18160ddd), totSup]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,bytes32) (NodeID: 305)
  │ │         💬 Args: [self, bytes32(amt)]
  │ │         👁️  Def: internal
  │ │       ├─ [6] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 306)
  │ │       │   💬 Args: [self]
  │ │       │   👁️  Def: internal
  │ │       │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 307)
  │ │       │     💬 Args: [self._keys]
  │ │       │     👁️  Def: private
  │ │       ├─ [6] ⚙️ FUNCTION: stdStorage.find(struct StdStorage,bool) (NodeID: 308)
  │ │       │   💬 Args: [self, false]
  │ │       │   👁️  Def: internal
  │ │       │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.find(struct StdStorage,bool) (NodeID: 309)
  │ │       │     💬 Args: [self, _clear]
  │ │       │     👁️  Def: internal
  │ │       │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 310)
  │ │       │   │   💬 Args: [self]
  │ │       │   │   👁️  Def: internal
  │ │       │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 311)
  │ │       │   │     💬 Args: [self._keys]
  │ │       │   │     👁️  Def: private
  │ │       │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 312)
  │ │       │   │   💬 Args: [self]
  │ │       │   │   👁️  Def: internal
  │ │       │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 313)
  │ │       │   │   💬 Args: [self]
  │ │       │   │   👁️  Def: internal
  │ │       │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 314)
  │ │       │   │ │   💬 Args: [self]
  │ │       │   │ │   👁️  Def: internal
  │ │       │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 315)
  │ │       │   │ │     💬 Args: [self._keys]
  │ │       │   │ │     👁️  Def: private
  │ │       │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 316)
  │ │       │   │     💬 Args: [rdat, 32 * self._depth]
  │ │       │   │     👁️  Def: private
  │ │       │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.checkSlotMutatesCall(struct StdStorage,bytes32) (NodeID: 317)
  │ │       │   │   💬 Args: [self, reads[i]]
  │ │       │   │   👁️  Def: internal
  │ │       │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 318)
  │ │       │   │ │   💬 Args: [self]
  │ │       │   │ │   👁️  Def: internal
  │ │       │   │ │ ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 319)
  │ │       │   │ │ │   💬 Args: [self]
  │ │       │   │ │ │   👁️  Def: internal
  │ │       │   │ │ │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 320)
  │ │       │   │ │ │     💬 Args: [self._keys]
  │ │       │   │ │ │     👁️  Def: private
  │ │       │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 321)
  │ │       │   │ │     💬 Args: [rdat, 32 * self._depth]
  │ │       │   │ │     👁️  Def: private
  │ │       │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 322)
  │ │       │   │     💬 Args: [self]
  │ │       │   │     👁️  Def: internal
  │ │       │   │   ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 323)
  │ │       │   │   │   💬 Args: [self]
  │ │       │   │   │   👁️  Def: internal
  │ │       │   │   │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 324)
  │ │       │   │   │     💬 Args: [self._keys]
  │ │       │   │   │     👁️  Def: private
  │ │       │   │   └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 325)
  │ │       │   │       💬 Args: [rdat, 32 * self._depth]
  │ │       │   │       👁️  Def: private
  │ │       │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.findOffsets(struct StdStorage,bytes32) (NodeID: 326)
  │ │       │   │   💬 Args: [self, reads[i]]
  │ │       │   │   👁️  Def: internal
  │ │       │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 327)
  │ │       │   │ │   💬 Args: [self, slot, true]
  │ │       │   │ │   👁️  Def: internal
  │ │       │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 328)
  │ │       │   │ │     💬 Args: [self]
  │ │       │   │ │     👁️  Def: internal
  │ │       │   │ │   ├─ [11] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 329)
  │ │       │   │ │   │   💬 Args: [self]
  │ │       │   │ │   │   👁️  Def: internal
  │ │       │   │ │   │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 330)
  │ │       │   │ │   │     💬 Args: [self._keys]
  │ │       │   │ │   │     👁️  Def: private
  │ │       │   │ │   └─ [11] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 331)
  │ │       │   │ │       💬 Args: [rdat, 32 * self._depth]
  │ │       │   │ │       👁️  Def: private
  │ │       │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 332)
  │ │       │   │     💬 Args: [self, slot, false]
  │ │       │   │     👁️  Def: internal
  │ │       │   │   └─ [10] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 333)
  │ │       │   │       💬 Args: [self]
  │ │       │   │       👁️  Def: internal
  │ │       │   │     ├─ [11] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 334)
  │ │       │   │     │   💬 Args: [self]
  │ │       │   │     │   👁️  Def: internal
  │ │       │   │     │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 335)
  │ │       │   │     │     💬 Args: [self._keys]
  │ │       │   │     │     👁️  Def: private
  │ │       │   │     └─ [11] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 336)
  │ │       │   │         💬 Args: [rdat, 32 * self._depth]
  │ │       │   │         👁️  Def: private
  │ │       │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 337)
  │ │       │   │   💬 Args: [offsetLeft, offsetRight]
  │ │       │   │   👁️  Def: internal
  │ │       │   └─ [8] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 338)
  │ │       │       💬 Args: [self]
  │ │       │       👁️  Def: internal
  │ │       ├─ [6] ⚙️ FUNCTION: stdStorageSafe.getUpdatedSlotValue(bytes32,uint256,uint256,uint256) (NodeID: 339)
  │ │       │   💬 Args: [curVal, uint256(set), data.offsetLeft, data.offsetRight]
  │ │       │   👁️  Def: internal
  │ │       │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 340)
  │ │       │     💬 Args: [offsetLeft, offsetRight]
  │ │       │     👁️  Def: internal
  │ │       ├─ [6] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 341)
  │ │       │   💬 Args: [self]
  │ │       │   👁️  Def: internal
  │ │       │ ├─ [7] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 342)
  │ │       │ │   💬 Args: [self]
  │ │       │ │   👁️  Def: internal
  │ │       │ │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 343)
  │ │       │ │     💬 Args: [self._keys]
  │ │       │ │     👁️  Def: private
  │ │       │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 344)
  │ │       │     💬 Args: [rdat, 32 * self._depth]
  │ │       │     👁️  Def: private
  │ │       └─ [6] ⚙️ FUNCTION: stdStorage.clear(struct StdStorage) (NodeID: 345)
  │ │           💬 Args: [self]
  │ │           👁️  Def: internal
  │ │         └─ [7] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 346)
  │ │             💬 Args: [self]
  │ │             👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StdCheats.deal(address,address,uint256) (NodeID: 347)
  │ │   💬 Args: [assetBase, accountBase1.account, depositAmount]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdCheats.deal(address,address,uint256,bool) (NodeID: 348)
  │ │     💬 Args: [token, to, give, false]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: stdStorage.target(struct StdStorage,address) (NodeID: 349)
  │ │   │   💬 Args: [stdstore, token]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: stdStorageSafe.target(struct StdStorage,address) (NodeID: 350)
  │ │   │     💬 Args: [self, _target]
  │ │   │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: stdStorage.sig(struct StdStorage,bytes4) (NodeID: 351)
  │ │   │   💬 Args: [stdstore.target(token), 0x70a08231]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: stdStorageSafe.sig(struct StdStorage,bytes4) (NodeID: 352)
  │ │   │     💬 Args: [self, _sig]
  │ │   │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: stdStorage.with_key(struct StdStorage,address) (NodeID: 353)
  │ │   │   💬 Args: [stdstore.target(token).sig(0x70a08231), to]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: stdStorageSafe.with_key(struct StdStorage,address) (NodeID: 354)
  │ │   │     💬 Args: [self, who]
  │ │   │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,uint256) (NodeID: 355)
  │ │   │   💬 Args: [stdstore.target(token).sig(0x70a08231).with_key(to), give]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,bytes32) (NodeID: 356)
  │ │   │     💬 Args: [self, bytes32(amt)]
  │ │   │     👁️  Def: internal
  │ │   │   ├─ [6] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 357)
  │ │   │   │   💬 Args: [self]
  │ │   │   │   👁️  Def: internal
  │ │   │   │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 358)
  │ │   │   │     💬 Args: [self._keys]
  │ │   │   │     👁️  Def: private
  │ │   │   ├─ [6] ⚙️ FUNCTION: stdStorage.find(struct StdStorage,bool) (NodeID: 359)
  │ │   │   │   💬 Args: [self, false]
  │ │   │   │   👁️  Def: internal
  │ │   │   │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.find(struct StdStorage,bool) (NodeID: 360)
  │ │   │   │     💬 Args: [self, _clear]
  │ │   │   │     👁️  Def: internal
  │ │   │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 361)
  │ │   │   │   │   💬 Args: [self]
  │ │   │   │   │   👁️  Def: internal
  │ │   │   │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 362)
  │ │   │   │   │     💬 Args: [self._keys]
  │ │   │   │   │     👁️  Def: private
  │ │   │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 363)
  │ │   │   │   │   💬 Args: [self]
  │ │   │   │   │   👁️  Def: internal
  │ │   │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 364)
  │ │   │   │   │   💬 Args: [self]
  │ │   │   │   │   👁️  Def: internal
  │ │   │   │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 365)
  │ │   │   │   │ │   💬 Args: [self]
  │ │   │   │   │ │   👁️  Def: internal
  │ │   │   │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 366)
  │ │   │   │   │ │     💬 Args: [self._keys]
  │ │   │   │   │ │     👁️  Def: private
  │ │   │   │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 367)
  │ │   │   │   │     💬 Args: [rdat, 32 * self._depth]
  │ │   │   │   │     👁️  Def: private
  │ │   │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.checkSlotMutatesCall(struct StdStorage,bytes32) (NodeID: 368)
  │ │   │   │   │   💬 Args: [self, reads[i]]
  │ │   │   │   │   👁️  Def: internal
  │ │   │   │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 369)
  │ │   │   │   │ │   💬 Args: [self]
  │ │   │   │   │ │   👁️  Def: internal
  │ │   │   │   │ │ ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 370)
  │ │   │   │   │ │ │   💬 Args: [self]
  │ │   │   │   │ │ │   👁️  Def: internal
  │ │   │   │   │ │ │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 371)
  │ │   │   │   │ │ │     💬 Args: [self._keys]
  │ │   │   │   │ │ │     👁️  Def: private
  │ │   │   │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 372)
  │ │   │   │   │ │     💬 Args: [rdat, 32 * self._depth]
  │ │   │   │   │ │     👁️  Def: private
  │ │   │   │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 373)
  │ │   │   │   │     💬 Args: [self]
  │ │   │   │   │     👁️  Def: internal
  │ │   │   │   │   ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 374)
  │ │   │   │   │   │   💬 Args: [self]
  │ │   │   │   │   │   👁️  Def: internal
  │ │   │   │   │   │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 375)
  │ │   │   │   │   │     💬 Args: [self._keys]
  │ │   │   │   │   │     👁️  Def: private
  │ │   │   │   │   └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 376)
  │ │   │   │   │       💬 Args: [rdat, 32 * self._depth]
  │ │   │   │   │       👁️  Def: private
  │ │   │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.findOffsets(struct StdStorage,bytes32) (NodeID: 377)
  │ │   │   │   │   💬 Args: [self, reads[i]]
  │ │   │   │   │   👁️  Def: internal
  │ │   │   │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 378)
  │ │   │   │   │ │   💬 Args: [self, slot, true]
  │ │   │   │   │ │   👁️  Def: internal
  │ │   │   │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 379)
  │ │   │   │   │ │     💬 Args: [self]
  │ │   │   │   │ │     👁️  Def: internal
  │ │   │   │   │ │   ├─ [11] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 380)
  │ │   │   │   │ │   │   💬 Args: [self]
  │ │   │   │   │ │   │   👁️  Def: internal
  │ │   │   │   │ │   │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 381)
  │ │   │   │   │ │   │     💬 Args: [self._keys]
  │ │   │   │   │ │   │     👁️  Def: private
  │ │   │   │   │ │   └─ [11] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 382)
  │ │   │   │   │ │       💬 Args: [rdat, 32 * self._depth]
  │ │   │   │   │ │       👁️  Def: private
  │ │   │   │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 383)
  │ │   │   │   │     💬 Args: [self, slot, false]
  │ │   │   │   │     👁️  Def: internal
  │ │   │   │   │   └─ [10] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 384)
  │ │   │   │   │       💬 Args: [self]
  │ │   │   │   │       👁️  Def: internal
  │ │   │   │   │     ├─ [11] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 385)
  │ │   │   │   │     │   💬 Args: [self]
  │ │   │   │   │     │   👁️  Def: internal
  │ │   │   │   │     │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 386)
  │ │   │   │   │     │     💬 Args: [self._keys]
  │ │   │   │   │     │     👁️  Def: private
  │ │   │   │   │     └─ [11] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 387)
  │ │   │   │   │         💬 Args: [rdat, 32 * self._depth]
  │ │   │   │   │         👁️  Def: private
  │ │   │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 388)
  │ │   │   │   │   💬 Args: [offsetLeft, offsetRight]
  │ │   │   │   │   👁️  Def: internal
  │ │   │   │   └─ [8] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 389)
  │ │   │   │       💬 Args: [self]
  │ │   │   │       👁️  Def: internal
  │ │   │   ├─ [6] ⚙️ FUNCTION: stdStorageSafe.getUpdatedSlotValue(bytes32,uint256,uint256,uint256) (NodeID: 390)
  │ │   │   │   💬 Args: [curVal, uint256(set), data.offsetLeft, data.offsetRight]
  │ │   │   │   👁️  Def: internal
  │ │   │   │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 391)
  │ │   │   │     💬 Args: [offsetLeft, offsetRight]
  │ │   │   │     👁️  Def: internal
  │ │   │   ├─ [6] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 392)
  │ │   │   │   💬 Args: [self]
  │ │   │   │   👁️  Def: internal
  │ │   │   │ ├─ [7] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 393)
  │ │   │   │ │   💬 Args: [self]
  │ │   │   │ │   👁️  Def: internal
  │ │   │   │ │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 394)
  │ │   │   │ │     💬 Args: [self._keys]
  │ │   │   │ │     👁️  Def: private
  │ │   │   │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 395)
  │ │   │   │     💬 Args: [rdat, 32 * self._depth]
  │ │   │   │     👁️  Def: private
  │ │   │   └─ [6] ⚙️ FUNCTION: stdStorage.clear(struct StdStorage) (NodeID: 396)
  │ │   │       💬 Args: [self]
  │ │   │       👁️  Def: internal
  │ │   │     └─ [7] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 397)
  │ │   │         💬 Args: [self]
  │ │   │         👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: stdStorage.target(struct StdStorage,address) (NodeID: 398)
  │ │   │   💬 Args: [stdstore, token]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: stdStorageSafe.target(struct StdStorage,address) (NodeID: 399)
  │ │   │     💬 Args: [self, _target]
  │ │   │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: stdStorage.sig(struct StdStorage,bytes4) (NodeID: 400)
  │ │   │   💬 Args: [stdstore.target(token), 0x18160ddd]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: stdStorageSafe.sig(struct StdStorage,bytes4) (NodeID: 401)
  │ │   │     💬 Args: [self, _sig]
  │ │   │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,uint256) (NodeID: 402)
  │ │       💬 Args: [stdstore.target(token).sig(0x18160ddd), totSup]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,bytes32) (NodeID: 403)
  │ │         💬 Args: [self, bytes32(amt)]
  │ │         👁️  Def: internal
  │ │       ├─ [6] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 404)
  │ │       │   💬 Args: [self]
  │ │       │   👁️  Def: internal
  │ │       │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 405)
  │ │       │     💬 Args: [self._keys]
  │ │       │     👁️  Def: private
  │ │       ├─ [6] ⚙️ FUNCTION: stdStorage.find(struct StdStorage,bool) (NodeID: 406)
  │ │       │   💬 Args: [self, false]
  │ │       │   👁️  Def: internal
  │ │       │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.find(struct StdStorage,bool) (NodeID: 407)
  │ │       │     💬 Args: [self, _clear]
  │ │       │     👁️  Def: internal
  │ │       │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 408)
  │ │       │   │   💬 Args: [self]
  │ │       │   │   👁️  Def: internal
  │ │       │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 409)
  │ │       │   │     💬 Args: [self._keys]
  │ │       │   │     👁️  Def: private
  │ │       │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 410)
  │ │       │   │   💬 Args: [self]
  │ │       │   │   👁️  Def: internal
  │ │       │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 411)
  │ │       │   │   💬 Args: [self]
  │ │       │   │   👁️  Def: internal
  │ │       │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 412)
  │ │       │   │ │   💬 Args: [self]
  │ │       │   │ │   👁️  Def: internal
  │ │       │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 413)
  │ │       │   │ │     💬 Args: [self._keys]
  │ │       │   │ │     👁️  Def: private
  │ │       │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 414)
  │ │       │   │     💬 Args: [rdat, 32 * self._depth]
  │ │       │   │     👁️  Def: private
  │ │       │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.checkSlotMutatesCall(struct StdStorage,bytes32) (NodeID: 415)
  │ │       │   │   💬 Args: [self, reads[i]]
  │ │       │   │   👁️  Def: internal
  │ │       │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 416)
  │ │       │   │ │   💬 Args: [self]
  │ │       │   │ │   👁️  Def: internal
  │ │       │   │ │ ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 417)
  │ │       │   │ │ │   💬 Args: [self]
  │ │       │   │ │ │   👁️  Def: internal
  │ │       │   │ │ │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 418)
  │ │       │   │ │ │     💬 Args: [self._keys]
  │ │       │   │ │ │     👁️  Def: private
  │ │       │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 419)
  │ │       │   │ │     💬 Args: [rdat, 32 * self._depth]
  │ │       │   │ │     👁️  Def: private
  │ │       │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 420)
  │ │       │   │     💬 Args: [self]
  │ │       │   │     👁️  Def: internal
  │ │       │   │   ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 421)
  │ │       │   │   │   💬 Args: [self]
  │ │       │   │   │   👁️  Def: internal
  │ │       │   │   │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 422)
  │ │       │   │   │     💬 Args: [self._keys]
  │ │       │   │   │     👁️  Def: private
  │ │       │   │   └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 423)
  │ │       │   │       💬 Args: [rdat, 32 * self._depth]
  │ │       │   │       👁️  Def: private
  │ │       │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.findOffsets(struct StdStorage,bytes32) (NodeID: 424)
  │ │       │   │   💬 Args: [self, reads[i]]
  │ │       │   │   👁️  Def: internal
  │ │       │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 425)
  │ │       │   │ │   💬 Args: [self, slot, true]
  │ │       │   │ │   👁️  Def: internal
  │ │       │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 426)
  │ │       │   │ │     💬 Args: [self]
  │ │       │   │ │     👁️  Def: internal
  │ │       │   │ │   ├─ [11] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 427)
  │ │       │   │ │   │   💬 Args: [self]
  │ │       │   │ │   │   👁️  Def: internal
  │ │       │   │ │   │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 428)
  │ │       │   │ │   │     💬 Args: [self._keys]
  │ │       │   │ │   │     👁️  Def: private
  │ │       │   │ │   └─ [11] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 429)
  │ │       │   │ │       💬 Args: [rdat, 32 * self._depth]
  │ │       │   │ │       👁️  Def: private
  │ │       │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 430)
  │ │       │   │     💬 Args: [self, slot, false]
  │ │       │   │     👁️  Def: internal
  │ │       │   │   └─ [10] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 431)
  │ │       │   │       💬 Args: [self]
  │ │       │   │       👁️  Def: internal
  │ │       │   │     ├─ [11] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 432)
  │ │       │   │     │   💬 Args: [self]
  │ │       │   │     │   👁️  Def: internal
  │ │       │   │     │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 433)
  │ │       │   │     │     💬 Args: [self._keys]
  │ │       │   │     │     👁️  Def: private
  │ │       │   │     └─ [11] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 434)
  │ │       │   │         💬 Args: [rdat, 32 * self._depth]
  │ │       │   │         👁️  Def: private
  │ │       │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 435)
  │ │       │   │   💬 Args: [offsetLeft, offsetRight]
  │ │       │   │   👁️  Def: internal
  │ │       │   └─ [8] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 436)
  │ │       │       💬 Args: [self]
  │ │       │       👁️  Def: internal
  │ │       ├─ [6] ⚙️ FUNCTION: stdStorageSafe.getUpdatedSlotValue(bytes32,uint256,uint256,uint256) (NodeID: 437)
  │ │       │   💬 Args: [curVal, uint256(set), data.offsetLeft, data.offsetRight]
  │ │       │   👁️  Def: internal
  │ │       │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 438)
  │ │       │     💬 Args: [offsetLeft, offsetRight]
  │ │       │     👁️  Def: internal
  │ │       ├─ [6] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 439)
  │ │       │   💬 Args: [self]
  │ │       │   👁️  Def: internal
  │ │       │ ├─ [7] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 440)
  │ │       │ │   💬 Args: [self]
  │ │       │ │   👁️  Def: internal
  │ │       │ │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 441)
  │ │       │ │     💬 Args: [self._keys]
  │ │       │ │     👁️  Def: private
  │ │       │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 442)
  │ │       │     💬 Args: [rdat, 32 * self._depth]
  │ │       │     👁️  Def: private
  │ │       └─ [6] ⚙️ FUNCTION: stdStorage.clear(struct StdStorage) (NodeID: 443)
  │ │           💬 Args: [self]
  │ │           👁️  Def: internal
  │ │         └─ [7] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 444)
  │ │             💬 Args: [self]
  │ │             👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: SuperVaultTest._depositIntoUnderlyingOnBase(address,address,address,uint256) (NodeID: 445)
  │ │   💬 Args: [assetBase, morphoVaultAddr, address(bTStrategy), depositAmount]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: BaseTest._getHookAddress(uint64,string) (NodeID: 446)
  │ │ │   💬 Args: [BASE, APPROVE_AND_DEPOSIT_4626_VAULT_HOOK_KEY]
  │ │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: InternalHelpers._createApproveAndDeposit4626HookData(bytes32,address,address,uint256,bool,address,uint256) (NodeID: 447)
  │ │ │   💬 Args: [_getYieldSourceOracleId(bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), MANAGER), baseUnderlying, assetOnBase, depositAmount, false, address(0), 0]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: InternalHelpers._getYieldSourceOracleId(bytes32,address) (NodeID: 448)
  │ │ │     💬 Args: [bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), MANAGER]
  │ │ │     👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: BaseTest._getContract(uint64,string) (NodeID: 449)
  │ │ │   💬 Args: [BASE, SUPER_VAULT_AGGREGATOR_KEY]
  │ │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: SuperVaultTest._tryGetBaseMerkleProofs(address[],bytes[]) (NodeID: 450)
  │ │     💬 Args: [fulfillHooksAddresses, argsForProofs]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: BaseSuperVaultTest._updateSuperVaultBasePPS(address,address) (NodeID: 451)
  │     💬 Args: [address(bTStrategy), address(bTVault)]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256,enum Math.Rounding) (NodeID: 452)
  │   │   💬 Args: [vars.currentTotalAssets, vars.precision, vars.totalSupplyAmount, Math.Rounding.Floor]
  │   │   👁️  Def: internal
  │   │ ├─ [4] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 453)
  │   │ │   💬 Args: [unsignedRoundsUp(rounding) && (mulmod(x, y, denominator) > 0)]
  │   │ │   👁️  Def: internal
  │   │ │ └─ [5] ⚙️ FUNCTION: Math.unsignedRoundsUp(enum Math.Rounding) (NodeID: 454)
  │   │ │     💬 Args: [rounding]
  │   │ │     👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 455)
  │   │     💬 Args: [x, y, denominator]
  │   │     👁️  Def: internal
  │   │   ├─ [5] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 456)
  │   │   │   💬 Args: [x, y]
  │   │   │   👁️  Def: internal
  │   │   └─ [5] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 457)
  │   │       💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │   │       👁️  Def: internal
  │   │     └─ [6] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 458)
  │   │         💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │   │         👁️  Def: internal
  │   │       └─ [7] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 459)
  │   │           💬 Args: [condition]
  │   │           👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: BaseTest._getContract(uint64,string) (NodeID: 460)
  │   │   💬 Args: [BASE, ECDSAPPS_ORACLE_KEY]
  │   │   👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: MessageHashUtils.toTypedDataHash(bytes32,bytes32) (NodeID: 461)
  │   │   💬 Args: [baseOracle.domainSeparator(), structHash]
  │   │   👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: console.log(string,address,uint256) (NodeID: 462)
  │       💬 Args: ["Updated PPS for strategy", strategyAddr, vars.pps]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 463)
  │         💬 Args: [abi.encodeWithSignature("log(string,address,uint256)", p0, p1, p2)]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 464)
  │           💬 Args: [_sendLogPayloadView]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: SuperVaultTest._processBridgeTestRedemption(contract SuperVault,contract SuperVaultStrategy,contract SuperGovernor,contract SuperVaultAggregator) (NodeID: 465)
  │   💬 Args: [bTVault, bTStrategy, govBase, aggregatorBase]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: RhinestoneModuleKit.makeAccountInstance(bytes32) (NodeID: 466)
  │ │   💬 Args: ["accountBase"]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: ModuleKitHelpers.getAccountEnv() (NodeID: 467)
  │ │ │   💬 Args: [no args]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Unknown.getAccountEnv() (NodeID: 468)
  │ │ │     💬 Args: [no args]
  │ │ │     👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 469)
  │ │ │   💬 Args: [address(account), toString(salt)]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Unknown.toString(bytes32) (NodeID: 470)
  │ │ │     💬 Args: [salt]
  │ │ │     👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StdCheats.deal(address,uint256) (NodeID: 471)
  │ │ │   💬 Args: [account, 10 ether]
  │ │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: RhinestoneModuleKit._makeAccountInstance(bytes32,address,bytes,address,address,address,enum AccountType,address) (NodeID: 472)
  │ │ │   💬 Args: [salt, env, accountHelper, account, initCode, address(_defaultValidator), address(accountFactory), address(_defaultSessionValidator)]
  │ │ │   👁️  Def: internal
  │ │ └─ [3] 🔒 MODIFIER: RhinestoneModuleKit.initializeModuleKit() (NodeID: 473)
  │ │     💬 Args: [no args]
  │ │   ├─ [4] ⚙️ FUNCTION: Helpers.envOr(string,string) (NodeID: 474)
  │ │   │   💬 Args: ["ACCOUNT_TYPE", DEFAULT]
  │ │   │   👁️  Def: public
  │ │   └─ [4] ⚙️ FUNCTION: RhinestoneModuleKit._initializeModuleKit(string) (NodeID: 475)
  │ │       💬 Args: [_env]
  │ │       👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: AuxiliaryFactory.init() (NodeID: 476)
  │ │     │   💬 Args: [no args]
  │ │     │   👁️  Def: internal
  │ │     │ ├─ [6] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 477)
  │ │     │ │   💬 Args: [address(auxiliary.mockFactory), "Mock Factory"]
  │ │     │ │   👁️  Def: internal
  │ │     │ ├─ [6] ⚙️ FUNCTION: Unknown.etchEntrypoint() (NodeID: 478)
  │ │     │ │   💬 Args: [no args]
  │ │     │ │   👁️  Def: internal
  │ │     │ │ └─ [7] ⚙️ FUNCTION: Unknown.etch(address,bytes) (NodeID: 479)
  │ │     │ │     💬 Args: [ENTRYPOINT_ADDR, entryPoint.code]
  │ │     │ │     👁️  Def: internal
  │ │     │ ├─ [6] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 480)
  │ │     │ │   💬 Args: [address(auxiliary.entrypoint), "EntryPoint"]
  │ │     │ │   👁️  Def: internal
  │ │     │ ├─ [6] ⚙️ FUNCTION: Unknown.etchRegistry() (NodeID: 481)
  │ │     │ │   💬 Args: [no args]
  │ │     │ │   👁️  Def: internal
  │ │     │ │ └─ [7] ⚙️ FUNCTION: Unknown.etch(address,bytes) (NodeID: 482)
  │ │     │ │     💬 Args: [REGISTRY_ADDR, _registry.code]
  │ │     │ │     👁️  Def: internal
  │ │     │ ├─ [6] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 483)
  │ │     │ │   💬 Args: [address(auxiliary.registry), "ERC7484Registry"]
  │ │     │ │   👁️  Def: internal
  │ │     │ ├─ [6] ⚙️ FUNCTION: Unknown.etchSmartSessions() (NodeID: 484)
  │ │     │ │   💬 Args: [no args]
  │ │     │ │   👁️  Def: internal
  │ │     │ │ └─ [7] ⚙️ FUNCTION: Unknown.etch(address,bytes) (NodeID: 485)
  │ │     │ │     💬 Args: [address(SMARTSESSION_ADDR), SMART_SESSION_DEPLOYED_BYTECODE]
  │ │     │ │     👁️  Def: internal
  │ │     │ └─ [6] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 486)
  │ │     │     💬 Args: [address(auxiliary.smartSession), "SmartSession"]
  │ │     │     👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.writeFactory(address,string) (NodeID: 487)
  │ │     │   💬 Args: [address(new ERC7579Factory()), DEFAULT]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.writeFactory(address,string) (NodeID: 488)
  │ │     │   💬 Args: [address(new SafeFactory()), SAFE]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.writeFactory(address,string) (NodeID: 489)
  │ │     │   💬 Args: [address(new KernelFactory()), KERNEL]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.writeFactory(address,string) (NodeID: 490)
  │ │     │   💬 Args: [address(new NexusFactory()), NEXUS]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.writeFactory(address,string) (NodeID: 491)
  │ │     │   💬 Args: [address(new ERC7579Factory()), CUSTOM]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.writeHelper(address,string) (NodeID: 492)
  │ │     │   💬 Args: [address(new ERC7579Helpers()), DEFAULT]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.writeHelper(address,string) (NodeID: 493)
  │ │     │   💬 Args: [address(new SafeHelpers()), SAFE]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.writeHelper(address,string) (NodeID: 494)
  │ │     │   💬 Args: [address(new KernelHelpers()), KERNEL]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.writeHelper(address,string) (NodeID: 495)
  │ │     │   💬 Args: [address(new NexusHelpers()), NEXUS]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.writeHelper(address,string) (NodeID: 496)
  │ │     │   💬 Args: [address(new ERC7579Helpers()), CUSTOM]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.getFactory(string) (NodeID: 497)
  │ │     │   💬 Args: [SAFE]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.getFactory(string) (NodeID: 498)
  │ │     │   💬 Args: [KERNEL]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.getFactory(string) (NodeID: 499)
  │ │     │   💬 Args: [DEFAULT]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.getFactory(string) (NodeID: 500)
  │ │     │   💬 Args: [NEXUS]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.getFactory(string) (NodeID: 501)
  │ │     │   💬 Args: [CUSTOM]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 502)
  │ │     │   💬 Args: [address(safeFactory), "SafeFactory"]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 503)
  │ │     │   💬 Args: [address(kernelFactory), "KernelFactory"]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 504)
  │ │     │   💬 Args: [address(erc7579Factory), "ERC7579Factory"]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 505)
  │ │     │   💬 Args: [address(nexusFactory), "NexusFactory"]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 506)
  │ │     │   💬 Args: [address(customFactory), "CustomFactory"]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: StdCheats.deal(address,uint256) (NodeID: 507)
  │ │     │   💬 Args: [address(safeFactory), 10 ether]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: StdCheats.deal(address,uint256) (NodeID: 508)
  │ │     │   💬 Args: [address(kernelFactory), 10 ether]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: StdCheats.deal(address,uint256) (NodeID: 509)
  │ │     │   💬 Args: [address(erc7579Factory), 10 ether]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: StdCheats.deal(address,uint256) (NodeID: 510)
  │ │     │   💬 Args: [address(nexusFactory), 10 ether]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: StdCheats.deal(address,uint256) (NodeID: 511)
  │ │     │   💬 Args: [address(customFactory), 10 ether]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.prank(address) (NodeID: 512)
  │ │     │   💬 Args: [address(safeFactory)]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.prank(address) (NodeID: 513)
  │ │     │   💬 Args: [address(kernelFactory)]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.prank(address) (NodeID: 514)
  │ │     │   💬 Args: [address(erc7579Factory)]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.prank(address) (NodeID: 515)
  │ │     │   💬 Args: [address(nexusFactory)]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: ModuleKitHelpers.setAccountEnv(string) (NodeID: 516)
  │ │     │   💬 Args: [_env]
  │ │     │   👁️  Def: internal
  │ │     │ └─ [6] ⚙️ FUNCTION: ModuleKitHelpers._setAccountEnv(string) (NodeID: 517)
  │ │     │     💬 Args: [env]
  │ │     │     👁️  Def: private
  │ │     │   ├─ [7] ⚙️ FUNCTION: Unknown.getFactory(string) (NodeID: 518)
  │ │     │   │   💬 Args: [env]
  │ │     │   │   👁️  Def: internal
  │ │     │   ├─ [7] ⚙️ FUNCTION: Unknown.getHelper(string) (NodeID: 519)
  │ │     │   │   💬 Args: [env]
  │ │     │   │   👁️  Def: internal
  │ │     │   ├─ [7] ⚙️ FUNCTION: Unknown.writeAccountEnv(string,address,address) (NodeID: 520)
  │ │     │   │   💬 Args: [env, factory, helper]
  │ │     │   │   👁️  Def: internal
  │ │     │   ├─ [7] ⚙️ FUNCTION: Unknown.writeAccountEnv(string,address,address) (NodeID: 521)
  │ │     │   │   💬 Args: [env, factory, helper]
  │ │     │   │   👁️  Def: internal
  │ │     │   ├─ [7] ⚙️ FUNCTION: Unknown.writeAccountEnv(string,address,address) (NodeID: 522)
  │ │     │   │   💬 Args: [env, factory, helper]
  │ │     │   │   👁️  Def: internal
  │ │     │   ├─ [7] ⚙️ FUNCTION: Unknown.writeAccountEnv(string,address,address) (NodeID: 523)
  │ │     │   │   💬 Args: [env, factory, helper]
  │ │     │   │   👁️  Def: internal
  │ │     │   └─ [7] ⚙️ FUNCTION: Unknown.writeAccountEnv(string,address,address) (NodeID: 524)
  │ │     │       💬 Args: [env, factory, helper]
  │ │     │       👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.getFactory(string) (NodeID: 525)
  │ │     │   💬 Args: [_env]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 526)
  │ │     │   💬 Args: [address(accountFactory), "AccountFactory"]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 527)
  │ │     │   💬 Args: [address(_defaultValidator), "DefaultValidator"]
  │ │     │   👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 528)
  │ │         💬 Args: [address(_defaultSessionValidator), "SessionValidator"]
  │ │         👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: RhinestoneModuleKit.makeAccountInstance(bytes32) (NodeID: 529)
  │ │   💬 Args: ["accountBase1"]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: ModuleKitHelpers.getAccountEnv() (NodeID: 530)
  │ │ │   💬 Args: [no args]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Unknown.getAccountEnv() (NodeID: 531)
  │ │ │     💬 Args: [no args]
  │ │ │     👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 532)
  │ │ │   💬 Args: [address(account), toString(salt)]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Unknown.toString(bytes32) (NodeID: 533)
  │ │ │     💬 Args: [salt]
  │ │ │     👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StdCheats.deal(address,uint256) (NodeID: 534)
  │ │ │   💬 Args: [account, 10 ether]
  │ │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: RhinestoneModuleKit._makeAccountInstance(bytes32,address,bytes,address,address,address,enum AccountType,address) (NodeID: 535)
  │ │ │   💬 Args: [salt, env, accountHelper, account, initCode, address(_defaultValidator), address(accountFactory), address(_defaultSessionValidator)]
  │ │ │   👁️  Def: internal
  │ │ └─ [3] 🔒 MODIFIER: RhinestoneModuleKit.initializeModuleKit() (NodeID: 536)
  │ │     💬 Args: [no args]
  │ │   ├─ [4] ⚙️ FUNCTION: Helpers.envOr(string,string) (NodeID: 537)
  │ │   │   💬 Args: ["ACCOUNT_TYPE", DEFAULT]
  │ │   │   👁️  Def: public
  │ │   └─ [4] ⚙️ FUNCTION: RhinestoneModuleKit._initializeModuleKit(string) (NodeID: 538)
  │ │       💬 Args: [_env]
  │ │       👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: AuxiliaryFactory.init() (NodeID: 539)
  │ │     │   💬 Args: [no args]
  │ │     │   👁️  Def: internal
  │ │     │ ├─ [6] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 540)
  │ │     │ │   💬 Args: [address(auxiliary.mockFactory), "Mock Factory"]
  │ │     │ │   👁️  Def: internal
  │ │     │ ├─ [6] ⚙️ FUNCTION: Unknown.etchEntrypoint() (NodeID: 541)
  │ │     │ │   💬 Args: [no args]
  │ │     │ │   👁️  Def: internal
  │ │     │ │ └─ [7] ⚙️ FUNCTION: Unknown.etch(address,bytes) (NodeID: 542)
  │ │     │ │     💬 Args: [ENTRYPOINT_ADDR, entryPoint.code]
  │ │     │ │     👁️  Def: internal
  │ │     │ ├─ [6] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 543)
  │ │     │ │   💬 Args: [address(auxiliary.entrypoint), "EntryPoint"]
  │ │     │ │   👁️  Def: internal
  │ │     │ ├─ [6] ⚙️ FUNCTION: Unknown.etchRegistry() (NodeID: 544)
  │ │     │ │   💬 Args: [no args]
  │ │     │ │   👁️  Def: internal
  │ │     │ │ └─ [7] ⚙️ FUNCTION: Unknown.etch(address,bytes) (NodeID: 545)
  │ │     │ │     💬 Args: [REGISTRY_ADDR, _registry.code]
  │ │     │ │     👁️  Def: internal
  │ │     │ ├─ [6] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 546)
  │ │     │ │   💬 Args: [address(auxiliary.registry), "ERC7484Registry"]
  │ │     │ │   👁️  Def: internal
  │ │     │ ├─ [6] ⚙️ FUNCTION: Unknown.etchSmartSessions() (NodeID: 547)
  │ │     │ │   💬 Args: [no args]
  │ │     │ │   👁️  Def: internal
  │ │     │ │ └─ [7] ⚙️ FUNCTION: Unknown.etch(address,bytes) (NodeID: 548)
  │ │     │ │     💬 Args: [address(SMARTSESSION_ADDR), SMART_SESSION_DEPLOYED_BYTECODE]
  │ │     │ │     👁️  Def: internal
  │ │     │ └─ [6] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 549)
  │ │     │     💬 Args: [address(auxiliary.smartSession), "SmartSession"]
  │ │     │     👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.writeFactory(address,string) (NodeID: 550)
  │ │     │   💬 Args: [address(new ERC7579Factory()), DEFAULT]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.writeFactory(address,string) (NodeID: 551)
  │ │     │   💬 Args: [address(new SafeFactory()), SAFE]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.writeFactory(address,string) (NodeID: 552)
  │ │     │   💬 Args: [address(new KernelFactory()), KERNEL]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.writeFactory(address,string) (NodeID: 553)
  │ │     │   💬 Args: [address(new NexusFactory()), NEXUS]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.writeFactory(address,string) (NodeID: 554)
  │ │     │   💬 Args: [address(new ERC7579Factory()), CUSTOM]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.writeHelper(address,string) (NodeID: 555)
  │ │     │   💬 Args: [address(new ERC7579Helpers()), DEFAULT]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.writeHelper(address,string) (NodeID: 556)
  │ │     │   💬 Args: [address(new SafeHelpers()), SAFE]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.writeHelper(address,string) (NodeID: 557)
  │ │     │   💬 Args: [address(new KernelHelpers()), KERNEL]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.writeHelper(address,string) (NodeID: 558)
  │ │     │   💬 Args: [address(new NexusHelpers()), NEXUS]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.writeHelper(address,string) (NodeID: 559)
  │ │     │   💬 Args: [address(new ERC7579Helpers()), CUSTOM]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.getFactory(string) (NodeID: 560)
  │ │     │   💬 Args: [SAFE]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.getFactory(string) (NodeID: 561)
  │ │     │   💬 Args: [KERNEL]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.getFactory(string) (NodeID: 562)
  │ │     │   💬 Args: [DEFAULT]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.getFactory(string) (NodeID: 563)
  │ │     │   💬 Args: [NEXUS]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.getFactory(string) (NodeID: 564)
  │ │     │   💬 Args: [CUSTOM]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 565)
  │ │     │   💬 Args: [address(safeFactory), "SafeFactory"]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 566)
  │ │     │   💬 Args: [address(kernelFactory), "KernelFactory"]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 567)
  │ │     │   💬 Args: [address(erc7579Factory), "ERC7579Factory"]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 568)
  │ │     │   💬 Args: [address(nexusFactory), "NexusFactory"]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 569)
  │ │     │   💬 Args: [address(customFactory), "CustomFactory"]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: StdCheats.deal(address,uint256) (NodeID: 570)
  │ │     │   💬 Args: [address(safeFactory), 10 ether]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: StdCheats.deal(address,uint256) (NodeID: 571)
  │ │     │   💬 Args: [address(kernelFactory), 10 ether]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: StdCheats.deal(address,uint256) (NodeID: 572)
  │ │     │   💬 Args: [address(erc7579Factory), 10 ether]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: StdCheats.deal(address,uint256) (NodeID: 573)
  │ │     │   💬 Args: [address(nexusFactory), 10 ether]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: StdCheats.deal(address,uint256) (NodeID: 574)
  │ │     │   💬 Args: [address(customFactory), 10 ether]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.prank(address) (NodeID: 575)
  │ │     │   💬 Args: [address(safeFactory)]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.prank(address) (NodeID: 576)
  │ │     │   💬 Args: [address(kernelFactory)]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.prank(address) (NodeID: 577)
  │ │     │   💬 Args: [address(erc7579Factory)]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.prank(address) (NodeID: 578)
  │ │     │   💬 Args: [address(nexusFactory)]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: ModuleKitHelpers.setAccountEnv(string) (NodeID: 579)
  │ │     │   💬 Args: [_env]
  │ │     │   👁️  Def: internal
  │ │     │ └─ [6] ⚙️ FUNCTION: ModuleKitHelpers._setAccountEnv(string) (NodeID: 580)
  │ │     │     💬 Args: [env]
  │ │     │     👁️  Def: private
  │ │     │   ├─ [7] ⚙️ FUNCTION: Unknown.getFactory(string) (NodeID: 581)
  │ │     │   │   💬 Args: [env]
  │ │     │   │   👁️  Def: internal
  │ │     │   ├─ [7] ⚙️ FUNCTION: Unknown.getHelper(string) (NodeID: 582)
  │ │     │   │   💬 Args: [env]
  │ │     │   │   👁️  Def: internal
  │ │     │   ├─ [7] ⚙️ FUNCTION: Unknown.writeAccountEnv(string,address,address) (NodeID: 583)
  │ │     │   │   💬 Args: [env, factory, helper]
  │ │     │   │   👁️  Def: internal
  │ │     │   ├─ [7] ⚙️ FUNCTION: Unknown.writeAccountEnv(string,address,address) (NodeID: 584)
  │ │     │   │   💬 Args: [env, factory, helper]
  │ │     │   │   👁️  Def: internal
  │ │     │   ├─ [7] ⚙️ FUNCTION: Unknown.writeAccountEnv(string,address,address) (NodeID: 585)
  │ │     │   │   💬 Args: [env, factory, helper]
  │ │     │   │   👁️  Def: internal
  │ │     │   ├─ [7] ⚙️ FUNCTION: Unknown.writeAccountEnv(string,address,address) (NodeID: 586)
  │ │     │   │   💬 Args: [env, factory, helper]
  │ │     │   │   👁️  Def: internal
  │ │     │   └─ [7] ⚙️ FUNCTION: Unknown.writeAccountEnv(string,address,address) (NodeID: 587)
  │ │     │       💬 Args: [env, factory, helper]
  │ │     │       👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.getFactory(string) (NodeID: 588)
  │ │     │   💬 Args: [_env]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 589)
  │ │     │   💬 Args: [address(accountFactory), "AccountFactory"]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 590)
  │ │     │   💬 Args: [address(_defaultValidator), "DefaultValidator"]
  │ │     │   👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 591)
  │ │         💬 Args: [address(_defaultSessionValidator), "SessionValidator"]
  │ │         👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseSuperVaultTest._updateSuperVaultBasePPS(address,address) (NodeID: 592)
  │ │   💬 Args: [address(bTStrategy), address(bTVault)]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256,enum Math.Rounding) (NodeID: 593)
  │ │ │   💬 Args: [vars.currentTotalAssets, vars.precision, vars.totalSupplyAmount, Math.Rounding.Floor]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 594)
  │ │ │ │   💬 Args: [unsignedRoundsUp(rounding) && (mulmod(x, y, denominator) > 0)]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.unsignedRoundsUp(enum Math.Rounding) (NodeID: 595)
  │ │ │ │     💬 Args: [rounding]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 596)
  │ │ │     💬 Args: [x, y, denominator]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 597)
  │ │ │   │   💬 Args: [x, y]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 598)
  │ │ │       💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │ │ │       👁️  Def: internal
  │ │ │     └─ [6] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 599)
  │ │ │         💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │ │ │         👁️  Def: internal
  │ │ │       └─ [7] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 600)
  │ │ │           💬 Args: [condition]
  │ │ │           👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: BaseTest._getContract(uint64,string) (NodeID: 601)
  │ │ │   💬 Args: [BASE, ECDSAPPS_ORACLE_KEY]
  │ │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: MessageHashUtils.toTypedDataHash(bytes32,bytes32) (NodeID: 602)
  │ │ │   💬 Args: [baseOracle.domainSeparator(), structHash]
  │ │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: console.log(string,address,uint256) (NodeID: 603)
  │ │     💬 Args: ["Updated PPS for strategy", strategyAddr, vars.pps]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 604)
  │ │       💬 Args: [abi.encodeWithSignature("log(string,address,uint256)", p0, p1, p2)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 605)
  │ │         💬 Args: [_sendLogPayloadView]
  │ │         👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: SuperVaultTest._redeemFromUnderlyingOnBase(address,address) (NodeID: 606)
  │ │   💬 Args: [morphoVaultAddr, address(bTStrategy)]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: BaseTest._getHookAddress(uint64,string) (NodeID: 607)
  │ │ │   💬 Args: [BASE, REDEEM_4626_VAULT_HOOK_KEY]
  │ │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: InternalHelpers._createRedeem4626HookData(bytes32,address,address,uint256,bool) (NodeID: 608)
  │ │ │   💬 Args: [_getYieldSourceOracleId(bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), MANAGER), baseUnderlying, bridgeTestStrategy, redeemAmount, false]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: InternalHelpers._getYieldSourceOracleId(bytes32,address) (NodeID: 609)
  │ │ │     💬 Args: [bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), MANAGER]
  │ │ │     👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: BaseTest._getContract(uint64,string) (NodeID: 610)
  │ │ │   💬 Args: [BASE, SUPER_VAULT_AGGREGATOR_KEY]
  │ │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: SuperVaultTest._tryGetBaseMerkleProofs(address[],bytes[]) (NodeID: 611)
  │ │     💬 Args: [fulfillHooksAddresses, argsForProofs]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseSuperVaultTest._updateSuperVaultBasePPS(address,address) (NodeID: 612)
  │ │   💬 Args: [address(bTStrategy), address(bTVault)]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256,enum Math.Rounding) (NodeID: 613)
  │ │ │   💬 Args: [vars.currentTotalAssets, vars.precision, vars.totalSupplyAmount, Math.Rounding.Floor]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 614)
  │ │ │ │   💬 Args: [unsignedRoundsUp(rounding) && (mulmod(x, y, denominator) > 0)]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.unsignedRoundsUp(enum Math.Rounding) (NodeID: 615)
  │ │ │ │     💬 Args: [rounding]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 616)
  │ │ │     💬 Args: [x, y, denominator]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 617)
  │ │ │   │   💬 Args: [x, y]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 618)
  │ │ │       💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │ │ │       👁️  Def: internal
  │ │ │     └─ [6] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 619)
  │ │ │         💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │ │ │         👁️  Def: internal
  │ │ │       └─ [7] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 620)
  │ │ │           💬 Args: [condition]
  │ │ │           👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: BaseTest._getContract(uint64,string) (NodeID: 621)
  │ │ │   💬 Args: [BASE, ECDSAPPS_ORACLE_KEY]
  │ │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: MessageHashUtils.toTypedDataHash(bytes32,bytes32) (NodeID: 622)
  │ │ │   💬 Args: [baseOracle.domainSeparator(), structHash]
  │ │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: console.log(string,address,uint256) (NodeID: 623)
  │ │     💬 Args: ["Updated PPS for strategy", strategyAddr, vars.pps]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 624)
  │ │       💬 Args: [abi.encodeWithSignature("log(string,address,uint256)", p0, p1, p2)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 625)
  │ │         💬 Args: [_sendLogPayloadView]
  │ │         👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: SuperVaultTest._fulfillRedeemRequestsOnBase(address,address,address) (NodeID: 626)
  │     💬 Args: [accountBase.account, accountBase1.account, address(bTStrategy)]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: BaseSuperVaultTest._sortAndUniqueControllers(address[]) (NodeID: 627)
  │   │   💬 Args: [requestingUsers]
  │   │   👁️  Def: internal
  │   │ ├─ [4] ⚙️ FUNCTION: LibSort.insertionSort(address[]) (NodeID: 628)
  │   │ │   💬 Args: [controllers]
  │   │ │   👁️  Def: internal
  │   │ │ └─ [5] ⚙️ FUNCTION: LibSort.insertionSort(uint256[]) (NodeID: 629)
  │   │ │     💬 Args: [_toUints(a)]
  │   │ │     👁️  Def: internal
  │   │ │   └─ [6] ⚙️ FUNCTION: LibSort._toUints(address[]) (NodeID: 630)
  │   │ │       💬 Args: [a]
  │   │ │       👁️  Def: private
  │   │ └─ [4] ⚙️ FUNCTION: LibSort.uniquifySorted(address[]) (NodeID: 631)
  │   │     💬 Args: [controllers]
  │   │     👁️  Def: internal
  │   │   └─ [5] ⚙️ FUNCTION: LibSort.uniquifySorted(uint256[]) (NodeID: 632)
  │   │       💬 Args: [_toUints(a)]
  │   │       👁️  Def: internal
  │   │     └─ [6] ⚙️ FUNCTION: LibSort._toUints(address[]) (NodeID: 633)
  │   │         💬 Args: [a]
  │   │         👁️  Def: private
  │   └─ [3] ⚙️ FUNCTION: AssetAdjustmentHelper.calculateLiquidityOnlyFulfillment(contract ISuperVaultStrategy,address,address[]) (NodeID: 634)
  │       💬 Args: [ISuperVaultStrategy(bridgeTestStrategy), existingUnderlyingTokens[BASE][USDC_KEY], requestingUsers]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: AssetAdjustmentHelper.calculateFulfillRedeemTotalAssetsOut(address[],uint256[],uint256,uint256) (NodeID: 635)
  │         💬 Args: [controllers, theoreticalAssets, totalTheoretical, strategyBalance]
  │         👁️  Def: internal
  │       ├─ [5] ⚙️ FUNCTION: console.log(string,uint256,uint256) (NodeID: 636)
  │       │   💬 Args: ["Adjusting assets: Theoretical=%s, Available=%s", totalTheoreticalAssets, totalAvailableAssets]
  │       │   👁️  Def: internal
  │       │ └─ [6] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 637)
  │       │     💬 Args: [abi.encodeWithSignature("log(string,uint256,uint256)", p0, p1, p2)]
  │       │     👁️  Def: internal
  │       │   └─ [7] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 638)
  │       │       💬 Args: [_sendLogPayloadView]
  │       │       👁️  Def: internal
  │       ├─ [5] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256,enum Math.Rounding) (NodeID: 639)
  │       │   💬 Args: [theoreticalAssets[i], totalAvailableAssets, totalTheoreticalAssets, Math.Rounding.Floor]
  │       │   👁️  Def: internal
  │       │ ├─ [6] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 640)
  │       │ │   💬 Args: [unsignedRoundsUp(rounding) && (mulmod(x, y, denominator) > 0)]
  │       │ │   👁️  Def: internal
  │       │ │ └─ [7] ⚙️ FUNCTION: Math.unsignedRoundsUp(enum Math.Rounding) (NodeID: 641)
  │       │ │     💬 Args: [rounding]
  │       │ │     👁️  Def: internal
  │       │ └─ [6] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 642)
  │       │     💬 Args: [x, y, denominator]
  │       │     👁️  Def: internal
  │       │   ├─ [7] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 643)
  │       │   │   💬 Args: [x, y]
  │       │   │   👁️  Def: internal
  │       │   └─ [7] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 644)
  │       │       💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │       │       👁️  Def: internal
  │       │     └─ [8] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 645)
  │       │         💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │       │         👁️  Def: internal
  │       │       └─ [9] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 646)
  │       │           💬 Args: [condition]
  │       │           👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 647)
  │           💬 Args: ["Remainder kept in vault as free assets:", remainder]
  │           👁️  Def: internal
  │         └─ [6] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 648)
  │             💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │             👁️  Def: internal
  │           └─ [7] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 649)
  │               💬 Args: [_sendLogPayloadView]
  │               👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: SuperVaultTest._executeBridgeAndVerify(address,address,uint256) (NodeID: 650)
      💬 Args: [assetBase, assetETH, superBankEthBefore]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BaseTest._getContract(uint64,string) (NodeID: 651)
    │   💬 Args: [BASE, SUPER_BANK_KEY]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: SuperVaultTest._bridgeToSuperBankOnETH(address,address,uint256) (NodeID: 652)
    │   💬 Args: [assetBase, assetETH, bankBalanceBaseBefore]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: BaseTest._getHookAddress(uint64,string) (NodeID: 653)
    │ │   💬 Args: [BASE, APPROVE_ERC20_HOOK_KEY]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: BaseTest._getHookAddress(uint64,string) (NodeID: 654)
    │ │   💬 Args: [BASE, ACROSS_SEND_FUNDS_AND_EXECUTE_ON_DST_HOOK_KEY]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: InternalHelpers._createApproveHookData(address,address,uint256,bool) (NodeID: 655)
    │ │   💬 Args: [assetOnBase, spokedPoolV3, bridgeAmount, false]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: BaseTest._getContract(uint64,string) (NodeID: 656)
    │ │   💬 Args: [ETH, SUPER_BANK_KEY]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: BaseTest._createAcrossV3ReceiveFundsNoExecution(address,address,address,uint256,uint256,uint64,bool,bytes) (NodeID: 657)
    │ │   💬 Args: [superBankETH, assetOnBase, assetOnETH, bridgeAmount, bridgeAmount, ETH, false, ""]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: BaseTest._getContract(uint64,string) (NodeID: 658)
    │ │   💬 Args: [BASE, SUPER_BANK_KEY]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: BaseTest._getContract(uint64,string) (NodeID: 659)
    │ │   💬 Args: [BASE, SUPER_GOVERNOR_KEY]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: SuperVaultTest._setupSuperBankHookMerkleRoots(contract SuperGovernor,address[],bytes[]) (NodeID: 660)
    │ │   💬 Args: [govBase, fulfillHooksAddresses, fulfillHooksData]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: SuperVaultTest._createSuperBankMerkleProofs(address[]) (NodeID: 661)
    │ │   💬 Args: [fulfillHooksAddresses]
    │ │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: BaseTest._getContract(uint64,string) (NodeID: 662)
    │     💬 Args: [BASE, ACROSS_V3_HELPER_KEY]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StdAssertions.assertLt(uint256,uint256,string) (NodeID: 663)
    │   💬 Args: [bankBalanceBaseAfter, bankBalanceBaseBefore, "Funds should have been transferred from SuperBank Base"]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: console.log(string) (NodeID: 664)
    │   💬 Args: ["Bridge hook execution completed successfully"]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 665)
    │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 666)
    │       💬 Args: [_sendLogPayloadView]
    │       👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 667)
    │   💬 Args: ["SuperBank Base balance before: ", bankBalanceBaseBefore]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 668)
    │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 669)
    │       💬 Args: [_sendLogPayloadView]
    │       👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 670)
    │   💬 Args: ["SuperBank Base balance after: ", bankBalanceBaseAfter]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 671)
    │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 672)
    │       💬 Args: [_sendLogPayloadView]
    │       👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BaseTest._getContract(uint64,string) (NodeID: 673)
    │   💬 Args: [ETH, SUPER_BANK_KEY]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 674)
    │   💬 Args: ["SuperBank ETH balance before: ", superBankEthBefore]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 675)
    │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 676)
    │       💬 Args: [_sendLogPayloadView]
    │       👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 677)
    │   💬 Args: ["SuperBank ETH balance after: ", bankBalanceETHAfter]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 678)
    │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 679)
    │       💬 Args: [_sendLogPayloadView]
    │       👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 680)
        💬 Args: [bankBalanceETHAfter, bankBalanceBaseBefore, "Funds should have been transferred from SuperBank Base to SuperBank ETH"]
        👁️  Def: internal
```
