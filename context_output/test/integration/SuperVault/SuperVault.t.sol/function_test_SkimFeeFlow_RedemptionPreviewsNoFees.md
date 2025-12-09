# Function: test_SkimFeeFlow_RedemptionPreviewsNoFees()

**Contract**: [test/integration/SuperVault/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_SkimFeeFlow_RedemptionPreviewsNoFees()`
- **Visibility**: public
- **Source Range**: 469804:1452:580

## Implementation

```solidity
/// @notice Test 6.1: Redemption previews show no fees
function test_SkimFeeFlow_RedemptionPreviewsNoFees() public {
    uint256 depositAmount = 1000e6;
    address user = address(0x1234);
    vm.startPrank(MANAGER);
    aggregator.updateDeviationThreshold(address(strategy), type(uint256).max);
    vm.stopPrank();
    deal(address(asset), user, depositAmount);
    deal(address(asset), address(strategy), depositAmount * 2);
    vm.startPrank(user);
    asset.approve(address(vault), depositAmount);
    uint256 shares = vault.deposit(depositAmount, user);
    vm.stopPrank();
    _simulateProfitViaAllocation(1.2e18);
    vm.startPrank(user);
    vault.requestRedeem(shares, user, user);
    vm.stopPrank();
    vm.startPrank(MANAGER);
    strategy.skimPerformanceFee();
    vm.stopPrank();
    _updateSuperVaultPPS(address(strategy), address(vault));
}
```

## Related Implementations

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

### _simulateProfitViaAllocation(uint256)

- **Kind**: internal
- **Source**: 451230:1424:580
- **Link**: `test/integration/SuperVault/SuperVault.t.sol:SuperVaultTest:_simulateProfitViaAllocation(uint256)`

```solidity
/// @notice Helper to simulate profit by increasing PPS through allocation and yield simulation
function _simulateProfitViaAllocation(uint256 targetPPSMultiplier) internal {
    uint256 fluidBalance = fluidVault.balanceOf(address(strategy));
    uint256 aaveBalance = aaveVault.balanceOf(address(strategy));
    if (fluidBalance > 0) {
        uint256 currentFluidAssets = fluidVault.totalAssets();
        uint256 additionalAssets = ((currentFluidAssets * (targetPPSMultiplier - 1e18)) / 1e18) / 2;
        deal(address(asset), address(fluidVault), currentFluidAssets + additionalAssets);
    }
    if (aaveBalance > 0) {
        uint256 currentAaveAssets = aaveVault.totalAssets();
        uint256 additionalAssets = ((currentAaveAssets * (targetPPSMultiplier - 1e18)) / 1e18) / 2;
        deal(address(asset), address(aaveVault), currentAaveAssets + additionalAssets);
    }
    vm.warp(block.timestamp + 1 days);
    _updateSuperVaultPPS(address(strategy), address(vault));
    console2.log("Simulated profit - New PPS:", aggregator.getPPS(address(strategy)));
    console2.log("Total assets after simulation:", vault.totalAssets());
}
```

### _updateSuperVaultPPS(address,address)

- **Kind**: internal
- **Source**: 113586:2774:576
- **Link**: `test/integration/SuperVault/BaseSuperVaultTest.t.sol:BaseSuperVaultTest:_updateSuperVaultPPS(address,address)`

```solidity
///  @notice Updates the PPS (Price Per Share) using TotalAssetHelper
///  @return pps The calculated and updated price per share value
///  @dev This function uses TotalAssetHelper to get totalAssets, calculates PPS,
///       creates a signature, and updates the PPS through the ECDSAPPSOracle contract
function _updateSuperVaultPPS(address strategyAddr, address vault_) internal returns (uint256 pps) {
    UpdatePPSVars memory vars;
    vars.totalSupplyAmount = SuperVault(vault_).totalSupply();
    (vars.currentTotalAssets, ) = totalAssetHelper.totalAssets(strategyAddr);
    vars.precision = SuperVault(vault_).PRECISION();
    if (vars.totalSupplyAmount == 0) {
        vars.pps = vars.precision;
    } else {
        vars.pps = vars.currentTotalAssets.mulDiv(vars.precision, vars.totalSupplyAmount, Math.Rounding.Floor);
    }
    vars.timestamp = block.timestamp;
    bytes32 structHash = keccak256(abi.encodePacked(ecdsappsOracle.UPDATE_PPS_TYPEHASH(), strategyAddr, vars.pps, vars.timestamp, ecdsappsOracle.noncePerStrategy(strategyAddr)));
    vars.ethSignedMessageHash = MessageHashUtils.toTypedDataHash(ecdsappsOracle.domainSeparator(), structHash);
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
    ecdsappsOracle.updatePPS(IECDSAPPSOracle.UpdatePPSArgs({strategies: strategies, proofsArray: proofsArray, ppss: ppss, timestamps: timestamps}));
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

### log(string,uint256)

- **Kind**: internal
- **Source**: 7139:145:26
- **Link**: `lib/forge-std/src/console.sol:console:log(string,uint256)`

```solidity
function log(string memory p0, uint256 p1) internal pure {
    _sendLogPayload(abi.encodeWithSignature("log(string,uint256)", p0, p1));
}
```

## External Calls

- **Vm::startPrank(address)**
- **SuperVaultAggregator::updateDeviationThreshold(address,uint256)**
- **Vm::stopPrank()**
- **IERC20Metadata::approve(address,uint256)**
- **SuperVault::deposit(uint256,address)**
- **SuperVault::requestRedeem(uint256,address,address)**
- **SuperVaultStrategy::skimPerformanceFee()**

## State Variable Reads

- **stdstore** (`struct StdStorage`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]
- **UINT256_MAX** (`uint256`)
- **totalAssetHelper** (`contract TotalAssetHelper`) [test/integration/SuperVault/TotalAssetHelper.sol/contract_TotalAssetHelper.md]
- **ecdsappsOracle** (`contract IECDSAPPSOracle`) [src/interfaces/oracles/IECDSAPPSOracle.sol/interface_IECDSAPPSOracle.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_SkimFeeFlow_RedemptionPreviewsNoFees() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdCheats.deal(address,address,uint256) (NodeID: 1)
  │   💬 Args: [address(asset), user, depositAmount]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdCheats.deal(address,address,uint256,bool) (NodeID: 2)
  │     💬 Args: [token, to, give, false]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: stdStorage.target(struct StdStorage,address) (NodeID: 3)
  │   │   💬 Args: [stdstore, token]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: stdStorageSafe.target(struct StdStorage,address) (NodeID: 4)
  │   │     💬 Args: [self, _target]
  │   │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: stdStorage.sig(struct StdStorage,bytes4) (NodeID: 5)
  │   │   💬 Args: [stdstore.target(token), 0x70a08231]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: stdStorageSafe.sig(struct StdStorage,bytes4) (NodeID: 6)
  │   │     💬 Args: [self, _sig]
  │   │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: stdStorage.with_key(struct StdStorage,address) (NodeID: 7)
  │   │   💬 Args: [stdstore.target(token).sig(0x70a08231), to]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: stdStorageSafe.with_key(struct StdStorage,address) (NodeID: 8)
  │   │     💬 Args: [self, who]
  │   │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,uint256) (NodeID: 9)
  │   │   💬 Args: [stdstore.target(token).sig(0x70a08231).with_key(to), give]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,bytes32) (NodeID: 10)
  │   │     💬 Args: [self, bytes32(amt)]
  │   │     👁️  Def: internal
  │   │   ├─ [5] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 11)
  │   │   │   💬 Args: [self]
  │   │   │   👁️  Def: internal
  │   │   │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 12)
  │   │   │     💬 Args: [self._keys]
  │   │   │     👁️  Def: private
  │   │   ├─ [5] ⚙️ FUNCTION: stdStorage.find(struct StdStorage,bool) (NodeID: 13)
  │   │   │   💬 Args: [self, false]
  │   │   │   👁️  Def: internal
  │   │   │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.find(struct StdStorage,bool) (NodeID: 14)
  │   │   │     💬 Args: [self, _clear]
  │   │   │     👁️  Def: internal
  │   │   │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 15)
  │   │   │   │   💬 Args: [self]
  │   │   │   │   👁️  Def: internal
  │   │   │   │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 16)
  │   │   │   │     💬 Args: [self._keys]
  │   │   │   │     👁️  Def: private
  │   │   │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 17)
  │   │   │   │   💬 Args: [self]
  │   │   │   │   👁️  Def: internal
  │   │   │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 18)
  │   │   │   │   💬 Args: [self]
  │   │   │   │   👁️  Def: internal
  │   │   │   │ ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 19)
  │   │   │   │ │   💬 Args: [self]
  │   │   │   │ │   👁️  Def: internal
  │   │   │   │ │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 20)
  │   │   │   │ │     💬 Args: [self._keys]
  │   │   │   │ │     👁️  Def: private
  │   │   │   │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 21)
  │   │   │   │     💬 Args: [rdat, 32 * self._depth]
  │   │   │   │     👁️  Def: private
  │   │   │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.checkSlotMutatesCall(struct StdStorage,bytes32) (NodeID: 22)
  │   │   │   │   💬 Args: [self, reads[i]]
  │   │   │   │   👁️  Def: internal
  │   │   │   │ ├─ [8] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 23)
  │   │   │   │ │   💬 Args: [self]
  │   │   │   │ │   👁️  Def: internal
  │   │   │   │ │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 24)
  │   │   │   │ │ │   💬 Args: [self]
  │   │   │   │ │ │   👁️  Def: internal
  │   │   │   │ │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 25)
  │   │   │   │ │ │     💬 Args: [self._keys]
  │   │   │   │ │ │     👁️  Def: private
  │   │   │   │ │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 26)
  │   │   │   │ │     💬 Args: [rdat, 32 * self._depth]
  │   │   │   │ │     👁️  Def: private
  │   │   │   │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 27)
  │   │   │   │     💬 Args: [self]
  │   │   │   │     👁️  Def: internal
  │   │   │   │   ├─ [9] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 28)
  │   │   │   │   │   💬 Args: [self]
  │   │   │   │   │   👁️  Def: internal
  │   │   │   │   │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 29)
  │   │   │   │   │     💬 Args: [self._keys]
  │   │   │   │   │     👁️  Def: private
  │   │   │   │   └─ [9] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 30)
  │   │   │   │       💬 Args: [rdat, 32 * self._depth]
  │   │   │   │       👁️  Def: private
  │   │   │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.findOffsets(struct StdStorage,bytes32) (NodeID: 31)
  │   │   │   │   💬 Args: [self, reads[i]]
  │   │   │   │   👁️  Def: internal
  │   │   │   │ ├─ [8] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 32)
  │   │   │   │ │   💬 Args: [self, slot, true]
  │   │   │   │ │   👁️  Def: internal
  │   │   │   │ │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 33)
  │   │   │   │ │     💬 Args: [self]
  │   │   │   │ │     👁️  Def: internal
  │   │   │   │ │   ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 34)
  │   │   │   │ │   │   💬 Args: [self]
  │   │   │   │ │   │   👁️  Def: internal
  │   │   │   │ │   │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 35)
  │   │   │   │ │   │     💬 Args: [self._keys]
  │   │   │   │ │   │     👁️  Def: private
  │   │   │   │ │   └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 36)
  │   │   │   │ │       💬 Args: [rdat, 32 * self._depth]
  │   │   │   │ │       👁️  Def: private
  │   │   │   │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 37)
  │   │   │   │     💬 Args: [self, slot, false]
  │   │   │   │     👁️  Def: internal
  │   │   │   │   └─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 38)
  │   │   │   │       💬 Args: [self]
  │   │   │   │       👁️  Def: internal
  │   │   │   │     ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 39)
  │   │   │   │     │   💬 Args: [self]
  │   │   │   │     │   👁️  Def: internal
  │   │   │   │     │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 40)
  │   │   │   │     │     💬 Args: [self._keys]
  │   │   │   │     │     👁️  Def: private
  │   │   │   │     └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 41)
  │   │   │   │         💬 Args: [rdat, 32 * self._depth]
  │   │   │   │         👁️  Def: private
  │   │   │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 42)
  │   │   │   │   💬 Args: [offsetLeft, offsetRight]
  │   │   │   │   👁️  Def: internal
  │   │   │   └─ [7] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 43)
  │   │   │       💬 Args: [self]
  │   │   │       👁️  Def: internal
  │   │   ├─ [5] ⚙️ FUNCTION: stdStorageSafe.getUpdatedSlotValue(bytes32,uint256,uint256,uint256) (NodeID: 44)
  │   │   │   💬 Args: [curVal, uint256(set), data.offsetLeft, data.offsetRight]
  │   │   │   👁️  Def: internal
  │   │   │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 45)
  │   │   │     💬 Args: [offsetLeft, offsetRight]
  │   │   │     👁️  Def: internal
  │   │   ├─ [5] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 46)
  │   │   │   💬 Args: [self]
  │   │   │   👁️  Def: internal
  │   │   │ ├─ [6] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 47)
  │   │   │ │   💬 Args: [self]
  │   │   │ │   👁️  Def: internal
  │   │   │ │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 48)
  │   │   │ │     💬 Args: [self._keys]
  │   │   │ │     👁️  Def: private
  │   │   │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 49)
  │   │   │     💬 Args: [rdat, 32 * self._depth]
  │   │   │     👁️  Def: private
  │   │   └─ [5] ⚙️ FUNCTION: stdStorage.clear(struct StdStorage) (NodeID: 50)
  │   │       💬 Args: [self]
  │   │       👁️  Def: internal
  │   │     └─ [6] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 51)
  │   │         💬 Args: [self]
  │   │         👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: stdStorage.target(struct StdStorage,address) (NodeID: 52)
  │   │   💬 Args: [stdstore, token]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: stdStorageSafe.target(struct StdStorage,address) (NodeID: 53)
  │   │     💬 Args: [self, _target]
  │   │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: stdStorage.sig(struct StdStorage,bytes4) (NodeID: 54)
  │   │   💬 Args: [stdstore.target(token), 0x18160ddd]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: stdStorageSafe.sig(struct StdStorage,bytes4) (NodeID: 55)
  │   │     💬 Args: [self, _sig]
  │   │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,uint256) (NodeID: 56)
  │       💬 Args: [stdstore.target(token).sig(0x18160ddd), totSup]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,bytes32) (NodeID: 57)
  │         💬 Args: [self, bytes32(amt)]
  │         👁️  Def: internal
  │       ├─ [5] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 58)
  │       │   💬 Args: [self]
  │       │   👁️  Def: internal
  │       │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 59)
  │       │     💬 Args: [self._keys]
  │       │     👁️  Def: private
  │       ├─ [5] ⚙️ FUNCTION: stdStorage.find(struct StdStorage,bool) (NodeID: 60)
  │       │   💬 Args: [self, false]
  │       │   👁️  Def: internal
  │       │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.find(struct StdStorage,bool) (NodeID: 61)
  │       │     💬 Args: [self, _clear]
  │       │     👁️  Def: internal
  │       │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 62)
  │       │   │   💬 Args: [self]
  │       │   │   👁️  Def: internal
  │       │   │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 63)
  │       │   │     💬 Args: [self._keys]
  │       │   │     👁️  Def: private
  │       │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 64)
  │       │   │   💬 Args: [self]
  │       │   │   👁️  Def: internal
  │       │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 65)
  │       │   │   💬 Args: [self]
  │       │   │   👁️  Def: internal
  │       │   │ ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 66)
  │       │   │ │   💬 Args: [self]
  │       │   │ │   👁️  Def: internal
  │       │   │ │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 67)
  │       │   │ │     💬 Args: [self._keys]
  │       │   │ │     👁️  Def: private
  │       │   │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 68)
  │       │   │     💬 Args: [rdat, 32 * self._depth]
  │       │   │     👁️  Def: private
  │       │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.checkSlotMutatesCall(struct StdStorage,bytes32) (NodeID: 69)
  │       │   │   💬 Args: [self, reads[i]]
  │       │   │   👁️  Def: internal
  │       │   │ ├─ [8] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 70)
  │       │   │ │   💬 Args: [self]
  │       │   │ │   👁️  Def: internal
  │       │   │ │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 71)
  │       │   │ │ │   💬 Args: [self]
  │       │   │ │ │   👁️  Def: internal
  │       │   │ │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 72)
  │       │   │ │ │     💬 Args: [self._keys]
  │       │   │ │ │     👁️  Def: private
  │       │   │ │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 73)
  │       │   │ │     💬 Args: [rdat, 32 * self._depth]
  │       │   │ │     👁️  Def: private
  │       │   │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 74)
  │       │   │     💬 Args: [self]
  │       │   │     👁️  Def: internal
  │       │   │   ├─ [9] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 75)
  │       │   │   │   💬 Args: [self]
  │       │   │   │   👁️  Def: internal
  │       │   │   │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 76)
  │       │   │   │     💬 Args: [self._keys]
  │       │   │   │     👁️  Def: private
  │       │   │   └─ [9] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 77)
  │       │   │       💬 Args: [rdat, 32 * self._depth]
  │       │   │       👁️  Def: private
  │       │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.findOffsets(struct StdStorage,bytes32) (NodeID: 78)
  │       │   │   💬 Args: [self, reads[i]]
  │       │   │   👁️  Def: internal
  │       │   │ ├─ [8] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 79)
  │       │   │ │   💬 Args: [self, slot, true]
  │       │   │ │   👁️  Def: internal
  │       │   │ │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 80)
  │       │   │ │     💬 Args: [self]
  │       │   │ │     👁️  Def: internal
  │       │   │ │   ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 81)
  │       │   │ │   │   💬 Args: [self]
  │       │   │ │   │   👁️  Def: internal
  │       │   │ │   │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 82)
  │       │   │ │   │     💬 Args: [self._keys]
  │       │   │ │   │     👁️  Def: private
  │       │   │ │   └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 83)
  │       │   │ │       💬 Args: [rdat, 32 * self._depth]
  │       │   │ │       👁️  Def: private
  │       │   │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 84)
  │       │   │     💬 Args: [self, slot, false]
  │       │   │     👁️  Def: internal
  │       │   │   └─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 85)
  │       │   │       💬 Args: [self]
  │       │   │       👁️  Def: internal
  │       │   │     ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 86)
  │       │   │     │   💬 Args: [self]
  │       │   │     │   👁️  Def: internal
  │       │   │     │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 87)
  │       │   │     │     💬 Args: [self._keys]
  │       │   │     │     👁️  Def: private
  │       │   │     └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 88)
  │       │   │         💬 Args: [rdat, 32 * self._depth]
  │       │   │         👁️  Def: private
  │       │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 89)
  │       │   │   💬 Args: [offsetLeft, offsetRight]
  │       │   │   👁️  Def: internal
  │       │   └─ [7] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 90)
  │       │       💬 Args: [self]
  │       │       👁️  Def: internal
  │       ├─ [5] ⚙️ FUNCTION: stdStorageSafe.getUpdatedSlotValue(bytes32,uint256,uint256,uint256) (NodeID: 91)
  │       │   💬 Args: [curVal, uint256(set), data.offsetLeft, data.offsetRight]
  │       │   👁️  Def: internal
  │       │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 92)
  │       │     💬 Args: [offsetLeft, offsetRight]
  │       │     👁️  Def: internal
  │       ├─ [5] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 93)
  │       │   💬 Args: [self]
  │       │   👁️  Def: internal
  │       │ ├─ [6] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 94)
  │       │ │   💬 Args: [self]
  │       │ │   👁️  Def: internal
  │       │ │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 95)
  │       │ │     💬 Args: [self._keys]
  │       │ │     👁️  Def: private
  │       │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 96)
  │       │     💬 Args: [rdat, 32 * self._depth]
  │       │     👁️  Def: private
  │       └─ [5] ⚙️ FUNCTION: stdStorage.clear(struct StdStorage) (NodeID: 97)
  │           💬 Args: [self]
  │           👁️  Def: internal
  │         └─ [6] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 98)
  │             💬 Args: [self]
  │             👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdCheats.deal(address,address,uint256) (NodeID: 99)
  │   💬 Args: [address(asset), address(strategy), depositAmount * 2]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdCheats.deal(address,address,uint256,bool) (NodeID: 100)
  │     💬 Args: [token, to, give, false]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: stdStorage.target(struct StdStorage,address) (NodeID: 101)
  │   │   💬 Args: [stdstore, token]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: stdStorageSafe.target(struct StdStorage,address) (NodeID: 102)
  │   │     💬 Args: [self, _target]
  │   │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: stdStorage.sig(struct StdStorage,bytes4) (NodeID: 103)
  │   │   💬 Args: [stdstore.target(token), 0x70a08231]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: stdStorageSafe.sig(struct StdStorage,bytes4) (NodeID: 104)
  │   │     💬 Args: [self, _sig]
  │   │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: stdStorage.with_key(struct StdStorage,address) (NodeID: 105)
  │   │   💬 Args: [stdstore.target(token).sig(0x70a08231), to]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: stdStorageSafe.with_key(struct StdStorage,address) (NodeID: 106)
  │   │     💬 Args: [self, who]
  │   │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,uint256) (NodeID: 107)
  │   │   💬 Args: [stdstore.target(token).sig(0x70a08231).with_key(to), give]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,bytes32) (NodeID: 108)
  │   │     💬 Args: [self, bytes32(amt)]
  │   │     👁️  Def: internal
  │   │   ├─ [5] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 109)
  │   │   │   💬 Args: [self]
  │   │   │   👁️  Def: internal
  │   │   │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 110)
  │   │   │     💬 Args: [self._keys]
  │   │   │     👁️  Def: private
  │   │   ├─ [5] ⚙️ FUNCTION: stdStorage.find(struct StdStorage,bool) (NodeID: 111)
  │   │   │   💬 Args: [self, false]
  │   │   │   👁️  Def: internal
  │   │   │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.find(struct StdStorage,bool) (NodeID: 112)
  │   │   │     💬 Args: [self, _clear]
  │   │   │     👁️  Def: internal
  │   │   │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 113)
  │   │   │   │   💬 Args: [self]
  │   │   │   │   👁️  Def: internal
  │   │   │   │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 114)
  │   │   │   │     💬 Args: [self._keys]
  │   │   │   │     👁️  Def: private
  │   │   │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 115)
  │   │   │   │   💬 Args: [self]
  │   │   │   │   👁️  Def: internal
  │   │   │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 116)
  │   │   │   │   💬 Args: [self]
  │   │   │   │   👁️  Def: internal
  │   │   │   │ ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 117)
  │   │   │   │ │   💬 Args: [self]
  │   │   │   │ │   👁️  Def: internal
  │   │   │   │ │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 118)
  │   │   │   │ │     💬 Args: [self._keys]
  │   │   │   │ │     👁️  Def: private
  │   │   │   │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 119)
  │   │   │   │     💬 Args: [rdat, 32 * self._depth]
  │   │   │   │     👁️  Def: private
  │   │   │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.checkSlotMutatesCall(struct StdStorage,bytes32) (NodeID: 120)
  │   │   │   │   💬 Args: [self, reads[i]]
  │   │   │   │   👁️  Def: internal
  │   │   │   │ ├─ [8] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 121)
  │   │   │   │ │   💬 Args: [self]
  │   │   │   │ │   👁️  Def: internal
  │   │   │   │ │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 122)
  │   │   │   │ │ │   💬 Args: [self]
  │   │   │   │ │ │   👁️  Def: internal
  │   │   │   │ │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 123)
  │   │   │   │ │ │     💬 Args: [self._keys]
  │   │   │   │ │ │     👁️  Def: private
  │   │   │   │ │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 124)
  │   │   │   │ │     💬 Args: [rdat, 32 * self._depth]
  │   │   │   │ │     👁️  Def: private
  │   │   │   │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 125)
  │   │   │   │     💬 Args: [self]
  │   │   │   │     👁️  Def: internal
  │   │   │   │   ├─ [9] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 126)
  │   │   │   │   │   💬 Args: [self]
  │   │   │   │   │   👁️  Def: internal
  │   │   │   │   │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 127)
  │   │   │   │   │     💬 Args: [self._keys]
  │   │   │   │   │     👁️  Def: private
  │   │   │   │   └─ [9] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 128)
  │   │   │   │       💬 Args: [rdat, 32 * self._depth]
  │   │   │   │       👁️  Def: private
  │   │   │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.findOffsets(struct StdStorage,bytes32) (NodeID: 129)
  │   │   │   │   💬 Args: [self, reads[i]]
  │   │   │   │   👁️  Def: internal
  │   │   │   │ ├─ [8] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 130)
  │   │   │   │ │   💬 Args: [self, slot, true]
  │   │   │   │ │   👁️  Def: internal
  │   │   │   │ │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 131)
  │   │   │   │ │     💬 Args: [self]
  │   │   │   │ │     👁️  Def: internal
  │   │   │   │ │   ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 132)
  │   │   │   │ │   │   💬 Args: [self]
  │   │   │   │ │   │   👁️  Def: internal
  │   │   │   │ │   │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 133)
  │   │   │   │ │   │     💬 Args: [self._keys]
  │   │   │   │ │   │     👁️  Def: private
  │   │   │   │ │   └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 134)
  │   │   │   │ │       💬 Args: [rdat, 32 * self._depth]
  │   │   │   │ │       👁️  Def: private
  │   │   │   │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 135)
  │   │   │   │     💬 Args: [self, slot, false]
  │   │   │   │     👁️  Def: internal
  │   │   │   │   └─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 136)
  │   │   │   │       💬 Args: [self]
  │   │   │   │       👁️  Def: internal
  │   │   │   │     ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 137)
  │   │   │   │     │   💬 Args: [self]
  │   │   │   │     │   👁️  Def: internal
  │   │   │   │     │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 138)
  │   │   │   │     │     💬 Args: [self._keys]
  │   │   │   │     │     👁️  Def: private
  │   │   │   │     └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 139)
  │   │   │   │         💬 Args: [rdat, 32 * self._depth]
  │   │   │   │         👁️  Def: private
  │   │   │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 140)
  │   │   │   │   💬 Args: [offsetLeft, offsetRight]
  │   │   │   │   👁️  Def: internal
  │   │   │   └─ [7] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 141)
  │   │   │       💬 Args: [self]
  │   │   │       👁️  Def: internal
  │   │   ├─ [5] ⚙️ FUNCTION: stdStorageSafe.getUpdatedSlotValue(bytes32,uint256,uint256,uint256) (NodeID: 142)
  │   │   │   💬 Args: [curVal, uint256(set), data.offsetLeft, data.offsetRight]
  │   │   │   👁️  Def: internal
  │   │   │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 143)
  │   │   │     💬 Args: [offsetLeft, offsetRight]
  │   │   │     👁️  Def: internal
  │   │   ├─ [5] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 144)
  │   │   │   💬 Args: [self]
  │   │   │   👁️  Def: internal
  │   │   │ ├─ [6] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 145)
  │   │   │ │   💬 Args: [self]
  │   │   │ │   👁️  Def: internal
  │   │   │ │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 146)
  │   │   │ │     💬 Args: [self._keys]
  │   │   │ │     👁️  Def: private
  │   │   │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 147)
  │   │   │     💬 Args: [rdat, 32 * self._depth]
  │   │   │     👁️  Def: private
  │   │   └─ [5] ⚙️ FUNCTION: stdStorage.clear(struct StdStorage) (NodeID: 148)
  │   │       💬 Args: [self]
  │   │       👁️  Def: internal
  │   │     └─ [6] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 149)
  │   │         💬 Args: [self]
  │   │         👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: stdStorage.target(struct StdStorage,address) (NodeID: 150)
  │   │   💬 Args: [stdstore, token]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: stdStorageSafe.target(struct StdStorage,address) (NodeID: 151)
  │   │     💬 Args: [self, _target]
  │   │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: stdStorage.sig(struct StdStorage,bytes4) (NodeID: 152)
  │   │   💬 Args: [stdstore.target(token), 0x18160ddd]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: stdStorageSafe.sig(struct StdStorage,bytes4) (NodeID: 153)
  │   │     💬 Args: [self, _sig]
  │   │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,uint256) (NodeID: 154)
  │       💬 Args: [stdstore.target(token).sig(0x18160ddd), totSup]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,bytes32) (NodeID: 155)
  │         💬 Args: [self, bytes32(amt)]
  │         👁️  Def: internal
  │       ├─ [5] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 156)
  │       │   💬 Args: [self]
  │       │   👁️  Def: internal
  │       │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 157)
  │       │     💬 Args: [self._keys]
  │       │     👁️  Def: private
  │       ├─ [5] ⚙️ FUNCTION: stdStorage.find(struct StdStorage,bool) (NodeID: 158)
  │       │   💬 Args: [self, false]
  │       │   👁️  Def: internal
  │       │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.find(struct StdStorage,bool) (NodeID: 159)
  │       │     💬 Args: [self, _clear]
  │       │     👁️  Def: internal
  │       │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 160)
  │       │   │   💬 Args: [self]
  │       │   │   👁️  Def: internal
  │       │   │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 161)
  │       │   │     💬 Args: [self._keys]
  │       │   │     👁️  Def: private
  │       │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 162)
  │       │   │   💬 Args: [self]
  │       │   │   👁️  Def: internal
  │       │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 163)
  │       │   │   💬 Args: [self]
  │       │   │   👁️  Def: internal
  │       │   │ ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 164)
  │       │   │ │   💬 Args: [self]
  │       │   │ │   👁️  Def: internal
  │       │   │ │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 165)
  │       │   │ │     💬 Args: [self._keys]
  │       │   │ │     👁️  Def: private
  │       │   │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 166)
  │       │   │     💬 Args: [rdat, 32 * self._depth]
  │       │   │     👁️  Def: private
  │       │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.checkSlotMutatesCall(struct StdStorage,bytes32) (NodeID: 167)
  │       │   │   💬 Args: [self, reads[i]]
  │       │   │   👁️  Def: internal
  │       │   │ ├─ [8] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 168)
  │       │   │ │   💬 Args: [self]
  │       │   │ │   👁️  Def: internal
  │       │   │ │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 169)
  │       │   │ │ │   💬 Args: [self]
  │       │   │ │ │   👁️  Def: internal
  │       │   │ │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 170)
  │       │   │ │ │     💬 Args: [self._keys]
  │       │   │ │ │     👁️  Def: private
  │       │   │ │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 171)
  │       │   │ │     💬 Args: [rdat, 32 * self._depth]
  │       │   │ │     👁️  Def: private
  │       │   │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 172)
  │       │   │     💬 Args: [self]
  │       │   │     👁️  Def: internal
  │       │   │   ├─ [9] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 173)
  │       │   │   │   💬 Args: [self]
  │       │   │   │   👁️  Def: internal
  │       │   │   │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 174)
  │       │   │   │     💬 Args: [self._keys]
  │       │   │   │     👁️  Def: private
  │       │   │   └─ [9] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 175)
  │       │   │       💬 Args: [rdat, 32 * self._depth]
  │       │   │       👁️  Def: private
  │       │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.findOffsets(struct StdStorage,bytes32) (NodeID: 176)
  │       │   │   💬 Args: [self, reads[i]]
  │       │   │   👁️  Def: internal
  │       │   │ ├─ [8] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 177)
  │       │   │ │   💬 Args: [self, slot, true]
  │       │   │ │   👁️  Def: internal
  │       │   │ │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 178)
  │       │   │ │     💬 Args: [self]
  │       │   │ │     👁️  Def: internal
  │       │   │ │   ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 179)
  │       │   │ │   │   💬 Args: [self]
  │       │   │ │   │   👁️  Def: internal
  │       │   │ │   │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 180)
  │       │   │ │   │     💬 Args: [self._keys]
  │       │   │ │   │     👁️  Def: private
  │       │   │ │   └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 181)
  │       │   │ │       💬 Args: [rdat, 32 * self._depth]
  │       │   │ │       👁️  Def: private
  │       │   │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 182)
  │       │   │     💬 Args: [self, slot, false]
  │       │   │     👁️  Def: internal
  │       │   │   └─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 183)
  │       │   │       💬 Args: [self]
  │       │   │       👁️  Def: internal
  │       │   │     ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 184)
  │       │   │     │   💬 Args: [self]
  │       │   │     │   👁️  Def: internal
  │       │   │     │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 185)
  │       │   │     │     💬 Args: [self._keys]
  │       │   │     │     👁️  Def: private
  │       │   │     └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 186)
  │       │   │         💬 Args: [rdat, 32 * self._depth]
  │       │   │         👁️  Def: private
  │       │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 187)
  │       │   │   💬 Args: [offsetLeft, offsetRight]
  │       │   │   👁️  Def: internal
  │       │   └─ [7] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 188)
  │       │       💬 Args: [self]
  │       │       👁️  Def: internal
  │       ├─ [5] ⚙️ FUNCTION: stdStorageSafe.getUpdatedSlotValue(bytes32,uint256,uint256,uint256) (NodeID: 189)
  │       │   💬 Args: [curVal, uint256(set), data.offsetLeft, data.offsetRight]
  │       │   👁️  Def: internal
  │       │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 190)
  │       │     💬 Args: [offsetLeft, offsetRight]
  │       │     👁️  Def: internal
  │       ├─ [5] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 191)
  │       │   💬 Args: [self]
  │       │   👁️  Def: internal
  │       │ ├─ [6] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 192)
  │       │ │   💬 Args: [self]
  │       │ │   👁️  Def: internal
  │       │ │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 193)
  │       │ │     💬 Args: [self._keys]
  │       │ │     👁️  Def: private
  │       │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 194)
  │       │     💬 Args: [rdat, 32 * self._depth]
  │       │     👁️  Def: private
  │       └─ [5] ⚙️ FUNCTION: stdStorage.clear(struct StdStorage) (NodeID: 195)
  │           💬 Args: [self]
  │           👁️  Def: internal
  │         └─ [6] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 196)
  │             💬 Args: [self]
  │             👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: SuperVaultTest._simulateProfitViaAllocation(uint256) (NodeID: 197)
  │   💬 Args: [1.2e18]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StdCheats.deal(address,address,uint256) (NodeID: 198)
  │ │   💬 Args: [address(asset), address(fluidVault), currentFluidAssets + additionalAssets]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdCheats.deal(address,address,uint256,bool) (NodeID: 199)
  │ │     💬 Args: [token, to, give, false]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: stdStorage.target(struct StdStorage,address) (NodeID: 200)
  │ │   │   💬 Args: [stdstore, token]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: stdStorageSafe.target(struct StdStorage,address) (NodeID: 201)
  │ │   │     💬 Args: [self, _target]
  │ │   │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: stdStorage.sig(struct StdStorage,bytes4) (NodeID: 202)
  │ │   │   💬 Args: [stdstore.target(token), 0x70a08231]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: stdStorageSafe.sig(struct StdStorage,bytes4) (NodeID: 203)
  │ │   │     💬 Args: [self, _sig]
  │ │   │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: stdStorage.with_key(struct StdStorage,address) (NodeID: 204)
  │ │   │   💬 Args: [stdstore.target(token).sig(0x70a08231), to]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: stdStorageSafe.with_key(struct StdStorage,address) (NodeID: 205)
  │ │   │     💬 Args: [self, who]
  │ │   │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,uint256) (NodeID: 206)
  │ │   │   💬 Args: [stdstore.target(token).sig(0x70a08231).with_key(to), give]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,bytes32) (NodeID: 207)
  │ │   │     💬 Args: [self, bytes32(amt)]
  │ │   │     👁️  Def: internal
  │ │   │   ├─ [6] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 208)
  │ │   │   │   💬 Args: [self]
  │ │   │   │   👁️  Def: internal
  │ │   │   │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 209)
  │ │   │   │     💬 Args: [self._keys]
  │ │   │   │     👁️  Def: private
  │ │   │   ├─ [6] ⚙️ FUNCTION: stdStorage.find(struct StdStorage,bool) (NodeID: 210)
  │ │   │   │   💬 Args: [self, false]
  │ │   │   │   👁️  Def: internal
  │ │   │   │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.find(struct StdStorage,bool) (NodeID: 211)
  │ │   │   │     💬 Args: [self, _clear]
  │ │   │   │     👁️  Def: internal
  │ │   │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 212)
  │ │   │   │   │   💬 Args: [self]
  │ │   │   │   │   👁️  Def: internal
  │ │   │   │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 213)
  │ │   │   │   │     💬 Args: [self._keys]
  │ │   │   │   │     👁️  Def: private
  │ │   │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 214)
  │ │   │   │   │   💬 Args: [self]
  │ │   │   │   │   👁️  Def: internal
  │ │   │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 215)
  │ │   │   │   │   💬 Args: [self]
  │ │   │   │   │   👁️  Def: internal
  │ │   │   │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 216)
  │ │   │   │   │ │   💬 Args: [self]
  │ │   │   │   │ │   👁️  Def: internal
  │ │   │   │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 217)
  │ │   │   │   │ │     💬 Args: [self._keys]
  │ │   │   │   │ │     👁️  Def: private
  │ │   │   │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 218)
  │ │   │   │   │     💬 Args: [rdat, 32 * self._depth]
  │ │   │   │   │     👁️  Def: private
  │ │   │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.checkSlotMutatesCall(struct StdStorage,bytes32) (NodeID: 219)
  │ │   │   │   │   💬 Args: [self, reads[i]]
  │ │   │   │   │   👁️  Def: internal
  │ │   │   │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 220)
  │ │   │   │   │ │   💬 Args: [self]
  │ │   │   │   │ │   👁️  Def: internal
  │ │   │   │   │ │ ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 221)
  │ │   │   │   │ │ │   💬 Args: [self]
  │ │   │   │   │ │ │   👁️  Def: internal
  │ │   │   │   │ │ │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 222)
  │ │   │   │   │ │ │     💬 Args: [self._keys]
  │ │   │   │   │ │ │     👁️  Def: private
  │ │   │   │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 223)
  │ │   │   │   │ │     💬 Args: [rdat, 32 * self._depth]
  │ │   │   │   │ │     👁️  Def: private
  │ │   │   │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 224)
  │ │   │   │   │     💬 Args: [self]
  │ │   │   │   │     👁️  Def: internal
  │ │   │   │   │   ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 225)
  │ │   │   │   │   │   💬 Args: [self]
  │ │   │   │   │   │   👁️  Def: internal
  │ │   │   │   │   │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 226)
  │ │   │   │   │   │     💬 Args: [self._keys]
  │ │   │   │   │   │     👁️  Def: private
  │ │   │   │   │   └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 227)
  │ │   │   │   │       💬 Args: [rdat, 32 * self._depth]
  │ │   │   │   │       👁️  Def: private
  │ │   │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.findOffsets(struct StdStorage,bytes32) (NodeID: 228)
  │ │   │   │   │   💬 Args: [self, reads[i]]
  │ │   │   │   │   👁️  Def: internal
  │ │   │   │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 229)
  │ │   │   │   │ │   💬 Args: [self, slot, true]
  │ │   │   │   │ │   👁️  Def: internal
  │ │   │   │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 230)
  │ │   │   │   │ │     💬 Args: [self]
  │ │   │   │   │ │     👁️  Def: internal
  │ │   │   │   │ │   ├─ [11] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 231)
  │ │   │   │   │ │   │   💬 Args: [self]
  │ │   │   │   │ │   │   👁️  Def: internal
  │ │   │   │   │ │   │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 232)
  │ │   │   │   │ │   │     💬 Args: [self._keys]
  │ │   │   │   │ │   │     👁️  Def: private
  │ │   │   │   │ │   └─ [11] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 233)
  │ │   │   │   │ │       💬 Args: [rdat, 32 * self._depth]
  │ │   │   │   │ │       👁️  Def: private
  │ │   │   │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 234)
  │ │   │   │   │     💬 Args: [self, slot, false]
  │ │   │   │   │     👁️  Def: internal
  │ │   │   │   │   └─ [10] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 235)
  │ │   │   │   │       💬 Args: [self]
  │ │   │   │   │       👁️  Def: internal
  │ │   │   │   │     ├─ [11] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 236)
  │ │   │   │   │     │   💬 Args: [self]
  │ │   │   │   │     │   👁️  Def: internal
  │ │   │   │   │     │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 237)
  │ │   │   │   │     │     💬 Args: [self._keys]
  │ │   │   │   │     │     👁️  Def: private
  │ │   │   │   │     └─ [11] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 238)
  │ │   │   │   │         💬 Args: [rdat, 32 * self._depth]
  │ │   │   │   │         👁️  Def: private
  │ │   │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 239)
  │ │   │   │   │   💬 Args: [offsetLeft, offsetRight]
  │ │   │   │   │   👁️  Def: internal
  │ │   │   │   └─ [8] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 240)
  │ │   │   │       💬 Args: [self]
  │ │   │   │       👁️  Def: internal
  │ │   │   ├─ [6] ⚙️ FUNCTION: stdStorageSafe.getUpdatedSlotValue(bytes32,uint256,uint256,uint256) (NodeID: 241)
  │ │   │   │   💬 Args: [curVal, uint256(set), data.offsetLeft, data.offsetRight]
  │ │   │   │   👁️  Def: internal
  │ │   │   │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 242)
  │ │   │   │     💬 Args: [offsetLeft, offsetRight]
  │ │   │   │     👁️  Def: internal
  │ │   │   ├─ [6] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 243)
  │ │   │   │   💬 Args: [self]
  │ │   │   │   👁️  Def: internal
  │ │   │   │ ├─ [7] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 244)
  │ │   │   │ │   💬 Args: [self]
  │ │   │   │ │   👁️  Def: internal
  │ │   │   │ │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 245)
  │ │   │   │ │     💬 Args: [self._keys]
  │ │   │   │ │     👁️  Def: private
  │ │   │   │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 246)
  │ │   │   │     💬 Args: [rdat, 32 * self._depth]
  │ │   │   │     👁️  Def: private
  │ │   │   └─ [6] ⚙️ FUNCTION: stdStorage.clear(struct StdStorage) (NodeID: 247)
  │ │   │       💬 Args: [self]
  │ │   │       👁️  Def: internal
  │ │   │     └─ [7] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 248)
  │ │   │         💬 Args: [self]
  │ │   │         👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: stdStorage.target(struct StdStorage,address) (NodeID: 249)
  │ │   │   💬 Args: [stdstore, token]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: stdStorageSafe.target(struct StdStorage,address) (NodeID: 250)
  │ │   │     💬 Args: [self, _target]
  │ │   │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: stdStorage.sig(struct StdStorage,bytes4) (NodeID: 251)
  │ │   │   💬 Args: [stdstore.target(token), 0x18160ddd]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: stdStorageSafe.sig(struct StdStorage,bytes4) (NodeID: 252)
  │ │   │     💬 Args: [self, _sig]
  │ │   │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,uint256) (NodeID: 253)
  │ │       💬 Args: [stdstore.target(token).sig(0x18160ddd), totSup]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,bytes32) (NodeID: 254)
  │ │         💬 Args: [self, bytes32(amt)]
  │ │         👁️  Def: internal
  │ │       ├─ [6] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 255)
  │ │       │   💬 Args: [self]
  │ │       │   👁️  Def: internal
  │ │       │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 256)
  │ │       │     💬 Args: [self._keys]
  │ │       │     👁️  Def: private
  │ │       ├─ [6] ⚙️ FUNCTION: stdStorage.find(struct StdStorage,bool) (NodeID: 257)
  │ │       │   💬 Args: [self, false]
  │ │       │   👁️  Def: internal
  │ │       │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.find(struct StdStorage,bool) (NodeID: 258)
  │ │       │     💬 Args: [self, _clear]
  │ │       │     👁️  Def: internal
  │ │       │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 259)
  │ │       │   │   💬 Args: [self]
  │ │       │   │   👁️  Def: internal
  │ │       │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 260)
  │ │       │   │     💬 Args: [self._keys]
  │ │       │   │     👁️  Def: private
  │ │       │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 261)
  │ │       │   │   💬 Args: [self]
  │ │       │   │   👁️  Def: internal
  │ │       │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 262)
  │ │       │   │   💬 Args: [self]
  │ │       │   │   👁️  Def: internal
  │ │       │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 263)
  │ │       │   │ │   💬 Args: [self]
  │ │       │   │ │   👁️  Def: internal
  │ │       │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 264)
  │ │       │   │ │     💬 Args: [self._keys]
  │ │       │   │ │     👁️  Def: private
  │ │       │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 265)
  │ │       │   │     💬 Args: [rdat, 32 * self._depth]
  │ │       │   │     👁️  Def: private
  │ │       │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.checkSlotMutatesCall(struct StdStorage,bytes32) (NodeID: 266)
  │ │       │   │   💬 Args: [self, reads[i]]
  │ │       │   │   👁️  Def: internal
  │ │       │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 267)
  │ │       │   │ │   💬 Args: [self]
  │ │       │   │ │   👁️  Def: internal
  │ │       │   │ │ ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 268)
  │ │       │   │ │ │   💬 Args: [self]
  │ │       │   │ │ │   👁️  Def: internal
  │ │       │   │ │ │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 269)
  │ │       │   │ │ │     💬 Args: [self._keys]
  │ │       │   │ │ │     👁️  Def: private
  │ │       │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 270)
  │ │       │   │ │     💬 Args: [rdat, 32 * self._depth]
  │ │       │   │ │     👁️  Def: private
  │ │       │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 271)
  │ │       │   │     💬 Args: [self]
  │ │       │   │     👁️  Def: internal
  │ │       │   │   ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 272)
  │ │       │   │   │   💬 Args: [self]
  │ │       │   │   │   👁️  Def: internal
  │ │       │   │   │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 273)
  │ │       │   │   │     💬 Args: [self._keys]
  │ │       │   │   │     👁️  Def: private
  │ │       │   │   └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 274)
  │ │       │   │       💬 Args: [rdat, 32 * self._depth]
  │ │       │   │       👁️  Def: private
  │ │       │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.findOffsets(struct StdStorage,bytes32) (NodeID: 275)
  │ │       │   │   💬 Args: [self, reads[i]]
  │ │       │   │   👁️  Def: internal
  │ │       │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 276)
  │ │       │   │ │   💬 Args: [self, slot, true]
  │ │       │   │ │   👁️  Def: internal
  │ │       │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 277)
  │ │       │   │ │     💬 Args: [self]
  │ │       │   │ │     👁️  Def: internal
  │ │       │   │ │   ├─ [11] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 278)
  │ │       │   │ │   │   💬 Args: [self]
  │ │       │   │ │   │   👁️  Def: internal
  │ │       │   │ │   │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 279)
  │ │       │   │ │   │     💬 Args: [self._keys]
  │ │       │   │ │   │     👁️  Def: private
  │ │       │   │ │   └─ [11] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 280)
  │ │       │   │ │       💬 Args: [rdat, 32 * self._depth]
  │ │       │   │ │       👁️  Def: private
  │ │       │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 281)
  │ │       │   │     💬 Args: [self, slot, false]
  │ │       │   │     👁️  Def: internal
  │ │       │   │   └─ [10] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 282)
  │ │       │   │       💬 Args: [self]
  │ │       │   │       👁️  Def: internal
  │ │       │   │     ├─ [11] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 283)
  │ │       │   │     │   💬 Args: [self]
  │ │       │   │     │   👁️  Def: internal
  │ │       │   │     │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 284)
  │ │       │   │     │     💬 Args: [self._keys]
  │ │       │   │     │     👁️  Def: private
  │ │       │   │     └─ [11] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 285)
  │ │       │   │         💬 Args: [rdat, 32 * self._depth]
  │ │       │   │         👁️  Def: private
  │ │       │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 286)
  │ │       │   │   💬 Args: [offsetLeft, offsetRight]
  │ │       │   │   👁️  Def: internal
  │ │       │   └─ [8] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 287)
  │ │       │       💬 Args: [self]
  │ │       │       👁️  Def: internal
  │ │       ├─ [6] ⚙️ FUNCTION: stdStorageSafe.getUpdatedSlotValue(bytes32,uint256,uint256,uint256) (NodeID: 288)
  │ │       │   💬 Args: [curVal, uint256(set), data.offsetLeft, data.offsetRight]
  │ │       │   👁️  Def: internal
  │ │       │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 289)
  │ │       │     💬 Args: [offsetLeft, offsetRight]
  │ │       │     👁️  Def: internal
  │ │       ├─ [6] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 290)
  │ │       │   💬 Args: [self]
  │ │       │   👁️  Def: internal
  │ │       │ ├─ [7] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 291)
  │ │       │ │   💬 Args: [self]
  │ │       │ │   👁️  Def: internal
  │ │       │ │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 292)
  │ │       │ │     💬 Args: [self._keys]
  │ │       │ │     👁️  Def: private
  │ │       │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 293)
  │ │       │     💬 Args: [rdat, 32 * self._depth]
  │ │       │     👁️  Def: private
  │ │       └─ [6] ⚙️ FUNCTION: stdStorage.clear(struct StdStorage) (NodeID: 294)
  │ │           💬 Args: [self]
  │ │           👁️  Def: internal
  │ │         └─ [7] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 295)
  │ │             💬 Args: [self]
  │ │             👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StdCheats.deal(address,address,uint256) (NodeID: 296)
  │ │   💬 Args: [address(asset), address(aaveVault), currentAaveAssets + additionalAssets]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdCheats.deal(address,address,uint256,bool) (NodeID: 297)
  │ │     💬 Args: [token, to, give, false]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: stdStorage.target(struct StdStorage,address) (NodeID: 298)
  │ │   │   💬 Args: [stdstore, token]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: stdStorageSafe.target(struct StdStorage,address) (NodeID: 299)
  │ │   │     💬 Args: [self, _target]
  │ │   │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: stdStorage.sig(struct StdStorage,bytes4) (NodeID: 300)
  │ │   │   💬 Args: [stdstore.target(token), 0x70a08231]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: stdStorageSafe.sig(struct StdStorage,bytes4) (NodeID: 301)
  │ │   │     💬 Args: [self, _sig]
  │ │   │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: stdStorage.with_key(struct StdStorage,address) (NodeID: 302)
  │ │   │   💬 Args: [stdstore.target(token).sig(0x70a08231), to]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: stdStorageSafe.with_key(struct StdStorage,address) (NodeID: 303)
  │ │   │     💬 Args: [self, who]
  │ │   │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,uint256) (NodeID: 304)
  │ │   │   💬 Args: [stdstore.target(token).sig(0x70a08231).with_key(to), give]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,bytes32) (NodeID: 305)
  │ │   │     💬 Args: [self, bytes32(amt)]
  │ │   │     👁️  Def: internal
  │ │   │   ├─ [6] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 306)
  │ │   │   │   💬 Args: [self]
  │ │   │   │   👁️  Def: internal
  │ │   │   │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 307)
  │ │   │   │     💬 Args: [self._keys]
  │ │   │   │     👁️  Def: private
  │ │   │   ├─ [6] ⚙️ FUNCTION: stdStorage.find(struct StdStorage,bool) (NodeID: 308)
  │ │   │   │   💬 Args: [self, false]
  │ │   │   │   👁️  Def: internal
  │ │   │   │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.find(struct StdStorage,bool) (NodeID: 309)
  │ │   │   │     💬 Args: [self, _clear]
  │ │   │   │     👁️  Def: internal
  │ │   │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 310)
  │ │   │   │   │   💬 Args: [self]
  │ │   │   │   │   👁️  Def: internal
  │ │   │   │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 311)
  │ │   │   │   │     💬 Args: [self._keys]
  │ │   │   │   │     👁️  Def: private
  │ │   │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 312)
  │ │   │   │   │   💬 Args: [self]
  │ │   │   │   │   👁️  Def: internal
  │ │   │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 313)
  │ │   │   │   │   💬 Args: [self]
  │ │   │   │   │   👁️  Def: internal
  │ │   │   │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 314)
  │ │   │   │   │ │   💬 Args: [self]
  │ │   │   │   │ │   👁️  Def: internal
  │ │   │   │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 315)
  │ │   │   │   │ │     💬 Args: [self._keys]
  │ │   │   │   │ │     👁️  Def: private
  │ │   │   │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 316)
  │ │   │   │   │     💬 Args: [rdat, 32 * self._depth]
  │ │   │   │   │     👁️  Def: private
  │ │   │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.checkSlotMutatesCall(struct StdStorage,bytes32) (NodeID: 317)
  │ │   │   │   │   💬 Args: [self, reads[i]]
  │ │   │   │   │   👁️  Def: internal
  │ │   │   │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 318)
  │ │   │   │   │ │   💬 Args: [self]
  │ │   │   │   │ │   👁️  Def: internal
  │ │   │   │   │ │ ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 319)
  │ │   │   │   │ │ │   💬 Args: [self]
  │ │   │   │   │ │ │   👁️  Def: internal
  │ │   │   │   │ │ │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 320)
  │ │   │   │   │ │ │     💬 Args: [self._keys]
  │ │   │   │   │ │ │     👁️  Def: private
  │ │   │   │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 321)
  │ │   │   │   │ │     💬 Args: [rdat, 32 * self._depth]
  │ │   │   │   │ │     👁️  Def: private
  │ │   │   │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 322)
  │ │   │   │   │     💬 Args: [self]
  │ │   │   │   │     👁️  Def: internal
  │ │   │   │   │   ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 323)
  │ │   │   │   │   │   💬 Args: [self]
  │ │   │   │   │   │   👁️  Def: internal
  │ │   │   │   │   │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 324)
  │ │   │   │   │   │     💬 Args: [self._keys]
  │ │   │   │   │   │     👁️  Def: private
  │ │   │   │   │   └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 325)
  │ │   │   │   │       💬 Args: [rdat, 32 * self._depth]
  │ │   │   │   │       👁️  Def: private
  │ │   │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.findOffsets(struct StdStorage,bytes32) (NodeID: 326)
  │ │   │   │   │   💬 Args: [self, reads[i]]
  │ │   │   │   │   👁️  Def: internal
  │ │   │   │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 327)
  │ │   │   │   │ │   💬 Args: [self, slot, true]
  │ │   │   │   │ │   👁️  Def: internal
  │ │   │   │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 328)
  │ │   │   │   │ │     💬 Args: [self]
  │ │   │   │   │ │     👁️  Def: internal
  │ │   │   │   │ │   ├─ [11] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 329)
  │ │   │   │   │ │   │   💬 Args: [self]
  │ │   │   │   │ │   │   👁️  Def: internal
  │ │   │   │   │ │   │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 330)
  │ │   │   │   │ │   │     💬 Args: [self._keys]
  │ │   │   │   │ │   │     👁️  Def: private
  │ │   │   │   │ │   └─ [11] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 331)
  │ │   │   │   │ │       💬 Args: [rdat, 32 * self._depth]
  │ │   │   │   │ │       👁️  Def: private
  │ │   │   │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 332)
  │ │   │   │   │     💬 Args: [self, slot, false]
  │ │   │   │   │     👁️  Def: internal
  │ │   │   │   │   └─ [10] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 333)
  │ │   │   │   │       💬 Args: [self]
  │ │   │   │   │       👁️  Def: internal
  │ │   │   │   │     ├─ [11] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 334)
  │ │   │   │   │     │   💬 Args: [self]
  │ │   │   │   │     │   👁️  Def: internal
  │ │   │   │   │     │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 335)
  │ │   │   │   │     │     💬 Args: [self._keys]
  │ │   │   │   │     │     👁️  Def: private
  │ │   │   │   │     └─ [11] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 336)
  │ │   │   │   │         💬 Args: [rdat, 32 * self._depth]
  │ │   │   │   │         👁️  Def: private
  │ │   │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 337)
  │ │   │   │   │   💬 Args: [offsetLeft, offsetRight]
  │ │   │   │   │   👁️  Def: internal
  │ │   │   │   └─ [8] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 338)
  │ │   │   │       💬 Args: [self]
  │ │   │   │       👁️  Def: internal
  │ │   │   ├─ [6] ⚙️ FUNCTION: stdStorageSafe.getUpdatedSlotValue(bytes32,uint256,uint256,uint256) (NodeID: 339)
  │ │   │   │   💬 Args: [curVal, uint256(set), data.offsetLeft, data.offsetRight]
  │ │   │   │   👁️  Def: internal
  │ │   │   │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 340)
  │ │   │   │     💬 Args: [offsetLeft, offsetRight]
  │ │   │   │     👁️  Def: internal
  │ │   │   ├─ [6] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 341)
  │ │   │   │   💬 Args: [self]
  │ │   │   │   👁️  Def: internal
  │ │   │   │ ├─ [7] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 342)
  │ │   │   │ │   💬 Args: [self]
  │ │   │   │ │   👁️  Def: internal
  │ │   │   │ │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 343)
  │ │   │   │ │     💬 Args: [self._keys]
  │ │   │   │ │     👁️  Def: private
  │ │   │   │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 344)
  │ │   │   │     💬 Args: [rdat, 32 * self._depth]
  │ │   │   │     👁️  Def: private
  │ │   │   └─ [6] ⚙️ FUNCTION: stdStorage.clear(struct StdStorage) (NodeID: 345)
  │ │   │       💬 Args: [self]
  │ │   │       👁️  Def: internal
  │ │   │     └─ [7] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 346)
  │ │   │         💬 Args: [self]
  │ │   │         👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: stdStorage.target(struct StdStorage,address) (NodeID: 347)
  │ │   │   💬 Args: [stdstore, token]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: stdStorageSafe.target(struct StdStorage,address) (NodeID: 348)
  │ │   │     💬 Args: [self, _target]
  │ │   │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: stdStorage.sig(struct StdStorage,bytes4) (NodeID: 349)
  │ │   │   💬 Args: [stdstore.target(token), 0x18160ddd]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: stdStorageSafe.sig(struct StdStorage,bytes4) (NodeID: 350)
  │ │   │     💬 Args: [self, _sig]
  │ │   │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,uint256) (NodeID: 351)
  │ │       💬 Args: [stdstore.target(token).sig(0x18160ddd), totSup]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,bytes32) (NodeID: 352)
  │ │         💬 Args: [self, bytes32(amt)]
  │ │         👁️  Def: internal
  │ │       ├─ [6] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 353)
  │ │       │   💬 Args: [self]
  │ │       │   👁️  Def: internal
  │ │       │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 354)
  │ │       │     💬 Args: [self._keys]
  │ │       │     👁️  Def: private
  │ │       ├─ [6] ⚙️ FUNCTION: stdStorage.find(struct StdStorage,bool) (NodeID: 355)
  │ │       │   💬 Args: [self, false]
  │ │       │   👁️  Def: internal
  │ │       │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.find(struct StdStorage,bool) (NodeID: 356)
  │ │       │     💬 Args: [self, _clear]
  │ │       │     👁️  Def: internal
  │ │       │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 357)
  │ │       │   │   💬 Args: [self]
  │ │       │   │   👁️  Def: internal
  │ │       │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 358)
  │ │       │   │     💬 Args: [self._keys]
  │ │       │   │     👁️  Def: private
  │ │       │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 359)
  │ │       │   │   💬 Args: [self]
  │ │       │   │   👁️  Def: internal
  │ │       │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 360)
  │ │       │   │   💬 Args: [self]
  │ │       │   │   👁️  Def: internal
  │ │       │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 361)
  │ │       │   │ │   💬 Args: [self]
  │ │       │   │ │   👁️  Def: internal
  │ │       │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 362)
  │ │       │   │ │     💬 Args: [self._keys]
  │ │       │   │ │     👁️  Def: private
  │ │       │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 363)
  │ │       │   │     💬 Args: [rdat, 32 * self._depth]
  │ │       │   │     👁️  Def: private
  │ │       │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.checkSlotMutatesCall(struct StdStorage,bytes32) (NodeID: 364)
  │ │       │   │   💬 Args: [self, reads[i]]
  │ │       │   │   👁️  Def: internal
  │ │       │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 365)
  │ │       │   │ │   💬 Args: [self]
  │ │       │   │ │   👁️  Def: internal
  │ │       │   │ │ ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 366)
  │ │       │   │ │ │   💬 Args: [self]
  │ │       │   │ │ │   👁️  Def: internal
  │ │       │   │ │ │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 367)
  │ │       │   │ │ │     💬 Args: [self._keys]
  │ │       │   │ │ │     👁️  Def: private
  │ │       │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 368)
  │ │       │   │ │     💬 Args: [rdat, 32 * self._depth]
  │ │       │   │ │     👁️  Def: private
  │ │       │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 369)
  │ │       │   │     💬 Args: [self]
  │ │       │   │     👁️  Def: internal
  │ │       │   │   ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 370)
  │ │       │   │   │   💬 Args: [self]
  │ │       │   │   │   👁️  Def: internal
  │ │       │   │   │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 371)
  │ │       │   │   │     💬 Args: [self._keys]
  │ │       │   │   │     👁️  Def: private
  │ │       │   │   └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 372)
  │ │       │   │       💬 Args: [rdat, 32 * self._depth]
  │ │       │   │       👁️  Def: private
  │ │       │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.findOffsets(struct StdStorage,bytes32) (NodeID: 373)
  │ │       │   │   💬 Args: [self, reads[i]]
  │ │       │   │   👁️  Def: internal
  │ │       │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 374)
  │ │       │   │ │   💬 Args: [self, slot, true]
  │ │       │   │ │   👁️  Def: internal
  │ │       │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 375)
  │ │       │   │ │     💬 Args: [self]
  │ │       │   │ │     👁️  Def: internal
  │ │       │   │ │   ├─ [11] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 376)
  │ │       │   │ │   │   💬 Args: [self]
  │ │       │   │ │   │   👁️  Def: internal
  │ │       │   │ │   │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 377)
  │ │       │   │ │   │     💬 Args: [self._keys]
  │ │       │   │ │   │     👁️  Def: private
  │ │       │   │ │   └─ [11] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 378)
  │ │       │   │ │       💬 Args: [rdat, 32 * self._depth]
  │ │       │   │ │       👁️  Def: private
  │ │       │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 379)
  │ │       │   │     💬 Args: [self, slot, false]
  │ │       │   │     👁️  Def: internal
  │ │       │   │   └─ [10] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 380)
  │ │       │   │       💬 Args: [self]
  │ │       │   │       👁️  Def: internal
  │ │       │   │     ├─ [11] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 381)
  │ │       │   │     │   💬 Args: [self]
  │ │       │   │     │   👁️  Def: internal
  │ │       │   │     │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 382)
  │ │       │   │     │     💬 Args: [self._keys]
  │ │       │   │     │     👁️  Def: private
  │ │       │   │     └─ [11] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 383)
  │ │       │   │         💬 Args: [rdat, 32 * self._depth]
  │ │       │   │         👁️  Def: private
  │ │       │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 384)
  │ │       │   │   💬 Args: [offsetLeft, offsetRight]
  │ │       │   │   👁️  Def: internal
  │ │       │   └─ [8] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 385)
  │ │       │       💬 Args: [self]
  │ │       │       👁️  Def: internal
  │ │       ├─ [6] ⚙️ FUNCTION: stdStorageSafe.getUpdatedSlotValue(bytes32,uint256,uint256,uint256) (NodeID: 386)
  │ │       │   💬 Args: [curVal, uint256(set), data.offsetLeft, data.offsetRight]
  │ │       │   👁️  Def: internal
  │ │       │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 387)
  │ │       │     💬 Args: [offsetLeft, offsetRight]
  │ │       │     👁️  Def: internal
  │ │       ├─ [6] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 388)
  │ │       │   💬 Args: [self]
  │ │       │   👁️  Def: internal
  │ │       │ ├─ [7] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 389)
  │ │       │ │   💬 Args: [self]
  │ │       │ │   👁️  Def: internal
  │ │       │ │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 390)
  │ │       │ │     💬 Args: [self._keys]
  │ │       │ │     👁️  Def: private
  │ │       │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 391)
  │ │       │     💬 Args: [rdat, 32 * self._depth]
  │ │       │     👁️  Def: private
  │ │       └─ [6] ⚙️ FUNCTION: stdStorage.clear(struct StdStorage) (NodeID: 392)
  │ │           💬 Args: [self]
  │ │           👁️  Def: internal
  │ │         └─ [7] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 393)
  │ │             💬 Args: [self]
  │ │             👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseSuperVaultTest._updateSuperVaultPPS(address,address) (NodeID: 394)
  │ │   💬 Args: [address(strategy), address(vault)]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256,enum Math.Rounding) (NodeID: 395)
  │ │ │   💬 Args: [vars.currentTotalAssets, vars.precision, vars.totalSupplyAmount, Math.Rounding.Floor]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 396)
  │ │ │ │   💬 Args: [unsignedRoundsUp(rounding) && (mulmod(x, y, denominator) > 0)]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.unsignedRoundsUp(enum Math.Rounding) (NodeID: 397)
  │ │ │ │     💬 Args: [rounding]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 398)
  │ │ │     💬 Args: [x, y, denominator]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 399)
  │ │ │   │   💬 Args: [x, y]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 400)
  │ │ │       💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │ │ │       👁️  Def: internal
  │ │ │     └─ [6] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 401)
  │ │ │         💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │ │ │         👁️  Def: internal
  │ │ │       └─ [7] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 402)
  │ │ │           💬 Args: [condition]
  │ │ │           👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: MessageHashUtils.toTypedDataHash(bytes32,bytes32) (NodeID: 403)
  │ │ │   💬 Args: [ecdsappsOracle.domainSeparator(), structHash]
  │ │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: console.log(string,address,uint256) (NodeID: 404)
  │ │     💬 Args: ["Updated PPS for strategy", strategyAddr, vars.pps]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 405)
  │ │       💬 Args: [abi.encodeWithSignature("log(string,address,uint256)", p0, p1, p2)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 406)
  │ │         💬 Args: [_sendLogPayloadView]
  │ │         👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 407)
  │ │   💬 Args: ["Simulated profit - New PPS:", aggregator.getPPS(address(strategy))]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 408)
  │ │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 409)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 410)
  │     💬 Args: ["Total assets after simulation:", vault.totalAssets()]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 411)
  │       💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 412)
  │         💬 Args: [_sendLogPayloadView]
  │         👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: BaseSuperVaultTest._updateSuperVaultPPS(address,address) (NodeID: 413)
      💬 Args: [address(strategy), address(vault)]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256,enum Math.Rounding) (NodeID: 414)
    │   💬 Args: [vars.currentTotalAssets, vars.precision, vars.totalSupplyAmount, Math.Rounding.Floor]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 415)
    │ │   💬 Args: [unsignedRoundsUp(rounding) && (mulmod(x, y, denominator) > 0)]
    │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: Math.unsignedRoundsUp(enum Math.Rounding) (NodeID: 416)
    │ │     💬 Args: [rounding]
    │ │     👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 417)
    │     💬 Args: [x, y, denominator]
    │     👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 418)
    │   │   💬 Args: [x, y]
    │   │   👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 419)
    │       💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
    │       👁️  Def: internal
    │     └─ [5] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 420)
    │         💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
    │         👁️  Def: internal
    │       └─ [6] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 421)
    │           💬 Args: [condition]
    │           👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: MessageHashUtils.toTypedDataHash(bytes32,bytes32) (NodeID: 422)
    │   💬 Args: [ecdsappsOracle.domainSeparator(), structHash]
    │   👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: console.log(string,address,uint256) (NodeID: 423)
        💬 Args: ["Updated PPS for strategy", strategyAddr, vars.pps]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 424)
          💬 Args: [abi.encodeWithSignature("log(string,address,uint256)", p0, p1, p2)]
          👁️  Def: internal
        └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 425)
            💬 Args: [_sendLogPayloadView]
            👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Test 6.1: Redemption previews show no fees
