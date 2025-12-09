# Function: test_BatchUpdatePPS_ResizeArrays()

**Contract**: [test/oracles/ECDSAPPSOracle.t.sol/contract_ECDSAPPSOracleTest.md]

## Metadata

- **Contract**: ECDSAPPSOracleTest
- **Signature**: `test_BatchUpdatePPS_ResizeArrays()`
- **Visibility**: public
- **Source Range**: 43704:3955:622

## Implementation

```solidity
function test_BatchUpdatePPS_ResizeArrays() public {
    BatchTestData memory data;
    data.strategy1 = address(svStrategy);
    (, data.strategy2, ) = aggregatorSuperVault.createVault(ISuperVaultAggregator.VaultCreationParams({asset: address(asset), name: "Secondary TestVault", symbol: "STV", mainManager: mockManager, secondaryManagers: new address[](0), minUpdateInterval: 5, maxStaleness: 300, feeConfig: ISuperVaultStrategy.FeeConfig({performanceFeeBps: 1000, managementFeeBps: 0, recipient: TREASURY})}));
    (, data.strategy3, ) = aggregatorSuperVault.createVault(ISuperVaultAggregator.VaultCreationParams({asset: address(asset), name: "Third TestVault", symbol: "TV3", mainManager: mockManager, secondaryManagers: new address[](0), minUpdateInterval: 5, maxStaleness: 300, feeConfig: ISuperVaultStrategy.FeeConfig({performanceFeeBps: 1000, managementFeeBps: 0, recipient: TREASURY})}));
    vm.warp(block.timestamp + 1 days);
    data.strategies = new address[](3);
    data.strategies[0] = data.strategy1;
    data.strategies[1] = data.strategy2;
    data.strategies[2] = data.strategy3;
    data.ppss = new uint256[](3);
    data.ppss[0] = PPS;
    data.ppss[1] = PPS;
    data.ppss[2] = PPS;
    (data.strategies, data.ppss) = _swapIfNeeded(data.strategies, data.ppss);
    data.timestamps = new uint256[](3);
    data.timestamps[0] = block.timestamp;
    data.timestamps[1] = block.timestamp;
    data.timestamps[2] = block.timestamp;
    data.validatorSets = new uint256[](3);
    data.validatorSets[0] = 1;
    data.validatorSets[1] = 2;
    data.validatorSets[2] = 2;
    data.updateAuthorities = new address[](2);
    data.updateAuthorities[0] = user;
    data.updateAuthorities[1] = user;
    data.proofsArray = new bytes[][](3);
    data.proofsArray[0] = _createValidProofs(data.strategies[0], data.ppss[0], data.timestamps[0], new uint256[](0));
    data.proofsArray[1] = _createValidProofs(data.strategies[1], data.ppss[1], data.timestamps[1], new uint256[](0));
    data.proofsArray[2] = _createValidProofs(data.strategies[1], data.ppss[2], data.timestamps[2], new uint256[](0));
    vm.mockCall(governorAddress, abi.encodeWithSelector(ISuperGovernor.getValidatorsCount.selector), abi.encode(10));
    vm.mockCall(governorAddress, abi.encodeWithSelector(ISuperGovernor.getPPSOracleQuorum.selector), abi.encode(2));
    vm.mockCall(governorAddress, abi.encodeWithSelector(ISuperGovernor.isValidator.selector, 0x39852529E4D13aDA30bCE8cc0E442780b36E479F), abi.encode(true));
    vm.recordLogs();
    vm.prank(user);
    oracleECDSA.updatePPS(IECDSAPPSOracle.UpdatePPSArgs({strategies: data.strategies, proofsArray: data.proofsArray, ppss: data.ppss, timestamps: data.timestamps}));
    Vm.Log[] memory logs = vm.getRecordedLogs();
    uint256 count;
    for (uint256 i = 0; i < logs.length; i++) {
        if (logs[i].topics[0] == keccak256("PPSUpdated(address,uint256,uint256)")) {
            count++;
        }
    }
    assertEq(count, 2);
}
```

## Related Implementations

### _swapIfNeeded(address[],uint256[])

- **Kind**: internal
- **Source**: 47665:1363:622
- **Link**: `test/oracles/ECDSAPPSOracle.t.sol:ECDSAPPSOracleTest:_swapIfNeeded(address[],uint256[])`

```solidity
function _swapIfNeeded(address[] memory strategies, uint256[] memory ppss) internal pure returns (address[] memory, uint256[] memory) {
    if (uint160(strategies[0]) > uint160(strategies[1])) {
        address tmp = strategies[0];
        strategies[0] = strategies[1];
        strategies[1] = tmp;
        uint256 tmpPps = ppss[0];
        ppss[0] = ppss[1];
        ppss[1] = tmpPps;
    }
    if (uint160(strategies[1]) > uint160(strategies[2])) {
        address tmp = strategies[1];
        strategies[1] = strategies[2];
        strategies[2] = tmp;
        uint256 tmpPps = ppss[1];
        ppss[1] = ppss[2];
        ppss[2] = tmpPps;
    }
    if (uint160(strategies[0]) > uint160(strategies[1])) {
        address tmp = strategies[0];
        strategies[0] = strategies[1];
        strategies[1] = tmp;
        uint256 tmpPps = ppss[0];
        ppss[0] = ppss[1];
        ppss[1] = tmpPps;
    }
    return (strategies, ppss);
}
```

### _createValidProofs(address,uint256,uint256,uint256[])

- **Kind**: internal
- **Source**: 79274:1671:622
- **Link**: `test/oracles/ECDSAPPSOracle.t.sol:ECDSAPPSOracleTest:_createValidProofs(address,uint256,uint256,uint256[])`

```solidity
///  @notice Creates valid proofs for the ECDSAPPSOracle
///  @param strategy_ The address of the strategy
///  @param pps The price per share
///  @param timestamp The timestamp of the PPS update
///  @param specificSignerKeys An optional array of specific signer keys to use
///  @return proofs An array of valid proofs
function _createValidProofs(address strategy_, uint256 pps, uint256 timestamp, uint256[] memory specificSignerKeys) internal view returns (bytes[] memory) {
    bytes32 structHash = keccak256(abi.encodePacked(oracleECDSA.UPDATE_PPS_TYPEHASH(), strategy_, pps, timestamp, oracleECDSA.noncePerStrategy(address(svStrategy))));
    bytes32 domainSeparator = oracleECDSA.domainSeparator();
    bytes32 digest = MessageHashUtils.toTypedDataHash(domainSeparator, structHash);
    uint256[] memory signerKeys;
    if (specificSignerKeys.length > 0) {
        signerKeys = specificSignerKeys;
    } else {
        signerKeys = new uint256[](2);
        signerKeys[0] = validator1PrivateKey;
        signerKeys[1] = validator2PrivateKey;
    }
    _sortSignerKeysByAddress(signerKeys);
    bytes[] memory proofs = new bytes[](signerKeys.length);
    for (uint256 i = 0; i < signerKeys.length; i++) {
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(signerKeys[i], digest);
        proofs[i] = abi.encodePacked(r, s, v);
    }
    return proofs;
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

### _sortSignerKeysByAddress(uint256[])

- **Kind**: internal
- **Source**: 81093:683:622
- **Link**: `test/oracles/ECDSAPPSOracle.t.sol:ECDSAPPSOracleTest:_sortSignerKeysByAddress(uint256[])`

```solidity
/// @notice Sorts signer keys by their corresponding addresses in ascending order
///  @param signerKeys Array of private keys to sort
function _sortSignerKeysByAddress(uint256[] memory signerKeys) internal pure {
    uint256 length = signerKeys.length;
    for (uint256 i = 0; i < (length - 1); i++) {
        for (uint256 j = 0; j < ((length - i) - 1); j++) {
            address addr1 = vm.addr(signerKeys[j]);
            address addr2 = vm.addr(signerKeys[j + 1]);
            if (addr1 > addr2) {
                uint256 temp = signerKeys[j];
                signerKeys[j] = signerKeys[j + 1];
                signerKeys[j + 1] = temp;
            }
        }
    }
}
```

### assertEq(uint256,uint256)

- **Kind**: internal
- **Source**: 2664:153:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256)`

```solidity
function assertEq(uint256 left, uint256 right) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right);
    }
}
```

## External Calls

- **SuperVaultAggregator::createVault(struct ISuperVaultAggregator.VaultCreationParams)**
- **Vm::warp(uint256)**
- **Vm::mockCall(address,bytes,bytes)**
- **Vm::recordLogs()**
- **Vm::prank(address)**
- **ECDSAPPSOracle::updatePPS(struct IECDSAPPSOracle.UpdatePPSArgs)**
- **Vm::getRecordedLogs()**

## State Variable Reads

- **svStrategy** (`address`)
- **aggregatorSuperVault** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **mockManager** (`address`)
- **PPS** (`uint256`)
- **user** (`address`)
- **governorAddress** (`address`)
- **oracleECDSA** (`contract ECDSAPPSOracle`) [src/oracles/ECDSAPPSOracle.sol/contract_ECDSAPPSOracle.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ECDSAPPSOracleTest.test_BatchUpdatePPS_ResizeArrays() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: ECDSAPPSOracleTest._swapIfNeeded(address[],uint256[]) (NodeID: 1)
  │   💬 Args: [data.strategies, data.ppss]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: ECDSAPPSOracleTest._createValidProofs(address,uint256,uint256,uint256[]) (NodeID: 2)
  │   💬 Args: [data.strategies[0], data.ppss[0], data.timestamps[0], new uint256[](0)]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: MessageHashUtils.toTypedDataHash(bytes32,bytes32) (NodeID: 3)
  │ │   💬 Args: [domainSeparator, structHash]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: ECDSAPPSOracleTest._sortSignerKeysByAddress(uint256[]) (NodeID: 4)
  │     💬 Args: [signerKeys]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: ECDSAPPSOracleTest._createValidProofs(address,uint256,uint256,uint256[]) (NodeID: 5)
  │   💬 Args: [data.strategies[1], data.ppss[1], data.timestamps[1], new uint256[](0)]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: MessageHashUtils.toTypedDataHash(bytes32,bytes32) (NodeID: 6)
  │ │   💬 Args: [domainSeparator, structHash]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: ECDSAPPSOracleTest._sortSignerKeysByAddress(uint256[]) (NodeID: 7)
  │     💬 Args: [signerKeys]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: ECDSAPPSOracleTest._createValidProofs(address,uint256,uint256,uint256[]) (NodeID: 8)
  │   💬 Args: [data.strategies[1], data.ppss[2], data.timestamps[2], new uint256[](0)]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: MessageHashUtils.toTypedDataHash(bytes32,bytes32) (NodeID: 9)
  │ │   💬 Args: [domainSeparator, structHash]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: ECDSAPPSOracleTest._sortSignerKeysByAddress(uint256[]) (NodeID: 10)
  │     💬 Args: [signerKeys]
  │     👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 11)
      💬 Args: [count, 2]
      👁️  Def: internal
```
