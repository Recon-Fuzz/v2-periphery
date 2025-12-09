# Function: test_SuperVault_5115_PositivePPS()

**Contract**: [test/integration/SuperVault/SuperVault5115Tests.t.sol/contract_SuperVault5115Tests.md]

## Metadata

- **Contract**: SuperVault5115Tests
- **Signature**: `test_SuperVault_5115_PositivePPS()`
- **Visibility**: public
- **Source Range**: 28850:2845:581

## Implementation

```solidity
function test_SuperVault_5115_PositivePPS() public {
    vm.selectFork(FORKS[ETH]);
    _setup5115Vault();
    PositiveAndNegativePpsVars memory vars;
    vars.deposit1Amount = 1000e6;
    vars.deposit2Amount = 2000e6;
    vars.deposit3Amount = 3000e6;
    deal(address(asset5115), accountEth, vars.deposit1Amount);
    _deposit(vars.deposit1Amount, address(sv5115), address(asset5115));
    _depositFreeAssetsFromSingleAmount5115(vars.deposit1Amount, address(strategy5115SuperVault), pendleEthenaAddress);
    vars.shares1 = IERC20(sv5115.share()).balanceOf(accountEth);
    assertGt(vars.shares1, 0, "no shares minted for deposit 1");
    vm.warp(block.timestamp + 4 weeks);
    vars.ppsBefore = aggregator.getPPS(address(strategy5115SuperVault));
    _updateSuperVaultPPS(address(strategy5115SuperVault), address(sv5115));
    vars.ppsAfter = aggregator.getPPS(address(strategy5115SuperVault));
    assertGt(vars.ppsAfter, vars.ppsBefore);
    deal(address(asset5115), accountEth, vars.deposit2Amount);
    _deposit(vars.deposit2Amount, address(sv5115), address(asset5115));
    _depositFreeAssetsFromSingleAmount5115(vars.deposit2Amount, address(strategy5115SuperVault), pendleEthenaAddress);
    vars.shares2 = IERC20(sv5115.share()).balanceOf(accountEth) - vars.shares1;
    assertGt(vars.shares2, 0, "no shares minted for deposit 2");
    assertGt(vars.shares2, vars.shares1, "less shares than it should - deposit 2");
    vm.warp(block.timestamp + 4 weeks);
    vars.ppsBefore = aggregator.getPPS(address(strategy5115SuperVault));
    _updateSuperVaultPPS(address(strategy5115SuperVault), address(sv5115));
    vars.ppsAfter = aggregator.getPPS(address(strategy5115SuperVault));
    assertGt(vars.ppsAfter, vars.ppsBefore);
    deal(address(asset5115), accountEth, vars.deposit3Amount);
    _deposit(vars.deposit3Amount, address(sv5115), address(asset5115));
    _depositFreeAssetsFromSingleAmount5115(vars.deposit3Amount, address(strategy5115SuperVault), pendleEthenaAddress);
    vars.shares3 = (IERC20(sv5115.share()).balanceOf(accountEth) - vars.shares1) - vars.shares2;
    assertGt(vars.shares3, 0, "no shares minted for deposit 3");
    assertGt(vars.shares3, vars.shares2, "less shares than it should - deposit 3");
    vm.warp(block.timestamp + 4 weeks);
    vars.ppsBefore = aggregator.getPPS(address(strategy5115SuperVault));
    _updateSuperVaultPPS(address(strategy5115SuperVault), address(sv5115));
    vars.ppsAfter = aggregator.getPPS(address(strategy5115SuperVault));
    assertGt(vars.ppsAfter, vars.ppsBefore);
}
```

## Related Implementations

### _setup5115Vault()

- **Kind**: internal
- **Source**: 3469:1990:581
- **Link**: `test/integration/SuperVault/SuperVault5115Tests.t.sol:SuperVault5115Tests:_setup5115Vault()`

```solidity
function _setup5115Vault() internal {
    (address svAddr, address strategySuperVaultAddr, address escrowSuperVaultAddr) = _deployVault(address(asset5115), "sv5115");
    assertEq(strategySuperVaultAddr, globalSV5115Strategy, "SV STRATEGY NOT EQUAL TO PREDICTED");
    vm.label(svAddr, "SuperVault-5115");
    vm.label(strategySuperVaultAddr, "SuperVaultStrategy-5115");
    vm.label(escrowSuperVaultAddr, "SuperVaultEscrow-5115");
    sv5115 = SuperVault(svAddr);
    escrow5115SuperVault = SuperVaultEscrow(escrowSuperVaultAddr);
    strategy5115SuperVault = SuperVaultStrategy(payable(strategySuperVaultAddr));
    vm.startPrank(MANAGER);
    strategy5115SuperVault.manageYieldSource(address(pendleEthenaAddress), _getContract(ETH, ERC5115_YIELD_SOURCE_ORACLE_KEY), ISuperVaultStrategy.YieldSourceAction.Add);
    vm.stopPrank();
    vm.startPrank(MANAGER);
    strategy5115SuperVault.proposeVaultFeeConfigUpdate(100, 0, TREASURY);
    vm.warp(block.timestamp + 1 weeks);
    strategy5115SuperVault.executeVaultFeeConfigUpdate();
    vm.stopPrank();
    vm.startPrank(MANAGER);
    strategy5115SuperVault.managePPSExpiration(ISuperVaultStrategy.PPSExpirationAction.Propose, 86_400);
    strategy.managePPSExpiration(ISuperVaultStrategy.PPSExpirationAction.Propose, 86_400);
    vm.warp(block.timestamp + 2 weeks);
    strategy5115SuperVault.managePPSExpiration(ISuperVaultStrategy.PPSExpirationAction.Execute, 0);
    strategy.managePPSExpiration(ISuperVaultStrategy.PPSExpirationAction.Execute, 0);
    vm.stopPrank();
    _updateSuperVaultPPS(address(strategy5115SuperVault), address(sv5115));
    _updateSuperVaultPPS(address(strategy), address(vault));
}
```

### _deployVault(address,string)

- **Kind**: internal
- **Source**: 13311:1259:576
- **Link**: `test/integration/SuperVault/BaseSuperVaultTest.t.sol:BaseSuperVaultTest:_deployVault(address,string)`

```solidity
///  @notice Deploys a new SuperVault with default configuration
///  @return vaultAddr The address of the deployed SuperVault
///  @return strategyAddr The address of the deployed SuperVaultStrategy
///  @return escrowAddr The address of the deployed SuperVaultEscrow
function _deployVault(address _asset, string memory _superVaultSymbol) internal returns (address vaultAddr, address strategyAddr, address escrowAddr) {
    vm.startPrank(SV_MANAGER);
    (vaultAddr, strategyAddr, escrowAddr) = aggregator.createVault(ISuperVaultAggregator.VaultCreationParams({asset: _asset, name: "SuperVault", symbol: _superVaultSymbol, mainManager: MANAGER, secondaryManagers: new address[](0), minUpdateInterval: 5, maxStaleness: 1 weeks, feeConfig: ISuperVaultStrategy.FeeConfig({performanceFeeBps: 1000, managementFeeBps: 0, recipient: address(this)})}));
    vm.label(vaultAddr, string.concat("SuperVault ", _superVaultSymbol));
    vm.label(strategyAddr, string.concat("SuperVaultStrategy ", _superVaultSymbol));
    vm.label(escrowAddr, string.concat("SuperVaultEscrow ", _superVaultSymbol));
    vm.stopPrank();
    return (vaultAddr, strategyAddr, escrowAddr);
}
```

### assertEq(address,address,string)

- **Kind**: internal
- **Source**: 4179:177:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(address,address,string)`

```solidity
function assertEq(address left, address right, string memory err) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right, err);
    }
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

### _deposit(uint256,address,address)

- **Kind**: internal
- **Source**: 33093:162:576
- **Link**: `test/integration/SuperVault/BaseSuperVaultTest.t.sol:BaseSuperVaultTest:_deposit(uint256,address,address)`

```solidity
function _deposit(uint256 depositAmount, address superVault, address asset_) internal {
    __deposit(instanceOnEth, depositAmount, superVault, asset_);
}
```

### __deposit(struct AccountInstance,uint256,address,address)

- **Kind**: internal
- **Source**: 24723:958:576
- **Link**: `test/integration/SuperVault/BaseSuperVaultTest.t.sol:BaseSuperVaultTest:__deposit(struct AccountInstance,uint256,address,address)`

```solidity
function __deposit(AccountInstance memory accInst, uint256 depositAmount, address superVault, address asset_) internal {
    address[] memory hooksAddresses = new address[](1);
    hooksAddresses[0] = _getHookAddress(ETH, APPROVE_AND_DEPOSIT_4626_VAULT_HOOK_KEY);
    bytes[] memory hooksData = new bytes[](1);
    hooksData[0] = _createApproveAndDeposit4626HookData(_getYieldSourceOracleId(bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), MANAGER), superVault, asset_, depositAmount, false, address(0), 0);
    ISuperExecutor.ExecutorEntry memory entry = ISuperExecutor.ExecutorEntry({hooksAddresses: hooksAddresses, hooksData: hooksData});
    UserOpData memory userOpData = _getExecOps(accInst, superExecutorOnEth, abi.encode(entry));
    executeOp(userOpData);
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

### _getExecOps(struct AccountInstance,contract ISuperExecutor,bytes)

- **Kind**: internal
- **Source**: 3424:376:501
- **Link**: `lib/v2-core/test/utils/InternalHelpers.sol:InternalHelpers:_getExecOps(struct AccountInstance,contract ISuperExecutor,bytes)`

```solidity
function _getExecOps(AccountInstance memory instance, ISuperExecutor superExecutor, bytes memory data) internal returns (UserOpData memory userOpData) {
    return instance.getExecOps(address(superExecutor), 0, abi.encodeCall(superExecutor.execute, (data)), address(instance.defaultValidator));
}
```

### getExecOps(struct AccountInstance,address,uint256,bytes,address)

- **Kind**: internal
- **Source**: 4143:577:232
- **Link**: `lib/v2-core/lib/modulekit/src/test/ModuleKitHelpers.sol:ModuleKitHelpers:getExecOps(struct AccountInstance,address,uint256,bytes,address)`

```solidity
/// @notice Configures a userOp to execute a single operation
///  @param instance AccountInstance struct containing the account and accountHelper
///  @param target The address of the contract to call
///  @param value The amount of ether to send
///  @param callData The data to send to the contract
///  @param txValidator The address of the transaction validator
///  @return userOpData UserOpData struct containing the userOp, userOpHash, and entrypoint
function getExecOps(AccountInstance memory instance, address target, uint256 value, bytes memory callData, address txValidator) internal returns (UserOpData memory userOpData) {
    bytes memory erc7579ExecCall = HelperBase(instance.accountHelper).encode(target, value, callData);
    (userOpData.userOp, userOpData.userOpHash) = HelperBase(instance.accountHelper).execUserOp(instance, erc7579ExecCall, txValidator);
    userOpData.entrypoint = instance.aux.entrypoint;
}
```

### executeOp(struct UserOpData)

- **Kind**: internal
- **Source**: 2902:141:501
- **Link**: `lib/v2-core/test/utils/InternalHelpers.sol:InternalHelpers:executeOp(struct UserOpData)`

```solidity
function executeOp(UserOpData memory userOpData) public returns (ExecutionReturnData memory) {
    return userOpData.execUserOps();
}
```

### execUserOps(struct UserOpData)

- **Kind**: internal
- **Source**: 3413:243:232
- **Link**: `lib/v2-core/lib/modulekit/src/test/ModuleKitHelpers.sol:ModuleKitHelpers:execUserOps(struct UserOpData)`

```solidity
/// @notice Executes userOps on the entrypoint
///  @param userOpData UserOpData struct containing the userOp, userOpHash, and entrypoint
///  @return ExecutionReturnData struct containing the logs from the execution
function execUserOps(UserOpData memory userOpData) internal returns (ExecutionReturnData memory) {
    return ERC4337Helpers.exec4337(userOpData.userOp, userOpData.entrypoint);
}
```

### exec4337(struct PackedUserOperation,contract IEntryPoint)

- **Kind**: internal
- **Source**: 5908:333:241
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/ERC4337Helpers.sol:ERC4337Helpers:exec4337(struct PackedUserOperation,contract IEntryPoint)`

```solidity
function exec4337(PackedUserOperation memory userOp, IEntryPoint onEntryPoint) internal returns (ExecutionReturnData memory logs) {
    PackedUserOperation[] memory userOps = new PackedUserOperation[](1);
    userOps[0] = userOp;
    return exec4337(userOps, onEntryPoint);
}
```

### exec4337(struct PackedUserOperation[],contract IEntryPoint)

- **Kind**: internal
- **Source**: 1486:4373:241
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/ERC4337Helpers.sol:ERC4337Helpers:exec4337(struct PackedUserOperation[],contract IEntryPoint)`

```solidity
function exec4337(PackedUserOperation[] memory userOps, IEntryPoint onEntryPoint) internal returns (ExecutionReturnData memory executionData) {
    ExecutionContext memory ctx = ExecutionContext({isExpectRevert: getExpectRevert(), beneficiary: payable(address(0x69)), userOpCalldata: "", success: false, returnData: ""});
    if (envOr("SIMULATE", false) || getSimulateUserOp()) {
        bool simulationSuccess = userOps[0].simulateUserOp(address(onEntryPoint));
        if (ctx.isExpectRevert == 0) {
            require(simulationSuccess, "UserOperation simulation failed");
        }
    }
    recordLogs();
    ctx.userOpCalldata = abi.encodeCall(IEntryPoint.handleOps, (userOps, ctx.beneficiary));
    (ctx.success, ctx.returnData) = address(onEntryPoint).call(ctx.userOpCalldata);
    if (ctx.isExpectRevert == 0) {
        require(ctx.success, "UserOperation execution failed");
    } else if ((ctx.isExpectRevert == 2) && (!ctx.success)) {
        checkRevertMessage(ctx.returnData);
    }
    VmSafe.Log[] memory logs = getRecordedLogs();
    executionData = ExecutionReturnData(logs);
    uint256 totalUserOpGas = 0;
    for (uint256 i; i < logs.length; i++) {
        if (logs[i].topics[0] == 0x49628fd1471006c1482da88028e9ce4dbb080b815c9b0344d39e5a8e6ec1419f) {
            (uint256 nonce, bool userOpSuccess, , uint256 actualGasUsed) = abi.decode(logs[i].data, (uint256, bool, uint256, uint256));
            totalUserOpGas = actualGasUsed;
            if (!userOpSuccess) {
                bytes32 userOpHash = logs[i].topics[1];
                if (ctx.isExpectRevert == 0) {
                    bytes memory revertReason = getUserOpRevertReason(logs, userOpHash);
                    address account = address(bytes20(logs[i].topics[2]));
                    revert UserOperationReverted(userOpHash, account, getLabel(account), nonce, revertReason);
                } else {
                    if (ctx.isExpectRevert == 2) {
                        checkRevertMessage(getUserOpRevertReason(logs, userOpHash));
                    }
                    clearExpectRevert();
                }
            }
        } else if (logs[i].topics[0] == 0xd21d0b289f126c4b473ea641963e766833c2f13866e4ff480abd787c100ef123) {
            (uint256 moduleType, address module) = abi.decode(logs[i].data, (uint256, address));
            writeInstalledModule(InstalledModule(moduleType, module), logs[i].emitter);
        } else if (logs[i].topics[0] == 0x341347516a9de374859dfda710fa4828b2d48cb57d4fbe4c1149612b8e02276e) {
            (uint256 moduleType, address module) = abi.decode(logs[i].data, (uint256, address));
            InstalledModule[] memory installedModules = getInstalledModules(logs[i].emitter);
            for (uint256 j; j < installedModules.length; j++) {
                if ((installedModules[j].moduleAddress == module) && (installedModules[j].moduleType == moduleType)) {
                    removeInstalledModule(j, logs[i].emitter);
                    break;
                }
            }
        }
    }
    string memory gasIdentifier = getGasIdentifier();
    if ((envOr("GAS", false) && (bytes(gasIdentifier).length > 0)) && (bytes(gasIdentifier).length < 50)) {
        calculateGas(userOps, onEntryPoint, ctx.beneficiary, gasIdentifier, totalUserOpGas);
    }
    for (uint256 i; i < userOps.length; i++) {
        emit ModuleKitLogs.ModuleKit_Exec4337(userOps[i].sender);
    }
}
```

### getExpectRevert()

- **Kind**: free-function
- **Source**: 588:163:243
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Storage.sol:getExpectRevert()`

```solidity
function getExpectRevert() view returns (uint256 value) {
    bytes32 slot = keccak256("ModuleKit.ExpectSlot");
    assembly {
        value := sload(slot)
    }
}
```

### getSimulateUserOp()

- **Kind**: free-function
- **Source**: 1949:166:243
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Storage.sol:getSimulateUserOp()`

```solidity
function getSimulateUserOp() view returns (bool value) {
    bytes32 slot = keccak256("ModuleKit.SimulateUserOp");
    assembly {
        value := sload(slot)
    }
}
```

### envOr(string,bool)

- **Kind**: internal
- **Source**: 4355:148:500
- **Link**: `lib/v2-core/test/utils/Helpers.sol:Helpers:envOr(string,bool)`

```solidity
function envOr(string memory name, bool defaultValue) public view returns (bool value) {
    return Vm(VM_ADDR).envOr(name, defaultValue);
}
```

### simulateUserOp(struct PackedUserOperation,address)

- **Kind**: internal
- **Source**: 1279:1591:139
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/Simulator.sol:Simulator:simulateUserOp(struct PackedUserOperation,address)`

```solidity
///  Simulates a UserOperation and validates the ERC-4337 rules
///  @dev This function will revert if the UserOperation is invalid
///  @dev If the simulation fails, the rules might not be checked correctly so simulationSuccess
///  should be handled accordingly
///  @dev This function is used for v0.7 ERC-4337
///  @param userOp The PackedUserOperation to simulate
///  @param onEntryPoint The address of the entry point to simulate the UserOperation on
///  @return simulationSuccess True if the simulation was successful, false otherwise
function simulateUserOp(PackedUserOperation memory userOp, address onEntryPoint) internal returns (bool simulationSuccess) {
    _preSimulation();
    bytes memory epCallData = abi.encodeCall(IEntryPointSimulations.simulateValidation, (userOp));
    bytes memory returnData;
    (simulationSuccess, returnData) = address(onEntryPoint).call(epCallData);
    if (!simulationSuccess) {
        return simulationSuccess;
    }
    IEntryPointSimulations.ValidationResult memory result = abi.decode(returnData, (IEntryPointSimulations.ValidationResult));
    if (result.returnInfo.accountValidationData != 0) {
        bool sigFailed = (result.returnInfo.accountValidationData & 1) == 1;
        if (sigFailed) {
            simulationSuccess = false;
        }
    }
    UserOperationDetails memory userOpDetails = UserOperationDetails({entryPoint: onEntryPoint, sender: userOp.sender, initCode: userOp.initCode, paymasterAndData: userOp.paymasterAndData});
    _postSimulation(userOpDetails);
}
```

### _preSimulation()

- **Kind**: internal
- **Source**: 4794:514:139
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/Simulator.sol:Simulator:_preSimulation()`

```solidity
///  Pre-simulation setup
function _preSimulation() internal {
    uint256 snapShotId = snapshotState();
    bytes32 snapShotSlot = keccak256(abi.encodePacked("Simulator.SnapshotId"));
    assembly {
        sstore(snapShotSlot, snapShotId)
    }
    startMappingRecording();
    startDebugTraceRecording();
}
```

### snapshotState()

- **Kind**: free-function
- **Source**: 394:86:142
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/lib/Vm.sol:snapshotState()`

```solidity
function snapshotState() returns (uint256) {
    return Vm(VM_ADDR).snapshotState();
}
```

### startMappingRecording()

- **Kind**: free-function
- **Source**: 579:77:142
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/lib/Vm.sol:startMappingRecording()`

```solidity
function startMappingRecording() {
    Vm(VM_ADDR).startMappingRecording();
}
```

### startDebugTraceRecording()

- **Kind**: free-function
- **Source**: 961:83:142
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/lib/Vm.sol:startDebugTraceRecording()`

```solidity
function startDebugTraceRecording() {
    Vm(VM_ADDR).startDebugTraceRecording();
}
```

### _postSimulation(struct UserOperationDetails)

- **Kind**: internal
- **Source**: 5436:688:139
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/Simulator.sol:Simulator:_postSimulation(struct UserOperationDetails)`

```solidity
///  Post-simulation validation
///  @param userOpDetails The UserOperationDetails to validate
function _postSimulation(UserOperationDetails memory userOpDetails) internal {
    VmSafe.DebugStep[] memory debugTrace = stopAndReturnDebugTraceRecording();
    ERC4337SpecsParser.parseValidation(userOpDetails, debugTrace);
    stopMappingRecording();
    uint256 snapShotId;
    bytes32 snapShotSlot = keccak256(abi.encodePacked("Simulator.SnapshotId"));
    assembly {
        snapShotId := sload(snapShotSlot)
    }
    revertToState(snapShotId);
}
```

### stopAndReturnDebugTraceRecording()

- **Kind**: free-function
- **Source**: 1046:148:142
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/lib/Vm.sol:stopAndReturnDebugTraceRecording()`

```solidity
function stopAndReturnDebugTraceRecording() returns (VmSafe.DebugStep[] memory steps) {
    return Vm(VM_ADDR).stopAndReturnDebugTraceRecording();
}
```

### parseValidation(struct UserOperationDetails,struct VmSafe.DebugStep[])

- **Kind**: internal
- **Source**: 1656:1779:140
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/SpecsParser.sol:ERC4337SpecsParser:parseValidation(struct UserOperationDetails,struct VmSafe.DebugStep[])`

```solidity
///  Parses and validates the ERC-4337 rules
///  @param userOpDetails The UserOperationDetails to validate
///  @param debugTrace A trace of used opcodes, stack and memory to validate
function parseValidation(UserOperationDetails memory userOpDetails, VmSafe.DebugStep[] memory debugTrace) internal {
    Entities memory entities = getEntities(userOpDetails);
    (VmSafe.DebugStep[] memory filteredUserOpSteps, VmSafe.DebugStep[] memory filteredPaymasterUserOpSteps) = filterDebugTrace(debugTrace, entities, userOpDetails.entryPoint);
    validateBannedOpcodes(filteredUserOpSteps, entities);
    validateBannedOpcodes(filteredPaymasterUserOpSteps, entities);
    validateOutOfGas(filteredUserOpSteps);
    validateOutOfGas(filteredPaymasterUserOpSteps);
    validateBannedStorageLocations(filteredUserOpSteps, entities, userOpDetails);
    validateBannedStorageLocations(filteredPaymasterUserOpSteps, entities, userOpDetails);
    validateCalls(filteredUserOpSteps, entities, userOpDetails.entryPoint);
    validateCalls(filteredPaymasterUserOpSteps, entities, userOpDetails.entryPoint);
    validateExtOpcodes(filteredUserOpSteps, entities);
    validateExtOpcodes(filteredPaymasterUserOpSteps, entities);
    validateCreate(filteredUserOpSteps, entities, userOpDetails);
    validateCreate(filteredPaymasterUserOpSteps, entities, userOpDetails);
}
```

### getEntities(struct UserOperationDetails)

- **Kind**: internal
- **Source**: 25300:1252:140
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/SpecsParser.sol:ERC4337SpecsParser:getEntities(struct UserOperationDetails)`

```solidity
///  Returns the entities of the UserOperation
///  @param userOpDetails The UserOperationDetails to get the entities of
///  @return entities The entities of the UserOperation
function getEntities(UserOperationDetails memory userOpDetails) internal view returns (Entities memory entities) {
    address factory;
    if (userOpDetails.initCode.length > 20) {
        bytes memory initCode = userOpDetails.initCode;
        assembly {
            factory := mload(add(initCode, 20))
        }
    }
    address paymaster;
    if (userOpDetails.paymasterAndData.length > 20) {
        bytes memory paymasterAndData = userOpDetails.paymasterAndData;
        assembly {
            paymaster := mload(add(paymasterAndData, 20))
        }
    }
    address aggregator;
    entities = Entities({account: userOpDetails.sender, factory: factory, isFactoryStaked: isStaked(factory, userOpDetails.entryPoint), paymaster: paymaster, isPaymasterStaked: isStaked(paymaster, userOpDetails.entryPoint), aggregator: aggregator, isAggregatorStaked: isStaked(aggregator, userOpDetails.entryPoint)});
}
```

### isStaked(address,address)

- **Kind**: internal
- **Source**: 28211:470:140
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/SpecsParser.sol:ERC4337SpecsParser:isStaked(address,address)`

```solidity
///  Returns whether the entity is staked
///  @param entity The entity to check
///  @return isEntityStaked Whether the entity is staked
function isStaked(address entity, address entryPoint) internal view returns (bool isEntityStaked) {
    IStakeManager.DepositInfo memory deposit = IStakeManager(entryPoint).getDepositInfo(entity);
    isEntityStaked = (deposit.stake >= MIN_STAKE_VALUE) && (deposit.unstakeDelaySec >= MIN_UNSTAKE_DELAY);
}
```

### filterDebugTrace(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,address)

- **Kind**: internal
- **Source**: 6062:2998:140
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/SpecsParser.sol:ERC4337SpecsParser:filterDebugTrace(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,address)`

```solidity
///  Filter debug trace, we are interested in the following debug traces:
///  - Entrypoint -> validateUserOp
///  - Entrypoint - validatePaymasterUserOp
///  @param debugTrace The debug trace to filter
///  @param entities The entities of the userOp
///  @param entryPoint The entryPoint address
///  @return filteredUserOpSteps The filtered debug steps
///  @return filteredPaymasterUserOpSteps The filtered debug steps
function filterDebugTrace(VmSafe.DebugStep[] memory debugTrace, Entities memory entities, address entryPoint) private pure returns (VmSafe.DebugStep[] memory, VmSafe.DebugStep[] memory) {
    VmSafe.DebugStep[] memory filteredUserOpSteps = new VmSafe.DebugStep[](debugTrace.length);
    VmSafe.DebugStep[] memory filteredPaymasterUserOpSteps = new VmSafe.DebugStep[](debugTrace.length);
    uint256 filteredUserOpStepsLength;
    uint256 filteredPaymasterUserOpStepsLength;
    uint256 startDepth = 0;
    for (uint256 i; i < debugTrace.length; i++) {
        if (debugTrace[i].contractAddr == entryPoint) {
            startDepth = debugTrace[i].depth;
            break;
        }
    }
    address currentContractAddr;
    for (uint256 i = 0; i < debugTrace.length; i++) {
        if ((debugTrace[i].depth == startDepth) && (debugTrace[i].contractAddr == entryPoint)) {
            if ((debugTrace[i].opcode == 0xF1) || (debugTrace[i].opcode == 0xFA)) {
                currentContractAddr = address(uint160(uint256(debugTrace[i].stack[1])));
            }
            continue;
        }
        if (debugTrace[i].depth > startDepth) {
            if (currentContractAddr == entities.account) {
                filteredUserOpSteps[filteredUserOpStepsLength++] = debugTrace[i];
            } else if (currentContractAddr == entities.paymaster) {
                filteredPaymasterUserOpSteps[filteredPaymasterUserOpStepsLength++] = debugTrace[i];
            }
        }
    }
    assembly {
        mstore(filteredUserOpSteps, filteredUserOpStepsLength)
        mstore(filteredPaymasterUserOpSteps, filteredPaymasterUserOpStepsLength)
    }
    return (filteredUserOpSteps, filteredPaymasterUserOpSteps);
}
```

### validateBannedOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities)

- **Kind**: internal
- **Source**: 3559:2043:140
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/SpecsParser.sol:ERC4337SpecsParser:validateBannedOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities)`

```solidity
///  Validates that no banned opcodes are used
///  @param debugTrace The debug trace to validate
function validateBannedOpcodes(VmSafe.DebugStep[] memory debugTrace, Entities memory entities) internal pure {
    for (uint256 i; i < debugTrace.length; i++) {
        if (isForbiddenOpcode(debugTrace[i].opcode)) {
            if (debugTrace[i].opcode == 0x5A) {
                if (((i + 1) >= debugTrace.length) || ((((debugTrace[i + 1].opcode != 0xF1) && (debugTrace[i + 1].opcode != 0xF4)) && (debugTrace[i + 1].opcode != 0xF2)) && (debugTrace[i + 1].opcode != 0xFA))) {
                    revert InvalidOpcode(debugTrace[i].contractAddr, 0x5A);
                }
            } else if (((debugTrace[i].opcode == 0x31) || (debugTrace[i].opcode == 0x47)) && isEntityAndStaked(entities, debugTrace[i].contractAddr)) {
                continue;
            } else {
                revert InvalidOpcode(debugTrace[i].contractAddr, debugTrace[i].opcode);
            }
        }
    }
}
```

### isForbiddenOpcode(uint8)

- **Kind**: internal
- **Source**: 29220:729:140
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/SpecsParser.sol:ERC4337SpecsParser:isForbiddenOpcode(uint8)`

```solidity
///  Checks if the opcode is a forbidden opcode
///  @param opcode The opcode to check
///  @return isForbidden Whether the opcode is forbidden
function isForbiddenOpcode(uint8 opcode) private pure returns (bool isForbidden) {
    return ((((((((((((((opcode == 0x3A) || (opcode == 0x45)) || (opcode == 0x44)) || (opcode == 0x42)) || (opcode == 0x48)) || (opcode == 0x40)) || (opcode == 0x43)) || (opcode == 0x47)) || (opcode == 0x31)) || (opcode == 0x32)) || (opcode == 0x5A)) || (opcode == 0xF0)) || (opcode == 0x41)) || (opcode == 0xFE)) || (opcode == 0xFF);
}
```

### isEntityAndStaked(struct ERC4337SpecsParser.Entities,address)

- **Kind**: internal
- **Source**: 26835:634:140
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/SpecsParser.sol:ERC4337SpecsParser:isEntityAndStaked(struct ERC4337SpecsParser.Entities,address)`

```solidity
///  Returns whether something is an entity and is staked
///  @param entities The entities of the UserOperation
///  @param toCheck The address to check
///  @return addressIsEntityAndStaked Whether the address is an entity and is staked
function isEntityAndStaked(Entities memory entities, address toCheck) internal pure returns (bool addressIsEntityAndStaked) {
    if (toCheck == entities.account) {
        addressIsEntityAndStaked = true;
    } else if (toCheck == entities.factory) {
        addressIsEntityAndStaked = entities.isFactoryStaked;
    } else if (toCheck == entities.paymaster) {
        addressIsEntityAndStaked = entities.isPaymasterStaked;
    } else if (toCheck == entities.aggregator) {
        addressIsEntityAndStaked = entities.isAggregatorStaked;
    }
}
```

### validateOutOfGas(struct VmSafe.DebugStep[])

- **Kind**: internal
- **Source**: 9203:345:140
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/SpecsParser.sol:ERC4337SpecsParser:validateOutOfGas(struct VmSafe.DebugStep[])`

```solidity
///  Validate that the simulation does not revert with Out of Gas
///  @param debugTrace The debug trace to validate
function validateOutOfGas(VmSafe.DebugStep[] memory debugTrace) internal pure {
    for (uint256 i; i < debugTrace.length; i++) {
        if (debugTrace[i].isOutOfGas) {
            revert("[OP-020] Simulation reverts with Out of Gas");
        }
    }
}
```

### validateBannedStorageLocations(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails)

- **Kind**: internal
- **Source**: 9851:4230:140
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/SpecsParser.sol:ERC4337SpecsParser:validateBannedStorageLocations(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails)`

```solidity
///  Validates that no banned storage locations are accessed
///  @param debugTrace The debug trace to validate
///  @param entities  The entities of the userOp
///  @param userOpDetails The UserOperationDetails to validate
function validateBannedStorageLocations(VmSafe.DebugStep[] memory debugTrace, Entities memory entities, UserOperationDetails memory userOpDetails) internal {
    for (uint256 i; i < debugTrace.length; i++) {
        VmSafe.DebugStep memory currentStep = debugTrace[i];
        if ((((currentStep.opcode != 0x54) && (currentStep.opcode != 0x55)) && (currentStep.opcode != 0x5C)) && (currentStep.opcode != 0x5D)) {
            continue;
        }
        address currentAccessAccount = currentStep.contractAddr;
        bytes32 currentSlot = bytes32(uint256(currentStep.stack[0]));
        bool notEntity = !isEntity(entities, currentAccessAccount);
        if (currentAccessAccount == entities.account) {
            continue;
        }
        /// Access to associated storage of the account in an external (non-entity) contract
        bool accountAlreadyExists = (entities.account.code.length != 0) || ((currentAccessAccount == userOpDetails.entryPoint) && (entities.account != address(0)));
        bool isFactoryStaked = entities.isFactoryStaked;
        if ((notEntity && isAssociatedStorage(currentSlot, currentAccessAccount, entities.account)) && (accountAlreadyExists || isFactoryStaked)) {
            continue;
        }
        if (entities.isFactoryStaked || entities.isPaymasterStaked) {
            if (((currentAccessAccount == entities.factory) && entities.isFactoryStaked) || ((currentAccessAccount == entities.paymaster) && entities.isPaymasterStaked)) {
                continue;
            } else if (notEntity && ((isAssociatedStorage(currentSlot, currentAccessAccount, entities.factory) && entities.isFactoryStaked) || (isAssociatedStorage(currentSlot, currentAccessAccount, entities.paymaster) && entities.isPaymasterStaked))) {
                continue;
            } else if (notEntity && ((currentStep.opcode == 0x54) || (currentStep.opcode == 0x5C))) {
                continue;
            }
        }
        bool isWrite = (currentStep.opcode == 0x55) || (currentStep.opcode == 0x5D);
        revert InvalidStorageLocation(currentAccessAccount, getLabel(currentAccessAccount), currentSlot, isWrite ? bytes32(uint256(currentStep.stack[1])) : bytes32(0), isWrite);
    }
}
```

### isEntity(struct ERC4337SpecsParser.Entities,address)

- **Kind**: internal
- **Source**: 27643:388:140
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/SpecsParser.sol:ERC4337SpecsParser:isEntity(struct ERC4337SpecsParser.Entities,address)`

```solidity
///  Returns wether something is an entity
///  @param entities The entities of the UserOperation
///  @param toCheck The address to check
function isEntity(Entities memory entities, address toCheck) internal pure returns (bool addressIsEntity) {
    if ((((toCheck == entities.account) || (toCheck == entities.factory)) || (toCheck == entities.paymaster)) || (toCheck == entities.aggregator)) {
        addressIsEntity = true;
    }
}
```

### isAssociatedStorage(bytes32,address,address)

- **Kind**: internal
- **Source**: 20836:774:140
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/SpecsParser.sol:ERC4337SpecsParser:isAssociatedStorage(bytes32,address,address)`

```solidity
///  Returns whether the current storage slot matches a specific entity
///  @param currentSlot The current storage slot
///  @param currentAccessAccount The contract address of the current access
///  @param entity The entity to check
///  @return isAssociated Whether the current storage slot matches a specific entity
function isAssociatedStorage(bytes32 currentSlot, address currentAccessAccount, address entity) internal returns (bool isAssociated) {
    if (slotMatchesEntity(currentSlot, entity)) {
        isAssociated = true;
    } else {
        (bool found, bytes32 key) = getMappingParent(currentAccessAccount, currentSlot);
        if (found) {
            if (slotMatchesEntity(key, entity)) {
                isAssociated = true;
            }
        }
    }
}
```

### slotMatchesEntity(bytes32,address)

- **Kind**: internal
- **Source**: 23408:355:140
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/SpecsParser.sol:ERC4337SpecsParser:slotMatchesEntity(bytes32,address)`

```solidity
///  Returns whether the current storage slot matches an entity
///  @param slot The current storage slot
///  @param entity The entity to check
///  @return _ Whether the current storage slot matches an entity
function slotMatchesEntity(bytes32 slot, address entity) internal pure returns (bool) {
    if (slot == bytes32(0)) {
        return false;
    }
    return slot == bytes32(uint256(uint160(entity)));
}
```

### getMappingParent(address,bytes32)

- **Kind**: internal
- **Source**: 24067:1014:140
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/SpecsParser.sol:ERC4337SpecsParser:getMappingParent(address,bytes32)`

```solidity
///  Returns the parent of the current storage slot
///  @param currentAccessAccount The contract address of the current access
///  @param currentSlot The current storage slot
///  @return found Whether the parent was found
///  @return key The parent slot
function getMappingParent(address currentAccessAccount, bytes32 currentSlot) internal returns (bool found, bytes32 key) {
    (bool _found, bytes32 _key, ) = getMappingKeyAndParentOf(currentAccessAccount, currentSlot);
    if (_found) {
        found = _found;
        key = _key;
    } else {
        for (uint256 k = 1; (k <= 128) && (k <= uint256(currentSlot)); k++) {
            (_found, _key, ) = getMappingKeyAndParentOf(currentAccessAccount, bytes32(uint256(currentSlot) - k));
            if (_found) {
                found = _found;
                key = _key;
                break;
            }
        }
    }
}
```

### getMappingKeyAndParentOf(address,bytes32)

- **Kind**: free-function
- **Source**: 735:163:142
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/lib/Vm.sol:getMappingKeyAndParentOf(address,bytes32)`

```solidity
function getMappingKeyAndParentOf(address target, bytes32 slot) returns (bool, bytes32, bytes32) {
    return Vm(VM_ADDR).getMappingKeyAndParentOf(target, slot);
}
```

### getLabel(address)

- **Kind**: free-function
- **Source**: 289:103:142
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/lib/Vm.sol:getLabel(address)`

```solidity
function getLabel(address addr) view returns (string memory) {
    return Vm(VM_ADDR).getLabel(addr);
}
```

### validateCalls(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,address)

- **Kind**: internal
- **Source**: 14362:2479:140
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/SpecsParser.sol:ERC4337SpecsParser:validateCalls(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,address)`

```solidity
///  Validates *CALL operations in the trace (CALL, DELEGATECALL, CALLCODE, STATICCALL)
///  @param debugSteps The filtered debug steps to validate
///  @param entities The entities of the userOp
///  @param entryPoint The EntryPoint contract address
function validateCalls(VmSafe.DebugStep[] memory debugSteps, Entities memory entities, address entryPoint) internal view {
    for (uint256 i = 0; i < debugSteps.length; i++) {
        uint8 op = debugSteps[i].opcode;
        if ((((op != 0xF1) && (op != 0xF2)) && (op != 0xF4)) && (op != 0xFA)) {
            continue;
        }
        address targetAddr = address(uint160(uint256(debugSteps[i].stack[1])));
        uint256 value = ((op == 0xF1) || (op == 0xF2)) ? uint256(debugSteps[i].stack[2]) : 0;
        bytes memory callData = debugSteps[i].memoryInput;
        if (((targetAddr.code.length == 0) && (!isPrecompile(targetAddr))) && (targetAddr != entities.account)) {
            revert("[OP-041] Cannot *CALL addresses without code");
        }
        bool callerIsAccount = debugSteps[i].contractAddr == entities.account;
        bool callerIsFactory = debugSteps[i].contractAddr == entities.factory;
        bool calleeIsEntryPoint = targetAddr == entryPoint;
        if (value > 0) {
            if (!((callerIsAccount || callerIsFactory) && calleeIsEntryPoint)) {
                revert("[OP-061] Cannot use value except from account or factory to EntryPoint");
            }
        }
        if (calleeIsEntryPoint) {
            bytes4 selector;
            if (callData.length >= 4) {
                selector = bytes4(abi.encodePacked(callData[0], callData[1], callData[2], callData[3]));
            }
            if (!(((callerIsAccount || callerIsFactory) && (selector == bytes4(0xb760faf9))) || (callerIsAccount && (callData.length == 0)))) {
                revert("[OP-052] Cannot call EntryPoint except depositTo from factory or account");
            }
        }
    }
}
```

### isPrecompile(address)

- **Kind**: internal
- **Source**: 28874:160:140
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/SpecsParser.sol:ERC4337SpecsParser:isPrecompile(address)`

```solidity
///  Returns whether the address is a precompile
///  @param target The address to check
///  @return isPrecompile Whether the address is a precompile
function isPrecompile(address target) internal pure returns (bool) {
    return (uint256(uint160(target)) <= 0x09) || (uint256(uint160(target)) == 0x100);
}
```

### validateExtOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities)

- **Kind**: internal
- **Source**: 17061:862:140
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/SpecsParser.sol:ERC4337SpecsParser:validateExtOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities)`

```solidity
///  Validates EXT* operations in the trace (EXTCODESIZE, EXTCODEHASH, EXTCODECOPY)
///  @param debugSteps The filtered debug steps to validate
///  @param entities The entities of the userOp
function validateExtOpcodes(VmSafe.DebugStep[] memory debugSteps, Entities memory entities) internal view {
    for (uint256 i = 0; i < debugSteps.length; i++) {
        uint8 op = debugSteps[i].opcode;
        if (((op != 0x3B) && (op != 0x3C)) && (op != 0x3F)) {
            continue;
        }
        address targetAddr = address(uint160(uint256(debugSteps[i].stack[0])));
        if (((targetAddr.code.length == 0) && (!isPrecompile(targetAddr))) && (targetAddr != entities.account)) {
            revert("[OP-041] EXT* opcodes cannot access addresses without code");
        }
    }
}
```

### validateCreate(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails)

- **Kind**: internal
- **Source**: 18178:1122:140
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/SpecsParser.sol:ERC4337SpecsParser:validateCreate(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails)`

```solidity
///  Validates CREATE operations in the trace
///  @param debugSteps The filtered debug steps to validate
///  @param entities The entities of the userOp
///  @param userOpDetails The UserOperationDetails containing initCode
function validateCreate(VmSafe.DebugStep[] memory debugSteps, Entities memory entities, UserOperationDetails memory userOpDetails) internal pure {
    uint256 createCount = 0;
    for (uint256 i = 0; i < debugSteps.length; i++) {
        if (debugSteps[i].opcode == 0xF5) {
            createCount++;
            if (userOpDetails.initCode.length == 0) {
                revert("[OP-031] CREATE2 not allowed without initCode");
            }
            if (createCount > 1) {
                revert("[OP-031] Multiple CREATE2 operations not allowed");
            }
            address createdAddr = address(uint160(uint256(debugSteps[i].stack[0])));
            if (createdAddr != entities.account) {
                revert("[OP-031] CREATE2 must deploy the account contract");
            }
        }
    }
}
```

### stopMappingRecording()

- **Kind**: free-function
- **Source**: 658:75:142
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/lib/Vm.sol:stopMappingRecording()`

```solidity
function stopMappingRecording() {
    Vm(VM_ADDR).stopMappingRecording();
}
```

### revertToState(uint256)

- **Kind**: free-function
- **Source**: 482:95:142
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/lib/Vm.sol:revertToState(uint256)`

```solidity
function revertToState(uint256 id) returns (bool) {
    return Vm(VM_ADDR).revertToState(id);
}
```

### recordLogs()

- **Kind**: free-function
- **Source**: 1458:55:244
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Vm.sol:recordLogs()`

```solidity
function recordLogs() {
    Vm(VM_ADDR).recordLogs();
}
```

### checkRevertMessage(bytes)

- **Kind**: internal
- **Source**: 6800:719:241
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/ERC4337Helpers.sol:ERC4337Helpers:checkRevertMessage(bytes)`

```solidity
function checkRevertMessage(bytes memory actualReason) internal view {
    bytes memory revertMessage = getExpectRevertMessage();
    if (actualReason.length >= 4) {
        bytes4 actual = bytes4(actualReason);
        bytes4 expected = bytes4(revertMessage);
        if (actual == bytes4(0x65c8fd4d)) {
            return parseFailedOpWithRevert(actualReason, revertMessage);
        } else if (actual != expected) {
            revert InvalidRevertMessageBytes(revertMessage, actualReason);
        }
        return;
    }
    if (revertMessage.length != actualReason.length) {
        revert InvalidRevertMessageBytes(revertMessage, actualReason);
    }
}
```

### getExpectRevertMessage()

- **Kind**: free-function
- **Source**: 753:180:243
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Storage.sol:getExpectRevertMessage()`

```solidity
function getExpectRevertMessage() view returns (bytes memory data) {
    bytes32 slot = keccak256("ModuleKit.ExpectMessageSlot");
    assembly {
        data := sload(slot)
    }
}
```

### parseFailedOpWithRevert(bytes,bytes)

- **Kind**: internal
- **Source**: 7525:1258:241
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/ERC4337Helpers.sol:ERC4337Helpers:parseFailedOpWithRevert(bytes,bytes)`

```solidity
function parseFailedOpWithRevert(bytes memory actualReason, bytes memory revertMessage) internal pure {
    uint256 bytesOffset;
    assembly {
        let ptr := add(actualReason, 0x20)
        ptr := add(ptr, 0x04)
        ptr := add(ptr, 0x40)
        bytesOffset := mload(ptr)
    }
    bytes memory actual;
    assembly {
        let ptr := add(actualReason, 0x20)
        ptr := add(ptr, 0x04)
        ptr := add(ptr, bytesOffset)
        let innerLength := mload(ptr)
        actual := mload(0x40)
        mstore(actual, innerLength)
        let srcPtr := add(ptr, 0x20)
        let destPtr := add(actual, 0x20)
        mstore(destPtr, mload(srcPtr))
        mstore(0x40, add(add(actual, 0x20), innerLength))
    }
    if (revertMessage.length == 4) {
        bytes4 expected = bytes4(revertMessage);
        if (expected != bytes4(actual)) {
            revert InvalidRevertMessage(expected, bytes4(actual));
        }
    } else {
        if (keccak256(actual) != keccak256(revertMessage)) {
            revert InvalidRevertMessageBytes(revertMessage, actual);
        }
    }
}
```

### getRecordedLogs()

- **Kind**: free-function
- **Source**: 1515:102:244
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Vm.sol:getRecordedLogs()`

```solidity
function getRecordedLogs() returns (VmSafe.Log[] memory) {
    return Vm(VM_ADDR).getRecordedLogs();
}
```

### getUserOpRevertReason(struct VmSafe.Log[],bytes32)

- **Kind**: internal
- **Source**: 6247:547:241
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/ERC4337Helpers.sol:ERC4337Helpers:getUserOpRevertReason(struct VmSafe.Log[],bytes32)`

```solidity
function getUserOpRevertReason(VmSafe.Log[] memory logs, bytes32 userOpHash) internal pure returns (bytes memory revertReason) {
    for (uint256 i; i < logs.length; i++) {
        if ((logs[i].topics[0] == 0x1c4fada7374c0a9ee8841fc38afe82932dc0f8e69012e927f061a8bae611a201) && (logs[i].topics[1] == userOpHash)) {
            (, revertReason) = abi.decode(logs[i].data, (uint256, bytes));
        }
    }
}
```

### getLabel(address)

- **Kind**: free-function
- **Source**: 1066:103:244
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Vm.sol:getLabel(address)`

```solidity
function getLabel(address addr) view returns (string memory) {
    return Vm(VM_ADDR).getLabel(addr);
}
```

### clearExpectRevert()

- **Kind**: free-function
- **Source**: 935:230:243
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Storage.sol:clearExpectRevert()`

```solidity
function clearExpectRevert() {
    bytes32 slot = keccak256("ModuleKit.ExpectSlot");
    assembly {
        sstore(slot, 0)
    }
    slot = keccak256("ModuleKit.ExpectMessageSlot");
    assembly {
        sstore(slot, 0)
    }
}
```

### writeInstalledModule(struct InstalledModule,address)

- **Kind**: free-function
- **Source**: 6700:1960:243
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Storage.sol:writeInstalledModule(struct InstalledModule,address)`

```solidity
// Failed to render writeInstalledModule(struct InstalledModule,address) implementation (FunctionDefinition#96186). Check logs for details.
```

### getInstalledModules(address)

- **Kind**: free-function
- **Source**: 10596:2115:243
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Storage.sol:getInstalledModules(address)`

```solidity
function getInstalledModules(address account) view returns (InstalledModule[] memory modules) {
    bytes32 lengthSlot = keccak256(abi.encode("ModuleKit.InstalledModuleSlot.", keccak256(abi.encodePacked(account))));
    bytes32 headSlot = keccak256(abi.encode("ModuleKit.InstalledModuleHead.", keccak256(abi.encodePacked(account))));
    assembly {
        let length := sload(lengthSlot)
        let structSize := 0x40
        let size := mul(length, structSize)
        let totalSize := add(add(size, 0x40), mul(0x20, length))
        let freeMemoryPtr := mload(0x40)
        modules := freeMemoryPtr
        mstore(modules, length)
        mstore(0x40, add(freeMemoryPtr, totalSize))
        let storageLocation := sload(headSlot)
        for {
            let i := 0
        } lt(i, length) {
            i := add(i, 1)
        } {
            let structLocation := add(add(freeMemoryPtr, add(0x40, mul(i, structSize))), mul(0x20, length))
            let moduleType := sload(storageLocation)
            let moduleAddress := sload(add(storageLocation, 0x20))
            mstore(add(freeMemoryPtr, add(0x20, mul(i, 0x20))), structLocation)
            mstore(structLocation, moduleType)
            mstore(add(structLocation, 0x20), moduleAddress)
            storageLocation := sload(add(storageLocation, 0x60))
        }
    }
}
```

### removeInstalledModule(uint256,address)

- **Kind**: free-function
- **Source**: 8701:1838:243
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Storage.sol:removeInstalledModule(uint256,address)`

```solidity
function removeInstalledModule(uint256 index, address account) {
    bytes32 lengthSlot = keccak256(abi.encode("ModuleKit.InstalledModuleSlot.", keccak256(abi.encodePacked(account))));
    bytes32 headSlot = keccak256(abi.encode("ModuleKit.InstalledModuleHead.", keccak256(abi.encodePacked(account))));
    bytes32 tailSlot = keccak256(abi.encode("ModuleKit.InstalledModuleTail.", keccak256(abi.encodePacked(account))));
    assembly {
        let length := sload(lengthSlot)
        let elementSlot := sload(headSlot)
        if lt(index, length) {
            for {
                let i := 0
            } lt(i, index) {
                i := add(i, 1)
            } {
                elementSlot := sload(add(elementSlot, 0x60))
            }
            let prevSlot := sload(add(elementSlot, 0x40))
            let nextSlot := sload(add(elementSlot, 0x60))
            sstore(add(prevSlot, 0x60), nextSlot)
            sstore(add(nextSlot, 0x40), prevSlot)
            if eq(elementSlot, sload(headSlot)) {
                sstore(headSlot, nextSlot)
            }
            if eq(elementSlot, sload(tailSlot)) {
                sstore(tailSlot, prevSlot)
            }
            sstore(elementSlot, 0)
            sstore(add(elementSlot, 0x20), 0)
            sstore(add(elementSlot, 0x40), 0)
            sstore(add(elementSlot, 0x60), 0)
            sstore(lengthSlot, sub(length, 1))
        }
    }
}
```

### getGasIdentifier()

- **Kind**: free-function
- **Source**: 1476:151:243
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Storage.sol:getGasIdentifier()`

```solidity
function getGasIdentifier() view returns (string memory id) {
    bytes32 slot = keccak256("ModuleKit.GasIdentifierSlot");
    id = readString(slot);
}
```

### readString(bytes32)

- **Kind**: free-function
- **Source**: 13545:742:243
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Storage.sol:readString(bytes32)`

```solidity
function readString(bytes32 slot) view returns (string memory) {
    uint256 length;
    assembly {
        length := sload(slot)
    }
    bytes memory strBytes = new bytes(length);
    for (uint256 i = 0; i < length; i += 32) {
        bytes32 charSlot = keccak256(abi.encodePacked(slot, i / 32));
        bytes32 data;
        assembly {
            data := sload(charSlot)
        }
        for (uint256 j = 0; (j < 32) && ((i + j) < length); j++) {
            strBytes[i + j] = bytes1(uint8(uint256(data >> (248 - (j * 8)))));
        }
    }
    return string(strBytes);
}
```

### calculateGas(struct PackedUserOperation[],contract IEntryPoint,address,string,uint256)

- **Kind**: internal
- **Source**: 8789:510:241
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/ERC4337Helpers.sol:ERC4337Helpers:calculateGas(struct PackedUserOperation[],contract IEntryPoint,address,string,uint256)`

```solidity
function calculateGas(PackedUserOperation[] memory userOps, IEntryPoint onEntryPoint, address beneficiary, string memory gasIdentifier, uint256 totalUserOpGas) internal {
    bytes memory userOpCalldata = abi.encodeWithSelector(onEntryPoint.handleOps.selector, userOps, beneficiary);
    GasParser.parseAndWriteGas(userOpCalldata, address(onEntryPoint), gasIdentifier, userOps[0].sender, totalUserOpGas);
}
```

### parseAndWriteGas(bytes,address,string,address,uint256)

- **Kind**: internal
- **Source**: 243:1164:246
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/gas/GasParser.sol:GasParser:parseAndWriteGas(bytes,address,string,address,uint256)`

```solidity
function parseAndWriteGas(bytes memory userOpCalldata, address entrypoint, string memory gasIdentifier, address sender, uint256 totalUserOpGas) internal {
    string memory fileName = string.concat("./gas_calculations/", gasIdentifier, ".json");
    GasCalculations memory gasCalculations = GasCalculations({creation: GasDebug(entrypoint).getGasConsumed(sender, 0), validation: GasDebug(entrypoint).getGasConsumed(sender, 1), execution: GasDebug(entrypoint).getGasConsumed(sender, 2), total: totalUserOpGas, arbitrum: getArbitrumL1Gas(userOpCalldata), opStack: getOpStackL1Gas(userOpCalldata)});
    GasCalculations memory prevGasCalculations;
    if (exists(fileName)) {
        string memory fileContent = readFile(fileName);
        prevGasCalculations = parsePrevGasReport(fileContent);
    }
    string memory finalJson = formatGasToWrite(gasIdentifier, prevGasCalculations, gasCalculations);
    writeJson(finalJson, fileName);
    writeGasIdentifier("");
}
```

### getArbitrumL1Gas(bytes)

- **Kind**: free-function
- **Source**: 1197:185:245
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/gas/GasCalculations.sol:getArbitrumL1Gas(bytes)`

```solidity
/// @notice Calculate the gas cost of calldata on Arbitrum L1.
///  @param data The calldata to be sent.
///  @return calldataGas The gas cost of the calldata on Arbitrum L1.
function getArbitrumL1Gas(bytes memory data) pure returns (uint256 calldataGas) {
    bytes memory compressed = LibZip.flzCompress(data);
    calldataGas = getCallDataGas(compressed);
}
```

### flzCompress(bytes)

- **Kind**: internal
- **Source**: 1102:3958:322
- **Link**: `lib/v2-core/lib/solady/src/utils/LibZip.sol:LibZip:flzCompress(bytes)`

```solidity
/// @dev Returns the compressed `data`.
function flzCompress(bytes memory data) internal pure returns (bytes memory result) {
    /// @solidity memory-safe-assembly
    assembly {
        function ms8 (d_, v_) -> _d {
            mstore8(d_, v_)
            _d := add(d_, 1)
        }
        function u24 (p_) -> _u {
            _u := mload(p_)
            _u := or(shl(16, byte(2, _u)), or(shl(8, byte(1, _u)), byte(0, _u)))
        }
        function cmp (p_, q_, e_) -> _l {
            for {
                e_ := sub(e_, q_)
            } lt(_l, e_) {
                _l := add(_l, 1)
            } {
                e_ := mul(iszero(byte(0, xor(mload(add(p_, _l)), mload(add(q_, _l))))), e_)
            }
        }
        function literals (runs_, src_, dest_) -> _o {
            for {
                _o := dest_
            } iszero(lt(runs_, 0x20)) {
                runs_ := sub(runs_, 0x20)
            } {
                mstore(ms8(_o, 31), mload(src_))
                _o := add(_o, 0x21)
                src_ := add(src_, 0x20)
            }
            if iszero(runs_) {
                leave
            }
            mstore(ms8(_o, sub(runs_, 1)), mload(src_))
            _o := add(1, add(_o, runs_))
        }
        function mt (l_, d_, o_) -> _o {
            for {
                d_ := sub(d_, 1)
            } iszero(lt(l_, 263)) {
                l_ := sub(l_, 262)
            } {
                o_ := ms8(ms8(ms8(o_, add(224, shr(8, d_))), 253), and(0xff, d_))
            }
            if iszero(lt(l_, 7)) {
                _o := ms8(ms8(ms8(o_, add(224, shr(8, d_))), sub(l_, 7)), and(0xff, d_))
                leave
            }
            _o := ms8(ms8(o_, add(shl(5, l_), shr(8, d_))), and(0xff, d_))
        }
        function setHash (i_, v_) {
            let p_ := add(mload(0x40), shl(2, i_))
            mstore(p_, xor(mload(p_), shl(224, xor(shr(224, mload(p_)), v_))))
        }
        function getHash (i_) -> _h {
            _h := shr(224, mload(add(mload(0x40), shl(2, i_))))
        }
        function hash (v_) -> _r {
            _r := and(shr(19, mul(2654435769, v_)), 0x1fff)
        }
        function setNextHash (ip_, ipStart_) -> _ip {
            setHash(hash(u24(ip_)), sub(ip_, ipStart_))
            _ip := add(ip_, 1)
        }
        result := mload(0x40)
        calldatacopy(result, calldatasize(), 0x8000)
        let op := add(result, 0x8000)
        let a := add(data, 0x20)
        let ipStart := a
        let ipLimit := sub(add(ipStart, mload(data)), 13)
        for {
            let ip := add(2, a)
        } lt(ip, ipLimit) {} {
            let r := 0
            let d := 0
            for {} 1 {} {
                let s := u24(ip)
                let h := hash(s)
                r := add(ipStart, getHash(h))
                setHash(h, sub(ip, ipStart))
                d := sub(ip, r)
                if iszero(lt(ip, ipLimit)) {
                    break
                }
                ip := add(ip, 1)
                if iszero(gt(d, 0x1fff)) {
                    if eq(s, u24(r)) {
                        break
                    }
                }
            }
            if iszero(lt(ip, ipLimit)) {
                break
            }
            ip := sub(ip, 1)
            if gt(ip, a) {
                op := literals(sub(ip, a), a, op)
            }
            let l := cmp(add(r, 3), add(ip, 3), add(ipLimit, 9))
            op := mt(l, d, op)
            ip := setNextHash(setNextHash(add(ip, l), ipStart), ipStart)
            a := ip
        }
        let end := sub(literals(sub(add(ipStart, mload(data)), a), a, op), 0x7fe0)
        let o := add(result, 0x20)
        mstore(result, sub(end, o))
        for {} iszero(gt(o, end)) {
            o := add(o, 0x20)
        } {
            mstore(o, mload(add(o, 0x7fe0)))
        }
        mstore(end, 0)
        mstore(0x40, add(end, 0x20))
    }
}
```

### getCallDataGas(bytes)

- **Kind**: free-function
- **Source**: 768:254:245
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/gas/GasCalculations.sol:getCallDataGas(bytes)`

```solidity
/// @notice Calculate the gas cost of calldata.
///  @param data The calldata to be sent.
///  @return calldataGas The gas cost of the calldata.
function getCallDataGas(bytes memory data) pure returns (uint256 calldataGas) {
    for (uint256 i = 0; i < data.length; i++) {
        if (data[i] == 0x00) {
            calldataGas += 4;
        } else {
            calldataGas += 16;
        }
    }
}
```

### getOpStackL1Gas(bytes)

- **Kind**: free-function
- **Source**: 1555:300:245
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/gas/GasCalculations.sol:getOpStackL1Gas(bytes)`

```solidity
/// @notice Calculate the gas cost of calldata on OpStack L1.
///  @param data The calldata to be sent.
///  @return calldataGas The gas cost of the calldata on OpStack L1.
function getOpStackL1Gas(bytes memory data) pure returns (uint256 calldataGas) {
    uint256 opStackConstant = 2028;
    UD60x18 opStackScalar = ud(0.684e18);
    calldataGas = intoUint256(PRBMathCastingUint256.intoUD60x18(getCallDataGas(data)).mul(opStackScalar)) + opStackConstant;
}
```

### ud(uint256)

- **Kind**: free-function
- **Source**: 3445:86:132
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@prb/math/src/ud60x18/Casting.sol:ud(uint256)`

```solidity
/// @notice Alias for {wrap}.
function ud(uint256 x) pure returns (UD60x18 result) {
    result = UD60x18.wrap(x);
}
```

### intoUint256(UD60x18)

- **Kind**: free-function
- **Source**: 2647:97:132
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@prb/math/src/ud60x18/Casting.sol:intoUint256(UD60x18)`

```solidity
/// @notice Casts a UD60x18 number into uint128.
///  @dev This is basically an alias for {unwrap}.
function intoUint256(UD60x18 x) pure returns (uint256 result) {
    result = UD60x18.unwrap(x);
}
```

### intoUD60x18(uint256)

- **Kind**: internal
- **Source**: 3135:112:109
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@prb/math/src/casting/Uint256.sol:PRBMathCastingUint256:intoUD60x18(uint256)`

```solidity
/// @notice Casts a uint256 number to UD60x18.
function intoUD60x18(uint256 x) internal pure returns (UD60x18 result) {
    result = UD60x18.wrap(x);
}
```

### mul(UD60x18,UD60x18)

- **Kind**: free-function
- **Source**: 18914:128:137
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@prb/math/src/ud60x18/Math.sol:mul(UD60x18,UD60x18)`

```solidity
/// @notice Multiplies two UD60x18 numbers together, returning a new UD60x18 number.
///  @dev Uses {Common.mulDiv} to enable overflow-safe multiplication and division.
///  Notes:
///  - Refer to the notes in {Common.mulDiv}.
///  Requirements:
///  - Refer to the requirements in {Common.mulDiv}.
///  @dev See the documentation in {Common.mulDiv18}.
///  @param x The multiplicand as a UD60x18 number.
///  @param y The multiplier as a UD60x18 number.
///  @return result The product as a UD60x18 number.
///  @custom:smtchecker abstract-function-nondet
function mul(UD60x18 x, UD60x18 y) pure returns (UD60x18 result) {
    result = wrap(Common.mulDiv18(x.unwrap(), y.unwrap()));
}
```

### wrap(uint256)

- **Kind**: free-function
- **Source**: 3865:88:132
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@prb/math/src/ud60x18/Casting.sol:wrap(uint256)`

```solidity
/// @notice Wraps a uint256 number into the UD60x18 value type.
function wrap(uint256 x) pure returns (UD60x18 result) {
    result = UD60x18.wrap(x);
}
```

### mulDiv18(uint256,uint256)

- **Kind**: free-function
- **Source**: 19680:819:107
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@prb/math/src/Common.sol:mulDiv18(uint256,uint256)`

```solidity
/// @notice Calculates x*y÷1e18 with 512-bit precision.
///  @dev A variant of {mulDiv} with constant folding, i.e. in which the denominator is hard coded to 1e18.
///  Notes:
///  - The body is purposely left uncommented; to understand how this works, see the documentation in {mulDiv}.
///  - The result is rounded toward zero.
///  - We take as an axiom that the result cannot be `MAX_UINT256` when x and y solve the following system of equations:
///  $$
///  \begin{cases}
///      x * y = MAX\_UINT256 * UNIT \\
///      (x * y) \% UNIT \geq \frac{UNIT}{2}
///  \end{cases}
///  $$
///  Requirements:
///  - Refer to the requirements in {mulDiv}.
///  - The result must fit in uint256.
///  @param x The multiplicand as an unsigned 60.18-decimal fixed-point number.
///  @param y The multiplier as an unsigned 60.18-decimal fixed-point number.
///  @return result The result as an unsigned 60.18-decimal fixed-point number.
///  @custom:smtchecker abstract-function-nondet
function mulDiv18(uint256 x, uint256 y) pure returns (uint256 result) {
    uint256 prod0;
    uint256 prod1;
    assembly ("memory-safe") {
        let mm := mulmod(x, y, not(0))
        prod0 := mul(x, y)
        prod1 := sub(sub(mm, prod0), lt(mm, prod0))
    }
    if (prod1 == 0) {
        unchecked {
            return prod0 / UNIT;
        }
    }
    if (prod1 >= UNIT) {
        revert PRBMath_MulDiv18_Overflow(x, y);
    }
    uint256 remainder;
    assembly ("memory-safe") {
        remainder := mulmod(x, y, UNIT)
        result := mul(or(div(sub(prod0, remainder), UNIT_LPOTD), mul(sub(prod1, gt(remainder, prod0)), add(div(sub(0, UNIT_LPOTD), UNIT_LPOTD), 1))), UNIT_INVERSE)
    }
}
```

### unwrap(UD60x18)

- **Kind**: free-function
- **Source**: 3707:92:132
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@prb/math/src/ud60x18/Casting.sol:unwrap(UD60x18)`

```solidity
/// @notice Unwraps a UD60x18 number into uint256.
function unwrap(UD60x18 x) pure returns (uint256 result) {
    result = UD60x18.unwrap(x);
}
```

### exists(string)

- **Kind**: free-function
- **Source**: 3719:96:244
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Vm.sol:exists(string)`

```solidity
function exists(string memory path) view returns (bool) {
    return Vm(VM_ADDR).exists(path);
}
```

### readFile(string)

- **Kind**: free-function
- **Source**: 3608:109:244
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Vm.sol:readFile(string)`

```solidity
function readFile(string memory path) view returns (string memory) {
    return Vm(VM_ADDR).readFile(path);
}
```

### parsePrevGasReport(string)

- **Kind**: free-function
- **Source**: 2023:722:245
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/gas/GasCalculations.sol:parsePrevGasReport(string)`

```solidity
/// @notice Parse the previous gas report from a file.
///  @param fileContent The content of the file.
///  @return prevGasCalculations The previous gas calculations.
function parsePrevGasReport(string memory fileContent) pure returns (GasCalculations memory prevGasCalculations) {
    prevGasCalculations.total = parseUintFromASCII(parseJson(fileContent, ".Total"));
    prevGasCalculations.creation = parseUintFromASCII(parseJson(fileContent, ".Phases.Creation"));
    prevGasCalculations.validation = parseUintFromASCII(parseJson(fileContent, ".Phases.Validation"));
    prevGasCalculations.execution = parseUintFromASCII(parseJson(fileContent, ".Phases.Execution"));
    prevGasCalculations.arbitrum = parseUintFromASCII(parseJson(fileContent, ".Calldata.Arbitrum"));
    prevGasCalculations.opStack = parseUintFromASCII(parseJson(fileContent, ".Calldata.OP-Stack"));
}
```

### parseUintFromASCII(bytes)

- **Kind**: free-function
- **Source**: 2865:632:245
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/gas/GasCalculations.sol:parseUintFromASCII(bytes)`

```solidity
/// @notice Parse a uint256 from ASCII.
///  @param ascii The ASCII to be parsed.
///  @return _ret The parsed uint256.
function parseUintFromASCII(bytes memory ascii) pure returns (uint256 _ret) {
    bytes memory prevTotal;
    uint256 offset = (ascii.length > 32) ? 32 : 0;
    for (uint256 i; i < ascii.length; i++) {
        if (ascii[i] == 0x28) {
            break;
        } else {
            if (i >= offset) {
                prevTotal = abi.encodePacked(prevTotal, ascii[i]);
            }
        }
    }
    uint256 j = 1;
    for (uint256 i = prevTotal.length - 1; i > 0; i--) {
        if ((uint8(prevTotal[i]) >= 48) && (uint8(prevTotal[i]) <= 57)) {
            _ret += (uint8(prevTotal[i]) - 48) * j;
            j *= 10;
        }
    }
}
```

### parseJson(string,string)

- **Kind**: free-function
- **Source**: 4352:134:244
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Vm.sol:parseJson(string,string)`

```solidity
function parseJson(string memory json, string memory key) pure returns (bytes memory) {
    return Vm(VM_ADDR).parseJson(json, key);
}
```

### formatGasToWrite(string,struct GasCalculations,struct GasCalculations)

- **Kind**: internal
- **Source**: 1413:2033:246
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/gas/GasParser.sol:GasParser:formatGasToWrite(string,struct GasCalculations,struct GasCalculations)`

```solidity
function formatGasToWrite(string memory gasIdentifier, GasCalculations memory prevGasCalculations, GasCalculations memory gasCalculations) internal returns (string memory finalJson) {
    string memory jsonObj = string(abi.encodePacked(gasIdentifier));
    serializeString(jsonObj, "Total", formatGasValue({prevValue: prevGasCalculations.total, newValue: gasCalculations.total}));
    string memory phasesObj = "phases";
    serializeString(phasesObj, "Creation", formatGasValue({prevValue: prevGasCalculations.creation, newValue: gasCalculations.creation}));
    serializeString(phasesObj, "Validation", formatGasValue({prevValue: prevGasCalculations.validation, newValue: gasCalculations.validation}));
    string memory phasesOutput = serializeString(phasesObj, "Execution", formatGasValue({prevValue: prevGasCalculations.execution, newValue: gasCalculations.execution}));
    string memory l2sObj = "l2s";
    serializeString(l2sObj, "OP-Stack", formatGasValue({prevValue: prevGasCalculations.opStack, newValue: gasCalculations.opStack}));
    string memory l2sOutput = serializeString(l2sObj, "Arbitrum", formatGasValue({prevValue: prevGasCalculations.arbitrum, newValue: gasCalculations.arbitrum}));
    serializeString(jsonObj, "Phases", phasesOutput);
    finalJson = serializeString(jsonObj, "Calldata", l2sOutput);
}
```

### serializeString(string,string,string)

- **Kind**: free-function
- **Source**: 3290:213:244
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Vm.sol:serializeString(string,string,string)`

```solidity
function serializeString(string memory objectKey, string memory valueKey, string memory value) returns (string memory json) {
    return Vm(VM_ADDR).serializeString(objectKey, valueKey, value);
}
```

### formatGasValue(uint256,uint256)

- **Kind**: free-function
- **Source**: 3669:445:245
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/gas/GasCalculations.sol:formatGasValue(uint256,uint256)`

```solidity
/// @notice Format the gas value.
///  @param prevValue The previous gas value.
///  @param newValue The new gas value.
///  @return formattedValue The formatted gas value.
function formatGasValue(uint256 prevValue, uint256 newValue) pure returns (string memory formattedValue) {
    if (prevValue == 0) {
        formattedValue = string.concat(formatGas(int256(newValue)), " gas");
    } else {
        formattedValue = string.concat(formatGas(int256(newValue)), " gas (diff: ", formatGas(int256(newValue) - int256(prevValue)), ")");
    }
}
```

### formatGas(int256)

- **Kind**: free-function
- **Source**: 4268:455:245
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/gas/GasCalculations.sol:formatGas(int256)`

```solidity
/// @notice Format the gas value with underscores for readability.
///  @param value The gas value to be formatted.
///  @return The formatted gas value.
function formatGas(int256 value) pure returns (string memory) {
    string memory str = toString(value);
    bytes memory bStr = bytes(str);
    bytes memory result = new bytes(bStr.length + ((bStr.length - 1) / 3));
    uint256 j = result.length;
    for (uint256 i = 0; i < bStr.length; i++) {
        if ((i > 0) && ((i % 3) == 0)) {
            result[--j] = "_";
        }
        result[--j] = bStr[(bStr.length - i) - 1];
    }
    return string(result);
}
```

### toString(int256)

- **Kind**: free-function
- **Source**: 3924:104:244
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Vm.sol:toString(int256)`

```solidity
function toString(int256 input) pure returns (string memory) {
    return Vm(VM_ADDR).toString(input);
}
```

### writeJson(string,string)

- **Kind**: free-function
- **Source**: 3505:101:244
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Vm.sol:writeJson(string,string)`

```solidity
function writeJson(string memory json, string memory path) {
    Vm(VM_ADDR).writeJson(json, path);
}
```

### writeGasIdentifier(string)

- **Kind**: free-function
- **Source**: 1337:137:243
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Storage.sol:writeGasIdentifier(string)`

```solidity
function writeGasIdentifier(string memory id) {
    bytes32 slot = keccak256("ModuleKit.GasIdentifierSlot");
    writeString(slot, id);
}
```

### writeString(bytes32,string)

- **Kind**: free-function
- **Source**: 12883:660:243
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Storage.sol:writeString(bytes32,string)`

```solidity
function writeString(bytes32 slot, string memory value) {
    bytes memory strBytes = bytes(value);
    uint256 length = strBytes.length;
    assembly {
        sstore(slot, length)
    }
    for (uint256 i = 0; i < length; i += 32) {
        bytes32 data;
        for (uint256 j = 0; (j < 32) && ((i + j) < length); j++) {
            data |= bytes32(uint256(uint8(strBytes[i + j])) << (248 - (j * 8)));
        }
        bytes32 charSlot = keccak256(abi.encodePacked(slot, i / 32));
        assembly {
            sstore(charSlot, data)
        }
    }
}
```

### _depositFreeAssetsFromSingleAmount5115(uint256,address,address)

- **Kind**: internal
- **Source**: 36874:1941:576
- **Link**: `test/integration/SuperVault/BaseSuperVaultTest.t.sol:BaseSuperVaultTest:_depositFreeAssetsFromSingleAmount5115(uint256,address,address)`

```solidity
function _depositFreeAssetsFromSingleAmount5115(uint256 depositAmount, address strategyAddress, address underlyingVault) internal {
    address depositHookAddress = _getHookAddress(ETH, APPROVE_AND_DEPOSIT_5115_VAULT_HOOK_KEY);
    address[] memory fulfillHooksAddresses = new address[](1);
    fulfillHooksAddresses[0] = depositHookAddress;
    bytes[] memory fulfillHooksData = new bytes[](1);
    fulfillHooksData[0] = _createApproveAndDeposit5115HookData(_getYieldSourceOracleId(bytes32(bytes(ERC5115_YIELD_SOURCE_ORACLE_KEY)), MANAGER), underlyingVault, address(asset5115), depositAmount, 0, false);
    uint256[] memory expectedAssetsOrSharesOut = new uint256[](1);
    expectedAssetsOrSharesOut[0] = IStandardizedYield(address(underlyingVault)).previewDeposit(address(asset5115), depositAmount);
    bytes[] memory argsForProofs = new bytes[](1);
    argsForProofs[0] = ISuperHookInspector(fulfillHooksAddresses[0]).inspect(fulfillHooksData[0]);
    vm.startPrank(MANAGER);
    SuperVaultStrategy(payable(strategyAddress)).executeHooks(ISuperVaultStrategy.ExecuteArgs({hooks: fulfillHooksAddresses, hookCalldata: fulfillHooksData, expectedAssetsOrSharesOut: expectedAssetsOrSharesOut, globalProofs: _getMerkleProofsForHooks(fulfillHooksAddresses, argsForProofs), strategyProofs: new bytes32[][](1)}));
    vm.stopPrank();
    uint256 pricePerShare = _getSuperVaultPricePerShare();
    uint256 shares = depositAmount.mulDiv(strategy.PRECISION(), pricePerShare);
    _trackDeposit(accountEth, shares, depositAmount);
}
```

### _createApproveAndDeposit5115HookData(bytes32,address,address,uint256,uint256,bool)

- **Kind**: internal
- **Source**: 94:419:669
- **Link**: `test/utils/hooks/HooksHelpers.sol:HooksHelpers:_createApproveAndDeposit5115HookData(bytes32,address,address,uint256,uint256,bool)`

```solidity
function _createApproveAndDeposit5115HookData(bytes32 yieldSourceOracleId, address vault, address tokenIn, uint256 amount, uint256 minSharesOut, bool usePrevHookAmount) internal pure returns (bytes memory hookData) {
    hookData = abi.encodePacked(yieldSourceOracleId, vault, tokenIn, amount, minSharesOut, usePrevHookAmount);
}
```

### _getMerkleProofsForHooks(address[],bytes[])

- **Kind**: internal
- **Source**: 6398:1705:672
- **Link**: `test/utils/merkle/helper/MerkleReader.sol:MerkleReader:_getMerkleProofsForHooks(address[],bytes[])`

```solidity
///  @notice Get Merkle proofs for multiple hooks with specific arguments (OPTIMIZED)
///  @dev Uses efficient JS-based lookup to avoid gas-expensive Solidity operations
///  @param hookAddresses Array of hook contract addresses
///  @param encodedHookArgs Array of packed-encoded hook arguments corresponding to each hook
///  @return proofs Array of Merkle proofs for each hook/args combination
function _getMerkleProofsForHooks(address[] memory hookAddresses, bytes[] memory encodedHookArgs) internal returns (bytes32[][] memory proofs) {
    if (hookAddresses.length != encodedHookArgs.length) revert InvalidArrayLengths();
    if (hookAddresses.length == 0) revert EmptyInput();
    string memory addressesArg = "";
    string memory argsArg = "";
    for (uint256 i = 0; i < hookAddresses.length; i++) {
        if (i > 0) {
            addressesArg = string.concat(addressesArg, ",");
            argsArg = string.concat(argsArg, ",");
        }
        addressesArg = string.concat(addressesArg, vm.toString(hookAddresses[i]));
        argsArg = string.concat(argsArg, vm.toString(encodedHookArgs[i]));
    }
    string[] memory cmd = new string[](6);
    cmd[0] = "node";
    cmd[1] = string.concat(vm.projectRoot(), "/test/utils/merkle/merkle-js/efficient-proof-lookup.js");
    cmd[2] = "batch";
    cmd[3] = addressesArg;
    cmd[4] = argsArg;
    cmd[5] = vm.toString(currentChainId);
    bytes memory result = vm.ffi(cmd);
    string memory resultStr = string(result);
    proofs = abi.decode(vm.parseJson(resultStr), (bytes32[][]));
    return proofs;
}
```

### _getSuperVaultPricePerShare()

- **Kind**: internal
- **Source**: 112127:597:576
- **Link**: `test/integration/SuperVault/BaseSuperVaultTest.t.sol:BaseSuperVaultTest:_getSuperVaultPricePerShare()`

```solidity
function _getSuperVaultPricePerShare() internal view returns (uint256 pricePerShare) {
    uint256 totalSupplyAmount = vault.totalSupply();
    if (totalSupplyAmount == 0) {
        pricePerShare = vault.PRECISION();
    } else {
        (uint256 totalAssetsVault, ) = totalAssetHelper.totalAssets(address(strategy));
        pricePerShare = totalAssetsVault.mulDiv(vault.PRECISION(), totalSupplyAmount, Math.Rounding.Floor);
    }
}
```

### _trackDeposit(address,uint256,uint256)

- **Kind**: internal
- **Source**: 110828:238:576
- **Link**: `test/integration/SuperVault/BaseSuperVaultTest.t.sol:BaseSuperVaultTest:_trackDeposit(address,uint256,uint256)`

```solidity
function _trackDeposit(address user, uint256 shares, uint256 assets) internal {
    SuperVaultState storage state = superVaultStates[user];
    state.accumulatorShares += shares;
    state.accumulatorCostBasis += assets;
}
```

### assertGt(uint256,uint256,string)

- **Kind**: internal
- **Source**: 14795:177:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertGt(uint256,uint256,string)`

```solidity
function assertGt(uint256 left, uint256 right, string memory err) virtual internal pure {
    if (left <= right) {
        vm.assertGt(left, right, err);
    }
}
```

### assertGt(uint256,uint256)

- **Kind**: internal
- **Source**: 14636:153:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertGt(uint256,uint256)`

```solidity
function assertGt(uint256 left, uint256 right) virtual internal pure {
    if (left <= right) {
        vm.assertGt(left, right);
    }
}
```

## External Calls

- **Vm::selectFork(uint256)**
- **IERC20::balanceOf(address)**
- **SuperVault::share()**
- **Vm::warp(uint256)**
- **SuperVaultAggregator::getPPS(address)**

## State Variable Reads

- **sv5115** (`contract SuperVault`) [src/SuperVault/SuperVault.sol/contract_SuperVault.md]
- **strategy5115SuperVault** (`contract SuperVaultStrategy`) [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]
- **aggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]
- **contractAddresses** (`mapping(uint64 => mapping(string => address))`)
- **totalAssetHelper** (`contract TotalAssetHelper`) [test/integration/SuperVault/TotalAssetHelper.sol/contract_TotalAssetHelper.md]
- **ecdsappsOracle** (`contract IECDSAPPSOracle`) [src/interfaces/oracles/IECDSAPPSOracle.sol/interface_IECDSAPPSOracle.md]
- **stdstore** (`struct StdStorage`)
- **UINT256_MAX** (`uint256`)
- **instanceOnEth** (`struct AccountInstance`)
- **superExecutorOnEth** (`contract ISuperExecutor`) [lib/v2-core/src/interfaces/ISuperExecutor.sol/interface_ISuperExecutor.md]
- **hookAddresses** (`mapping(uint64 => mapping(string => address))`)
- **VM_ADDR** (`address`)
- **MIN_STAKE_VALUE** (`uint256`)
- **MIN_UNSTAKE_DELAY** (`uint256`)
- **asset5115** (`contract IERC20Metadata`) [lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol/interface_IERC20Metadata.md]
- **strategy** (`contract SuperVaultStrategy`) [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]
- **accountEth** (`address`)
- **currentChainId** (`uint256`)
- **vault** (`contract SuperVault`) [src/SuperVault/SuperVault.sol/contract_SuperVault.md]
- **superVaultStates** (`mapping(address => struct BaseSuperVaultTest.SuperVaultState)`)

## State Variable Writes

- **sv5115** (`contract SuperVault`) [src/SuperVault/SuperVault.sol/contract_SuperVault.md]
- **escrow5115SuperVault** (`contract SuperVaultEscrow`) [src/SuperVault/SuperVaultEscrow.sol/contract_SuperVaultEscrow.md]
- **strategy5115SuperVault** (`contract SuperVaultStrategy`) [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVault5115Tests.test_SuperVault_5115_PositivePPS() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: SuperVault5115Tests._setup5115Vault() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseSuperVaultTest._deployVault(address,string) (NodeID: 2)
  │ │   💬 Args: [address(asset5115), "sv5115"]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 3)
  │ │   💬 Args: [strategySuperVaultAddr, globalSV5115Strategy, "SV STRATEGY NOT EQUAL TO PREDICTED"]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseTest._getContract(uint64,string) (NodeID: 4)
  │ │   💬 Args: [ETH, ERC5115_YIELD_SOURCE_ORACLE_KEY]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseSuperVaultTest._updateSuperVaultPPS(address,address) (NodeID: 5)
  │ │   💬 Args: [address(strategy5115SuperVault), address(sv5115)]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256,enum Math.Rounding) (NodeID: 6)
  │ │ │   💬 Args: [vars.currentTotalAssets, vars.precision, vars.totalSupplyAmount, Math.Rounding.Floor]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 7)
  │ │ │ │   💬 Args: [unsignedRoundsUp(rounding) && (mulmod(x, y, denominator) > 0)]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.unsignedRoundsUp(enum Math.Rounding) (NodeID: 8)
  │ │ │ │     💬 Args: [rounding]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 9)
  │ │ │     💬 Args: [x, y, denominator]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 10)
  │ │ │   │   💬 Args: [x, y]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 11)
  │ │ │       💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │ │ │       👁️  Def: internal
  │ │ │     └─ [6] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 12)
  │ │ │         💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │ │ │         👁️  Def: internal
  │ │ │       └─ [7] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 13)
  │ │ │           💬 Args: [condition]
  │ │ │           👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: MessageHashUtils.toTypedDataHash(bytes32,bytes32) (NodeID: 14)
  │ │ │   💬 Args: [ecdsappsOracle.domainSeparator(), structHash]
  │ │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: console.log(string,address,uint256) (NodeID: 15)
  │ │     💬 Args: ["Updated PPS for strategy", strategyAddr, vars.pps]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 16)
  │ │       💬 Args: [abi.encodeWithSignature("log(string,address,uint256)", p0, p1, p2)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 17)
  │ │         💬 Args: [_sendLogPayloadView]
  │ │         👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: BaseSuperVaultTest._updateSuperVaultPPS(address,address) (NodeID: 18)
  │     💬 Args: [address(strategy), address(vault)]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256,enum Math.Rounding) (NodeID: 19)
  │   │   💬 Args: [vars.currentTotalAssets, vars.precision, vars.totalSupplyAmount, Math.Rounding.Floor]
  │   │   👁️  Def: internal
  │   │ ├─ [4] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 20)
  │   │ │   💬 Args: [unsignedRoundsUp(rounding) && (mulmod(x, y, denominator) > 0)]
  │   │ │   👁️  Def: internal
  │   │ │ └─ [5] ⚙️ FUNCTION: Math.unsignedRoundsUp(enum Math.Rounding) (NodeID: 21)
  │   │ │     💬 Args: [rounding]
  │   │ │     👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 22)
  │   │     💬 Args: [x, y, denominator]
  │   │     👁️  Def: internal
  │   │   ├─ [5] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 23)
  │   │   │   💬 Args: [x, y]
  │   │   │   👁️  Def: internal
  │   │   └─ [5] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 24)
  │   │       💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │   │       👁️  Def: internal
  │   │     └─ [6] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 25)
  │   │         💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │   │         👁️  Def: internal
  │   │       └─ [7] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 26)
  │   │           💬 Args: [condition]
  │   │           👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: MessageHashUtils.toTypedDataHash(bytes32,bytes32) (NodeID: 27)
  │   │   💬 Args: [ecdsappsOracle.domainSeparator(), structHash]
  │   │   👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: console.log(string,address,uint256) (NodeID: 28)
  │       💬 Args: ["Updated PPS for strategy", strategyAddr, vars.pps]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 29)
  │         💬 Args: [abi.encodeWithSignature("log(string,address,uint256)", p0, p1, p2)]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 30)
  │           💬 Args: [_sendLogPayloadView]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdCheats.deal(address,address,uint256) (NodeID: 31)
  │   💬 Args: [address(asset5115), accountEth, vars.deposit1Amount]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdCheats.deal(address,address,uint256,bool) (NodeID: 32)
  │     💬 Args: [token, to, give, false]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: stdStorage.target(struct StdStorage,address) (NodeID: 33)
  │   │   💬 Args: [stdstore, token]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: stdStorageSafe.target(struct StdStorage,address) (NodeID: 34)
  │   │     💬 Args: [self, _target]
  │   │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: stdStorage.sig(struct StdStorage,bytes4) (NodeID: 35)
  │   │   💬 Args: [stdstore.target(token), 0x70a08231]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: stdStorageSafe.sig(struct StdStorage,bytes4) (NodeID: 36)
  │   │     💬 Args: [self, _sig]
  │   │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: stdStorage.with_key(struct StdStorage,address) (NodeID: 37)
  │   │   💬 Args: [stdstore.target(token).sig(0x70a08231), to]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: stdStorageSafe.with_key(struct StdStorage,address) (NodeID: 38)
  │   │     💬 Args: [self, who]
  │   │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,uint256) (NodeID: 39)
  │   │   💬 Args: [stdstore.target(token).sig(0x70a08231).with_key(to), give]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,bytes32) (NodeID: 40)
  │   │     💬 Args: [self, bytes32(amt)]
  │   │     👁️  Def: internal
  │   │   ├─ [5] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 41)
  │   │   │   💬 Args: [self]
  │   │   │   👁️  Def: internal
  │   │   │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 42)
  │   │   │     💬 Args: [self._keys]
  │   │   │     👁️  Def: private
  │   │   ├─ [5] ⚙️ FUNCTION: stdStorage.find(struct StdStorage,bool) (NodeID: 43)
  │   │   │   💬 Args: [self, false]
  │   │   │   👁️  Def: internal
  │   │   │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.find(struct StdStorage,bool) (NodeID: 44)
  │   │   │     💬 Args: [self, _clear]
  │   │   │     👁️  Def: internal
  │   │   │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 45)
  │   │   │   │   💬 Args: [self]
  │   │   │   │   👁️  Def: internal
  │   │   │   │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 46)
  │   │   │   │     💬 Args: [self._keys]
  │   │   │   │     👁️  Def: private
  │   │   │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 47)
  │   │   │   │   💬 Args: [self]
  │   │   │   │   👁️  Def: internal
  │   │   │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 48)
  │   │   │   │   💬 Args: [self]
  │   │   │   │   👁️  Def: internal
  │   │   │   │ ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 49)
  │   │   │   │ │   💬 Args: [self]
  │   │   │   │ │   👁️  Def: internal
  │   │   │   │ │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 50)
  │   │   │   │ │     💬 Args: [self._keys]
  │   │   │   │ │     👁️  Def: private
  │   │   │   │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 51)
  │   │   │   │     💬 Args: [rdat, 32 * self._depth]
  │   │   │   │     👁️  Def: private
  │   │   │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.checkSlotMutatesCall(struct StdStorage,bytes32) (NodeID: 52)
  │   │   │   │   💬 Args: [self, reads[i]]
  │   │   │   │   👁️  Def: internal
  │   │   │   │ ├─ [8] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 53)
  │   │   │   │ │   💬 Args: [self]
  │   │   │   │ │   👁️  Def: internal
  │   │   │   │ │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 54)
  │   │   │   │ │ │   💬 Args: [self]
  │   │   │   │ │ │   👁️  Def: internal
  │   │   │   │ │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 55)
  │   │   │   │ │ │     💬 Args: [self._keys]
  │   │   │   │ │ │     👁️  Def: private
  │   │   │   │ │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 56)
  │   │   │   │ │     💬 Args: [rdat, 32 * self._depth]
  │   │   │   │ │     👁️  Def: private
  │   │   │   │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 57)
  │   │   │   │     💬 Args: [self]
  │   │   │   │     👁️  Def: internal
  │   │   │   │   ├─ [9] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 58)
  │   │   │   │   │   💬 Args: [self]
  │   │   │   │   │   👁️  Def: internal
  │   │   │   │   │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 59)
  │   │   │   │   │     💬 Args: [self._keys]
  │   │   │   │   │     👁️  Def: private
  │   │   │   │   └─ [9] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 60)
  │   │   │   │       💬 Args: [rdat, 32 * self._depth]
  │   │   │   │       👁️  Def: private
  │   │   │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.findOffsets(struct StdStorage,bytes32) (NodeID: 61)
  │   │   │   │   💬 Args: [self, reads[i]]
  │   │   │   │   👁️  Def: internal
  │   │   │   │ ├─ [8] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 62)
  │   │   │   │ │   💬 Args: [self, slot, true]
  │   │   │   │ │   👁️  Def: internal
  │   │   │   │ │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 63)
  │   │   │   │ │     💬 Args: [self]
  │   │   │   │ │     👁️  Def: internal
  │   │   │   │ │   ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 64)
  │   │   │   │ │   │   💬 Args: [self]
  │   │   │   │ │   │   👁️  Def: internal
  │   │   │   │ │   │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 65)
  │   │   │   │ │   │     💬 Args: [self._keys]
  │   │   │   │ │   │     👁️  Def: private
  │   │   │   │ │   └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 66)
  │   │   │   │ │       💬 Args: [rdat, 32 * self._depth]
  │   │   │   │ │       👁️  Def: private
  │   │   │   │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 67)
  │   │   │   │     💬 Args: [self, slot, false]
  │   │   │   │     👁️  Def: internal
  │   │   │   │   └─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 68)
  │   │   │   │       💬 Args: [self]
  │   │   │   │       👁️  Def: internal
  │   │   │   │     ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 69)
  │   │   │   │     │   💬 Args: [self]
  │   │   │   │     │   👁️  Def: internal
  │   │   │   │     │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 70)
  │   │   │   │     │     💬 Args: [self._keys]
  │   │   │   │     │     👁️  Def: private
  │   │   │   │     └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 71)
  │   │   │   │         💬 Args: [rdat, 32 * self._depth]
  │   │   │   │         👁️  Def: private
  │   │   │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 72)
  │   │   │   │   💬 Args: [offsetLeft, offsetRight]
  │   │   │   │   👁️  Def: internal
  │   │   │   └─ [7] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 73)
  │   │   │       💬 Args: [self]
  │   │   │       👁️  Def: internal
  │   │   ├─ [5] ⚙️ FUNCTION: stdStorageSafe.getUpdatedSlotValue(bytes32,uint256,uint256,uint256) (NodeID: 74)
  │   │   │   💬 Args: [curVal, uint256(set), data.offsetLeft, data.offsetRight]
  │   │   │   👁️  Def: internal
  │   │   │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 75)
  │   │   │     💬 Args: [offsetLeft, offsetRight]
  │   │   │     👁️  Def: internal
  │   │   ├─ [5] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 76)
  │   │   │   💬 Args: [self]
  │   │   │   👁️  Def: internal
  │   │   │ ├─ [6] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 77)
  │   │   │ │   💬 Args: [self]
  │   │   │ │   👁️  Def: internal
  │   │   │ │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 78)
  │   │   │ │     💬 Args: [self._keys]
  │   │   │ │     👁️  Def: private
  │   │   │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 79)
  │   │   │     💬 Args: [rdat, 32 * self._depth]
  │   │   │     👁️  Def: private
  │   │   └─ [5] ⚙️ FUNCTION: stdStorage.clear(struct StdStorage) (NodeID: 80)
  │   │       💬 Args: [self]
  │   │       👁️  Def: internal
  │   │     └─ [6] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 81)
  │   │         💬 Args: [self]
  │   │         👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: stdStorage.target(struct StdStorage,address) (NodeID: 82)
  │   │   💬 Args: [stdstore, token]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: stdStorageSafe.target(struct StdStorage,address) (NodeID: 83)
  │   │     💬 Args: [self, _target]
  │   │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: stdStorage.sig(struct StdStorage,bytes4) (NodeID: 84)
  │   │   💬 Args: [stdstore.target(token), 0x18160ddd]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: stdStorageSafe.sig(struct StdStorage,bytes4) (NodeID: 85)
  │   │     💬 Args: [self, _sig]
  │   │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,uint256) (NodeID: 86)
  │       💬 Args: [stdstore.target(token).sig(0x18160ddd), totSup]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,bytes32) (NodeID: 87)
  │         💬 Args: [self, bytes32(amt)]
  │         👁️  Def: internal
  │       ├─ [5] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 88)
  │       │   💬 Args: [self]
  │       │   👁️  Def: internal
  │       │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 89)
  │       │     💬 Args: [self._keys]
  │       │     👁️  Def: private
  │       ├─ [5] ⚙️ FUNCTION: stdStorage.find(struct StdStorage,bool) (NodeID: 90)
  │       │   💬 Args: [self, false]
  │       │   👁️  Def: internal
  │       │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.find(struct StdStorage,bool) (NodeID: 91)
  │       │     💬 Args: [self, _clear]
  │       │     👁️  Def: internal
  │       │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 92)
  │       │   │   💬 Args: [self]
  │       │   │   👁️  Def: internal
  │       │   │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 93)
  │       │   │     💬 Args: [self._keys]
  │       │   │     👁️  Def: private
  │       │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 94)
  │       │   │   💬 Args: [self]
  │       │   │   👁️  Def: internal
  │       │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 95)
  │       │   │   💬 Args: [self]
  │       │   │   👁️  Def: internal
  │       │   │ ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 96)
  │       │   │ │   💬 Args: [self]
  │       │   │ │   👁️  Def: internal
  │       │   │ │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 97)
  │       │   │ │     💬 Args: [self._keys]
  │       │   │ │     👁️  Def: private
  │       │   │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 98)
  │       │   │     💬 Args: [rdat, 32 * self._depth]
  │       │   │     👁️  Def: private
  │       │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.checkSlotMutatesCall(struct StdStorage,bytes32) (NodeID: 99)
  │       │   │   💬 Args: [self, reads[i]]
  │       │   │   👁️  Def: internal
  │       │   │ ├─ [8] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 100)
  │       │   │ │   💬 Args: [self]
  │       │   │ │   👁️  Def: internal
  │       │   │ │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 101)
  │       │   │ │ │   💬 Args: [self]
  │       │   │ │ │   👁️  Def: internal
  │       │   │ │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 102)
  │       │   │ │ │     💬 Args: [self._keys]
  │       │   │ │ │     👁️  Def: private
  │       │   │ │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 103)
  │       │   │ │     💬 Args: [rdat, 32 * self._depth]
  │       │   │ │     👁️  Def: private
  │       │   │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 104)
  │       │   │     💬 Args: [self]
  │       │   │     👁️  Def: internal
  │       │   │   ├─ [9] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 105)
  │       │   │   │   💬 Args: [self]
  │       │   │   │   👁️  Def: internal
  │       │   │   │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 106)
  │       │   │   │     💬 Args: [self._keys]
  │       │   │   │     👁️  Def: private
  │       │   │   └─ [9] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 107)
  │       │   │       💬 Args: [rdat, 32 * self._depth]
  │       │   │       👁️  Def: private
  │       │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.findOffsets(struct StdStorage,bytes32) (NodeID: 108)
  │       │   │   💬 Args: [self, reads[i]]
  │       │   │   👁️  Def: internal
  │       │   │ ├─ [8] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 109)
  │       │   │ │   💬 Args: [self, slot, true]
  │       │   │ │   👁️  Def: internal
  │       │   │ │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 110)
  │       │   │ │     💬 Args: [self]
  │       │   │ │     👁️  Def: internal
  │       │   │ │   ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 111)
  │       │   │ │   │   💬 Args: [self]
  │       │   │ │   │   👁️  Def: internal
  │       │   │ │   │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 112)
  │       │   │ │   │     💬 Args: [self._keys]
  │       │   │ │   │     👁️  Def: private
  │       │   │ │   └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 113)
  │       │   │ │       💬 Args: [rdat, 32 * self._depth]
  │       │   │ │       👁️  Def: private
  │       │   │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 114)
  │       │   │     💬 Args: [self, slot, false]
  │       │   │     👁️  Def: internal
  │       │   │   └─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 115)
  │       │   │       💬 Args: [self]
  │       │   │       👁️  Def: internal
  │       │   │     ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 116)
  │       │   │     │   💬 Args: [self]
  │       │   │     │   👁️  Def: internal
  │       │   │     │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 117)
  │       │   │     │     💬 Args: [self._keys]
  │       │   │     │     👁️  Def: private
  │       │   │     └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 118)
  │       │   │         💬 Args: [rdat, 32 * self._depth]
  │       │   │         👁️  Def: private
  │       │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 119)
  │       │   │   💬 Args: [offsetLeft, offsetRight]
  │       │   │   👁️  Def: internal
  │       │   └─ [7] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 120)
  │       │       💬 Args: [self]
  │       │       👁️  Def: internal
  │       ├─ [5] ⚙️ FUNCTION: stdStorageSafe.getUpdatedSlotValue(bytes32,uint256,uint256,uint256) (NodeID: 121)
  │       │   💬 Args: [curVal, uint256(set), data.offsetLeft, data.offsetRight]
  │       │   👁️  Def: internal
  │       │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 122)
  │       │     💬 Args: [offsetLeft, offsetRight]
  │       │     👁️  Def: internal
  │       ├─ [5] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 123)
  │       │   💬 Args: [self]
  │       │   👁️  Def: internal
  │       │ ├─ [6] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 124)
  │       │ │   💬 Args: [self]
  │       │ │   👁️  Def: internal
  │       │ │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 125)
  │       │ │     💬 Args: [self._keys]
  │       │ │     👁️  Def: private
  │       │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 126)
  │       │     💬 Args: [rdat, 32 * self._depth]
  │       │     👁️  Def: private
  │       └─ [5] ⚙️ FUNCTION: stdStorage.clear(struct StdStorage) (NodeID: 127)
  │           💬 Args: [self]
  │           👁️  Def: internal
  │         └─ [6] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 128)
  │             💬 Args: [self]
  │             👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseSuperVaultTest._deposit(uint256,address,address) (NodeID: 129)
  │   💬 Args: [vars.deposit1Amount, address(sv5115), address(asset5115)]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: BaseSuperVaultTest.__deposit(struct AccountInstance,uint256,address,address) (NodeID: 130)
  │     💬 Args: [instanceOnEth, depositAmount, superVault, asset_]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: BaseTest._getHookAddress(uint64,string) (NodeID: 131)
  │   │   💬 Args: [ETH, APPROVE_AND_DEPOSIT_4626_VAULT_HOOK_KEY]
  │   │   👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: InternalHelpers._createApproveAndDeposit4626HookData(bytes32,address,address,uint256,bool,address,uint256) (NodeID: 132)
  │   │   💬 Args: [_getYieldSourceOracleId(bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), MANAGER), superVault, asset_, depositAmount, false, address(0), 0]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: InternalHelpers._getYieldSourceOracleId(bytes32,address) (NodeID: 133)
  │   │     💬 Args: [bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), MANAGER]
  │   │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: InternalHelpers._getExecOps(struct AccountInstance,contract ISuperExecutor,bytes) (NodeID: 134)
  │   │   💬 Args: [accInst, superExecutorOnEth, abi.encode(entry)]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: ModuleKitHelpers.getExecOps(struct AccountInstance,address,uint256,bytes,address) (NodeID: 135)
  │   │     💬 Args: [instance, address(superExecutor), 0, abi.encodeCall(superExecutor.execute, (data)), address(instance.defaultValidator)]
  │   │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: InternalHelpers.executeOp(struct UserOpData) (NodeID: 136)
  │       💬 Args: [userOpData]
  │       👁️  Def: public
  │     └─ [4] ⚙️ FUNCTION: ModuleKitHelpers.execUserOps(struct UserOpData) (NodeID: 137)
  │         💬 Args: [userOpData]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: ERC4337Helpers.exec4337(struct PackedUserOperation,contract IEntryPoint) (NodeID: 138)
  │           💬 Args: [userOpData.userOp, userOpData.entrypoint]
  │           👁️  Def: internal
  │         └─ [6] ⚙️ FUNCTION: ERC4337Helpers.exec4337(struct PackedUserOperation[],contract IEntryPoint) (NodeID: 139)
  │             💬 Args: [userOps, onEntryPoint]
  │             👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Unknown.getExpectRevert() (NodeID: 140)
  │           │   💬 Args: [no args]
  │           │   👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Unknown.getSimulateUserOp() (NodeID: 141)
  │           │   💬 Args: [no args]
  │           │   👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Helpers.envOr(string,bool) (NodeID: 142)
  │           │   💬 Args: ["SIMULATE", false]
  │           │   👁️  Def: public
  │           ├─ [7] ⚙️ FUNCTION: Simulator.simulateUserOp(struct PackedUserOperation,address) (NodeID: 143)
  │           │   💬 Args: [userOps[0], address(onEntryPoint)]
  │           │   👁️  Def: internal
  │           │ ├─ [8] ⚙️ FUNCTION: Simulator._preSimulation() (NodeID: 144)
  │           │ │   💬 Args: [no args]
  │           │ │   👁️  Def: internal
  │           │ │ ├─ [9] ⚙️ FUNCTION: Unknown.snapshotState() (NodeID: 145)
  │           │ │ │   💬 Args: [no args]
  │           │ │ │   👁️  Def: internal
  │           │ │ ├─ [9] ⚙️ FUNCTION: Unknown.startMappingRecording() (NodeID: 146)
  │           │ │ │   💬 Args: [no args]
  │           │ │ │   👁️  Def: internal
  │           │ │ └─ [9] ⚙️ FUNCTION: Unknown.startDebugTraceRecording() (NodeID: 147)
  │           │ │     💬 Args: [no args]
  │           │ │     👁️  Def: internal
  │           │ └─ [8] ⚙️ FUNCTION: Simulator._postSimulation(struct UserOperationDetails) (NodeID: 148)
  │           │     💬 Args: [userOpDetails]
  │           │     👁️  Def: internal
  │           │   ├─ [9] ⚙️ FUNCTION: Unknown.stopAndReturnDebugTraceRecording() (NodeID: 149)
  │           │   │   💬 Args: [no args]
  │           │   │   👁️  Def: internal
  │           │   ├─ [9] ⚙️ FUNCTION: ERC4337SpecsParser.parseValidation(struct UserOperationDetails,struct VmSafe.DebugStep[]) (NodeID: 150)
  │           │   │   💬 Args: [userOpDetails, debugTrace]
  │           │   │   👁️  Def: internal
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.getEntities(struct UserOperationDetails) (NodeID: 151)
  │           │   │ │   💬 Args: [userOpDetails]
  │           │   │ │   👁️  Def: internal
  │           │   │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isStaked(address,address) (NodeID: 152)
  │           │   │ │ │   💬 Args: [factory, userOpDetails.entryPoint]
  │           │   │ │ │   👁️  Def: internal
  │           │   │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isStaked(address,address) (NodeID: 153)
  │           │   │ │ │   💬 Args: [paymaster, userOpDetails.entryPoint]
  │           │   │ │ │   👁️  Def: internal
  │           │   │ │ └─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isStaked(address,address) (NodeID: 154)
  │           │   │ │     💬 Args: [aggregator, userOpDetails.entryPoint]
  │           │   │ │     👁️  Def: internal
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.filterDebugTrace(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,address) (NodeID: 155)
  │           │   │ │   💬 Args: [debugTrace, entities, userOpDetails.entryPoint]
  │           │   │ │   👁️  Def: private
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 156)
  │           │   │ │   💬 Args: [filteredUserOpSteps, entities]
  │           │   │ │   👁️  Def: internal
  │           │   │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isForbiddenOpcode(uint8) (NodeID: 157)
  │           │   │ │ │   💬 Args: [debugTrace[i].opcode]
  │           │   │ │ │   👁️  Def: private
  │           │   │ │ └─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isEntityAndStaked(struct ERC4337SpecsParser.Entities,address) (NodeID: 158)
  │           │   │ │     💬 Args: [entities, debugTrace[i].contractAddr]
  │           │   │ │     👁️  Def: internal
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 159)
  │           │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities]
  │           │   │ │   👁️  Def: internal
  │           │   │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isForbiddenOpcode(uint8) (NodeID: 160)
  │           │   │ │ │   💬 Args: [debugTrace[i].opcode]
  │           │   │ │ │   👁️  Def: private
  │           │   │ │ └─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isEntityAndStaked(struct ERC4337SpecsParser.Entities,address) (NodeID: 161)
  │           │   │ │     💬 Args: [entities, debugTrace[i].contractAddr]
  │           │   │ │     👁️  Def: internal
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.validateOutOfGas(struct VmSafe.DebugStep[]) (NodeID: 162)
  │           │   │ │   💬 Args: [filteredUserOpSteps]
  │           │   │ │   👁️  Def: internal
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.validateOutOfGas(struct VmSafe.DebugStep[]) (NodeID: 163)
  │           │   │ │   💬 Args: [filteredPaymasterUserOpSteps]
  │           │   │ │   👁️  Def: internal
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedStorageLocations(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 164)
  │           │   │ │   💬 Args: [filteredUserOpSteps, entities, userOpDetails]
  │           │   │ │   👁️  Def: internal
  │           │   │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isEntity(struct ERC4337SpecsParser.Entities,address) (NodeID: 165)
  │           │   │ │ │   💬 Args: [entities, currentAccessAccount]
  │           │   │ │ │   👁️  Def: internal
  │           │   │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 166)
  │           │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.account]
  │           │   │ │ │   👁️  Def: internal
  │           │   │ │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 167)
  │           │   │ │ │ │   💬 Args: [currentSlot, entity]
  │           │   │ │ │ │   👁️  Def: internal
  │           │   │ │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 168)
  │           │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │           │   │ │ │ │   👁️  Def: internal
  │           │   │ │ │ │ ├─ [13] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 169)
  │           │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │           │   │ │ │ │ │   👁️  Def: internal
  │           │   │ │ │ │ └─ [13] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 170)
  │           │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │           │   │ │ │ │     👁️  Def: internal
  │           │   │ │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 171)
  │           │   │ │ │     💬 Args: [key, entity]
  │           │   │ │ │     👁️  Def: internal
  │           │   │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 172)
  │           │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.paymaster]
  │           │   │ │ │   👁️  Def: internal
  │           │   │ │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 173)
  │           │   │ │ │ │   💬 Args: [currentSlot, entity]
  │           │   │ │ │ │   👁️  Def: internal
  │           │   │ │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 174)
  │           │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │           │   │ │ │ │   👁️  Def: internal
  │           │   │ │ │ │ ├─ [13] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 175)
  │           │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │           │   │ │ │ │ │   👁️  Def: internal
  │           │   │ │ │ │ └─ [13] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 176)
  │           │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │           │   │ │ │ │     👁️  Def: internal
  │           │   │ │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 177)
  │           │   │ │ │     💬 Args: [key, entity]
  │           │   │ │ │     👁️  Def: internal
  │           │   │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 178)
  │           │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.factory]
  │           │   │ │ │   👁️  Def: internal
  │           │   │ │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 179)
  │           │   │ │ │ │   💬 Args: [currentSlot, entity]
  │           │   │ │ │ │   👁️  Def: internal
  │           │   │ │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 180)
  │           │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │           │   │ │ │ │   👁️  Def: internal
  │           │   │ │ │ │ ├─ [13] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 181)
  │           │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │           │   │ │ │ │ │   👁️  Def: internal
  │           │   │ │ │ │ └─ [13] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 182)
  │           │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │           │   │ │ │ │     👁️  Def: internal
  │           │   │ │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 183)
  │           │   │ │ │     💬 Args: [key, entity]
  │           │   │ │ │     👁️  Def: internal
  │           │   │ │ └─ [11] ⚙️ FUNCTION: Unknown.getLabel(address) (NodeID: 184)
  │           │   │ │     💬 Args: [currentAccessAccount]
  │           │   │ │     👁️  Def: internal
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedStorageLocations(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 185)
  │           │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities, userOpDetails]
  │           │   │ │   👁️  Def: internal
  │           │   │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isEntity(struct ERC4337SpecsParser.Entities,address) (NodeID: 186)
  │           │   │ │ │   💬 Args: [entities, currentAccessAccount]
  │           │   │ │ │   👁️  Def: internal
  │           │   │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 187)
  │           │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.account]
  │           │   │ │ │   👁️  Def: internal
  │           │   │ │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 188)
  │           │   │ │ │ │   💬 Args: [currentSlot, entity]
  │           │   │ │ │ │   👁️  Def: internal
  │           │   │ │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 189)
  │           │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │           │   │ │ │ │   👁️  Def: internal
  │           │   │ │ │ │ ├─ [13] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 190)
  │           │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │           │   │ │ │ │ │   👁️  Def: internal
  │           │   │ │ │ │ └─ [13] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 191)
  │           │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │           │   │ │ │ │     👁️  Def: internal
  │           │   │ │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 192)
  │           │   │ │ │     💬 Args: [key, entity]
  │           │   │ │ │     👁️  Def: internal
  │           │   │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 193)
  │           │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.paymaster]
  │           │   │ │ │   👁️  Def: internal
  │           │   │ │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 194)
  │           │   │ │ │ │   💬 Args: [currentSlot, entity]
  │           │   │ │ │ │   👁️  Def: internal
  │           │   │ │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 195)
  │           │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │           │   │ │ │ │   👁️  Def: internal
  │           │   │ │ │ │ ├─ [13] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 196)
  │           │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │           │   │ │ │ │ │   👁️  Def: internal
  │           │   │ │ │ │ └─ [13] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 197)
  │           │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │           │   │ │ │ │     👁️  Def: internal
  │           │   │ │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 198)
  │           │   │ │ │     💬 Args: [key, entity]
  │           │   │ │ │     👁️  Def: internal
  │           │   │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 199)
  │           │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.factory]
  │           │   │ │ │   👁️  Def: internal
  │           │   │ │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 200)
  │           │   │ │ │ │   💬 Args: [currentSlot, entity]
  │           │   │ │ │ │   👁️  Def: internal
  │           │   │ │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 201)
  │           │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │           │   │ │ │ │   👁️  Def: internal
  │           │   │ │ │ │ ├─ [13] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 202)
  │           │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │           │   │ │ │ │ │   👁️  Def: internal
  │           │   │ │ │ │ └─ [13] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 203)
  │           │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │           │   │ │ │ │     👁️  Def: internal
  │           │   │ │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 204)
  │           │   │ │ │     💬 Args: [key, entity]
  │           │   │ │ │     👁️  Def: internal
  │           │   │ │ └─ [11] ⚙️ FUNCTION: Unknown.getLabel(address) (NodeID: 205)
  │           │   │ │     💬 Args: [currentAccessAccount]
  │           │   │ │     👁️  Def: internal
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.validateCalls(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,address) (NodeID: 206)
  │           │   │ │   💬 Args: [filteredUserOpSteps, entities, userOpDetails.entryPoint]
  │           │   │ │   👁️  Def: internal
  │           │   │ │ └─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 207)
  │           │   │ │     💬 Args: [targetAddr]
  │           │   │ │     👁️  Def: internal
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.validateCalls(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,address) (NodeID: 208)
  │           │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities, userOpDetails.entryPoint]
  │           │   │ │   👁️  Def: internal
  │           │   │ │ └─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 209)
  │           │   │ │     💬 Args: [targetAddr]
  │           │   │ │     👁️  Def: internal
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.validateExtOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 210)
  │           │   │ │   💬 Args: [filteredUserOpSteps, entities]
  │           │   │ │   👁️  Def: internal
  │           │   │ │ └─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 211)
  │           │   │ │     💬 Args: [targetAddr]
  │           │   │ │     👁️  Def: internal
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.validateExtOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 212)
  │           │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities]
  │           │   │ │   👁️  Def: internal
  │           │   │ │ └─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 213)
  │           │   │ │     💬 Args: [targetAddr]
  │           │   │ │     👁️  Def: internal
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.validateCreate(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 214)
  │           │   │ │   💬 Args: [filteredUserOpSteps, entities, userOpDetails]
  │           │   │ │   👁️  Def: internal
  │           │   │ └─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.validateCreate(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 215)
  │           │   │     💬 Args: [filteredPaymasterUserOpSteps, entities, userOpDetails]
  │           │   │     👁️  Def: internal
  │           │   ├─ [9] ⚙️ FUNCTION: Unknown.stopMappingRecording() (NodeID: 216)
  │           │   │   💬 Args: [no args]
  │           │   │   👁️  Def: internal
  │           │   └─ [9] ⚙️ FUNCTION: Unknown.revertToState(uint256) (NodeID: 217)
  │           │       💬 Args: [snapShotId]
  │           │       👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Unknown.recordLogs() (NodeID: 218)
  │           │   💬 Args: [no args]
  │           │   👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: ERC4337Helpers.checkRevertMessage(bytes) (NodeID: 219)
  │           │   💬 Args: [ctx.returnData]
  │           │   👁️  Def: internal
  │           │ ├─ [8] ⚙️ FUNCTION: Unknown.getExpectRevertMessage() (NodeID: 220)
  │           │ │   💬 Args: [no args]
  │           │ │   👁️  Def: internal
  │           │ └─ [8] ⚙️ FUNCTION: ERC4337Helpers.parseFailedOpWithRevert(bytes,bytes) (NodeID: 221)
  │           │     💬 Args: [actualReason, revertMessage]
  │           │     👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Unknown.getRecordedLogs() (NodeID: 222)
  │           │   💬 Args: [no args]
  │           │   👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: ERC4337Helpers.getUserOpRevertReason(struct VmSafe.Log[],bytes32) (NodeID: 223)
  │           │   💬 Args: [logs, userOpHash]
  │           │   👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Unknown.getLabel(address) (NodeID: 224)
  │           │   💬 Args: [account]
  │           │   👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: ERC4337Helpers.checkRevertMessage(bytes) (NodeID: 225)
  │           │   💬 Args: [getUserOpRevertReason(logs, userOpHash)]
  │           │   👁️  Def: internal
  │           │ ├─ [8] ⚙️ FUNCTION: ERC4337Helpers.getUserOpRevertReason(struct VmSafe.Log[],bytes32) (NodeID: 228)
  │           │ │   💬 Args: [logs, userOpHash]
  │           │ │   👁️  Def: internal
  │           │ ├─ [8] ⚙️ FUNCTION: Unknown.getExpectRevertMessage() (NodeID: 226)
  │           │ │   💬 Args: [no args]
  │           │ │   👁️  Def: internal
  │           │ └─ [8] ⚙️ FUNCTION: ERC4337Helpers.parseFailedOpWithRevert(bytes,bytes) (NodeID: 227)
  │           │     💬 Args: [actualReason, revertMessage]
  │           │     👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Unknown.clearExpectRevert() (NodeID: 229)
  │           │   💬 Args: [no args]
  │           │   👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Unknown.writeInstalledModule(struct InstalledModule,address) (NodeID: 230)
  │           │   💬 Args: [InstalledModule(moduleType, module), logs[i].emitter]
  │           │   👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Unknown.getInstalledModules(address) (NodeID: 231)
  │           │   💬 Args: [logs[i].emitter]
  │           │   👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Unknown.removeInstalledModule(uint256,address) (NodeID: 232)
  │           │   💬 Args: [j, logs[i].emitter]
  │           │   👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Unknown.getGasIdentifier() (NodeID: 233)
  │           │   💬 Args: [no args]
  │           │   👁️  Def: internal
  │           │ └─ [8] ⚙️ FUNCTION: Unknown.readString(bytes32) (NodeID: 234)
  │           │     💬 Args: [slot]
  │           │     👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Helpers.envOr(string,bool) (NodeID: 235)
  │           │   💬 Args: ["GAS", false]
  │           │   👁️  Def: public
  │           └─ [7] ⚙️ FUNCTION: ERC4337Helpers.calculateGas(struct PackedUserOperation[],contract IEntryPoint,address,string,uint256) (NodeID: 236)
  │               💬 Args: [userOps, onEntryPoint, ctx.beneficiary, gasIdentifier, totalUserOpGas]
  │               👁️  Def: internal
  │             └─ [8] ⚙️ FUNCTION: GasParser.parseAndWriteGas(bytes,address,string,address,uint256) (NodeID: 237)
  │                 💬 Args: [userOpCalldata, address(onEntryPoint), gasIdentifier, userOps[0].sender, totalUserOpGas]
  │                 👁️  Def: internal
  │               ├─ [9] ⚙️ FUNCTION: Unknown.getArbitrumL1Gas(bytes) (NodeID: 238)
  │               │   💬 Args: [userOpCalldata]
  │               │   👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: LibZip.flzCompress(bytes) (NodeID: 239)
  │               │ │   💬 Args: [data]
  │               │ │   👁️  Def: internal
  │               │ └─ [10] ⚙️ FUNCTION: Unknown.getCallDataGas(bytes) (NodeID: 240)
  │               │     💬 Args: [compressed]
  │               │     👁️  Def: internal
  │               ├─ [9] ⚙️ FUNCTION: Unknown.getOpStackL1Gas(bytes) (NodeID: 241)
  │               │   💬 Args: [userOpCalldata]
  │               │   👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.ud(uint256) (NodeID: 242)
  │               │ │   💬 Args: [0.684e18]
  │               │ │   👁️  Def: internal
  │               │ └─ [10] ⚙️ FUNCTION: Unknown.intoUint256(UD60x18) (NodeID: 243)
  │               │     💬 Args: [PRBMathCastingUint256.intoUD60x18(getCallDataGas(data)).mul(opStackScalar)]
  │               │     👁️  Def: internal
  │               │   ├─ [11] ⚙️ FUNCTION: PRBMathCastingUint256.intoUD60x18(uint256) (NodeID: 244)
  │               │   │   💬 Args: [getCallDataGas(data)]
  │               │   │   👁️  Def: internal
  │               │   │ └─ [12] ⚙️ FUNCTION: Unknown.getCallDataGas(bytes) (NodeID: 245)
  │               │   │     💬 Args: [data]
  │               │   │     👁️  Def: internal
  │               │   └─ [11] ⚙️ FUNCTION: Unknown.mul(UD60x18,UD60x18) (NodeID: 246)
  │               │       💬 Args: [PRBMathCastingUint256.intoUD60x18(getCallDataGas(data)), opStackScalar]
  │               │       👁️  Def: internal
  │               │     └─ [12] ⚙️ FUNCTION: Unknown.wrap(uint256) (NodeID: 247)
  │               │         💬 Args: [Common.mulDiv18(x.unwrap(), y.unwrap())]
  │               │         👁️  Def: internal
  │               │       └─ [13] ⚙️ FUNCTION: Unknown.mulDiv18(uint256,uint256) (NodeID: 248)
  │               │           💬 Args: [Common, x.unwrap(), y.unwrap()]
  │               │           👁️  Def: internal
  │               │         ├─ [14] ⚙️ FUNCTION: Unknown.unwrap(UD60x18) (NodeID: 249)
  │               │         │   💬 Args: [x]
  │               │         │   👁️  Def: internal
  │               │         └─ [14] ⚙️ FUNCTION: Unknown.unwrap(UD60x18) (NodeID: 250)
  │               │             💬 Args: [y]
  │               │             👁️  Def: internal
  │               ├─ [9] ⚙️ FUNCTION: Unknown.exists(string) (NodeID: 251)
  │               │   💬 Args: [fileName]
  │               │   👁️  Def: internal
  │               ├─ [9] ⚙️ FUNCTION: Unknown.readFile(string) (NodeID: 252)
  │               │   💬 Args: [fileName]
  │               │   👁️  Def: internal
  │               ├─ [9] ⚙️ FUNCTION: Unknown.parsePrevGasReport(string) (NodeID: 253)
  │               │   💬 Args: [fileContent]
  │               │   👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 254)
  │               │ │   💬 Args: [parseJson(fileContent, ".Total")]
  │               │ │   👁️  Def: internal
  │               │ │ └─ [11] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 255)
  │               │ │     💬 Args: [fileContent, ".Total"]
  │               │ │     👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 256)
  │               │ │   💬 Args: [parseJson(fileContent, ".Phases.Creation")]
  │               │ │   👁️  Def: internal
  │               │ │ └─ [11] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 257)
  │               │ │     💬 Args: [fileContent, ".Phases.Creation"]
  │               │ │     👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 258)
  │               │ │   💬 Args: [parseJson(fileContent, ".Phases.Validation")]
  │               │ │   👁️  Def: internal
  │               │ │ └─ [11] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 259)
  │               │ │     💬 Args: [fileContent, ".Phases.Validation"]
  │               │ │     👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 260)
  │               │ │   💬 Args: [parseJson(fileContent, ".Phases.Execution")]
  │               │ │   👁️  Def: internal
  │               │ │ └─ [11] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 261)
  │               │ │     💬 Args: [fileContent, ".Phases.Execution"]
  │               │ │     👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 262)
  │               │ │   💬 Args: [parseJson(fileContent, ".Calldata.Arbitrum")]
  │               │ │   👁️  Def: internal
  │               │ │ └─ [11] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 263)
  │               │ │     💬 Args: [fileContent, ".Calldata.Arbitrum"]
  │               │ │     👁️  Def: internal
  │               │ └─ [10] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 264)
  │               │     💬 Args: [parseJson(fileContent, ".Calldata.OP-Stack")]
  │               │     👁️  Def: internal
  │               │   └─ [11] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 265)
  │               │       💬 Args: [fileContent, ".Calldata.OP-Stack"]
  │               │       👁️  Def: internal
  │               ├─ [9] ⚙️ FUNCTION: GasParser.formatGasToWrite(string,struct GasCalculations,struct GasCalculations) (NodeID: 266)
  │               │   💬 Args: [gasIdentifier, prevGasCalculations, gasCalculations]
  │               │   👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 267)
  │               │ │   💬 Args: [jsonObj, "Total", formatGasValue({prevValue: prevGasCalculations.total, newValue: gasCalculations.total})]
  │               │ │   👁️  Def: internal
  │               │ │ └─ [11] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 268)
  │               │ │     💬 Args: [prevGasCalculations.total, gasCalculations.total]
  │               │ │     👁️  Def: internal
  │               │ │   ├─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 269)
  │               │ │   │   💬 Args: [int256(newValue)]
  │               │ │   │   👁️  Def: internal
  │               │ │   │ └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 270)
  │               │ │   │     💬 Args: [value]
  │               │ │   │     👁️  Def: internal
  │               │ │   ├─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 271)
  │               │ │   │   💬 Args: [int256(newValue)]
  │               │ │   │   👁️  Def: internal
  │               │ │   │ └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 272)
  │               │ │   │     💬 Args: [value]
  │               │ │   │     👁️  Def: internal
  │               │ │   └─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 273)
  │               │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │               │ │       👁️  Def: internal
  │               │ │     └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 274)
  │               │ │         💬 Args: [value]
  │               │ │         👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 275)
  │               │ │   💬 Args: [phasesObj, "Creation", formatGasValue({prevValue: prevGasCalculations.creation, newValue: gasCalculations.creation})]
  │               │ │   👁️  Def: internal
  │               │ │ └─ [11] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 276)
  │               │ │     💬 Args: [prevGasCalculations.creation, gasCalculations.creation]
  │               │ │     👁️  Def: internal
  │               │ │   ├─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 277)
  │               │ │   │   💬 Args: [int256(newValue)]
  │               │ │   │   👁️  Def: internal
  │               │ │   │ └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 278)
  │               │ │   │     💬 Args: [value]
  │               │ │   │     👁️  Def: internal
  │               │ │   ├─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 279)
  │               │ │   │   💬 Args: [int256(newValue)]
  │               │ │   │   👁️  Def: internal
  │               │ │   │ └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 280)
  │               │ │   │     💬 Args: [value]
  │               │ │   │     👁️  Def: internal
  │               │ │   └─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 281)
  │               │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │               │ │       👁️  Def: internal
  │               │ │     └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 282)
  │               │ │         💬 Args: [value]
  │               │ │         👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 283)
  │               │ │   💬 Args: [phasesObj, "Validation", formatGasValue({prevValue: prevGasCalculations.validation, newValue: gasCalculations.validation})]
  │               │ │   👁️  Def: internal
  │               │ │ └─ [11] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 284)
  │               │ │     💬 Args: [prevGasCalculations.validation, gasCalculations.validation]
  │               │ │     👁️  Def: internal
  │               │ │   ├─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 285)
  │               │ │   │   💬 Args: [int256(newValue)]
  │               │ │   │   👁️  Def: internal
  │               │ │   │ └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 286)
  │               │ │   │     💬 Args: [value]
  │               │ │   │     👁️  Def: internal
  │               │ │   ├─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 287)
  │               │ │   │   💬 Args: [int256(newValue)]
  │               │ │   │   👁️  Def: internal
  │               │ │   │ └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 288)
  │               │ │   │     💬 Args: [value]
  │               │ │   │     👁️  Def: internal
  │               │ │   └─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 289)
  │               │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │               │ │       👁️  Def: internal
  │               │ │     └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 290)
  │               │ │         💬 Args: [value]
  │               │ │         👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 291)
  │               │ │   💬 Args: [phasesObj, "Execution", formatGasValue({prevValue: prevGasCalculations.execution, newValue: gasCalculations.execution})]
  │               │ │   👁️  Def: internal
  │               │ │ └─ [11] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 292)
  │               │ │     💬 Args: [prevGasCalculations.execution, gasCalculations.execution]
  │               │ │     👁️  Def: internal
  │               │ │   ├─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 293)
  │               │ │   │   💬 Args: [int256(newValue)]
  │               │ │   │   👁️  Def: internal
  │               │ │   │ └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 294)
  │               │ │   │     💬 Args: [value]
  │               │ │   │     👁️  Def: internal
  │               │ │   ├─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 295)
  │               │ │   │   💬 Args: [int256(newValue)]
  │               │ │   │   👁️  Def: internal
  │               │ │   │ └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 296)
  │               │ │   │     💬 Args: [value]
  │               │ │   │     👁️  Def: internal
  │               │ │   └─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 297)
  │               │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │               │ │       👁️  Def: internal
  │               │ │     └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 298)
  │               │ │         💬 Args: [value]
  │               │ │         👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 299)
  │               │ │   💬 Args: [l2sObj, "OP-Stack", formatGasValue({prevValue: prevGasCalculations.opStack, newValue: gasCalculations.opStack})]
  │               │ │   👁️  Def: internal
  │               │ │ └─ [11] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 300)
  │               │ │     💬 Args: [prevGasCalculations.opStack, gasCalculations.opStack]
  │               │ │     👁️  Def: internal
  │               │ │   ├─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 301)
  │               │ │   │   💬 Args: [int256(newValue)]
  │               │ │   │   👁️  Def: internal
  │               │ │   │ └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 302)
  │               │ │   │     💬 Args: [value]
  │               │ │   │     👁️  Def: internal
  │               │ │   ├─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 303)
  │               │ │   │   💬 Args: [int256(newValue)]
  │               │ │   │   👁️  Def: internal
  │               │ │   │ └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 304)
  │               │ │   │     💬 Args: [value]
  │               │ │   │     👁️  Def: internal
  │               │ │   └─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 305)
  │               │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │               │ │       👁️  Def: internal
  │               │ │     └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 306)
  │               │ │         💬 Args: [value]
  │               │ │         👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 307)
  │               │ │   💬 Args: [l2sObj, "Arbitrum", formatGasValue({prevValue: prevGasCalculations.arbitrum, newValue: gasCalculations.arbitrum})]
  │               │ │   👁️  Def: internal
  │               │ │ └─ [11] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 308)
  │               │ │     💬 Args: [prevGasCalculations.arbitrum, gasCalculations.arbitrum]
  │               │ │     👁️  Def: internal
  │               │ │   ├─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 309)
  │               │ │   │   💬 Args: [int256(newValue)]
  │               │ │   │   👁️  Def: internal
  │               │ │   │ └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 310)
  │               │ │   │     💬 Args: [value]
  │               │ │   │     👁️  Def: internal
  │               │ │   ├─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 311)
  │               │ │   │   💬 Args: [int256(newValue)]
  │               │ │   │   👁️  Def: internal
  │               │ │   │ └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 312)
  │               │ │   │     💬 Args: [value]
  │               │ │   │     👁️  Def: internal
  │               │ │   └─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 313)
  │               │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │               │ │       👁️  Def: internal
  │               │ │     └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 314)
  │               │ │         💬 Args: [value]
  │               │ │         👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 315)
  │               │ │   💬 Args: [jsonObj, "Phases", phasesOutput]
  │               │ │   👁️  Def: internal
  │               │ └─ [10] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 316)
  │               │     💬 Args: [jsonObj, "Calldata", l2sOutput]
  │               │     👁️  Def: internal
  │               ├─ [9] ⚙️ FUNCTION: Unknown.writeJson(string,string) (NodeID: 317)
  │               │   💬 Args: [finalJson, fileName]
  │               │   👁️  Def: internal
  │               └─ [9] ⚙️ FUNCTION: Unknown.writeGasIdentifier(string) (NodeID: 318)
  │                   💬 Args: [""]
  │                   👁️  Def: internal
  │                 └─ [10] ⚙️ FUNCTION: Unknown.writeString(bytes32,string) (NodeID: 319)
  │                     💬 Args: [slot, id]
  │                     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseSuperVaultTest._depositFreeAssetsFromSingleAmount5115(uint256,address,address) (NodeID: 320)
  │   💬 Args: [vars.deposit1Amount, address(strategy5115SuperVault), pendleEthenaAddress]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseTest._getHookAddress(uint64,string) (NodeID: 321)
  │ │   💬 Args: [ETH, APPROVE_AND_DEPOSIT_5115_VAULT_HOOK_KEY]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: HooksHelpers._createApproveAndDeposit5115HookData(bytes32,address,address,uint256,uint256,bool) (NodeID: 322)
  │ │   💬 Args: [_getYieldSourceOracleId(bytes32(bytes(ERC5115_YIELD_SOURCE_ORACLE_KEY)), MANAGER), underlyingVault, address(asset5115), depositAmount, 0, false]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: InternalHelpers._getYieldSourceOracleId(bytes32,address) (NodeID: 323)
  │ │     💬 Args: [bytes32(bytes(ERC5115_YIELD_SOURCE_ORACLE_KEY)), MANAGER]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: MerkleReader._getMerkleProofsForHooks(address[],bytes[]) (NodeID: 324)
  │ │   💬 Args: [fulfillHooksAddresses, argsForProofs]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseSuperVaultTest._getSuperVaultPricePerShare() (NodeID: 325)
  │ │   💬 Args: [no args]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256,enum Math.Rounding) (NodeID: 326)
  │ │     💬 Args: [totalAssetsVault, vault.PRECISION(), totalSupplyAmount, Math.Rounding.Floor]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 327)
  │ │   │   💬 Args: [unsignedRoundsUp(rounding) && (mulmod(x, y, denominator) > 0)]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: Math.unsignedRoundsUp(enum Math.Rounding) (NodeID: 328)
  │ │   │     💬 Args: [rounding]
  │ │   │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 329)
  │ │       💬 Args: [x, y, denominator]
  │ │       👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 330)
  │ │     │   💬 Args: [x, y]
  │ │     │   👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 331)
  │ │         💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 332)
  │ │           💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │ │           👁️  Def: internal
  │ │         └─ [7] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 333)
  │ │             💬 Args: [condition]
  │ │             👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 334)
  │ │   💬 Args: [depositAmount, strategy.PRECISION(), pricePerShare]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 335)
  │ │ │   💬 Args: [x, y]
  │ │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 336)
  │ │     💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 337)
  │ │       💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 338)
  │ │         💬 Args: [condition]
  │ │         👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: BaseSuperVaultTest._trackDeposit(address,uint256,uint256) (NodeID: 339)
  │     💬 Args: [accountEth, shares, depositAmount]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 340)
  │   💬 Args: [vars.shares1, 0, "no shares minted for deposit 1"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseSuperVaultTest._updateSuperVaultPPS(address,address) (NodeID: 341)
  │   💬 Args: [address(strategy5115SuperVault), address(sv5115)]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256,enum Math.Rounding) (NodeID: 342)
  │ │   💬 Args: [vars.currentTotalAssets, vars.precision, vars.totalSupplyAmount, Math.Rounding.Floor]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 343)
  │ │ │   💬 Args: [unsignedRoundsUp(rounding) && (mulmod(x, y, denominator) > 0)]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Math.unsignedRoundsUp(enum Math.Rounding) (NodeID: 344)
  │ │ │     💬 Args: [rounding]
  │ │ │     👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 345)
  │ │     💬 Args: [x, y, denominator]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 346)
  │ │   │   💬 Args: [x, y]
  │ │   │   👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 347)
  │ │       💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 348)
  │ │         💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 349)
  │ │           💬 Args: [condition]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: MessageHashUtils.toTypedDataHash(bytes32,bytes32) (NodeID: 350)
  │ │   💬 Args: [ecdsappsOracle.domainSeparator(), structHash]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: console.log(string,address,uint256) (NodeID: 351)
  │     💬 Args: ["Updated PPS for strategy", strategyAddr, vars.pps]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 352)
  │       💬 Args: [abi.encodeWithSignature("log(string,address,uint256)", p0, p1, p2)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 353)
  │         💬 Args: [_sendLogPayloadView]
  │         👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 354)
  │   💬 Args: [vars.ppsAfter, vars.ppsBefore]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdCheats.deal(address,address,uint256) (NodeID: 355)
  │   💬 Args: [address(asset5115), accountEth, vars.deposit2Amount]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdCheats.deal(address,address,uint256,bool) (NodeID: 356)
  │     💬 Args: [token, to, give, false]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: stdStorage.target(struct StdStorage,address) (NodeID: 357)
  │   │   💬 Args: [stdstore, token]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: stdStorageSafe.target(struct StdStorage,address) (NodeID: 358)
  │   │     💬 Args: [self, _target]
  │   │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: stdStorage.sig(struct StdStorage,bytes4) (NodeID: 359)
  │   │   💬 Args: [stdstore.target(token), 0x70a08231]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: stdStorageSafe.sig(struct StdStorage,bytes4) (NodeID: 360)
  │   │     💬 Args: [self, _sig]
  │   │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: stdStorage.with_key(struct StdStorage,address) (NodeID: 361)
  │   │   💬 Args: [stdstore.target(token).sig(0x70a08231), to]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: stdStorageSafe.with_key(struct StdStorage,address) (NodeID: 362)
  │   │     💬 Args: [self, who]
  │   │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,uint256) (NodeID: 363)
  │   │   💬 Args: [stdstore.target(token).sig(0x70a08231).with_key(to), give]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,bytes32) (NodeID: 364)
  │   │     💬 Args: [self, bytes32(amt)]
  │   │     👁️  Def: internal
  │   │   ├─ [5] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 365)
  │   │   │   💬 Args: [self]
  │   │   │   👁️  Def: internal
  │   │   │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 366)
  │   │   │     💬 Args: [self._keys]
  │   │   │     👁️  Def: private
  │   │   ├─ [5] ⚙️ FUNCTION: stdStorage.find(struct StdStorage,bool) (NodeID: 367)
  │   │   │   💬 Args: [self, false]
  │   │   │   👁️  Def: internal
  │   │   │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.find(struct StdStorage,bool) (NodeID: 368)
  │   │   │     💬 Args: [self, _clear]
  │   │   │     👁️  Def: internal
  │   │   │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 369)
  │   │   │   │   💬 Args: [self]
  │   │   │   │   👁️  Def: internal
  │   │   │   │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 370)
  │   │   │   │     💬 Args: [self._keys]
  │   │   │   │     👁️  Def: private
  │   │   │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 371)
  │   │   │   │   💬 Args: [self]
  │   │   │   │   👁️  Def: internal
  │   │   │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 372)
  │   │   │   │   💬 Args: [self]
  │   │   │   │   👁️  Def: internal
  │   │   │   │ ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 373)
  │   │   │   │ │   💬 Args: [self]
  │   │   │   │ │   👁️  Def: internal
  │   │   │   │ │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 374)
  │   │   │   │ │     💬 Args: [self._keys]
  │   │   │   │ │     👁️  Def: private
  │   │   │   │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 375)
  │   │   │   │     💬 Args: [rdat, 32 * self._depth]
  │   │   │   │     👁️  Def: private
  │   │   │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.checkSlotMutatesCall(struct StdStorage,bytes32) (NodeID: 376)
  │   │   │   │   💬 Args: [self, reads[i]]
  │   │   │   │   👁️  Def: internal
  │   │   │   │ ├─ [8] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 377)
  │   │   │   │ │   💬 Args: [self]
  │   │   │   │ │   👁️  Def: internal
  │   │   │   │ │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 378)
  │   │   │   │ │ │   💬 Args: [self]
  │   │   │   │ │ │   👁️  Def: internal
  │   │   │   │ │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 379)
  │   │   │   │ │ │     💬 Args: [self._keys]
  │   │   │   │ │ │     👁️  Def: private
  │   │   │   │ │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 380)
  │   │   │   │ │     💬 Args: [rdat, 32 * self._depth]
  │   │   │   │ │     👁️  Def: private
  │   │   │   │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 381)
  │   │   │   │     💬 Args: [self]
  │   │   │   │     👁️  Def: internal
  │   │   │   │   ├─ [9] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 382)
  │   │   │   │   │   💬 Args: [self]
  │   │   │   │   │   👁️  Def: internal
  │   │   │   │   │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 383)
  │   │   │   │   │     💬 Args: [self._keys]
  │   │   │   │   │     👁️  Def: private
  │   │   │   │   └─ [9] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 384)
  │   │   │   │       💬 Args: [rdat, 32 * self._depth]
  │   │   │   │       👁️  Def: private
  │   │   │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.findOffsets(struct StdStorage,bytes32) (NodeID: 385)
  │   │   │   │   💬 Args: [self, reads[i]]
  │   │   │   │   👁️  Def: internal
  │   │   │   │ ├─ [8] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 386)
  │   │   │   │ │   💬 Args: [self, slot, true]
  │   │   │   │ │   👁️  Def: internal
  │   │   │   │ │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 387)
  │   │   │   │ │     💬 Args: [self]
  │   │   │   │ │     👁️  Def: internal
  │   │   │   │ │   ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 388)
  │   │   │   │ │   │   💬 Args: [self]
  │   │   │   │ │   │   👁️  Def: internal
  │   │   │   │ │   │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 389)
  │   │   │   │ │   │     💬 Args: [self._keys]
  │   │   │   │ │   │     👁️  Def: private
  │   │   │   │ │   └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 390)
  │   │   │   │ │       💬 Args: [rdat, 32 * self._depth]
  │   │   │   │ │       👁️  Def: private
  │   │   │   │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 391)
  │   │   │   │     💬 Args: [self, slot, false]
  │   │   │   │     👁️  Def: internal
  │   │   │   │   └─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 392)
  │   │   │   │       💬 Args: [self]
  │   │   │   │       👁️  Def: internal
  │   │   │   │     ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 393)
  │   │   │   │     │   💬 Args: [self]
  │   │   │   │     │   👁️  Def: internal
  │   │   │   │     │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 394)
  │   │   │   │     │     💬 Args: [self._keys]
  │   │   │   │     │     👁️  Def: private
  │   │   │   │     └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 395)
  │   │   │   │         💬 Args: [rdat, 32 * self._depth]
  │   │   │   │         👁️  Def: private
  │   │   │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 396)
  │   │   │   │   💬 Args: [offsetLeft, offsetRight]
  │   │   │   │   👁️  Def: internal
  │   │   │   └─ [7] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 397)
  │   │   │       💬 Args: [self]
  │   │   │       👁️  Def: internal
  │   │   ├─ [5] ⚙️ FUNCTION: stdStorageSafe.getUpdatedSlotValue(bytes32,uint256,uint256,uint256) (NodeID: 398)
  │   │   │   💬 Args: [curVal, uint256(set), data.offsetLeft, data.offsetRight]
  │   │   │   👁️  Def: internal
  │   │   │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 399)
  │   │   │     💬 Args: [offsetLeft, offsetRight]
  │   │   │     👁️  Def: internal
  │   │   ├─ [5] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 400)
  │   │   │   💬 Args: [self]
  │   │   │   👁️  Def: internal
  │   │   │ ├─ [6] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 401)
  │   │   │ │   💬 Args: [self]
  │   │   │ │   👁️  Def: internal
  │   │   │ │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 402)
  │   │   │ │     💬 Args: [self._keys]
  │   │   │ │     👁️  Def: private
  │   │   │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 403)
  │   │   │     💬 Args: [rdat, 32 * self._depth]
  │   │   │     👁️  Def: private
  │   │   └─ [5] ⚙️ FUNCTION: stdStorage.clear(struct StdStorage) (NodeID: 404)
  │   │       💬 Args: [self]
  │   │       👁️  Def: internal
  │   │     └─ [6] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 405)
  │   │         💬 Args: [self]
  │   │         👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: stdStorage.target(struct StdStorage,address) (NodeID: 406)
  │   │   💬 Args: [stdstore, token]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: stdStorageSafe.target(struct StdStorage,address) (NodeID: 407)
  │   │     💬 Args: [self, _target]
  │   │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: stdStorage.sig(struct StdStorage,bytes4) (NodeID: 408)
  │   │   💬 Args: [stdstore.target(token), 0x18160ddd]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: stdStorageSafe.sig(struct StdStorage,bytes4) (NodeID: 409)
  │   │     💬 Args: [self, _sig]
  │   │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,uint256) (NodeID: 410)
  │       💬 Args: [stdstore.target(token).sig(0x18160ddd), totSup]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,bytes32) (NodeID: 411)
  │         💬 Args: [self, bytes32(amt)]
  │         👁️  Def: internal
  │       ├─ [5] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 412)
  │       │   💬 Args: [self]
  │       │   👁️  Def: internal
  │       │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 413)
  │       │     💬 Args: [self._keys]
  │       │     👁️  Def: private
  │       ├─ [5] ⚙️ FUNCTION: stdStorage.find(struct StdStorage,bool) (NodeID: 414)
  │       │   💬 Args: [self, false]
  │       │   👁️  Def: internal
  │       │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.find(struct StdStorage,bool) (NodeID: 415)
  │       │     💬 Args: [self, _clear]
  │       │     👁️  Def: internal
  │       │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 416)
  │       │   │   💬 Args: [self]
  │       │   │   👁️  Def: internal
  │       │   │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 417)
  │       │   │     💬 Args: [self._keys]
  │       │   │     👁️  Def: private
  │       │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 418)
  │       │   │   💬 Args: [self]
  │       │   │   👁️  Def: internal
  │       │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 419)
  │       │   │   💬 Args: [self]
  │       │   │   👁️  Def: internal
  │       │   │ ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 420)
  │       │   │ │   💬 Args: [self]
  │       │   │ │   👁️  Def: internal
  │       │   │ │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 421)
  │       │   │ │     💬 Args: [self._keys]
  │       │   │ │     👁️  Def: private
  │       │   │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 422)
  │       │   │     💬 Args: [rdat, 32 * self._depth]
  │       │   │     👁️  Def: private
  │       │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.checkSlotMutatesCall(struct StdStorage,bytes32) (NodeID: 423)
  │       │   │   💬 Args: [self, reads[i]]
  │       │   │   👁️  Def: internal
  │       │   │ ├─ [8] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 424)
  │       │   │ │   💬 Args: [self]
  │       │   │ │   👁️  Def: internal
  │       │   │ │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 425)
  │       │   │ │ │   💬 Args: [self]
  │       │   │ │ │   👁️  Def: internal
  │       │   │ │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 426)
  │       │   │ │ │     💬 Args: [self._keys]
  │       │   │ │ │     👁️  Def: private
  │       │   │ │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 427)
  │       │   │ │     💬 Args: [rdat, 32 * self._depth]
  │       │   │ │     👁️  Def: private
  │       │   │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 428)
  │       │   │     💬 Args: [self]
  │       │   │     👁️  Def: internal
  │       │   │   ├─ [9] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 429)
  │       │   │   │   💬 Args: [self]
  │       │   │   │   👁️  Def: internal
  │       │   │   │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 430)
  │       │   │   │     💬 Args: [self._keys]
  │       │   │   │     👁️  Def: private
  │       │   │   └─ [9] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 431)
  │       │   │       💬 Args: [rdat, 32 * self._depth]
  │       │   │       👁️  Def: private
  │       │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.findOffsets(struct StdStorage,bytes32) (NodeID: 432)
  │       │   │   💬 Args: [self, reads[i]]
  │       │   │   👁️  Def: internal
  │       │   │ ├─ [8] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 433)
  │       │   │ │   💬 Args: [self, slot, true]
  │       │   │ │   👁️  Def: internal
  │       │   │ │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 434)
  │       │   │ │     💬 Args: [self]
  │       │   │ │     👁️  Def: internal
  │       │   │ │   ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 435)
  │       │   │ │   │   💬 Args: [self]
  │       │   │ │   │   👁️  Def: internal
  │       │   │ │   │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 436)
  │       │   │ │   │     💬 Args: [self._keys]
  │       │   │ │   │     👁️  Def: private
  │       │   │ │   └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 437)
  │       │   │ │       💬 Args: [rdat, 32 * self._depth]
  │       │   │ │       👁️  Def: private
  │       │   │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 438)
  │       │   │     💬 Args: [self, slot, false]
  │       │   │     👁️  Def: internal
  │       │   │   └─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 439)
  │       │   │       💬 Args: [self]
  │       │   │       👁️  Def: internal
  │       │   │     ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 440)
  │       │   │     │   💬 Args: [self]
  │       │   │     │   👁️  Def: internal
  │       │   │     │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 441)
  │       │   │     │     💬 Args: [self._keys]
  │       │   │     │     👁️  Def: private
  │       │   │     └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 442)
  │       │   │         💬 Args: [rdat, 32 * self._depth]
  │       │   │         👁️  Def: private
  │       │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 443)
  │       │   │   💬 Args: [offsetLeft, offsetRight]
  │       │   │   👁️  Def: internal
  │       │   └─ [7] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 444)
  │       │       💬 Args: [self]
  │       │       👁️  Def: internal
  │       ├─ [5] ⚙️ FUNCTION: stdStorageSafe.getUpdatedSlotValue(bytes32,uint256,uint256,uint256) (NodeID: 445)
  │       │   💬 Args: [curVal, uint256(set), data.offsetLeft, data.offsetRight]
  │       │   👁️  Def: internal
  │       │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 446)
  │       │     💬 Args: [offsetLeft, offsetRight]
  │       │     👁️  Def: internal
  │       ├─ [5] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 447)
  │       │   💬 Args: [self]
  │       │   👁️  Def: internal
  │       │ ├─ [6] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 448)
  │       │ │   💬 Args: [self]
  │       │ │   👁️  Def: internal
  │       │ │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 449)
  │       │ │     💬 Args: [self._keys]
  │       │ │     👁️  Def: private
  │       │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 450)
  │       │     💬 Args: [rdat, 32 * self._depth]
  │       │     👁️  Def: private
  │       └─ [5] ⚙️ FUNCTION: stdStorage.clear(struct StdStorage) (NodeID: 451)
  │           💬 Args: [self]
  │           👁️  Def: internal
  │         └─ [6] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 452)
  │             💬 Args: [self]
  │             👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseSuperVaultTest._deposit(uint256,address,address) (NodeID: 453)
  │   💬 Args: [vars.deposit2Amount, address(sv5115), address(asset5115)]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: BaseSuperVaultTest.__deposit(struct AccountInstance,uint256,address,address) (NodeID: 454)
  │     💬 Args: [instanceOnEth, depositAmount, superVault, asset_]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: BaseTest._getHookAddress(uint64,string) (NodeID: 455)
  │   │   💬 Args: [ETH, APPROVE_AND_DEPOSIT_4626_VAULT_HOOK_KEY]
  │   │   👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: InternalHelpers._createApproveAndDeposit4626HookData(bytes32,address,address,uint256,bool,address,uint256) (NodeID: 456)
  │   │   💬 Args: [_getYieldSourceOracleId(bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), MANAGER), superVault, asset_, depositAmount, false, address(0), 0]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: InternalHelpers._getYieldSourceOracleId(bytes32,address) (NodeID: 457)
  │   │     💬 Args: [bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), MANAGER]
  │   │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: InternalHelpers._getExecOps(struct AccountInstance,contract ISuperExecutor,bytes) (NodeID: 458)
  │   │   💬 Args: [accInst, superExecutorOnEth, abi.encode(entry)]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: ModuleKitHelpers.getExecOps(struct AccountInstance,address,uint256,bytes,address) (NodeID: 459)
  │   │     💬 Args: [instance, address(superExecutor), 0, abi.encodeCall(superExecutor.execute, (data)), address(instance.defaultValidator)]
  │   │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: InternalHelpers.executeOp(struct UserOpData) (NodeID: 460)
  │       💬 Args: [userOpData]
  │       👁️  Def: public
  │     └─ [4] ⚙️ FUNCTION: ModuleKitHelpers.execUserOps(struct UserOpData) (NodeID: 461)
  │         💬 Args: [userOpData]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: ERC4337Helpers.exec4337(struct PackedUserOperation,contract IEntryPoint) (NodeID: 462)
  │           💬 Args: [userOpData.userOp, userOpData.entrypoint]
  │           👁️  Def: internal
  │         └─ [6] ⚙️ FUNCTION: ERC4337Helpers.exec4337(struct PackedUserOperation[],contract IEntryPoint) (NodeID: 463)
  │             💬 Args: [userOps, onEntryPoint]
  │             👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Unknown.getExpectRevert() (NodeID: 464)
  │           │   💬 Args: [no args]
  │           │   👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Unknown.getSimulateUserOp() (NodeID: 465)
  │           │   💬 Args: [no args]
  │           │   👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Helpers.envOr(string,bool) (NodeID: 466)
  │           │   💬 Args: ["SIMULATE", false]
  │           │   👁️  Def: public
  │           ├─ [7] ⚙️ FUNCTION: Simulator.simulateUserOp(struct PackedUserOperation,address) (NodeID: 467)
  │           │   💬 Args: [userOps[0], address(onEntryPoint)]
  │           │   👁️  Def: internal
  │           │ ├─ [8] ⚙️ FUNCTION: Simulator._preSimulation() (NodeID: 468)
  │           │ │   💬 Args: [no args]
  │           │ │   👁️  Def: internal
  │           │ │ ├─ [9] ⚙️ FUNCTION: Unknown.snapshotState() (NodeID: 469)
  │           │ │ │   💬 Args: [no args]
  │           │ │ │   👁️  Def: internal
  │           │ │ ├─ [9] ⚙️ FUNCTION: Unknown.startMappingRecording() (NodeID: 470)
  │           │ │ │   💬 Args: [no args]
  │           │ │ │   👁️  Def: internal
  │           │ │ └─ [9] ⚙️ FUNCTION: Unknown.startDebugTraceRecording() (NodeID: 471)
  │           │ │     💬 Args: [no args]
  │           │ │     👁️  Def: internal
  │           │ └─ [8] ⚙️ FUNCTION: Simulator._postSimulation(struct UserOperationDetails) (NodeID: 472)
  │           │     💬 Args: [userOpDetails]
  │           │     👁️  Def: internal
  │           │   ├─ [9] ⚙️ FUNCTION: Unknown.stopAndReturnDebugTraceRecording() (NodeID: 473)
  │           │   │   💬 Args: [no args]
  │           │   │   👁️  Def: internal
  │           │   ├─ [9] ⚙️ FUNCTION: ERC4337SpecsParser.parseValidation(struct UserOperationDetails,struct VmSafe.DebugStep[]) (NodeID: 474)
  │           │   │   💬 Args: [userOpDetails, debugTrace]
  │           │   │   👁️  Def: internal
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.getEntities(struct UserOperationDetails) (NodeID: 475)
  │           │   │ │   💬 Args: [userOpDetails]
  │           │   │ │   👁️  Def: internal
  │           │   │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isStaked(address,address) (NodeID: 476)
  │           │   │ │ │   💬 Args: [factory, userOpDetails.entryPoint]
  │           │   │ │ │   👁️  Def: internal
  │           │   │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isStaked(address,address) (NodeID: 477)
  │           │   │ │ │   💬 Args: [paymaster, userOpDetails.entryPoint]
  │           │   │ │ │   👁️  Def: internal
  │           │   │ │ └─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isStaked(address,address) (NodeID: 478)
  │           │   │ │     💬 Args: [aggregator, userOpDetails.entryPoint]
  │           │   │ │     👁️  Def: internal
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.filterDebugTrace(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,address) (NodeID: 479)
  │           │   │ │   💬 Args: [debugTrace, entities, userOpDetails.entryPoint]
  │           │   │ │   👁️  Def: private
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 480)
  │           │   │ │   💬 Args: [filteredUserOpSteps, entities]
  │           │   │ │   👁️  Def: internal
  │           │   │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isForbiddenOpcode(uint8) (NodeID: 481)
  │           │   │ │ │   💬 Args: [debugTrace[i].opcode]
  │           │   │ │ │   👁️  Def: private
  │           │   │ │ └─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isEntityAndStaked(struct ERC4337SpecsParser.Entities,address) (NodeID: 482)
  │           │   │ │     💬 Args: [entities, debugTrace[i].contractAddr]
  │           │   │ │     👁️  Def: internal
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 483)
  │           │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities]
  │           │   │ │   👁️  Def: internal
  │           │   │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isForbiddenOpcode(uint8) (NodeID: 484)
  │           │   │ │ │   💬 Args: [debugTrace[i].opcode]
  │           │   │ │ │   👁️  Def: private
  │           │   │ │ └─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isEntityAndStaked(struct ERC4337SpecsParser.Entities,address) (NodeID: 485)
  │           │   │ │     💬 Args: [entities, debugTrace[i].contractAddr]
  │           │   │ │     👁️  Def: internal
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.validateOutOfGas(struct VmSafe.DebugStep[]) (NodeID: 486)
  │           │   │ │   💬 Args: [filteredUserOpSteps]
  │           │   │ │   👁️  Def: internal
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.validateOutOfGas(struct VmSafe.DebugStep[]) (NodeID: 487)
  │           │   │ │   💬 Args: [filteredPaymasterUserOpSteps]
  │           │   │ │   👁️  Def: internal
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedStorageLocations(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 488)
  │           │   │ │   💬 Args: [filteredUserOpSteps, entities, userOpDetails]
  │           │   │ │   👁️  Def: internal
  │           │   │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isEntity(struct ERC4337SpecsParser.Entities,address) (NodeID: 489)
  │           │   │ │ │   💬 Args: [entities, currentAccessAccount]
  │           │   │ │ │   👁️  Def: internal
  │           │   │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 490)
  │           │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.account]
  │           │   │ │ │   👁️  Def: internal
  │           │   │ │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 491)
  │           │   │ │ │ │   💬 Args: [currentSlot, entity]
  │           │   │ │ │ │   👁️  Def: internal
  │           │   │ │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 492)
  │           │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │           │   │ │ │ │   👁️  Def: internal
  │           │   │ │ │ │ ├─ [13] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 493)
  │           │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │           │   │ │ │ │ │   👁️  Def: internal
  │           │   │ │ │ │ └─ [13] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 494)
  │           │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │           │   │ │ │ │     👁️  Def: internal
  │           │   │ │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 495)
  │           │   │ │ │     💬 Args: [key, entity]
  │           │   │ │ │     👁️  Def: internal
  │           │   │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 496)
  │           │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.paymaster]
  │           │   │ │ │   👁️  Def: internal
  │           │   │ │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 497)
  │           │   │ │ │ │   💬 Args: [currentSlot, entity]
  │           │   │ │ │ │   👁️  Def: internal
  │           │   │ │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 498)
  │           │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │           │   │ │ │ │   👁️  Def: internal
  │           │   │ │ │ │ ├─ [13] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 499)
  │           │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │           │   │ │ │ │ │   👁️  Def: internal
  │           │   │ │ │ │ └─ [13] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 500)
  │           │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │           │   │ │ │ │     👁️  Def: internal
  │           │   │ │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 501)
  │           │   │ │ │     💬 Args: [key, entity]
  │           │   │ │ │     👁️  Def: internal
  │           │   │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 502)
  │           │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.factory]
  │           │   │ │ │   👁️  Def: internal
  │           │   │ │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 503)
  │           │   │ │ │ │   💬 Args: [currentSlot, entity]
  │           │   │ │ │ │   👁️  Def: internal
  │           │   │ │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 504)
  │           │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │           │   │ │ │ │   👁️  Def: internal
  │           │   │ │ │ │ ├─ [13] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 505)
  │           │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │           │   │ │ │ │ │   👁️  Def: internal
  │           │   │ │ │ │ └─ [13] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 506)
  │           │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │           │   │ │ │ │     👁️  Def: internal
  │           │   │ │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 507)
  │           │   │ │ │     💬 Args: [key, entity]
  │           │   │ │ │     👁️  Def: internal
  │           │   │ │ └─ [11] ⚙️ FUNCTION: Unknown.getLabel(address) (NodeID: 508)
  │           │   │ │     💬 Args: [currentAccessAccount]
  │           │   │ │     👁️  Def: internal
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedStorageLocations(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 509)
  │           │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities, userOpDetails]
  │           │   │ │   👁️  Def: internal
  │           │   │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isEntity(struct ERC4337SpecsParser.Entities,address) (NodeID: 510)
  │           │   │ │ │   💬 Args: [entities, currentAccessAccount]
  │           │   │ │ │   👁️  Def: internal
  │           │   │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 511)
  │           │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.account]
  │           │   │ │ │   👁️  Def: internal
  │           │   │ │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 512)
  │           │   │ │ │ │   💬 Args: [currentSlot, entity]
  │           │   │ │ │ │   👁️  Def: internal
  │           │   │ │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 513)
  │           │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │           │   │ │ │ │   👁️  Def: internal
  │           │   │ │ │ │ ├─ [13] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 514)
  │           │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │           │   │ │ │ │ │   👁️  Def: internal
  │           │   │ │ │ │ └─ [13] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 515)
  │           │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │           │   │ │ │ │     👁️  Def: internal
  │           │   │ │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 516)
  │           │   │ │ │     💬 Args: [key, entity]
  │           │   │ │ │     👁️  Def: internal
  │           │   │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 517)
  │           │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.paymaster]
  │           │   │ │ │   👁️  Def: internal
  │           │   │ │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 518)
  │           │   │ │ │ │   💬 Args: [currentSlot, entity]
  │           │   │ │ │ │   👁️  Def: internal
  │           │   │ │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 519)
  │           │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │           │   │ │ │ │   👁️  Def: internal
  │           │   │ │ │ │ ├─ [13] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 520)
  │           │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │           │   │ │ │ │ │   👁️  Def: internal
  │           │   │ │ │ │ └─ [13] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 521)
  │           │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │           │   │ │ │ │     👁️  Def: internal
  │           │   │ │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 522)
  │           │   │ │ │     💬 Args: [key, entity]
  │           │   │ │ │     👁️  Def: internal
  │           │   │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 523)
  │           │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.factory]
  │           │   │ │ │   👁️  Def: internal
  │           │   │ │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 524)
  │           │   │ │ │ │   💬 Args: [currentSlot, entity]
  │           │   │ │ │ │   👁️  Def: internal
  │           │   │ │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 525)
  │           │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │           │   │ │ │ │   👁️  Def: internal
  │           │   │ │ │ │ ├─ [13] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 526)
  │           │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │           │   │ │ │ │ │   👁️  Def: internal
  │           │   │ │ │ │ └─ [13] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 527)
  │           │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │           │   │ │ │ │     👁️  Def: internal
  │           │   │ │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 528)
  │           │   │ │ │     💬 Args: [key, entity]
  │           │   │ │ │     👁️  Def: internal
  │           │   │ │ └─ [11] ⚙️ FUNCTION: Unknown.getLabel(address) (NodeID: 529)
  │           │   │ │     💬 Args: [currentAccessAccount]
  │           │   │ │     👁️  Def: internal
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.validateCalls(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,address) (NodeID: 530)
  │           │   │ │   💬 Args: [filteredUserOpSteps, entities, userOpDetails.entryPoint]
  │           │   │ │   👁️  Def: internal
  │           │   │ │ └─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 531)
  │           │   │ │     💬 Args: [targetAddr]
  │           │   │ │     👁️  Def: internal
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.validateCalls(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,address) (NodeID: 532)
  │           │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities, userOpDetails.entryPoint]
  │           │   │ │   👁️  Def: internal
  │           │   │ │ └─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 533)
  │           │   │ │     💬 Args: [targetAddr]
  │           │   │ │     👁️  Def: internal
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.validateExtOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 534)
  │           │   │ │   💬 Args: [filteredUserOpSteps, entities]
  │           │   │ │   👁️  Def: internal
  │           │   │ │ └─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 535)
  │           │   │ │     💬 Args: [targetAddr]
  │           │   │ │     👁️  Def: internal
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.validateExtOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 536)
  │           │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities]
  │           │   │ │   👁️  Def: internal
  │           │   │ │ └─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 537)
  │           │   │ │     💬 Args: [targetAddr]
  │           │   │ │     👁️  Def: internal
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.validateCreate(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 538)
  │           │   │ │   💬 Args: [filteredUserOpSteps, entities, userOpDetails]
  │           │   │ │   👁️  Def: internal
  │           │   │ └─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.validateCreate(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 539)
  │           │   │     💬 Args: [filteredPaymasterUserOpSteps, entities, userOpDetails]
  │           │   │     👁️  Def: internal
  │           │   ├─ [9] ⚙️ FUNCTION: Unknown.stopMappingRecording() (NodeID: 540)
  │           │   │   💬 Args: [no args]
  │           │   │   👁️  Def: internal
  │           │   └─ [9] ⚙️ FUNCTION: Unknown.revertToState(uint256) (NodeID: 541)
  │           │       💬 Args: [snapShotId]
  │           │       👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Unknown.recordLogs() (NodeID: 542)
  │           │   💬 Args: [no args]
  │           │   👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: ERC4337Helpers.checkRevertMessage(bytes) (NodeID: 543)
  │           │   💬 Args: [ctx.returnData]
  │           │   👁️  Def: internal
  │           │ ├─ [8] ⚙️ FUNCTION: Unknown.getExpectRevertMessage() (NodeID: 544)
  │           │ │   💬 Args: [no args]
  │           │ │   👁️  Def: internal
  │           │ └─ [8] ⚙️ FUNCTION: ERC4337Helpers.parseFailedOpWithRevert(bytes,bytes) (NodeID: 545)
  │           │     💬 Args: [actualReason, revertMessage]
  │           │     👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Unknown.getRecordedLogs() (NodeID: 546)
  │           │   💬 Args: [no args]
  │           │   👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: ERC4337Helpers.getUserOpRevertReason(struct VmSafe.Log[],bytes32) (NodeID: 547)
  │           │   💬 Args: [logs, userOpHash]
  │           │   👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Unknown.getLabel(address) (NodeID: 548)
  │           │   💬 Args: [account]
  │           │   👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: ERC4337Helpers.checkRevertMessage(bytes) (NodeID: 549)
  │           │   💬 Args: [getUserOpRevertReason(logs, userOpHash)]
  │           │   👁️  Def: internal
  │           │ ├─ [8] ⚙️ FUNCTION: ERC4337Helpers.getUserOpRevertReason(struct VmSafe.Log[],bytes32) (NodeID: 552)
  │           │ │   💬 Args: [logs, userOpHash]
  │           │ │   👁️  Def: internal
  │           │ ├─ [8] ⚙️ FUNCTION: Unknown.getExpectRevertMessage() (NodeID: 550)
  │           │ │   💬 Args: [no args]
  │           │ │   👁️  Def: internal
  │           │ └─ [8] ⚙️ FUNCTION: ERC4337Helpers.parseFailedOpWithRevert(bytes,bytes) (NodeID: 551)
  │           │     💬 Args: [actualReason, revertMessage]
  │           │     👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Unknown.clearExpectRevert() (NodeID: 553)
  │           │   💬 Args: [no args]
  │           │   👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Unknown.writeInstalledModule(struct InstalledModule,address) (NodeID: 554)
  │           │   💬 Args: [InstalledModule(moduleType, module), logs[i].emitter]
  │           │   👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Unknown.getInstalledModules(address) (NodeID: 555)
  │           │   💬 Args: [logs[i].emitter]
  │           │   👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Unknown.removeInstalledModule(uint256,address) (NodeID: 556)
  │           │   💬 Args: [j, logs[i].emitter]
  │           │   👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Unknown.getGasIdentifier() (NodeID: 557)
  │           │   💬 Args: [no args]
  │           │   👁️  Def: internal
  │           │ └─ [8] ⚙️ FUNCTION: Unknown.readString(bytes32) (NodeID: 558)
  │           │     💬 Args: [slot]
  │           │     👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Helpers.envOr(string,bool) (NodeID: 559)
  │           │   💬 Args: ["GAS", false]
  │           │   👁️  Def: public
  │           └─ [7] ⚙️ FUNCTION: ERC4337Helpers.calculateGas(struct PackedUserOperation[],contract IEntryPoint,address,string,uint256) (NodeID: 560)
  │               💬 Args: [userOps, onEntryPoint, ctx.beneficiary, gasIdentifier, totalUserOpGas]
  │               👁️  Def: internal
  │             └─ [8] ⚙️ FUNCTION: GasParser.parseAndWriteGas(bytes,address,string,address,uint256) (NodeID: 561)
  │                 💬 Args: [userOpCalldata, address(onEntryPoint), gasIdentifier, userOps[0].sender, totalUserOpGas]
  │                 👁️  Def: internal
  │               ├─ [9] ⚙️ FUNCTION: Unknown.getArbitrumL1Gas(bytes) (NodeID: 562)
  │               │   💬 Args: [userOpCalldata]
  │               │   👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: LibZip.flzCompress(bytes) (NodeID: 563)
  │               │ │   💬 Args: [data]
  │               │ │   👁️  Def: internal
  │               │ └─ [10] ⚙️ FUNCTION: Unknown.getCallDataGas(bytes) (NodeID: 564)
  │               │     💬 Args: [compressed]
  │               │     👁️  Def: internal
  │               ├─ [9] ⚙️ FUNCTION: Unknown.getOpStackL1Gas(bytes) (NodeID: 565)
  │               │   💬 Args: [userOpCalldata]
  │               │   👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.ud(uint256) (NodeID: 566)
  │               │ │   💬 Args: [0.684e18]
  │               │ │   👁️  Def: internal
  │               │ └─ [10] ⚙️ FUNCTION: Unknown.intoUint256(UD60x18) (NodeID: 567)
  │               │     💬 Args: [PRBMathCastingUint256.intoUD60x18(getCallDataGas(data)).mul(opStackScalar)]
  │               │     👁️  Def: internal
  │               │   ├─ [11] ⚙️ FUNCTION: PRBMathCastingUint256.intoUD60x18(uint256) (NodeID: 568)
  │               │   │   💬 Args: [getCallDataGas(data)]
  │               │   │   👁️  Def: internal
  │               │   │ └─ [12] ⚙️ FUNCTION: Unknown.getCallDataGas(bytes) (NodeID: 569)
  │               │   │     💬 Args: [data]
  │               │   │     👁️  Def: internal
  │               │   └─ [11] ⚙️ FUNCTION: Unknown.mul(UD60x18,UD60x18) (NodeID: 570)
  │               │       💬 Args: [PRBMathCastingUint256.intoUD60x18(getCallDataGas(data)), opStackScalar]
  │               │       👁️  Def: internal
  │               │     └─ [12] ⚙️ FUNCTION: Unknown.wrap(uint256) (NodeID: 571)
  │               │         💬 Args: [Common.mulDiv18(x.unwrap(), y.unwrap())]
  │               │         👁️  Def: internal
  │               │       └─ [13] ⚙️ FUNCTION: Unknown.mulDiv18(uint256,uint256) (NodeID: 572)
  │               │           💬 Args: [Common, x.unwrap(), y.unwrap()]
  │               │           👁️  Def: internal
  │               │         ├─ [14] ⚙️ FUNCTION: Unknown.unwrap(UD60x18) (NodeID: 573)
  │               │         │   💬 Args: [x]
  │               │         │   👁️  Def: internal
  │               │         └─ [14] ⚙️ FUNCTION: Unknown.unwrap(UD60x18) (NodeID: 574)
  │               │             💬 Args: [y]
  │               │             👁️  Def: internal
  │               ├─ [9] ⚙️ FUNCTION: Unknown.exists(string) (NodeID: 575)
  │               │   💬 Args: [fileName]
  │               │   👁️  Def: internal
  │               ├─ [9] ⚙️ FUNCTION: Unknown.readFile(string) (NodeID: 576)
  │               │   💬 Args: [fileName]
  │               │   👁️  Def: internal
  │               ├─ [9] ⚙️ FUNCTION: Unknown.parsePrevGasReport(string) (NodeID: 577)
  │               │   💬 Args: [fileContent]
  │               │   👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 578)
  │               │ │   💬 Args: [parseJson(fileContent, ".Total")]
  │               │ │   👁️  Def: internal
  │               │ │ └─ [11] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 579)
  │               │ │     💬 Args: [fileContent, ".Total"]
  │               │ │     👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 580)
  │               │ │   💬 Args: [parseJson(fileContent, ".Phases.Creation")]
  │               │ │   👁️  Def: internal
  │               │ │ └─ [11] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 581)
  │               │ │     💬 Args: [fileContent, ".Phases.Creation"]
  │               │ │     👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 582)
  │               │ │   💬 Args: [parseJson(fileContent, ".Phases.Validation")]
  │               │ │   👁️  Def: internal
  │               │ │ └─ [11] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 583)
  │               │ │     💬 Args: [fileContent, ".Phases.Validation"]
  │               │ │     👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 584)
  │               │ │   💬 Args: [parseJson(fileContent, ".Phases.Execution")]
  │               │ │   👁️  Def: internal
  │               │ │ └─ [11] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 585)
  │               │ │     💬 Args: [fileContent, ".Phases.Execution"]
  │               │ │     👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 586)
  │               │ │   💬 Args: [parseJson(fileContent, ".Calldata.Arbitrum")]
  │               │ │   👁️  Def: internal
  │               │ │ └─ [11] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 587)
  │               │ │     💬 Args: [fileContent, ".Calldata.Arbitrum"]
  │               │ │     👁️  Def: internal
  │               │ └─ [10] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 588)
  │               │     💬 Args: [parseJson(fileContent, ".Calldata.OP-Stack")]
  │               │     👁️  Def: internal
  │               │   └─ [11] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 589)
  │               │       💬 Args: [fileContent, ".Calldata.OP-Stack"]
  │               │       👁️  Def: internal
  │               ├─ [9] ⚙️ FUNCTION: GasParser.formatGasToWrite(string,struct GasCalculations,struct GasCalculations) (NodeID: 590)
  │               │   💬 Args: [gasIdentifier, prevGasCalculations, gasCalculations]
  │               │   👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 591)
  │               │ │   💬 Args: [jsonObj, "Total", formatGasValue({prevValue: prevGasCalculations.total, newValue: gasCalculations.total})]
  │               │ │   👁️  Def: internal
  │               │ │ └─ [11] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 592)
  │               │ │     💬 Args: [prevGasCalculations.total, gasCalculations.total]
  │               │ │     👁️  Def: internal
  │               │ │   ├─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 593)
  │               │ │   │   💬 Args: [int256(newValue)]
  │               │ │   │   👁️  Def: internal
  │               │ │   │ └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 594)
  │               │ │   │     💬 Args: [value]
  │               │ │   │     👁️  Def: internal
  │               │ │   ├─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 595)
  │               │ │   │   💬 Args: [int256(newValue)]
  │               │ │   │   👁️  Def: internal
  │               │ │   │ └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 596)
  │               │ │   │     💬 Args: [value]
  │               │ │   │     👁️  Def: internal
  │               │ │   └─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 597)
  │               │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │               │ │       👁️  Def: internal
  │               │ │     └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 598)
  │               │ │         💬 Args: [value]
  │               │ │         👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 599)
  │               │ │   💬 Args: [phasesObj, "Creation", formatGasValue({prevValue: prevGasCalculations.creation, newValue: gasCalculations.creation})]
  │               │ │   👁️  Def: internal
  │               │ │ └─ [11] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 600)
  │               │ │     💬 Args: [prevGasCalculations.creation, gasCalculations.creation]
  │               │ │     👁️  Def: internal
  │               │ │   ├─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 601)
  │               │ │   │   💬 Args: [int256(newValue)]
  │               │ │   │   👁️  Def: internal
  │               │ │   │ └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 602)
  │               │ │   │     💬 Args: [value]
  │               │ │   │     👁️  Def: internal
  │               │ │   ├─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 603)
  │               │ │   │   💬 Args: [int256(newValue)]
  │               │ │   │   👁️  Def: internal
  │               │ │   │ └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 604)
  │               │ │   │     💬 Args: [value]
  │               │ │   │     👁️  Def: internal
  │               │ │   └─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 605)
  │               │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │               │ │       👁️  Def: internal
  │               │ │     └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 606)
  │               │ │         💬 Args: [value]
  │               │ │         👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 607)
  │               │ │   💬 Args: [phasesObj, "Validation", formatGasValue({prevValue: prevGasCalculations.validation, newValue: gasCalculations.validation})]
  │               │ │   👁️  Def: internal
  │               │ │ └─ [11] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 608)
  │               │ │     💬 Args: [prevGasCalculations.validation, gasCalculations.validation]
  │               │ │     👁️  Def: internal
  │               │ │   ├─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 609)
  │               │ │   │   💬 Args: [int256(newValue)]
  │               │ │   │   👁️  Def: internal
  │               │ │   │ └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 610)
  │               │ │   │     💬 Args: [value]
  │               │ │   │     👁️  Def: internal
  │               │ │   ├─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 611)
  │               │ │   │   💬 Args: [int256(newValue)]
  │               │ │   │   👁️  Def: internal
  │               │ │   │ └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 612)
  │               │ │   │     💬 Args: [value]
  │               │ │   │     👁️  Def: internal
  │               │ │   └─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 613)
  │               │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │               │ │       👁️  Def: internal
  │               │ │     └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 614)
  │               │ │         💬 Args: [value]
  │               │ │         👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 615)
  │               │ │   💬 Args: [phasesObj, "Execution", formatGasValue({prevValue: prevGasCalculations.execution, newValue: gasCalculations.execution})]
  │               │ │   👁️  Def: internal
  │               │ │ └─ [11] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 616)
  │               │ │     💬 Args: [prevGasCalculations.execution, gasCalculations.execution]
  │               │ │     👁️  Def: internal
  │               │ │   ├─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 617)
  │               │ │   │   💬 Args: [int256(newValue)]
  │               │ │   │   👁️  Def: internal
  │               │ │   │ └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 618)
  │               │ │   │     💬 Args: [value]
  │               │ │   │     👁️  Def: internal
  │               │ │   ├─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 619)
  │               │ │   │   💬 Args: [int256(newValue)]
  │               │ │   │   👁️  Def: internal
  │               │ │   │ └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 620)
  │               │ │   │     💬 Args: [value]
  │               │ │   │     👁️  Def: internal
  │               │ │   └─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 621)
  │               │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │               │ │       👁️  Def: internal
  │               │ │     └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 622)
  │               │ │         💬 Args: [value]
  │               │ │         👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 623)
  │               │ │   💬 Args: [l2sObj, "OP-Stack", formatGasValue({prevValue: prevGasCalculations.opStack, newValue: gasCalculations.opStack})]
  │               │ │   👁️  Def: internal
  │               │ │ └─ [11] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 624)
  │               │ │     💬 Args: [prevGasCalculations.opStack, gasCalculations.opStack]
  │               │ │     👁️  Def: internal
  │               │ │   ├─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 625)
  │               │ │   │   💬 Args: [int256(newValue)]
  │               │ │   │   👁️  Def: internal
  │               │ │   │ └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 626)
  │               │ │   │     💬 Args: [value]
  │               │ │   │     👁️  Def: internal
  │               │ │   ├─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 627)
  │               │ │   │   💬 Args: [int256(newValue)]
  │               │ │   │   👁️  Def: internal
  │               │ │   │ └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 628)
  │               │ │   │     💬 Args: [value]
  │               │ │   │     👁️  Def: internal
  │               │ │   └─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 629)
  │               │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │               │ │       👁️  Def: internal
  │               │ │     └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 630)
  │               │ │         💬 Args: [value]
  │               │ │         👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 631)
  │               │ │   💬 Args: [l2sObj, "Arbitrum", formatGasValue({prevValue: prevGasCalculations.arbitrum, newValue: gasCalculations.arbitrum})]
  │               │ │   👁️  Def: internal
  │               │ │ └─ [11] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 632)
  │               │ │     💬 Args: [prevGasCalculations.arbitrum, gasCalculations.arbitrum]
  │               │ │     👁️  Def: internal
  │               │ │   ├─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 633)
  │               │ │   │   💬 Args: [int256(newValue)]
  │               │ │   │   👁️  Def: internal
  │               │ │   │ └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 634)
  │               │ │   │     💬 Args: [value]
  │               │ │   │     👁️  Def: internal
  │               │ │   ├─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 635)
  │               │ │   │   💬 Args: [int256(newValue)]
  │               │ │   │   👁️  Def: internal
  │               │ │   │ └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 636)
  │               │ │   │     💬 Args: [value]
  │               │ │   │     👁️  Def: internal
  │               │ │   └─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 637)
  │               │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │               │ │       👁️  Def: internal
  │               │ │     └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 638)
  │               │ │         💬 Args: [value]
  │               │ │         👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 639)
  │               │ │   💬 Args: [jsonObj, "Phases", phasesOutput]
  │               │ │   👁️  Def: internal
  │               │ └─ [10] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 640)
  │               │     💬 Args: [jsonObj, "Calldata", l2sOutput]
  │               │     👁️  Def: internal
  │               ├─ [9] ⚙️ FUNCTION: Unknown.writeJson(string,string) (NodeID: 641)
  │               │   💬 Args: [finalJson, fileName]
  │               │   👁️  Def: internal
  │               └─ [9] ⚙️ FUNCTION: Unknown.writeGasIdentifier(string) (NodeID: 642)
  │                   💬 Args: [""]
  │                   👁️  Def: internal
  │                 └─ [10] ⚙️ FUNCTION: Unknown.writeString(bytes32,string) (NodeID: 643)
  │                     💬 Args: [slot, id]
  │                     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseSuperVaultTest._depositFreeAssetsFromSingleAmount5115(uint256,address,address) (NodeID: 644)
  │   💬 Args: [vars.deposit2Amount, address(strategy5115SuperVault), pendleEthenaAddress]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseTest._getHookAddress(uint64,string) (NodeID: 645)
  │ │   💬 Args: [ETH, APPROVE_AND_DEPOSIT_5115_VAULT_HOOK_KEY]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: HooksHelpers._createApproveAndDeposit5115HookData(bytes32,address,address,uint256,uint256,bool) (NodeID: 646)
  │ │   💬 Args: [_getYieldSourceOracleId(bytes32(bytes(ERC5115_YIELD_SOURCE_ORACLE_KEY)), MANAGER), underlyingVault, address(asset5115), depositAmount, 0, false]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: InternalHelpers._getYieldSourceOracleId(bytes32,address) (NodeID: 647)
  │ │     💬 Args: [bytes32(bytes(ERC5115_YIELD_SOURCE_ORACLE_KEY)), MANAGER]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: MerkleReader._getMerkleProofsForHooks(address[],bytes[]) (NodeID: 648)
  │ │   💬 Args: [fulfillHooksAddresses, argsForProofs]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseSuperVaultTest._getSuperVaultPricePerShare() (NodeID: 649)
  │ │   💬 Args: [no args]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256,enum Math.Rounding) (NodeID: 650)
  │ │     💬 Args: [totalAssetsVault, vault.PRECISION(), totalSupplyAmount, Math.Rounding.Floor]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 651)
  │ │   │   💬 Args: [unsignedRoundsUp(rounding) && (mulmod(x, y, denominator) > 0)]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: Math.unsignedRoundsUp(enum Math.Rounding) (NodeID: 652)
  │ │   │     💬 Args: [rounding]
  │ │   │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 653)
  │ │       💬 Args: [x, y, denominator]
  │ │       👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 654)
  │ │     │   💬 Args: [x, y]
  │ │     │   👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 655)
  │ │         💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 656)
  │ │           💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │ │           👁️  Def: internal
  │ │         └─ [7] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 657)
  │ │             💬 Args: [condition]
  │ │             👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 658)
  │ │   💬 Args: [depositAmount, strategy.PRECISION(), pricePerShare]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 659)
  │ │ │   💬 Args: [x, y]
  │ │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 660)
  │ │     💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 661)
  │ │       💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 662)
  │ │         💬 Args: [condition]
  │ │         👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: BaseSuperVaultTest._trackDeposit(address,uint256,uint256) (NodeID: 663)
  │     💬 Args: [accountEth, shares, depositAmount]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 664)
  │   💬 Args: [vars.shares2, 0, "no shares minted for deposit 2"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 665)
  │   💬 Args: [vars.shares2, vars.shares1, "less shares than it should - deposit 2"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseSuperVaultTest._updateSuperVaultPPS(address,address) (NodeID: 666)
  │   💬 Args: [address(strategy5115SuperVault), address(sv5115)]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256,enum Math.Rounding) (NodeID: 667)
  │ │   💬 Args: [vars.currentTotalAssets, vars.precision, vars.totalSupplyAmount, Math.Rounding.Floor]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 668)
  │ │ │   💬 Args: [unsignedRoundsUp(rounding) && (mulmod(x, y, denominator) > 0)]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Math.unsignedRoundsUp(enum Math.Rounding) (NodeID: 669)
  │ │ │     💬 Args: [rounding]
  │ │ │     👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 670)
  │ │     💬 Args: [x, y, denominator]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 671)
  │ │   │   💬 Args: [x, y]
  │ │   │   👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 672)
  │ │       💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 673)
  │ │         💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 674)
  │ │           💬 Args: [condition]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: MessageHashUtils.toTypedDataHash(bytes32,bytes32) (NodeID: 675)
  │ │   💬 Args: [ecdsappsOracle.domainSeparator(), structHash]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: console.log(string,address,uint256) (NodeID: 676)
  │     💬 Args: ["Updated PPS for strategy", strategyAddr, vars.pps]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 677)
  │       💬 Args: [abi.encodeWithSignature("log(string,address,uint256)", p0, p1, p2)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 678)
  │         💬 Args: [_sendLogPayloadView]
  │         👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 679)
  │   💬 Args: [vars.ppsAfter, vars.ppsBefore]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdCheats.deal(address,address,uint256) (NodeID: 680)
  │   💬 Args: [address(asset5115), accountEth, vars.deposit3Amount]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdCheats.deal(address,address,uint256,bool) (NodeID: 681)
  │     💬 Args: [token, to, give, false]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: stdStorage.target(struct StdStorage,address) (NodeID: 682)
  │   │   💬 Args: [stdstore, token]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: stdStorageSafe.target(struct StdStorage,address) (NodeID: 683)
  │   │     💬 Args: [self, _target]
  │   │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: stdStorage.sig(struct StdStorage,bytes4) (NodeID: 684)
  │   │   💬 Args: [stdstore.target(token), 0x70a08231]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: stdStorageSafe.sig(struct StdStorage,bytes4) (NodeID: 685)
  │   │     💬 Args: [self, _sig]
  │   │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: stdStorage.with_key(struct StdStorage,address) (NodeID: 686)
  │   │   💬 Args: [stdstore.target(token).sig(0x70a08231), to]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: stdStorageSafe.with_key(struct StdStorage,address) (NodeID: 687)
  │   │     💬 Args: [self, who]
  │   │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,uint256) (NodeID: 688)
  │   │   💬 Args: [stdstore.target(token).sig(0x70a08231).with_key(to), give]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,bytes32) (NodeID: 689)
  │   │     💬 Args: [self, bytes32(amt)]
  │   │     👁️  Def: internal
  │   │   ├─ [5] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 690)
  │   │   │   💬 Args: [self]
  │   │   │   👁️  Def: internal
  │   │   │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 691)
  │   │   │     💬 Args: [self._keys]
  │   │   │     👁️  Def: private
  │   │   ├─ [5] ⚙️ FUNCTION: stdStorage.find(struct StdStorage,bool) (NodeID: 692)
  │   │   │   💬 Args: [self, false]
  │   │   │   👁️  Def: internal
  │   │   │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.find(struct StdStorage,bool) (NodeID: 693)
  │   │   │     💬 Args: [self, _clear]
  │   │   │     👁️  Def: internal
  │   │   │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 694)
  │   │   │   │   💬 Args: [self]
  │   │   │   │   👁️  Def: internal
  │   │   │   │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 695)
  │   │   │   │     💬 Args: [self._keys]
  │   │   │   │     👁️  Def: private
  │   │   │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 696)
  │   │   │   │   💬 Args: [self]
  │   │   │   │   👁️  Def: internal
  │   │   │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 697)
  │   │   │   │   💬 Args: [self]
  │   │   │   │   👁️  Def: internal
  │   │   │   │ ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 698)
  │   │   │   │ │   💬 Args: [self]
  │   │   │   │ │   👁️  Def: internal
  │   │   │   │ │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 699)
  │   │   │   │ │     💬 Args: [self._keys]
  │   │   │   │ │     👁️  Def: private
  │   │   │   │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 700)
  │   │   │   │     💬 Args: [rdat, 32 * self._depth]
  │   │   │   │     👁️  Def: private
  │   │   │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.checkSlotMutatesCall(struct StdStorage,bytes32) (NodeID: 701)
  │   │   │   │   💬 Args: [self, reads[i]]
  │   │   │   │   👁️  Def: internal
  │   │   │   │ ├─ [8] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 702)
  │   │   │   │ │   💬 Args: [self]
  │   │   │   │ │   👁️  Def: internal
  │   │   │   │ │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 703)
  │   │   │   │ │ │   💬 Args: [self]
  │   │   │   │ │ │   👁️  Def: internal
  │   │   │   │ │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 704)
  │   │   │   │ │ │     💬 Args: [self._keys]
  │   │   │   │ │ │     👁️  Def: private
  │   │   │   │ │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 705)
  │   │   │   │ │     💬 Args: [rdat, 32 * self._depth]
  │   │   │   │ │     👁️  Def: private
  │   │   │   │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 706)
  │   │   │   │     💬 Args: [self]
  │   │   │   │     👁️  Def: internal
  │   │   │   │   ├─ [9] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 707)
  │   │   │   │   │   💬 Args: [self]
  │   │   │   │   │   👁️  Def: internal
  │   │   │   │   │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 708)
  │   │   │   │   │     💬 Args: [self._keys]
  │   │   │   │   │     👁️  Def: private
  │   │   │   │   └─ [9] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 709)
  │   │   │   │       💬 Args: [rdat, 32 * self._depth]
  │   │   │   │       👁️  Def: private
  │   │   │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.findOffsets(struct StdStorage,bytes32) (NodeID: 710)
  │   │   │   │   💬 Args: [self, reads[i]]
  │   │   │   │   👁️  Def: internal
  │   │   │   │ ├─ [8] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 711)
  │   │   │   │ │   💬 Args: [self, slot, true]
  │   │   │   │ │   👁️  Def: internal
  │   │   │   │ │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 712)
  │   │   │   │ │     💬 Args: [self]
  │   │   │   │ │     👁️  Def: internal
  │   │   │   │ │   ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 713)
  │   │   │   │ │   │   💬 Args: [self]
  │   │   │   │ │   │   👁️  Def: internal
  │   │   │   │ │   │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 714)
  │   │   │   │ │   │     💬 Args: [self._keys]
  │   │   │   │ │   │     👁️  Def: private
  │   │   │   │ │   └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 715)
  │   │   │   │ │       💬 Args: [rdat, 32 * self._depth]
  │   │   │   │ │       👁️  Def: private
  │   │   │   │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 716)
  │   │   │   │     💬 Args: [self, slot, false]
  │   │   │   │     👁️  Def: internal
  │   │   │   │   └─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 717)
  │   │   │   │       💬 Args: [self]
  │   │   │   │       👁️  Def: internal
  │   │   │   │     ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 718)
  │   │   │   │     │   💬 Args: [self]
  │   │   │   │     │   👁️  Def: internal
  │   │   │   │     │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 719)
  │   │   │   │     │     💬 Args: [self._keys]
  │   │   │   │     │     👁️  Def: private
  │   │   │   │     └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 720)
  │   │   │   │         💬 Args: [rdat, 32 * self._depth]
  │   │   │   │         👁️  Def: private
  │   │   │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 721)
  │   │   │   │   💬 Args: [offsetLeft, offsetRight]
  │   │   │   │   👁️  Def: internal
  │   │   │   └─ [7] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 722)
  │   │   │       💬 Args: [self]
  │   │   │       👁️  Def: internal
  │   │   ├─ [5] ⚙️ FUNCTION: stdStorageSafe.getUpdatedSlotValue(bytes32,uint256,uint256,uint256) (NodeID: 723)
  │   │   │   💬 Args: [curVal, uint256(set), data.offsetLeft, data.offsetRight]
  │   │   │   👁️  Def: internal
  │   │   │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 724)
  │   │   │     💬 Args: [offsetLeft, offsetRight]
  │   │   │     👁️  Def: internal
  │   │   ├─ [5] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 725)
  │   │   │   💬 Args: [self]
  │   │   │   👁️  Def: internal
  │   │   │ ├─ [6] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 726)
  │   │   │ │   💬 Args: [self]
  │   │   │ │   👁️  Def: internal
  │   │   │ │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 727)
  │   │   │ │     💬 Args: [self._keys]
  │   │   │ │     👁️  Def: private
  │   │   │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 728)
  │   │   │     💬 Args: [rdat, 32 * self._depth]
  │   │   │     👁️  Def: private
  │   │   └─ [5] ⚙️ FUNCTION: stdStorage.clear(struct StdStorage) (NodeID: 729)
  │   │       💬 Args: [self]
  │   │       👁️  Def: internal
  │   │     └─ [6] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 730)
  │   │         💬 Args: [self]
  │   │         👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: stdStorage.target(struct StdStorage,address) (NodeID: 731)
  │   │   💬 Args: [stdstore, token]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: stdStorageSafe.target(struct StdStorage,address) (NodeID: 732)
  │   │     💬 Args: [self, _target]
  │   │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: stdStorage.sig(struct StdStorage,bytes4) (NodeID: 733)
  │   │   💬 Args: [stdstore.target(token), 0x18160ddd]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: stdStorageSafe.sig(struct StdStorage,bytes4) (NodeID: 734)
  │   │     💬 Args: [self, _sig]
  │   │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,uint256) (NodeID: 735)
  │       💬 Args: [stdstore.target(token).sig(0x18160ddd), totSup]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,bytes32) (NodeID: 736)
  │         💬 Args: [self, bytes32(amt)]
  │         👁️  Def: internal
  │       ├─ [5] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 737)
  │       │   💬 Args: [self]
  │       │   👁️  Def: internal
  │       │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 738)
  │       │     💬 Args: [self._keys]
  │       │     👁️  Def: private
  │       ├─ [5] ⚙️ FUNCTION: stdStorage.find(struct StdStorage,bool) (NodeID: 739)
  │       │   💬 Args: [self, false]
  │       │   👁️  Def: internal
  │       │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.find(struct StdStorage,bool) (NodeID: 740)
  │       │     💬 Args: [self, _clear]
  │       │     👁️  Def: internal
  │       │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 741)
  │       │   │   💬 Args: [self]
  │       │   │   👁️  Def: internal
  │       │   │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 742)
  │       │   │     💬 Args: [self._keys]
  │       │   │     👁️  Def: private
  │       │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 743)
  │       │   │   💬 Args: [self]
  │       │   │   👁️  Def: internal
  │       │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 744)
  │       │   │   💬 Args: [self]
  │       │   │   👁️  Def: internal
  │       │   │ ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 745)
  │       │   │ │   💬 Args: [self]
  │       │   │ │   👁️  Def: internal
  │       │   │ │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 746)
  │       │   │ │     💬 Args: [self._keys]
  │       │   │ │     👁️  Def: private
  │       │   │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 747)
  │       │   │     💬 Args: [rdat, 32 * self._depth]
  │       │   │     👁️  Def: private
  │       │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.checkSlotMutatesCall(struct StdStorage,bytes32) (NodeID: 748)
  │       │   │   💬 Args: [self, reads[i]]
  │       │   │   👁️  Def: internal
  │       │   │ ├─ [8] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 749)
  │       │   │ │   💬 Args: [self]
  │       │   │ │   👁️  Def: internal
  │       │   │ │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 750)
  │       │   │ │ │   💬 Args: [self]
  │       │   │ │ │   👁️  Def: internal
  │       │   │ │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 751)
  │       │   │ │ │     💬 Args: [self._keys]
  │       │   │ │ │     👁️  Def: private
  │       │   │ │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 752)
  │       │   │ │     💬 Args: [rdat, 32 * self._depth]
  │       │   │ │     👁️  Def: private
  │       │   │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 753)
  │       │   │     💬 Args: [self]
  │       │   │     👁️  Def: internal
  │       │   │   ├─ [9] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 754)
  │       │   │   │   💬 Args: [self]
  │       │   │   │   👁️  Def: internal
  │       │   │   │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 755)
  │       │   │   │     💬 Args: [self._keys]
  │       │   │   │     👁️  Def: private
  │       │   │   └─ [9] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 756)
  │       │   │       💬 Args: [rdat, 32 * self._depth]
  │       │   │       👁️  Def: private
  │       │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.findOffsets(struct StdStorage,bytes32) (NodeID: 757)
  │       │   │   💬 Args: [self, reads[i]]
  │       │   │   👁️  Def: internal
  │       │   │ ├─ [8] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 758)
  │       │   │ │   💬 Args: [self, slot, true]
  │       │   │ │   👁️  Def: internal
  │       │   │ │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 759)
  │       │   │ │     💬 Args: [self]
  │       │   │ │     👁️  Def: internal
  │       │   │ │   ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 760)
  │       │   │ │   │   💬 Args: [self]
  │       │   │ │   │   👁️  Def: internal
  │       │   │ │   │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 761)
  │       │   │ │   │     💬 Args: [self._keys]
  │       │   │ │   │     👁️  Def: private
  │       │   │ │   └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 762)
  │       │   │ │       💬 Args: [rdat, 32 * self._depth]
  │       │   │ │       👁️  Def: private
  │       │   │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 763)
  │       │   │     💬 Args: [self, slot, false]
  │       │   │     👁️  Def: internal
  │       │   │   └─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 764)
  │       │   │       💬 Args: [self]
  │       │   │       👁️  Def: internal
  │       │   │     ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 765)
  │       │   │     │   💬 Args: [self]
  │       │   │     │   👁️  Def: internal
  │       │   │     │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 766)
  │       │   │     │     💬 Args: [self._keys]
  │       │   │     │     👁️  Def: private
  │       │   │     └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 767)
  │       │   │         💬 Args: [rdat, 32 * self._depth]
  │       │   │         👁️  Def: private
  │       │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 768)
  │       │   │   💬 Args: [offsetLeft, offsetRight]
  │       │   │   👁️  Def: internal
  │       │   └─ [7] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 769)
  │       │       💬 Args: [self]
  │       │       👁️  Def: internal
  │       ├─ [5] ⚙️ FUNCTION: stdStorageSafe.getUpdatedSlotValue(bytes32,uint256,uint256,uint256) (NodeID: 770)
  │       │   💬 Args: [curVal, uint256(set), data.offsetLeft, data.offsetRight]
  │       │   👁️  Def: internal
  │       │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 771)
  │       │     💬 Args: [offsetLeft, offsetRight]
  │       │     👁️  Def: internal
  │       ├─ [5] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 772)
  │       │   💬 Args: [self]
  │       │   👁️  Def: internal
  │       │ ├─ [6] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 773)
  │       │ │   💬 Args: [self]
  │       │ │   👁️  Def: internal
  │       │ │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 774)
  │       │ │     💬 Args: [self._keys]
  │       │ │     👁️  Def: private
  │       │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 775)
  │       │     💬 Args: [rdat, 32 * self._depth]
  │       │     👁️  Def: private
  │       └─ [5] ⚙️ FUNCTION: stdStorage.clear(struct StdStorage) (NodeID: 776)
  │           💬 Args: [self]
  │           👁️  Def: internal
  │         └─ [6] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 777)
  │             💬 Args: [self]
  │             👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseSuperVaultTest._deposit(uint256,address,address) (NodeID: 778)
  │   💬 Args: [vars.deposit3Amount, address(sv5115), address(asset5115)]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: BaseSuperVaultTest.__deposit(struct AccountInstance,uint256,address,address) (NodeID: 779)
  │     💬 Args: [instanceOnEth, depositAmount, superVault, asset_]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: BaseTest._getHookAddress(uint64,string) (NodeID: 780)
  │   │   💬 Args: [ETH, APPROVE_AND_DEPOSIT_4626_VAULT_HOOK_KEY]
  │   │   👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: InternalHelpers._createApproveAndDeposit4626HookData(bytes32,address,address,uint256,bool,address,uint256) (NodeID: 781)
  │   │   💬 Args: [_getYieldSourceOracleId(bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), MANAGER), superVault, asset_, depositAmount, false, address(0), 0]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: InternalHelpers._getYieldSourceOracleId(bytes32,address) (NodeID: 782)
  │   │     💬 Args: [bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), MANAGER]
  │   │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: InternalHelpers._getExecOps(struct AccountInstance,contract ISuperExecutor,bytes) (NodeID: 783)
  │   │   💬 Args: [accInst, superExecutorOnEth, abi.encode(entry)]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: ModuleKitHelpers.getExecOps(struct AccountInstance,address,uint256,bytes,address) (NodeID: 784)
  │   │     💬 Args: [instance, address(superExecutor), 0, abi.encodeCall(superExecutor.execute, (data)), address(instance.defaultValidator)]
  │   │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: InternalHelpers.executeOp(struct UserOpData) (NodeID: 785)
  │       💬 Args: [userOpData]
  │       👁️  Def: public
  │     └─ [4] ⚙️ FUNCTION: ModuleKitHelpers.execUserOps(struct UserOpData) (NodeID: 786)
  │         💬 Args: [userOpData]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: ERC4337Helpers.exec4337(struct PackedUserOperation,contract IEntryPoint) (NodeID: 787)
  │           💬 Args: [userOpData.userOp, userOpData.entrypoint]
  │           👁️  Def: internal
  │         └─ [6] ⚙️ FUNCTION: ERC4337Helpers.exec4337(struct PackedUserOperation[],contract IEntryPoint) (NodeID: 788)
  │             💬 Args: [userOps, onEntryPoint]
  │             👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Unknown.getExpectRevert() (NodeID: 789)
  │           │   💬 Args: [no args]
  │           │   👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Unknown.getSimulateUserOp() (NodeID: 790)
  │           │   💬 Args: [no args]
  │           │   👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Helpers.envOr(string,bool) (NodeID: 791)
  │           │   💬 Args: ["SIMULATE", false]
  │           │   👁️  Def: public
  │           ├─ [7] ⚙️ FUNCTION: Simulator.simulateUserOp(struct PackedUserOperation,address) (NodeID: 792)
  │           │   💬 Args: [userOps[0], address(onEntryPoint)]
  │           │   👁️  Def: internal
  │           │ ├─ [8] ⚙️ FUNCTION: Simulator._preSimulation() (NodeID: 793)
  │           │ │   💬 Args: [no args]
  │           │ │   👁️  Def: internal
  │           │ │ ├─ [9] ⚙️ FUNCTION: Unknown.snapshotState() (NodeID: 794)
  │           │ │ │   💬 Args: [no args]
  │           │ │ │   👁️  Def: internal
  │           │ │ ├─ [9] ⚙️ FUNCTION: Unknown.startMappingRecording() (NodeID: 795)
  │           │ │ │   💬 Args: [no args]
  │           │ │ │   👁️  Def: internal
  │           │ │ └─ [9] ⚙️ FUNCTION: Unknown.startDebugTraceRecording() (NodeID: 796)
  │           │ │     💬 Args: [no args]
  │           │ │     👁️  Def: internal
  │           │ └─ [8] ⚙️ FUNCTION: Simulator._postSimulation(struct UserOperationDetails) (NodeID: 797)
  │           │     💬 Args: [userOpDetails]
  │           │     👁️  Def: internal
  │           │   ├─ [9] ⚙️ FUNCTION: Unknown.stopAndReturnDebugTraceRecording() (NodeID: 798)
  │           │   │   💬 Args: [no args]
  │           │   │   👁️  Def: internal
  │           │   ├─ [9] ⚙️ FUNCTION: ERC4337SpecsParser.parseValidation(struct UserOperationDetails,struct VmSafe.DebugStep[]) (NodeID: 799)
  │           │   │   💬 Args: [userOpDetails, debugTrace]
  │           │   │   👁️  Def: internal
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.getEntities(struct UserOperationDetails) (NodeID: 800)
  │           │   │ │   💬 Args: [userOpDetails]
  │           │   │ │   👁️  Def: internal
  │           │   │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isStaked(address,address) (NodeID: 801)
  │           │   │ │ │   💬 Args: [factory, userOpDetails.entryPoint]
  │           │   │ │ │   👁️  Def: internal
  │           │   │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isStaked(address,address) (NodeID: 802)
  │           │   │ │ │   💬 Args: [paymaster, userOpDetails.entryPoint]
  │           │   │ │ │   👁️  Def: internal
  │           │   │ │ └─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isStaked(address,address) (NodeID: 803)
  │           │   │ │     💬 Args: [aggregator, userOpDetails.entryPoint]
  │           │   │ │     👁️  Def: internal
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.filterDebugTrace(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,address) (NodeID: 804)
  │           │   │ │   💬 Args: [debugTrace, entities, userOpDetails.entryPoint]
  │           │   │ │   👁️  Def: private
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 805)
  │           │   │ │   💬 Args: [filteredUserOpSteps, entities]
  │           │   │ │   👁️  Def: internal
  │           │   │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isForbiddenOpcode(uint8) (NodeID: 806)
  │           │   │ │ │   💬 Args: [debugTrace[i].opcode]
  │           │   │ │ │   👁️  Def: private
  │           │   │ │ └─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isEntityAndStaked(struct ERC4337SpecsParser.Entities,address) (NodeID: 807)
  │           │   │ │     💬 Args: [entities, debugTrace[i].contractAddr]
  │           │   │ │     👁️  Def: internal
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 808)
  │           │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities]
  │           │   │ │   👁️  Def: internal
  │           │   │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isForbiddenOpcode(uint8) (NodeID: 809)
  │           │   │ │ │   💬 Args: [debugTrace[i].opcode]
  │           │   │ │ │   👁️  Def: private
  │           │   │ │ └─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isEntityAndStaked(struct ERC4337SpecsParser.Entities,address) (NodeID: 810)
  │           │   │ │     💬 Args: [entities, debugTrace[i].contractAddr]
  │           │   │ │     👁️  Def: internal
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.validateOutOfGas(struct VmSafe.DebugStep[]) (NodeID: 811)
  │           │   │ │   💬 Args: [filteredUserOpSteps]
  │           │   │ │   👁️  Def: internal
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.validateOutOfGas(struct VmSafe.DebugStep[]) (NodeID: 812)
  │           │   │ │   💬 Args: [filteredPaymasterUserOpSteps]
  │           │   │ │   👁️  Def: internal
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedStorageLocations(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 813)
  │           │   │ │   💬 Args: [filteredUserOpSteps, entities, userOpDetails]
  │           │   │ │   👁️  Def: internal
  │           │   │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isEntity(struct ERC4337SpecsParser.Entities,address) (NodeID: 814)
  │           │   │ │ │   💬 Args: [entities, currentAccessAccount]
  │           │   │ │ │   👁️  Def: internal
  │           │   │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 815)
  │           │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.account]
  │           │   │ │ │   👁️  Def: internal
  │           │   │ │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 816)
  │           │   │ │ │ │   💬 Args: [currentSlot, entity]
  │           │   │ │ │ │   👁️  Def: internal
  │           │   │ │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 817)
  │           │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │           │   │ │ │ │   👁️  Def: internal
  │           │   │ │ │ │ ├─ [13] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 818)
  │           │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │           │   │ │ │ │ │   👁️  Def: internal
  │           │   │ │ │ │ └─ [13] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 819)
  │           │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │           │   │ │ │ │     👁️  Def: internal
  │           │   │ │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 820)
  │           │   │ │ │     💬 Args: [key, entity]
  │           │   │ │ │     👁️  Def: internal
  │           │   │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 821)
  │           │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.paymaster]
  │           │   │ │ │   👁️  Def: internal
  │           │   │ │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 822)
  │           │   │ │ │ │   💬 Args: [currentSlot, entity]
  │           │   │ │ │ │   👁️  Def: internal
  │           │   │ │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 823)
  │           │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │           │   │ │ │ │   👁️  Def: internal
  │           │   │ │ │ │ ├─ [13] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 824)
  │           │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │           │   │ │ │ │ │   👁️  Def: internal
  │           │   │ │ │ │ └─ [13] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 825)
  │           │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │           │   │ │ │ │     👁️  Def: internal
  │           │   │ │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 826)
  │           │   │ │ │     💬 Args: [key, entity]
  │           │   │ │ │     👁️  Def: internal
  │           │   │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 827)
  │           │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.factory]
  │           │   │ │ │   👁️  Def: internal
  │           │   │ │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 828)
  │           │   │ │ │ │   💬 Args: [currentSlot, entity]
  │           │   │ │ │ │   👁️  Def: internal
  │           │   │ │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 829)
  │           │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │           │   │ │ │ │   👁️  Def: internal
  │           │   │ │ │ │ ├─ [13] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 830)
  │           │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │           │   │ │ │ │ │   👁️  Def: internal
  │           │   │ │ │ │ └─ [13] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 831)
  │           │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │           │   │ │ │ │     👁️  Def: internal
  │           │   │ │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 832)
  │           │   │ │ │     💬 Args: [key, entity]
  │           │   │ │ │     👁️  Def: internal
  │           │   │ │ └─ [11] ⚙️ FUNCTION: Unknown.getLabel(address) (NodeID: 833)
  │           │   │ │     💬 Args: [currentAccessAccount]
  │           │   │ │     👁️  Def: internal
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedStorageLocations(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 834)
  │           │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities, userOpDetails]
  │           │   │ │   👁️  Def: internal
  │           │   │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isEntity(struct ERC4337SpecsParser.Entities,address) (NodeID: 835)
  │           │   │ │ │   💬 Args: [entities, currentAccessAccount]
  │           │   │ │ │   👁️  Def: internal
  │           │   │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 836)
  │           │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.account]
  │           │   │ │ │   👁️  Def: internal
  │           │   │ │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 837)
  │           │   │ │ │ │   💬 Args: [currentSlot, entity]
  │           │   │ │ │ │   👁️  Def: internal
  │           │   │ │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 838)
  │           │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │           │   │ │ │ │   👁️  Def: internal
  │           │   │ │ │ │ ├─ [13] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 839)
  │           │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │           │   │ │ │ │ │   👁️  Def: internal
  │           │   │ │ │ │ └─ [13] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 840)
  │           │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │           │   │ │ │ │     👁️  Def: internal
  │           │   │ │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 841)
  │           │   │ │ │     💬 Args: [key, entity]
  │           │   │ │ │     👁️  Def: internal
  │           │   │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 842)
  │           │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.paymaster]
  │           │   │ │ │   👁️  Def: internal
  │           │   │ │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 843)
  │           │   │ │ │ │   💬 Args: [currentSlot, entity]
  │           │   │ │ │ │   👁️  Def: internal
  │           │   │ │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 844)
  │           │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │           │   │ │ │ │   👁️  Def: internal
  │           │   │ │ │ │ ├─ [13] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 845)
  │           │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │           │   │ │ │ │ │   👁️  Def: internal
  │           │   │ │ │ │ └─ [13] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 846)
  │           │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │           │   │ │ │ │     👁️  Def: internal
  │           │   │ │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 847)
  │           │   │ │ │     💬 Args: [key, entity]
  │           │   │ │ │     👁️  Def: internal
  │           │   │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 848)
  │           │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.factory]
  │           │   │ │ │   👁️  Def: internal
  │           │   │ │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 849)
  │           │   │ │ │ │   💬 Args: [currentSlot, entity]
  │           │   │ │ │ │   👁️  Def: internal
  │           │   │ │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 850)
  │           │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │           │   │ │ │ │   👁️  Def: internal
  │           │   │ │ │ │ ├─ [13] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 851)
  │           │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │           │   │ │ │ │ │   👁️  Def: internal
  │           │   │ │ │ │ └─ [13] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 852)
  │           │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │           │   │ │ │ │     👁️  Def: internal
  │           │   │ │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 853)
  │           │   │ │ │     💬 Args: [key, entity]
  │           │   │ │ │     👁️  Def: internal
  │           │   │ │ └─ [11] ⚙️ FUNCTION: Unknown.getLabel(address) (NodeID: 854)
  │           │   │ │     💬 Args: [currentAccessAccount]
  │           │   │ │     👁️  Def: internal
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.validateCalls(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,address) (NodeID: 855)
  │           │   │ │   💬 Args: [filteredUserOpSteps, entities, userOpDetails.entryPoint]
  │           │   │ │   👁️  Def: internal
  │           │   │ │ └─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 856)
  │           │   │ │     💬 Args: [targetAddr]
  │           │   │ │     👁️  Def: internal
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.validateCalls(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,address) (NodeID: 857)
  │           │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities, userOpDetails.entryPoint]
  │           │   │ │   👁️  Def: internal
  │           │   │ │ └─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 858)
  │           │   │ │     💬 Args: [targetAddr]
  │           │   │ │     👁️  Def: internal
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.validateExtOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 859)
  │           │   │ │   💬 Args: [filteredUserOpSteps, entities]
  │           │   │ │   👁️  Def: internal
  │           │   │ │ └─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 860)
  │           │   │ │     💬 Args: [targetAddr]
  │           │   │ │     👁️  Def: internal
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.validateExtOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 861)
  │           │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities]
  │           │   │ │   👁️  Def: internal
  │           │   │ │ └─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 862)
  │           │   │ │     💬 Args: [targetAddr]
  │           │   │ │     👁️  Def: internal
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.validateCreate(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 863)
  │           │   │ │   💬 Args: [filteredUserOpSteps, entities, userOpDetails]
  │           │   │ │   👁️  Def: internal
  │           │   │ └─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.validateCreate(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 864)
  │           │   │     💬 Args: [filteredPaymasterUserOpSteps, entities, userOpDetails]
  │           │   │     👁️  Def: internal
  │           │   ├─ [9] ⚙️ FUNCTION: Unknown.stopMappingRecording() (NodeID: 865)
  │           │   │   💬 Args: [no args]
  │           │   │   👁️  Def: internal
  │           │   └─ [9] ⚙️ FUNCTION: Unknown.revertToState(uint256) (NodeID: 866)
  │           │       💬 Args: [snapShotId]
  │           │       👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Unknown.recordLogs() (NodeID: 867)
  │           │   💬 Args: [no args]
  │           │   👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: ERC4337Helpers.checkRevertMessage(bytes) (NodeID: 868)
  │           │   💬 Args: [ctx.returnData]
  │           │   👁️  Def: internal
  │           │ ├─ [8] ⚙️ FUNCTION: Unknown.getExpectRevertMessage() (NodeID: 869)
  │           │ │   💬 Args: [no args]
  │           │ │   👁️  Def: internal
  │           │ └─ [8] ⚙️ FUNCTION: ERC4337Helpers.parseFailedOpWithRevert(bytes,bytes) (NodeID: 870)
  │           │     💬 Args: [actualReason, revertMessage]
  │           │     👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Unknown.getRecordedLogs() (NodeID: 871)
  │           │   💬 Args: [no args]
  │           │   👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: ERC4337Helpers.getUserOpRevertReason(struct VmSafe.Log[],bytes32) (NodeID: 872)
  │           │   💬 Args: [logs, userOpHash]
  │           │   👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Unknown.getLabel(address) (NodeID: 873)
  │           │   💬 Args: [account]
  │           │   👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: ERC4337Helpers.checkRevertMessage(bytes) (NodeID: 874)
  │           │   💬 Args: [getUserOpRevertReason(logs, userOpHash)]
  │           │   👁️  Def: internal
  │           │ ├─ [8] ⚙️ FUNCTION: ERC4337Helpers.getUserOpRevertReason(struct VmSafe.Log[],bytes32) (NodeID: 877)
  │           │ │   💬 Args: [logs, userOpHash]
  │           │ │   👁️  Def: internal
  │           │ ├─ [8] ⚙️ FUNCTION: Unknown.getExpectRevertMessage() (NodeID: 875)
  │           │ │   💬 Args: [no args]
  │           │ │   👁️  Def: internal
  │           │ └─ [8] ⚙️ FUNCTION: ERC4337Helpers.parseFailedOpWithRevert(bytes,bytes) (NodeID: 876)
  │           │     💬 Args: [actualReason, revertMessage]
  │           │     👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Unknown.clearExpectRevert() (NodeID: 878)
  │           │   💬 Args: [no args]
  │           │   👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Unknown.writeInstalledModule(struct InstalledModule,address) (NodeID: 879)
  │           │   💬 Args: [InstalledModule(moduleType, module), logs[i].emitter]
  │           │   👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Unknown.getInstalledModules(address) (NodeID: 880)
  │           │   💬 Args: [logs[i].emitter]
  │           │   👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Unknown.removeInstalledModule(uint256,address) (NodeID: 881)
  │           │   💬 Args: [j, logs[i].emitter]
  │           │   👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Unknown.getGasIdentifier() (NodeID: 882)
  │           │   💬 Args: [no args]
  │           │   👁️  Def: internal
  │           │ └─ [8] ⚙️ FUNCTION: Unknown.readString(bytes32) (NodeID: 883)
  │           │     💬 Args: [slot]
  │           │     👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Helpers.envOr(string,bool) (NodeID: 884)
  │           │   💬 Args: ["GAS", false]
  │           │   👁️  Def: public
  │           └─ [7] ⚙️ FUNCTION: ERC4337Helpers.calculateGas(struct PackedUserOperation[],contract IEntryPoint,address,string,uint256) (NodeID: 885)
  │               💬 Args: [userOps, onEntryPoint, ctx.beneficiary, gasIdentifier, totalUserOpGas]
  │               👁️  Def: internal
  │             └─ [8] ⚙️ FUNCTION: GasParser.parseAndWriteGas(bytes,address,string,address,uint256) (NodeID: 886)
  │                 💬 Args: [userOpCalldata, address(onEntryPoint), gasIdentifier, userOps[0].sender, totalUserOpGas]
  │                 👁️  Def: internal
  │               ├─ [9] ⚙️ FUNCTION: Unknown.getArbitrumL1Gas(bytes) (NodeID: 887)
  │               │   💬 Args: [userOpCalldata]
  │               │   👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: LibZip.flzCompress(bytes) (NodeID: 888)
  │               │ │   💬 Args: [data]
  │               │ │   👁️  Def: internal
  │               │ └─ [10] ⚙️ FUNCTION: Unknown.getCallDataGas(bytes) (NodeID: 889)
  │               │     💬 Args: [compressed]
  │               │     👁️  Def: internal
  │               ├─ [9] ⚙️ FUNCTION: Unknown.getOpStackL1Gas(bytes) (NodeID: 890)
  │               │   💬 Args: [userOpCalldata]
  │               │   👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.ud(uint256) (NodeID: 891)
  │               │ │   💬 Args: [0.684e18]
  │               │ │   👁️  Def: internal
  │               │ └─ [10] ⚙️ FUNCTION: Unknown.intoUint256(UD60x18) (NodeID: 892)
  │               │     💬 Args: [PRBMathCastingUint256.intoUD60x18(getCallDataGas(data)).mul(opStackScalar)]
  │               │     👁️  Def: internal
  │               │   ├─ [11] ⚙️ FUNCTION: PRBMathCastingUint256.intoUD60x18(uint256) (NodeID: 893)
  │               │   │   💬 Args: [getCallDataGas(data)]
  │               │   │   👁️  Def: internal
  │               │   │ └─ [12] ⚙️ FUNCTION: Unknown.getCallDataGas(bytes) (NodeID: 894)
  │               │   │     💬 Args: [data]
  │               │   │     👁️  Def: internal
  │               │   └─ [11] ⚙️ FUNCTION: Unknown.mul(UD60x18,UD60x18) (NodeID: 895)
  │               │       💬 Args: [PRBMathCastingUint256.intoUD60x18(getCallDataGas(data)), opStackScalar]
  │               │       👁️  Def: internal
  │               │     └─ [12] ⚙️ FUNCTION: Unknown.wrap(uint256) (NodeID: 896)
  │               │         💬 Args: [Common.mulDiv18(x.unwrap(), y.unwrap())]
  │               │         👁️  Def: internal
  │               │       └─ [13] ⚙️ FUNCTION: Unknown.mulDiv18(uint256,uint256) (NodeID: 897)
  │               │           💬 Args: [Common, x.unwrap(), y.unwrap()]
  │               │           👁️  Def: internal
  │               │         ├─ [14] ⚙️ FUNCTION: Unknown.unwrap(UD60x18) (NodeID: 898)
  │               │         │   💬 Args: [x]
  │               │         │   👁️  Def: internal
  │               │         └─ [14] ⚙️ FUNCTION: Unknown.unwrap(UD60x18) (NodeID: 899)
  │               │             💬 Args: [y]
  │               │             👁️  Def: internal
  │               ├─ [9] ⚙️ FUNCTION: Unknown.exists(string) (NodeID: 900)
  │               │   💬 Args: [fileName]
  │               │   👁️  Def: internal
  │               ├─ [9] ⚙️ FUNCTION: Unknown.readFile(string) (NodeID: 901)
  │               │   💬 Args: [fileName]
  │               │   👁️  Def: internal
  │               ├─ [9] ⚙️ FUNCTION: Unknown.parsePrevGasReport(string) (NodeID: 902)
  │               │   💬 Args: [fileContent]
  │               │   👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 903)
  │               │ │   💬 Args: [parseJson(fileContent, ".Total")]
  │               │ │   👁️  Def: internal
  │               │ │ └─ [11] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 904)
  │               │ │     💬 Args: [fileContent, ".Total"]
  │               │ │     👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 905)
  │               │ │   💬 Args: [parseJson(fileContent, ".Phases.Creation")]
  │               │ │   👁️  Def: internal
  │               │ │ └─ [11] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 906)
  │               │ │     💬 Args: [fileContent, ".Phases.Creation"]
  │               │ │     👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 907)
  │               │ │   💬 Args: [parseJson(fileContent, ".Phases.Validation")]
  │               │ │   👁️  Def: internal
  │               │ │ └─ [11] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 908)
  │               │ │     💬 Args: [fileContent, ".Phases.Validation"]
  │               │ │     👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 909)
  │               │ │   💬 Args: [parseJson(fileContent, ".Phases.Execution")]
  │               │ │   👁️  Def: internal
  │               │ │ └─ [11] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 910)
  │               │ │     💬 Args: [fileContent, ".Phases.Execution"]
  │               │ │     👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 911)
  │               │ │   💬 Args: [parseJson(fileContent, ".Calldata.Arbitrum")]
  │               │ │   👁️  Def: internal
  │               │ │ └─ [11] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 912)
  │               │ │     💬 Args: [fileContent, ".Calldata.Arbitrum"]
  │               │ │     👁️  Def: internal
  │               │ └─ [10] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 913)
  │               │     💬 Args: [parseJson(fileContent, ".Calldata.OP-Stack")]
  │               │     👁️  Def: internal
  │               │   └─ [11] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 914)
  │               │       💬 Args: [fileContent, ".Calldata.OP-Stack"]
  │               │       👁️  Def: internal
  │               ├─ [9] ⚙️ FUNCTION: GasParser.formatGasToWrite(string,struct GasCalculations,struct GasCalculations) (NodeID: 915)
  │               │   💬 Args: [gasIdentifier, prevGasCalculations, gasCalculations]
  │               │   👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 916)
  │               │ │   💬 Args: [jsonObj, "Total", formatGasValue({prevValue: prevGasCalculations.total, newValue: gasCalculations.total})]
  │               │ │   👁️  Def: internal
  │               │ │ └─ [11] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 917)
  │               │ │     💬 Args: [prevGasCalculations.total, gasCalculations.total]
  │               │ │     👁️  Def: internal
  │               │ │   ├─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 918)
  │               │ │   │   💬 Args: [int256(newValue)]
  │               │ │   │   👁️  Def: internal
  │               │ │   │ └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 919)
  │               │ │   │     💬 Args: [value]
  │               │ │   │     👁️  Def: internal
  │               │ │   ├─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 920)
  │               │ │   │   💬 Args: [int256(newValue)]
  │               │ │   │   👁️  Def: internal
  │               │ │   │ └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 921)
  │               │ │   │     💬 Args: [value]
  │               │ │   │     👁️  Def: internal
  │               │ │   └─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 922)
  │               │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │               │ │       👁️  Def: internal
  │               │ │     └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 923)
  │               │ │         💬 Args: [value]
  │               │ │         👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 924)
  │               │ │   💬 Args: [phasesObj, "Creation", formatGasValue({prevValue: prevGasCalculations.creation, newValue: gasCalculations.creation})]
  │               │ │   👁️  Def: internal
  │               │ │ └─ [11] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 925)
  │               │ │     💬 Args: [prevGasCalculations.creation, gasCalculations.creation]
  │               │ │     👁️  Def: internal
  │               │ │   ├─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 926)
  │               │ │   │   💬 Args: [int256(newValue)]
  │               │ │   │   👁️  Def: internal
  │               │ │   │ └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 927)
  │               │ │   │     💬 Args: [value]
  │               │ │   │     👁️  Def: internal
  │               │ │   ├─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 928)
  │               │ │   │   💬 Args: [int256(newValue)]
  │               │ │   │   👁️  Def: internal
  │               │ │   │ └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 929)
  │               │ │   │     💬 Args: [value]
  │               │ │   │     👁️  Def: internal
  │               │ │   └─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 930)
  │               │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │               │ │       👁️  Def: internal
  │               │ │     └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 931)
  │               │ │         💬 Args: [value]
  │               │ │         👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 932)
  │               │ │   💬 Args: [phasesObj, "Validation", formatGasValue({prevValue: prevGasCalculations.validation, newValue: gasCalculations.validation})]
  │               │ │   👁️  Def: internal
  │               │ │ └─ [11] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 933)
  │               │ │     💬 Args: [prevGasCalculations.validation, gasCalculations.validation]
  │               │ │     👁️  Def: internal
  │               │ │   ├─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 934)
  │               │ │   │   💬 Args: [int256(newValue)]
  │               │ │   │   👁️  Def: internal
  │               │ │   │ └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 935)
  │               │ │   │     💬 Args: [value]
  │               │ │   │     👁️  Def: internal
  │               │ │   ├─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 936)
  │               │ │   │   💬 Args: [int256(newValue)]
  │               │ │   │   👁️  Def: internal
  │               │ │   │ └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 937)
  │               │ │   │     💬 Args: [value]
  │               │ │   │     👁️  Def: internal
  │               │ │   └─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 938)
  │               │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │               │ │       👁️  Def: internal
  │               │ │     └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 939)
  │               │ │         💬 Args: [value]
  │               │ │         👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 940)
  │               │ │   💬 Args: [phasesObj, "Execution", formatGasValue({prevValue: prevGasCalculations.execution, newValue: gasCalculations.execution})]
  │               │ │   👁️  Def: internal
  │               │ │ └─ [11] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 941)
  │               │ │     💬 Args: [prevGasCalculations.execution, gasCalculations.execution]
  │               │ │     👁️  Def: internal
  │               │ │   ├─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 942)
  │               │ │   │   💬 Args: [int256(newValue)]
  │               │ │   │   👁️  Def: internal
  │               │ │   │ └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 943)
  │               │ │   │     💬 Args: [value]
  │               │ │   │     👁️  Def: internal
  │               │ │   ├─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 944)
  │               │ │   │   💬 Args: [int256(newValue)]
  │               │ │   │   👁️  Def: internal
  │               │ │   │ └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 945)
  │               │ │   │     💬 Args: [value]
  │               │ │   │     👁️  Def: internal
  │               │ │   └─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 946)
  │               │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │               │ │       👁️  Def: internal
  │               │ │     └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 947)
  │               │ │         💬 Args: [value]
  │               │ │         👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 948)
  │               │ │   💬 Args: [l2sObj, "OP-Stack", formatGasValue({prevValue: prevGasCalculations.opStack, newValue: gasCalculations.opStack})]
  │               │ │   👁️  Def: internal
  │               │ │ └─ [11] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 949)
  │               │ │     💬 Args: [prevGasCalculations.opStack, gasCalculations.opStack]
  │               │ │     👁️  Def: internal
  │               │ │   ├─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 950)
  │               │ │   │   💬 Args: [int256(newValue)]
  │               │ │   │   👁️  Def: internal
  │               │ │   │ └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 951)
  │               │ │   │     💬 Args: [value]
  │               │ │   │     👁️  Def: internal
  │               │ │   ├─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 952)
  │               │ │   │   💬 Args: [int256(newValue)]
  │               │ │   │   👁️  Def: internal
  │               │ │   │ └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 953)
  │               │ │   │     💬 Args: [value]
  │               │ │   │     👁️  Def: internal
  │               │ │   └─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 954)
  │               │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │               │ │       👁️  Def: internal
  │               │ │     └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 955)
  │               │ │         💬 Args: [value]
  │               │ │         👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 956)
  │               │ │   💬 Args: [l2sObj, "Arbitrum", formatGasValue({prevValue: prevGasCalculations.arbitrum, newValue: gasCalculations.arbitrum})]
  │               │ │   👁️  Def: internal
  │               │ │ └─ [11] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 957)
  │               │ │     💬 Args: [prevGasCalculations.arbitrum, gasCalculations.arbitrum]
  │               │ │     👁️  Def: internal
  │               │ │   ├─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 958)
  │               │ │   │   💬 Args: [int256(newValue)]
  │               │ │   │   👁️  Def: internal
  │               │ │   │ └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 959)
  │               │ │   │     💬 Args: [value]
  │               │ │   │     👁️  Def: internal
  │               │ │   ├─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 960)
  │               │ │   │   💬 Args: [int256(newValue)]
  │               │ │   │   👁️  Def: internal
  │               │ │   │ └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 961)
  │               │ │   │     💬 Args: [value]
  │               │ │   │     👁️  Def: internal
  │               │ │   └─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 962)
  │               │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │               │ │       👁️  Def: internal
  │               │ │     └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 963)
  │               │ │         💬 Args: [value]
  │               │ │         👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 964)
  │               │ │   💬 Args: [jsonObj, "Phases", phasesOutput]
  │               │ │   👁️  Def: internal
  │               │ └─ [10] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 965)
  │               │     💬 Args: [jsonObj, "Calldata", l2sOutput]
  │               │     👁️  Def: internal
  │               ├─ [9] ⚙️ FUNCTION: Unknown.writeJson(string,string) (NodeID: 966)
  │               │   💬 Args: [finalJson, fileName]
  │               │   👁️  Def: internal
  │               └─ [9] ⚙️ FUNCTION: Unknown.writeGasIdentifier(string) (NodeID: 967)
  │                   💬 Args: [""]
  │                   👁️  Def: internal
  │                 └─ [10] ⚙️ FUNCTION: Unknown.writeString(bytes32,string) (NodeID: 968)
  │                     💬 Args: [slot, id]
  │                     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseSuperVaultTest._depositFreeAssetsFromSingleAmount5115(uint256,address,address) (NodeID: 969)
  │   💬 Args: [vars.deposit3Amount, address(strategy5115SuperVault), pendleEthenaAddress]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseTest._getHookAddress(uint64,string) (NodeID: 970)
  │ │   💬 Args: [ETH, APPROVE_AND_DEPOSIT_5115_VAULT_HOOK_KEY]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: HooksHelpers._createApproveAndDeposit5115HookData(bytes32,address,address,uint256,uint256,bool) (NodeID: 971)
  │ │   💬 Args: [_getYieldSourceOracleId(bytes32(bytes(ERC5115_YIELD_SOURCE_ORACLE_KEY)), MANAGER), underlyingVault, address(asset5115), depositAmount, 0, false]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: InternalHelpers._getYieldSourceOracleId(bytes32,address) (NodeID: 972)
  │ │     💬 Args: [bytes32(bytes(ERC5115_YIELD_SOURCE_ORACLE_KEY)), MANAGER]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: MerkleReader._getMerkleProofsForHooks(address[],bytes[]) (NodeID: 973)
  │ │   💬 Args: [fulfillHooksAddresses, argsForProofs]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseSuperVaultTest._getSuperVaultPricePerShare() (NodeID: 974)
  │ │   💬 Args: [no args]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256,enum Math.Rounding) (NodeID: 975)
  │ │     💬 Args: [totalAssetsVault, vault.PRECISION(), totalSupplyAmount, Math.Rounding.Floor]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 976)
  │ │   │   💬 Args: [unsignedRoundsUp(rounding) && (mulmod(x, y, denominator) > 0)]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: Math.unsignedRoundsUp(enum Math.Rounding) (NodeID: 977)
  │ │   │     💬 Args: [rounding]
  │ │   │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 978)
  │ │       💬 Args: [x, y, denominator]
  │ │       👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 979)
  │ │     │   💬 Args: [x, y]
  │ │     │   👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 980)
  │ │         💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 981)
  │ │           💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │ │           👁️  Def: internal
  │ │         └─ [7] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 982)
  │ │             💬 Args: [condition]
  │ │             👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 983)
  │ │   💬 Args: [depositAmount, strategy.PRECISION(), pricePerShare]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 984)
  │ │ │   💬 Args: [x, y]
  │ │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 985)
  │ │     💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 986)
  │ │       💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 987)
  │ │         💬 Args: [condition]
  │ │         👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: BaseSuperVaultTest._trackDeposit(address,uint256,uint256) (NodeID: 988)
  │     💬 Args: [accountEth, shares, depositAmount]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 989)
  │   💬 Args: [vars.shares3, 0, "no shares minted for deposit 3"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 990)
  │   💬 Args: [vars.shares3, vars.shares2, "less shares than it should - deposit 3"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseSuperVaultTest._updateSuperVaultPPS(address,address) (NodeID: 991)
  │   💬 Args: [address(strategy5115SuperVault), address(sv5115)]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256,enum Math.Rounding) (NodeID: 992)
  │ │   💬 Args: [vars.currentTotalAssets, vars.precision, vars.totalSupplyAmount, Math.Rounding.Floor]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 993)
  │ │ │   💬 Args: [unsignedRoundsUp(rounding) && (mulmod(x, y, denominator) > 0)]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Math.unsignedRoundsUp(enum Math.Rounding) (NodeID: 994)
  │ │ │     💬 Args: [rounding]
  │ │ │     👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 995)
  │ │     💬 Args: [x, y, denominator]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 996)
  │ │   │   💬 Args: [x, y]
  │ │   │   👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 997)
  │ │       💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 998)
  │ │         💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 999)
  │ │           💬 Args: [condition]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: MessageHashUtils.toTypedDataHash(bytes32,bytes32) (NodeID: 1000)
  │ │   💬 Args: [ecdsappsOracle.domainSeparator(), structHash]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: console.log(string,address,uint256) (NodeID: 1001)
  │     💬 Args: ["Updated PPS for strategy", strategyAddr, vars.pps]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 1002)
  │       💬 Args: [abi.encodeWithSignature("log(string,address,uint256)", p0, p1, p2)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 1003)
  │         💬 Args: [_sendLogPayloadView]
  │         👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 1004)
      💬 Args: [vars.ppsAfter, vars.ppsBefore]
      👁️  Def: internal
```
