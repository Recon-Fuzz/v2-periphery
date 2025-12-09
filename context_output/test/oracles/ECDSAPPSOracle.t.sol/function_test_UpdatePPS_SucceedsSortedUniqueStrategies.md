# Function: test_UpdatePPS_SucceedsSortedUniqueStrategies()

**Contract**: [test/oracles/ECDSAPPSOracle.t.sol/contract_ECDSAPPSOracleTest.md]

## Metadata

- **Contract**: ECDSAPPSOracleTest
- **Signature**: `test_UpdatePPS_SucceedsSortedUniqueStrategies()`
- **Visibility**: public
- **Source Range**: 100225:2526:622

## Implementation

```solidity
/// @notice Test that sorted unique strategies succeed
///  @dev Ensures the deduplication check doesn't break valid use cases
function test_UpdatePPS_SucceedsSortedUniqueStrategies() public {
    (, address svStrategy2, ) = aggregatorSuperVault.createVault(ISuperVaultAggregator.VaultCreationParams({asset: address(asset), name: "TestVault2", symbol: "TV2", mainManager: mockManager, secondaryManagers: new address[](0), minUpdateInterval: 5, maxStaleness: 300, feeConfig: ISuperVaultStrategy.FeeConfig({performanceFeeBps: 1000, managementFeeBps: 0, recipient: TREASURY})}));
    bytes[] memory proofs1 = _createValidProofs(address(svStrategy), PPS, block.timestamp, new uint256[](0));
    bytes[] memory proofs2 = _createValidProofs(address(svStrategy2), PPS, block.timestamp, new uint256[](0));
    uint256 nonce1Before = oracleECDSA.noncePerStrategy(svStrategy);
    uint256 nonce2Before = oracleECDSA.noncePerStrategy(svStrategy2);
    address[] memory strategies = new address[](2);
    bytes[][] memory proofsArray = new bytes[][](2);
    if (uint160(svStrategy) < uint160(svStrategy2)) {
        strategies[0] = address(svStrategy);
        strategies[1] = address(svStrategy2);
        proofsArray[0] = proofs1;
        proofsArray[1] = proofs2;
    } else {
        strategies[0] = address(svStrategy2);
        strategies[1] = address(svStrategy);
        proofsArray[0] = proofs2;
        proofsArray[1] = proofs1;
    }
    uint256[] memory ppss = new uint256[](2);
    ppss[0] = PPS;
    ppss[1] = PPS;
    uint256[] memory timestamps = new uint256[](2);
    timestamps[0] = block.timestamp;
    timestamps[1] = block.timestamp;
    oracleECDSA.updatePPS(IECDSAPPSOracle.UpdatePPSArgs({strategies: strategies, proofsArray: proofsArray, ppss: ppss, timestamps: timestamps}));
    assertEq(oracleECDSA.noncePerStrategy(svStrategy), nonce1Before + 1, "Strategy 1 nonce should increment once");
    assertEq(oracleECDSA.noncePerStrategy(svStrategy2), nonce2Before + 1, "Strategy 2 nonce should increment once");
}
```

## Related Implementations

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

## External Calls

- **SuperVaultAggregator::createVault(struct ISuperVaultAggregator.VaultCreationParams)**
- **ECDSAPPSOracle::noncePerStrategy(address)**
- **ECDSAPPSOracle::updatePPS(struct IECDSAPPSOracle.UpdatePPSArgs)**

## State Variable Reads

- **aggregatorSuperVault** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **mockManager** (`address`)
- **svStrategy** (`address`)
- **PPS** (`uint256`)
- **oracleECDSA** (`contract ECDSAPPSOracle`) [src/oracles/ECDSAPPSOracle.sol/contract_ECDSAPPSOracle.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ECDSAPPSOracleTest.test_UpdatePPS_SucceedsSortedUniqueStrategies() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: ECDSAPPSOracleTest._createValidProofs(address,uint256,uint256,uint256[]) (NodeID: 1)
  │   💬 Args: [address(svStrategy), PPS, block.timestamp, new uint256[](0)]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: MessageHashUtils.toTypedDataHash(bytes32,bytes32) (NodeID: 2)
  │ │   💬 Args: [domainSeparator, structHash]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: ECDSAPPSOracleTest._sortSignerKeysByAddress(uint256[]) (NodeID: 3)
  │     💬 Args: [signerKeys]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: ECDSAPPSOracleTest._createValidProofs(address,uint256,uint256,uint256[]) (NodeID: 4)
  │   💬 Args: [address(svStrategy2), PPS, block.timestamp, new uint256[](0)]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: MessageHashUtils.toTypedDataHash(bytes32,bytes32) (NodeID: 5)
  │ │   💬 Args: [domainSeparator, structHash]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: ECDSAPPSOracleTest._sortSignerKeysByAddress(uint256[]) (NodeID: 6)
  │     💬 Args: [signerKeys]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 7)
  │   💬 Args: [oracleECDSA.noncePerStrategy(svStrategy), nonce1Before + 1, "Strategy 1 nonce should increment once"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 8)
      💬 Args: [oracleECDSA.noncePerStrategy(svStrategy2), nonce2Before + 1, "Strategy 2 nonce should increment once"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Test that sorted unique strategies succeed
 @dev Ensures the deduplication check doesn't break valid use cases
