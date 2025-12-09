# Function: test_10_RuggableVault_Deposit()

**Contract**: [test/integration/SuperVault/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_10_RuggableVault_Deposit()`
- **Visibility**: public
- **Source Range**: 329799:3432:580

## Implementation

```solidity
function test_10_RuggableVault_Deposit() public {
    RugTestVarsDeposit memory vars;
    vars.depositAmount = 1000e6;
    vars.rugPercentage = 5000;
    vars.initialTimestamp = block.timestamp;
    vars.ruggableVault = RuggableVault(Create2.deploy(0, keccak256(abi.encodePacked(TEST_SALT)), abi.encodePacked(type(RuggableVault).creationCode, abi.encode(IERC20(address(asset)), "Ruggable Vault", "RUG", true, false, vars.rugPercentage))));
    console2.log("ruggableVault", address(vars.ruggableVault));
    assertEq(address(vars.ruggableVault), test10_RuggableVault_Deposit, "TEST10_DEPOSIT VAULT NOT EQUAL TO PREDICTED");
    _getTokens(address(asset), address(this), 2 * LARGE_DEPOSIT);
    asset.approve(address(vars.ruggableVault), type(uint256).max);
    vars.ruggableVault.deposit(2 * LARGE_DEPOSIT, address(this));
    _deployNewSuperVaultWithRuggableVault(address(vars.ruggableVault));
    vars.depositUsers = new address[](5);
    vars.depositAmounts = new uint256[](5);
    for (uint256 i = 0; i < 5; i++) {
        vars.depositUsers[i] = accInstances[i].account;
        vars.depositAmounts[i] = vars.depositAmount;
    }
    for (uint256 i = 0; i < 5; i++) {
        _getTokens(address(asset), vars.depositUsers[i], vars.depositAmounts[i]);
        vm.startPrank(vars.depositUsers[i]);
        asset.approve(address(vault), vars.depositAmounts[i]);
        vault.deposit(vars.depositAmounts[i], vars.depositUsers[i]);
        vm.stopPrank();
    }
    vm.warp(vars.initialTimestamp + 1 days);
    uint256 sharesVault1 = IERC4626(address(fluidVault)).convertToShares((vars.depositAmount * 5) / 2);
    uint256 sharesVault2 = IERC4626(address(vars.ruggableVault)).convertToShares((vars.depositAmount * 5) / 2);
    uint256[] memory expectedAssetsOrSharesOut = new uint256[](2);
    expectedAssetsOrSharesOut[0] = sharesVault1 - ((sharesVault1 * 4e2) / 1e5);
    expectedAssetsOrSharesOut[1] = (sharesVault2 - ((sharesVault2 * vars.rugPercentage) / 10_000)) * 2;
    _depositFreeAssets((vars.depositAmount * 5) / 2, (vars.depositAmount * 5) / 2, address(fluidVault), address(vars.ruggableVault), expectedAssetsOrSharesOut, ISuperVaultStrategy.MINIMUM_OUTPUT_AMOUNT_ASSETS_NOT_MET.selector);
    expectedAssetsOrSharesOut[1] = sharesVault2 - ((sharesVault2 * vars.rugPercentage) / 10_000);
    _depositFreeAssets((vars.depositAmount * 5) / 2, (vars.depositAmount * 5) / 2, address(fluidVault), address(vars.ruggableVault), expectedAssetsOrSharesOut, bytes4(0));
}
```

## Related Implementations

### deploy(uint256,bytes32,bytes)

- **Kind**: internal
- **Source**: 1210:847:53
- **Link**: `lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/Create2.sol:Create2:deploy(uint256,bytes32,bytes)`

```solidity
///  @dev Deploys a contract using `CREATE2`. The address where the contract
///  will be deployed can be known in advance via {computeAddress}.
///  The bytecode for a contract can be obtained from Solidity with
///  `type(contractName).creationCode`.
///  Requirements:
///  - `bytecode` must not be empty.
///  - `salt` must have not been used for `bytecode` already.
///  - the factory must have a balance of at least `amount`.
///  - if `amount` is non-zero, `bytecode` must have a `payable` constructor.
function deploy(uint256 amount, bytes32 salt, bytes memory bytecode) internal returns (address addr) {
    if (address(this).balance < amount) {
        revert Errors.InsufficientBalance(address(this).balance, amount);
    }
    if (bytecode.length == 0) {
        revert Create2EmptyBytecode();
    }
    assembly ("memory-safe") {
        addr := create2(amount, add(bytecode, 0x20), mload(bytecode), salt)
        if and(iszero(addr), not(iszero(returndatasize()))) {
            let p := mload(0x40)
            returndatacopy(p, 0, returndatasize())
            revert(p, returndatasize())
        }
    }
    if (addr == address(0)) {
        revert Errors.FailedDeployment();
    }
}
```

### log(string,address)

- **Kind**: internal
- **Source**: 7740:145:26
- **Link**: `lib/forge-std/src/console.sol:console:log(string,address)`

```solidity
function log(string memory p0, address p1) internal pure {
    _sendLogPayload(abi.encodeWithSignature("log(string,address)", p0, p1));
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

### _getTokens(address,address,uint256)

- **Kind**: internal
- **Source**: 3137:118:500
- **Link**: `lib/v2-core/test/utils/Helpers.sol:Helpers:_getTokens(address,address,uint256)`

```solidity
function _getTokens(address token_, address to_, uint256 amount_) internal {
    deal(token_, to_, amount_);
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

### _deployNewSuperVaultWithRuggableVault(address)

- **Kind**: internal
- **Source**: 376362:1346:580
- **Link**: `test/integration/SuperVault/SuperVault.t.sol:SuperVaultTest:_deployNewSuperVaultWithRuggableVault(address)`

```solidity
function _deployNewSuperVaultWithRuggableVault(address ruggableVault) internal {
    address vaultAddr;
    address strategyAddr;
    address escrowAddr;
    (vaultAddr, strategyAddr, escrowAddr) = _deployVault("SV_USDC_RUG");
    vault = SuperVault(vaultAddr);
    strategy = SuperVaultStrategy(payable(strategyAddr));
    escrow = SuperVaultEscrow(escrowAddr);
    vm.startPrank(MANAGER);
    strategy.manageYieldSource(address(fluidVault), _getContract(ETH, ERC4626_YIELD_SOURCE_ORACLE_KEY), ISuperVaultStrategy.YieldSourceAction.Add);
    strategy.manageYieldSource(ruggableVault, _getContract(ETH, ERC4626_YIELD_SOURCE_ORACLE_KEY), ISuperVaultStrategy.YieldSourceAction.Add);
    vm.stopPrank();
    vm.startPrank(MANAGER);
    strategy.managePPSExpiration(ISuperVaultStrategy.PPSExpirationAction.Propose, 86_400);
    vm.warp(block.timestamp + 2 weeks);
    strategy.managePPSExpiration(ISuperVaultStrategy.PPSExpirationAction.Execute, 0);
    vm.stopPrank();
    _updateSuperVaultPPS(address(strategy), address(vault));
}
```

### _deployVault(string)

- **Kind**: internal
- **Source**: 16658:225:576
- **Link**: `test/integration/SuperVault/BaseSuperVaultTest.t.sol:BaseSuperVaultTest:_deployVault(string)`

```solidity
///  @notice Deploys a new SuperVault with default configuration
///  @param _superVaultSymbol The symbol for the SuperVault
///  @return vaultAddr The address of the deployed SuperVault
///  @return strategyAddr The address of the deployed SuperVaultStrategy
///  @return escrowAddr The address of the deployed SuperVaultEscrow
function _deployVault(string memory _superVaultSymbol) internal returns (address vaultAddr, address strategyAddr, address escrowAddr) {
    return _deployVault(address(asset), _superVaultSymbol);
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

### _depositFreeAssets(uint256,uint256,address,address,uint256[],bytes4)

- **Kind**: internal
- **Source**: 61062:2686:576
- **Link**: `test/integration/SuperVault/BaseSuperVaultTest.t.sol:BaseSuperVaultTest:_depositFreeAssets(uint256,uint256,address,address,uint256[],bytes4)`

```solidity
function _depositFreeAssets(uint256 allocationAmountVault1, uint256 allocationAmountVault2, address vault1, address vault2, uint256[] memory expectedAssetsOrSharesOut, bytes4 revertSelector) internal {
    address depositHookAddress = _getHookAddress(ETH, APPROVE_AND_DEPOSIT_4626_VAULT_HOOK_KEY);
    address[] memory fulfillHooksAddresses = new address[](2);
    fulfillHooksAddresses[0] = depositHookAddress;
    fulfillHooksAddresses[1] = depositHookAddress;
    bytes[] memory fulfillHooksData = new bytes[](2);
    fulfillHooksData[0] = _createApproveAndDeposit4626HookData(_getYieldSourceOracleId(bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), MANAGER), vault1, address(asset), allocationAmountVault1, false, address(0), 0);
    fulfillHooksData[1] = _createApproveAndDeposit4626HookData(_getYieldSourceOracleId(bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), MANAGER), vault2, address(asset), allocationAmountVault2, false, address(0), 0);
    bytes[] memory argsForProofs = new bytes[](2);
    argsForProofs[0] = ISuperHookInspector(fulfillHooksAddresses[0]).inspect(fulfillHooksData[0]);
    argsForProofs[1] = ISuperHookInspector(fulfillHooksAddresses[1]).inspect(fulfillHooksData[1]);
    vm.startPrank(MANAGER);
    bool revertExpected = revertSelector != bytes4(0);
    if (revertExpected) {
        vm.expectRevert(revertSelector);
        strategy.executeHooks(ISuperVaultStrategy.ExecuteArgs({hooks: fulfillHooksAddresses, hookCalldata: fulfillHooksData, expectedAssetsOrSharesOut: expectedAssetsOrSharesOut, globalProofs: _getMerkleProofsForHooks(fulfillHooksAddresses, argsForProofs), strategyProofs: new bytes32[][](2)}));
    } else {
        strategy.executeHooks(ISuperVaultStrategy.ExecuteArgs({hooks: fulfillHooksAddresses, hookCalldata: fulfillHooksData, expectedAssetsOrSharesOut: expectedAssetsOrSharesOut, globalProofs: _getMerkleProofsForHooks(fulfillHooksAddresses, argsForProofs), strategyProofs: new bytes32[][](2)}));
    }
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

## External Calls

- **IERC20Metadata::approve(address,uint256)**
- **RuggableVault::deposit(uint256,address)**
- **Vm::startPrank(address)**
- **SuperVault::deposit(uint256,address)**
- **Vm::stopPrank()**
- **Vm::warp(uint256)**
- **IERC4626::convertToShares(uint256)**

## State Variable Reads

- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]
- **stdstore** (`struct StdStorage`)
- **UINT256_MAX** (`uint256`)
- **asset** (`contract IERC20Metadata`) [lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol/interface_IERC20Metadata.md]
- **aggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **contractAddresses** (`mapping(uint64 => mapping(string => address))`)
- **totalAssetHelper** (`contract TotalAssetHelper`) [test/integration/SuperVault/TotalAssetHelper.sol/contract_TotalAssetHelper.md]
- **ecdsappsOracle** (`contract IECDSAPPSOracle`) [src/interfaces/oracles/IECDSAPPSOracle.sol/interface_IECDSAPPSOracle.md]
- **strategy** (`contract SuperVaultStrategy`) [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]
- **hookAddresses** (`mapping(uint64 => mapping(string => address))`)
- **currentChainId** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_10_RuggableVault_Deposit() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: Create2.deploy(uint256,bytes32,bytes) (NodeID: 1)
  │   💬 Args: [0, keccak256(abi.encodePacked(TEST_SALT)), abi.encodePacked(type(RuggableVault).creationCode, abi.encode(IERC20(address(asset)), "Ruggable Vault", "RUG", true, false, vars.rugPercentage))]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,address) (NodeID: 2)
  │   💬 Args: ["ruggableVault", address(vars.ruggableVault)]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 3)
  │     💬 Args: [abi.encodeWithSignature("log(string,address)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 4)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 5)
  │   💬 Args: [address(vars.ruggableVault), test10_RuggableVault_Deposit, "TEST10_DEPOSIT VAULT NOT EQUAL TO PREDICTED"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Helpers._getTokens(address,address,uint256) (NodeID: 6)
  │   💬 Args: [address(asset), address(this), 2 * LARGE_DEPOSIT]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdCheats.deal(address,address,uint256) (NodeID: 7)
  │     💬 Args: [token_, to_, amount_]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdCheats.deal(address,address,uint256,bool) (NodeID: 8)
  │       💬 Args: [token, to, give, false]
  │       👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: stdStorage.target(struct StdStorage,address) (NodeID: 9)
  │     │   💬 Args: [stdstore, token]
  │     │   👁️  Def: internal
  │     │ └─ [5] ⚙️ FUNCTION: stdStorageSafe.target(struct StdStorage,address) (NodeID: 10)
  │     │     💬 Args: [self, _target]
  │     │     👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: stdStorage.sig(struct StdStorage,bytes4) (NodeID: 11)
  │     │   💬 Args: [stdstore.target(token), 0x70a08231]
  │     │   👁️  Def: internal
  │     │ └─ [5] ⚙️ FUNCTION: stdStorageSafe.sig(struct StdStorage,bytes4) (NodeID: 12)
  │     │     💬 Args: [self, _sig]
  │     │     👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: stdStorage.with_key(struct StdStorage,address) (NodeID: 13)
  │     │   💬 Args: [stdstore.target(token).sig(0x70a08231), to]
  │     │   👁️  Def: internal
  │     │ └─ [5] ⚙️ FUNCTION: stdStorageSafe.with_key(struct StdStorage,address) (NodeID: 14)
  │     │     💬 Args: [self, who]
  │     │     👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,uint256) (NodeID: 15)
  │     │   💬 Args: [stdstore.target(token).sig(0x70a08231).with_key(to), give]
  │     │   👁️  Def: internal
  │     │ └─ [5] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,bytes32) (NodeID: 16)
  │     │     💬 Args: [self, bytes32(amt)]
  │     │     👁️  Def: internal
  │     │   ├─ [6] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 17)
  │     │   │   💬 Args: [self]
  │     │   │   👁️  Def: internal
  │     │   │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 18)
  │     │   │     💬 Args: [self._keys]
  │     │   │     👁️  Def: private
  │     │   ├─ [6] ⚙️ FUNCTION: stdStorage.find(struct StdStorage,bool) (NodeID: 19)
  │     │   │   💬 Args: [self, false]
  │     │   │   👁️  Def: internal
  │     │   │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.find(struct StdStorage,bool) (NodeID: 20)
  │     │   │     💬 Args: [self, _clear]
  │     │   │     👁️  Def: internal
  │     │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 21)
  │     │   │   │   💬 Args: [self]
  │     │   │   │   👁️  Def: internal
  │     │   │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 22)
  │     │   │   │     💬 Args: [self._keys]
  │     │   │   │     👁️  Def: private
  │     │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 23)
  │     │   │   │   💬 Args: [self]
  │     │   │   │   👁️  Def: internal
  │     │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 24)
  │     │   │   │   💬 Args: [self]
  │     │   │   │   👁️  Def: internal
  │     │   │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 25)
  │     │   │   │ │   💬 Args: [self]
  │     │   │   │ │   👁️  Def: internal
  │     │   │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 26)
  │     │   │   │ │     💬 Args: [self._keys]
  │     │   │   │ │     👁️  Def: private
  │     │   │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 27)
  │     │   │   │     💬 Args: [rdat, 32 * self._depth]
  │     │   │   │     👁️  Def: private
  │     │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.checkSlotMutatesCall(struct StdStorage,bytes32) (NodeID: 28)
  │     │   │   │   💬 Args: [self, reads[i]]
  │     │   │   │   👁️  Def: internal
  │     │   │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 29)
  │     │   │   │ │   💬 Args: [self]
  │     │   │   │ │   👁️  Def: internal
  │     │   │   │ │ ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 30)
  │     │   │   │ │ │   💬 Args: [self]
  │     │   │   │ │ │   👁️  Def: internal
  │     │   │   │ │ │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 31)
  │     │   │   │ │ │     💬 Args: [self._keys]
  │     │   │   │ │ │     👁️  Def: private
  │     │   │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 32)
  │     │   │   │ │     💬 Args: [rdat, 32 * self._depth]
  │     │   │   │ │     👁️  Def: private
  │     │   │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 33)
  │     │   │   │     💬 Args: [self]
  │     │   │   │     👁️  Def: internal
  │     │   │   │   ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 34)
  │     │   │   │   │   💬 Args: [self]
  │     │   │   │   │   👁️  Def: internal
  │     │   │   │   │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 35)
  │     │   │   │   │     💬 Args: [self._keys]
  │     │   │   │   │     👁️  Def: private
  │     │   │   │   └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 36)
  │     │   │   │       💬 Args: [rdat, 32 * self._depth]
  │     │   │   │       👁️  Def: private
  │     │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.findOffsets(struct StdStorage,bytes32) (NodeID: 37)
  │     │   │   │   💬 Args: [self, reads[i]]
  │     │   │   │   👁️  Def: internal
  │     │   │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 38)
  │     │   │   │ │   💬 Args: [self, slot, true]
  │     │   │   │ │   👁️  Def: internal
  │     │   │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 39)
  │     │   │   │ │     💬 Args: [self]
  │     │   │   │ │     👁️  Def: internal
  │     │   │   │ │   ├─ [11] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 40)
  │     │   │   │ │   │   💬 Args: [self]
  │     │   │   │ │   │   👁️  Def: internal
  │     │   │   │ │   │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 41)
  │     │   │   │ │   │     💬 Args: [self._keys]
  │     │   │   │ │   │     👁️  Def: private
  │     │   │   │ │   └─ [11] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 42)
  │     │   │   │ │       💬 Args: [rdat, 32 * self._depth]
  │     │   │   │ │       👁️  Def: private
  │     │   │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 43)
  │     │   │   │     💬 Args: [self, slot, false]
  │     │   │   │     👁️  Def: internal
  │     │   │   │   └─ [10] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 44)
  │     │   │   │       💬 Args: [self]
  │     │   │   │       👁️  Def: internal
  │     │   │   │     ├─ [11] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 45)
  │     │   │   │     │   💬 Args: [self]
  │     │   │   │     │   👁️  Def: internal
  │     │   │   │     │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 46)
  │     │   │   │     │     💬 Args: [self._keys]
  │     │   │   │     │     👁️  Def: private
  │     │   │   │     └─ [11] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 47)
  │     │   │   │         💬 Args: [rdat, 32 * self._depth]
  │     │   │   │         👁️  Def: private
  │     │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 48)
  │     │   │   │   💬 Args: [offsetLeft, offsetRight]
  │     │   │   │   👁️  Def: internal
  │     │   │   └─ [8] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 49)
  │     │   │       💬 Args: [self]
  │     │   │       👁️  Def: internal
  │     │   ├─ [6] ⚙️ FUNCTION: stdStorageSafe.getUpdatedSlotValue(bytes32,uint256,uint256,uint256) (NodeID: 50)
  │     │   │   💬 Args: [curVal, uint256(set), data.offsetLeft, data.offsetRight]
  │     │   │   👁️  Def: internal
  │     │   │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 51)
  │     │   │     💬 Args: [offsetLeft, offsetRight]
  │     │   │     👁️  Def: internal
  │     │   ├─ [6] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 52)
  │     │   │   💬 Args: [self]
  │     │   │   👁️  Def: internal
  │     │   │ ├─ [7] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 53)
  │     │   │ │   💬 Args: [self]
  │     │   │ │   👁️  Def: internal
  │     │   │ │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 54)
  │     │   │ │     💬 Args: [self._keys]
  │     │   │ │     👁️  Def: private
  │     │   │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 55)
  │     │   │     💬 Args: [rdat, 32 * self._depth]
  │     │   │     👁️  Def: private
  │     │   └─ [6] ⚙️ FUNCTION: stdStorage.clear(struct StdStorage) (NodeID: 56)
  │     │       💬 Args: [self]
  │     │       👁️  Def: internal
  │     │     └─ [7] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 57)
  │     │         💬 Args: [self]
  │     │         👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: stdStorage.target(struct StdStorage,address) (NodeID: 58)
  │     │   💬 Args: [stdstore, token]
  │     │   👁️  Def: internal
  │     │ └─ [5] ⚙️ FUNCTION: stdStorageSafe.target(struct StdStorage,address) (NodeID: 59)
  │     │     💬 Args: [self, _target]
  │     │     👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: stdStorage.sig(struct StdStorage,bytes4) (NodeID: 60)
  │     │   💬 Args: [stdstore.target(token), 0x18160ddd]
  │     │   👁️  Def: internal
  │     │ └─ [5] ⚙️ FUNCTION: stdStorageSafe.sig(struct StdStorage,bytes4) (NodeID: 61)
  │     │     💬 Args: [self, _sig]
  │     │     👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,uint256) (NodeID: 62)
  │         💬 Args: [stdstore.target(token).sig(0x18160ddd), totSup]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,bytes32) (NodeID: 63)
  │           💬 Args: [self, bytes32(amt)]
  │           👁️  Def: internal
  │         ├─ [6] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 64)
  │         │   💬 Args: [self]
  │         │   👁️  Def: internal
  │         │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 65)
  │         │     💬 Args: [self._keys]
  │         │     👁️  Def: private
  │         ├─ [6] ⚙️ FUNCTION: stdStorage.find(struct StdStorage,bool) (NodeID: 66)
  │         │   💬 Args: [self, false]
  │         │   👁️  Def: internal
  │         │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.find(struct StdStorage,bool) (NodeID: 67)
  │         │     💬 Args: [self, _clear]
  │         │     👁️  Def: internal
  │         │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 68)
  │         │   │   💬 Args: [self]
  │         │   │   👁️  Def: internal
  │         │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 69)
  │         │   │     💬 Args: [self._keys]
  │         │   │     👁️  Def: private
  │         │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 70)
  │         │   │   💬 Args: [self]
  │         │   │   👁️  Def: internal
  │         │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 71)
  │         │   │   💬 Args: [self]
  │         │   │   👁️  Def: internal
  │         │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 72)
  │         │   │ │   💬 Args: [self]
  │         │   │ │   👁️  Def: internal
  │         │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 73)
  │         │   │ │     💬 Args: [self._keys]
  │         │   │ │     👁️  Def: private
  │         │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 74)
  │         │   │     💬 Args: [rdat, 32 * self._depth]
  │         │   │     👁️  Def: private
  │         │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.checkSlotMutatesCall(struct StdStorage,bytes32) (NodeID: 75)
  │         │   │   💬 Args: [self, reads[i]]
  │         │   │   👁️  Def: internal
  │         │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 76)
  │         │   │ │   💬 Args: [self]
  │         │   │ │   👁️  Def: internal
  │         │   │ │ ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 77)
  │         │   │ │ │   💬 Args: [self]
  │         │   │ │ │   👁️  Def: internal
  │         │   │ │ │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 78)
  │         │   │ │ │     💬 Args: [self._keys]
  │         │   │ │ │     👁️  Def: private
  │         │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 79)
  │         │   │ │     💬 Args: [rdat, 32 * self._depth]
  │         │   │ │     👁️  Def: private
  │         │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 80)
  │         │   │     💬 Args: [self]
  │         │   │     👁️  Def: internal
  │         │   │   ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 81)
  │         │   │   │   💬 Args: [self]
  │         │   │   │   👁️  Def: internal
  │         │   │   │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 82)
  │         │   │   │     💬 Args: [self._keys]
  │         │   │   │     👁️  Def: private
  │         │   │   └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 83)
  │         │   │       💬 Args: [rdat, 32 * self._depth]
  │         │   │       👁️  Def: private
  │         │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.findOffsets(struct StdStorage,bytes32) (NodeID: 84)
  │         │   │   💬 Args: [self, reads[i]]
  │         │   │   👁️  Def: internal
  │         │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 85)
  │         │   │ │   💬 Args: [self, slot, true]
  │         │   │ │   👁️  Def: internal
  │         │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 86)
  │         │   │ │     💬 Args: [self]
  │         │   │ │     👁️  Def: internal
  │         │   │ │   ├─ [11] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 87)
  │         │   │ │   │   💬 Args: [self]
  │         │   │ │   │   👁️  Def: internal
  │         │   │ │   │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 88)
  │         │   │ │   │     💬 Args: [self._keys]
  │         │   │ │   │     👁️  Def: private
  │         │   │ │   └─ [11] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 89)
  │         │   │ │       💬 Args: [rdat, 32 * self._depth]
  │         │   │ │       👁️  Def: private
  │         │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 90)
  │         │   │     💬 Args: [self, slot, false]
  │         │   │     👁️  Def: internal
  │         │   │   └─ [10] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 91)
  │         │   │       💬 Args: [self]
  │         │   │       👁️  Def: internal
  │         │   │     ├─ [11] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 92)
  │         │   │     │   💬 Args: [self]
  │         │   │     │   👁️  Def: internal
  │         │   │     │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 93)
  │         │   │     │     💬 Args: [self._keys]
  │         │   │     │     👁️  Def: private
  │         │   │     └─ [11] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 94)
  │         │   │         💬 Args: [rdat, 32 * self._depth]
  │         │   │         👁️  Def: private
  │         │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 95)
  │         │   │   💬 Args: [offsetLeft, offsetRight]
  │         │   │   👁️  Def: internal
  │         │   └─ [8] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 96)
  │         │       💬 Args: [self]
  │         │       👁️  Def: internal
  │         ├─ [6] ⚙️ FUNCTION: stdStorageSafe.getUpdatedSlotValue(bytes32,uint256,uint256,uint256) (NodeID: 97)
  │         │   💬 Args: [curVal, uint256(set), data.offsetLeft, data.offsetRight]
  │         │   👁️  Def: internal
  │         │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 98)
  │         │     💬 Args: [offsetLeft, offsetRight]
  │         │     👁️  Def: internal
  │         ├─ [6] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 99)
  │         │   💬 Args: [self]
  │         │   👁️  Def: internal
  │         │ ├─ [7] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 100)
  │         │ │   💬 Args: [self]
  │         │ │   👁️  Def: internal
  │         │ │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 101)
  │         │ │     💬 Args: [self._keys]
  │         │ │     👁️  Def: private
  │         │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 102)
  │         │     💬 Args: [rdat, 32 * self._depth]
  │         │     👁️  Def: private
  │         └─ [6] ⚙️ FUNCTION: stdStorage.clear(struct StdStorage) (NodeID: 103)
  │             💬 Args: [self]
  │             👁️  Def: internal
  │           └─ [7] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 104)
  │               💬 Args: [self]
  │               👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: SuperVaultTest._deployNewSuperVaultWithRuggableVault(address) (NodeID: 105)
  │   💬 Args: [address(vars.ruggableVault)]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseSuperVaultTest._deployVault(string) (NodeID: 106)
  │ │   💬 Args: ["SV_USDC_RUG"]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: BaseSuperVaultTest._deployVault(address,string) (NodeID: 107)
  │ │     💬 Args: [address(asset), _superVaultSymbol]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseTest._getContract(uint64,string) (NodeID: 108)
  │ │   💬 Args: [ETH, ERC4626_YIELD_SOURCE_ORACLE_KEY]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseTest._getContract(uint64,string) (NodeID: 109)
  │ │   💬 Args: [ETH, ERC4626_YIELD_SOURCE_ORACLE_KEY]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: BaseSuperVaultTest._updateSuperVaultPPS(address,address) (NodeID: 110)
  │     💬 Args: [address(strategy), address(vault)]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256,enum Math.Rounding) (NodeID: 111)
  │   │   💬 Args: [vars.currentTotalAssets, vars.precision, vars.totalSupplyAmount, Math.Rounding.Floor]
  │   │   👁️  Def: internal
  │   │ ├─ [4] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 112)
  │   │ │   💬 Args: [unsignedRoundsUp(rounding) && (mulmod(x, y, denominator) > 0)]
  │   │ │   👁️  Def: internal
  │   │ │ └─ [5] ⚙️ FUNCTION: Math.unsignedRoundsUp(enum Math.Rounding) (NodeID: 113)
  │   │ │     💬 Args: [rounding]
  │   │ │     👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 114)
  │   │     💬 Args: [x, y, denominator]
  │   │     👁️  Def: internal
  │   │   ├─ [5] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 115)
  │   │   │   💬 Args: [x, y]
  │   │   │   👁️  Def: internal
  │   │   └─ [5] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 116)
  │   │       💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │   │       👁️  Def: internal
  │   │     └─ [6] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 117)
  │   │         💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │   │         👁️  Def: internal
  │   │       └─ [7] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 118)
  │   │           💬 Args: [condition]
  │   │           👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: MessageHashUtils.toTypedDataHash(bytes32,bytes32) (NodeID: 119)
  │   │   💬 Args: [ecdsappsOracle.domainSeparator(), structHash]
  │   │   👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: console.log(string,address,uint256) (NodeID: 120)
  │       💬 Args: ["Updated PPS for strategy", strategyAddr, vars.pps]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 121)
  │         💬 Args: [abi.encodeWithSignature("log(string,address,uint256)", p0, p1, p2)]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 122)
  │           💬 Args: [_sendLogPayloadView]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Helpers._getTokens(address,address,uint256) (NodeID: 123)
  │   💬 Args: [address(asset), vars.depositUsers[i], vars.depositAmounts[i]]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdCheats.deal(address,address,uint256) (NodeID: 124)
  │     💬 Args: [token_, to_, amount_]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdCheats.deal(address,address,uint256,bool) (NodeID: 125)
  │       💬 Args: [token, to, give, false]
  │       👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: stdStorage.target(struct StdStorage,address) (NodeID: 126)
  │     │   💬 Args: [stdstore, token]
  │     │   👁️  Def: internal
  │     │ └─ [5] ⚙️ FUNCTION: stdStorageSafe.target(struct StdStorage,address) (NodeID: 127)
  │     │     💬 Args: [self, _target]
  │     │     👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: stdStorage.sig(struct StdStorage,bytes4) (NodeID: 128)
  │     │   💬 Args: [stdstore.target(token), 0x70a08231]
  │     │   👁️  Def: internal
  │     │ └─ [5] ⚙️ FUNCTION: stdStorageSafe.sig(struct StdStorage,bytes4) (NodeID: 129)
  │     │     💬 Args: [self, _sig]
  │     │     👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: stdStorage.with_key(struct StdStorage,address) (NodeID: 130)
  │     │   💬 Args: [stdstore.target(token).sig(0x70a08231), to]
  │     │   👁️  Def: internal
  │     │ └─ [5] ⚙️ FUNCTION: stdStorageSafe.with_key(struct StdStorage,address) (NodeID: 131)
  │     │     💬 Args: [self, who]
  │     │     👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,uint256) (NodeID: 132)
  │     │   💬 Args: [stdstore.target(token).sig(0x70a08231).with_key(to), give]
  │     │   👁️  Def: internal
  │     │ └─ [5] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,bytes32) (NodeID: 133)
  │     │     💬 Args: [self, bytes32(amt)]
  │     │     👁️  Def: internal
  │     │   ├─ [6] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 134)
  │     │   │   💬 Args: [self]
  │     │   │   👁️  Def: internal
  │     │   │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 135)
  │     │   │     💬 Args: [self._keys]
  │     │   │     👁️  Def: private
  │     │   ├─ [6] ⚙️ FUNCTION: stdStorage.find(struct StdStorage,bool) (NodeID: 136)
  │     │   │   💬 Args: [self, false]
  │     │   │   👁️  Def: internal
  │     │   │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.find(struct StdStorage,bool) (NodeID: 137)
  │     │   │     💬 Args: [self, _clear]
  │     │   │     👁️  Def: internal
  │     │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 138)
  │     │   │   │   💬 Args: [self]
  │     │   │   │   👁️  Def: internal
  │     │   │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 139)
  │     │   │   │     💬 Args: [self._keys]
  │     │   │   │     👁️  Def: private
  │     │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 140)
  │     │   │   │   💬 Args: [self]
  │     │   │   │   👁️  Def: internal
  │     │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 141)
  │     │   │   │   💬 Args: [self]
  │     │   │   │   👁️  Def: internal
  │     │   │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 142)
  │     │   │   │ │   💬 Args: [self]
  │     │   │   │ │   👁️  Def: internal
  │     │   │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 143)
  │     │   │   │ │     💬 Args: [self._keys]
  │     │   │   │ │     👁️  Def: private
  │     │   │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 144)
  │     │   │   │     💬 Args: [rdat, 32 * self._depth]
  │     │   │   │     👁️  Def: private
  │     │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.checkSlotMutatesCall(struct StdStorage,bytes32) (NodeID: 145)
  │     │   │   │   💬 Args: [self, reads[i]]
  │     │   │   │   👁️  Def: internal
  │     │   │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 146)
  │     │   │   │ │   💬 Args: [self]
  │     │   │   │ │   👁️  Def: internal
  │     │   │   │ │ ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 147)
  │     │   │   │ │ │   💬 Args: [self]
  │     │   │   │ │ │   👁️  Def: internal
  │     │   │   │ │ │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 148)
  │     │   │   │ │ │     💬 Args: [self._keys]
  │     │   │   │ │ │     👁️  Def: private
  │     │   │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 149)
  │     │   │   │ │     💬 Args: [rdat, 32 * self._depth]
  │     │   │   │ │     👁️  Def: private
  │     │   │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 150)
  │     │   │   │     💬 Args: [self]
  │     │   │   │     👁️  Def: internal
  │     │   │   │   ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 151)
  │     │   │   │   │   💬 Args: [self]
  │     │   │   │   │   👁️  Def: internal
  │     │   │   │   │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 152)
  │     │   │   │   │     💬 Args: [self._keys]
  │     │   │   │   │     👁️  Def: private
  │     │   │   │   └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 153)
  │     │   │   │       💬 Args: [rdat, 32 * self._depth]
  │     │   │   │       👁️  Def: private
  │     │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.findOffsets(struct StdStorage,bytes32) (NodeID: 154)
  │     │   │   │   💬 Args: [self, reads[i]]
  │     │   │   │   👁️  Def: internal
  │     │   │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 155)
  │     │   │   │ │   💬 Args: [self, slot, true]
  │     │   │   │ │   👁️  Def: internal
  │     │   │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 156)
  │     │   │   │ │     💬 Args: [self]
  │     │   │   │ │     👁️  Def: internal
  │     │   │   │ │   ├─ [11] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 157)
  │     │   │   │ │   │   💬 Args: [self]
  │     │   │   │ │   │   👁️  Def: internal
  │     │   │   │ │   │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 158)
  │     │   │   │ │   │     💬 Args: [self._keys]
  │     │   │   │ │   │     👁️  Def: private
  │     │   │   │ │   └─ [11] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 159)
  │     │   │   │ │       💬 Args: [rdat, 32 * self._depth]
  │     │   │   │ │       👁️  Def: private
  │     │   │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 160)
  │     │   │   │     💬 Args: [self, slot, false]
  │     │   │   │     👁️  Def: internal
  │     │   │   │   └─ [10] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 161)
  │     │   │   │       💬 Args: [self]
  │     │   │   │       👁️  Def: internal
  │     │   │   │     ├─ [11] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 162)
  │     │   │   │     │   💬 Args: [self]
  │     │   │   │     │   👁️  Def: internal
  │     │   │   │     │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 163)
  │     │   │   │     │     💬 Args: [self._keys]
  │     │   │   │     │     👁️  Def: private
  │     │   │   │     └─ [11] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 164)
  │     │   │   │         💬 Args: [rdat, 32 * self._depth]
  │     │   │   │         👁️  Def: private
  │     │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 165)
  │     │   │   │   💬 Args: [offsetLeft, offsetRight]
  │     │   │   │   👁️  Def: internal
  │     │   │   └─ [8] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 166)
  │     │   │       💬 Args: [self]
  │     │   │       👁️  Def: internal
  │     │   ├─ [6] ⚙️ FUNCTION: stdStorageSafe.getUpdatedSlotValue(bytes32,uint256,uint256,uint256) (NodeID: 167)
  │     │   │   💬 Args: [curVal, uint256(set), data.offsetLeft, data.offsetRight]
  │     │   │   👁️  Def: internal
  │     │   │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 168)
  │     │   │     💬 Args: [offsetLeft, offsetRight]
  │     │   │     👁️  Def: internal
  │     │   ├─ [6] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 169)
  │     │   │   💬 Args: [self]
  │     │   │   👁️  Def: internal
  │     │   │ ├─ [7] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 170)
  │     │   │ │   💬 Args: [self]
  │     │   │ │   👁️  Def: internal
  │     │   │ │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 171)
  │     │   │ │     💬 Args: [self._keys]
  │     │   │ │     👁️  Def: private
  │     │   │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 172)
  │     │   │     💬 Args: [rdat, 32 * self._depth]
  │     │   │     👁️  Def: private
  │     │   └─ [6] ⚙️ FUNCTION: stdStorage.clear(struct StdStorage) (NodeID: 173)
  │     │       💬 Args: [self]
  │     │       👁️  Def: internal
  │     │     └─ [7] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 174)
  │     │         💬 Args: [self]
  │     │         👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: stdStorage.target(struct StdStorage,address) (NodeID: 175)
  │     │   💬 Args: [stdstore, token]
  │     │   👁️  Def: internal
  │     │ └─ [5] ⚙️ FUNCTION: stdStorageSafe.target(struct StdStorage,address) (NodeID: 176)
  │     │     💬 Args: [self, _target]
  │     │     👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: stdStorage.sig(struct StdStorage,bytes4) (NodeID: 177)
  │     │   💬 Args: [stdstore.target(token), 0x18160ddd]
  │     │   👁️  Def: internal
  │     │ └─ [5] ⚙️ FUNCTION: stdStorageSafe.sig(struct StdStorage,bytes4) (NodeID: 178)
  │     │     💬 Args: [self, _sig]
  │     │     👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,uint256) (NodeID: 179)
  │         💬 Args: [stdstore.target(token).sig(0x18160ddd), totSup]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,bytes32) (NodeID: 180)
  │           💬 Args: [self, bytes32(amt)]
  │           👁️  Def: internal
  │         ├─ [6] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 181)
  │         │   💬 Args: [self]
  │         │   👁️  Def: internal
  │         │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 182)
  │         │     💬 Args: [self._keys]
  │         │     👁️  Def: private
  │         ├─ [6] ⚙️ FUNCTION: stdStorage.find(struct StdStorage,bool) (NodeID: 183)
  │         │   💬 Args: [self, false]
  │         │   👁️  Def: internal
  │         │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.find(struct StdStorage,bool) (NodeID: 184)
  │         │     💬 Args: [self, _clear]
  │         │     👁️  Def: internal
  │         │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 185)
  │         │   │   💬 Args: [self]
  │         │   │   👁️  Def: internal
  │         │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 186)
  │         │   │     💬 Args: [self._keys]
  │         │   │     👁️  Def: private
  │         │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 187)
  │         │   │   💬 Args: [self]
  │         │   │   👁️  Def: internal
  │         │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 188)
  │         │   │   💬 Args: [self]
  │         │   │   👁️  Def: internal
  │         │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 189)
  │         │   │ │   💬 Args: [self]
  │         │   │ │   👁️  Def: internal
  │         │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 190)
  │         │   │ │     💬 Args: [self._keys]
  │         │   │ │     👁️  Def: private
  │         │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 191)
  │         │   │     💬 Args: [rdat, 32 * self._depth]
  │         │   │     👁️  Def: private
  │         │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.checkSlotMutatesCall(struct StdStorage,bytes32) (NodeID: 192)
  │         │   │   💬 Args: [self, reads[i]]
  │         │   │   👁️  Def: internal
  │         │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 193)
  │         │   │ │   💬 Args: [self]
  │         │   │ │   👁️  Def: internal
  │         │   │ │ ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 194)
  │         │   │ │ │   💬 Args: [self]
  │         │   │ │ │   👁️  Def: internal
  │         │   │ │ │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 195)
  │         │   │ │ │     💬 Args: [self._keys]
  │         │   │ │ │     👁️  Def: private
  │         │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 196)
  │         │   │ │     💬 Args: [rdat, 32 * self._depth]
  │         │   │ │     👁️  Def: private
  │         │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 197)
  │         │   │     💬 Args: [self]
  │         │   │     👁️  Def: internal
  │         │   │   ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 198)
  │         │   │   │   💬 Args: [self]
  │         │   │   │   👁️  Def: internal
  │         │   │   │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 199)
  │         │   │   │     💬 Args: [self._keys]
  │         │   │   │     👁️  Def: private
  │         │   │   └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 200)
  │         │   │       💬 Args: [rdat, 32 * self._depth]
  │         │   │       👁️  Def: private
  │         │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.findOffsets(struct StdStorage,bytes32) (NodeID: 201)
  │         │   │   💬 Args: [self, reads[i]]
  │         │   │   👁️  Def: internal
  │         │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 202)
  │         │   │ │   💬 Args: [self, slot, true]
  │         │   │ │   👁️  Def: internal
  │         │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 203)
  │         │   │ │     💬 Args: [self]
  │         │   │ │     👁️  Def: internal
  │         │   │ │   ├─ [11] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 204)
  │         │   │ │   │   💬 Args: [self]
  │         │   │ │   │   👁️  Def: internal
  │         │   │ │   │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 205)
  │         │   │ │   │     💬 Args: [self._keys]
  │         │   │ │   │     👁️  Def: private
  │         │   │ │   └─ [11] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 206)
  │         │   │ │       💬 Args: [rdat, 32 * self._depth]
  │         │   │ │       👁️  Def: private
  │         │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 207)
  │         │   │     💬 Args: [self, slot, false]
  │         │   │     👁️  Def: internal
  │         │   │   └─ [10] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 208)
  │         │   │       💬 Args: [self]
  │         │   │       👁️  Def: internal
  │         │   │     ├─ [11] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 209)
  │         │   │     │   💬 Args: [self]
  │         │   │     │   👁️  Def: internal
  │         │   │     │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 210)
  │         │   │     │     💬 Args: [self._keys]
  │         │   │     │     👁️  Def: private
  │         │   │     └─ [11] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 211)
  │         │   │         💬 Args: [rdat, 32 * self._depth]
  │         │   │         👁️  Def: private
  │         │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 212)
  │         │   │   💬 Args: [offsetLeft, offsetRight]
  │         │   │   👁️  Def: internal
  │         │   └─ [8] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 213)
  │         │       💬 Args: [self]
  │         │       👁️  Def: internal
  │         ├─ [6] ⚙️ FUNCTION: stdStorageSafe.getUpdatedSlotValue(bytes32,uint256,uint256,uint256) (NodeID: 214)
  │         │   💬 Args: [curVal, uint256(set), data.offsetLeft, data.offsetRight]
  │         │   👁️  Def: internal
  │         │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 215)
  │         │     💬 Args: [offsetLeft, offsetRight]
  │         │     👁️  Def: internal
  │         ├─ [6] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 216)
  │         │   💬 Args: [self]
  │         │   👁️  Def: internal
  │         │ ├─ [7] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 217)
  │         │ │   💬 Args: [self]
  │         │ │   👁️  Def: internal
  │         │ │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 218)
  │         │ │     💬 Args: [self._keys]
  │         │ │     👁️  Def: private
  │         │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 219)
  │         │     💬 Args: [rdat, 32 * self._depth]
  │         │     👁️  Def: private
  │         └─ [6] ⚙️ FUNCTION: stdStorage.clear(struct StdStorage) (NodeID: 220)
  │             💬 Args: [self]
  │             👁️  Def: internal
  │           └─ [7] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 221)
  │               💬 Args: [self]
  │               👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseSuperVaultTest._depositFreeAssets(uint256,uint256,address,address,uint256[],bytes4) (NodeID: 222)
  │   💬 Args: [(vars.depositAmount * 5) / 2, (vars.depositAmount * 5) / 2, address(fluidVault), address(vars.ruggableVault), expectedAssetsOrSharesOut, ISuperVaultStrategy.MINIMUM_OUTPUT_AMOUNT_ASSETS_NOT_MET.selector]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseTest._getHookAddress(uint64,string) (NodeID: 223)
  │ │   💬 Args: [ETH, APPROVE_AND_DEPOSIT_4626_VAULT_HOOK_KEY]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: InternalHelpers._createApproveAndDeposit4626HookData(bytes32,address,address,uint256,bool,address,uint256) (NodeID: 224)
  │ │   💬 Args: [_getYieldSourceOracleId(bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), MANAGER), vault1, address(asset), allocationAmountVault1, false, address(0), 0]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: InternalHelpers._getYieldSourceOracleId(bytes32,address) (NodeID: 225)
  │ │     💬 Args: [bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), MANAGER]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: InternalHelpers._createApproveAndDeposit4626HookData(bytes32,address,address,uint256,bool,address,uint256) (NodeID: 226)
  │ │   💬 Args: [_getYieldSourceOracleId(bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), MANAGER), vault2, address(asset), allocationAmountVault2, false, address(0), 0]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: InternalHelpers._getYieldSourceOracleId(bytes32,address) (NodeID: 227)
  │ │     💬 Args: [bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), MANAGER]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: MerkleReader._getMerkleProofsForHooks(address[],bytes[]) (NodeID: 228)
  │ │   💬 Args: [fulfillHooksAddresses, argsForProofs]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: MerkleReader._getMerkleProofsForHooks(address[],bytes[]) (NodeID: 229)
  │     💬 Args: [fulfillHooksAddresses, argsForProofs]
  │     👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: BaseSuperVaultTest._depositFreeAssets(uint256,uint256,address,address,uint256[],bytes4) (NodeID: 230)
      💬 Args: [(vars.depositAmount * 5) / 2, (vars.depositAmount * 5) / 2, address(fluidVault), address(vars.ruggableVault), expectedAssetsOrSharesOut, bytes4(0)]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BaseTest._getHookAddress(uint64,string) (NodeID: 231)
    │   💬 Args: [ETH, APPROVE_AND_DEPOSIT_4626_VAULT_HOOK_KEY]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: InternalHelpers._createApproveAndDeposit4626HookData(bytes32,address,address,uint256,bool,address,uint256) (NodeID: 232)
    │   💬 Args: [_getYieldSourceOracleId(bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), MANAGER), vault1, address(asset), allocationAmountVault1, false, address(0), 0]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: InternalHelpers._getYieldSourceOracleId(bytes32,address) (NodeID: 233)
    │     💬 Args: [bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), MANAGER]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: InternalHelpers._createApproveAndDeposit4626HookData(bytes32,address,address,uint256,bool,address,uint256) (NodeID: 234)
    │   💬 Args: [_getYieldSourceOracleId(bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), MANAGER), vault2, address(asset), allocationAmountVault2, false, address(0), 0]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: InternalHelpers._getYieldSourceOracleId(bytes32,address) (NodeID: 235)
    │     💬 Args: [bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), MANAGER]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: MerkleReader._getMerkleProofsForHooks(address[],bytes[]) (NodeID: 236)
    │   💬 Args: [fulfillHooksAddresses, argsForProofs]
    │   👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: MerkleReader._getMerkleProofsForHooks(address[],bytes[]) (NodeID: 237)
        💬 Args: [fulfillHooksAddresses, argsForProofs]
        👁️  Def: internal
```
