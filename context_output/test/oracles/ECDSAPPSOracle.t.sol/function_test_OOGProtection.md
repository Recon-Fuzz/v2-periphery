# Function: test_OOGProtection()

**Contract**: [test/oracles/ECDSAPPSOracle.t.sol/contract_ECDSAPPSOracleTest.md]

## Metadata

- **Contract**: ECDSAPPSOracleTest
- **Signature**: `test_OOGProtection()`
- **Visibility**: public
- **Source Range**: 92846:2581:622

## Implementation

```solidity
/// @notice Test OOG protection (nonces not burned on OOG)
///  @dev Validates that out-of-gas doesn't burn signatures
function test_OOGProtection() public {
    vm.warp(block.timestamp + 1 days);
    uint256 timestamp1 = block.timestamp;
    bytes[] memory proofs1 = _createValidProofs(svStrategy, PPS, timestamp1, new uint256[](0));
    vm.prank(user);
    oracleECDSA.updatePPS(IECDSAPPSOracle.UpdatePPSArgs({strategies: _createSingleStrategyArray(svStrategy), proofsArray: _createSingleProofArray(proofs1), ppss: _createSinglePPSArray(PPS), timestamps: _createSingleTimestampArray(timestamp1)}));
    vm.warp(block.timestamp + 1 days);
    uint256 timestamp2 = block.timestamp;
    bytes[] memory proofs2 = _createValidProofs(svStrategy, PPS * 2, timestamp2, new uint256[](0));
    uint256 nonceBefore = oracleECDSA.noncePerStrategy(svStrategy);
    vm.prank(user);
    try oracleECDSA.updatePPS{gas: 500_000}(IECDSAPPSOracle.UpdatePPSArgs({strategies: _createSingleStrategyArray(svStrategy), proofsArray: _createSingleProofArray(proofs2), ppss: _createSinglePPSArray(PPS * 2), timestamps: _createSingleTimestampArray(timestamp2)})) {
        uint256 nonceAfter = oracleECDSA.noncePerStrategy(svStrategy);
        assertTrue(nonceAfter == (nonceBefore + 1), "If success, nonce should increment");
    } catch {
        uint256 nonceAfter = oracleECDSA.noncePerStrategy(svStrategy);
        assertEq(nonceAfter, nonceBefore, "If OOG, nonce should not increment");
        vm.prank(user);
        oracleECDSA.updatePPS(IECDSAPPSOracle.UpdatePPSArgs({strategies: _createSingleStrategyArray(svStrategy), proofsArray: _createSingleProofArray(proofs2), ppss: _createSinglePPSArray(PPS * 2), timestamps: _createSingleTimestampArray(timestamp2)}));
        assertEq(oracleECDSA.noncePerStrategy(svStrategy), nonceBefore + 1, "Retry should succeed");
    }
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

### _createSingleStrategyArray(address)

- **Kind**: internal
- **Source**: 102951:219:622
- **Link**: `test/oracles/ECDSAPPSOracle.t.sol:ECDSAPPSOracleTest:_createSingleStrategyArray(address)`

```solidity
function _createSingleStrategyArray(address strategy) internal pure returns (address[] memory) {
    address[] memory strategies = new address[](1);
    strategies[0] = strategy;
    return strategies;
}
```

### _createSingleProofArray(bytes[])

- **Kind**: internal
- **Source**: 103176:222:622
- **Link**: `test/oracles/ECDSAPPSOracle.t.sol:ECDSAPPSOracleTest:_createSingleProofArray(bytes[])`

```solidity
function _createSingleProofArray(bytes[] memory proofs) internal pure returns (bytes[][] memory) {
    bytes[][] memory proofsArray = new bytes[][](1);
    proofsArray[0] = proofs;
    return proofsArray;
}
```

### _createSinglePPSArray(uint256)

- **Kind**: internal
- **Source**: 103404:186:622
- **Link**: `test/oracles/ECDSAPPSOracle.t.sol:ECDSAPPSOracleTest:_createSinglePPSArray(uint256)`

```solidity
function _createSinglePPSArray(uint256 pps) internal pure returns (uint256[] memory) {
    uint256[] memory ppss = new uint256[](1);
    ppss[0] = pps;
    return ppss;
}
```

### _createSingleTimestampArray(uint256)

- **Kind**: internal
- **Source**: 103596:222:622
- **Link**: `test/oracles/ECDSAPPSOracle.t.sol:ECDSAPPSOracleTest:_createSingleTimestampArray(uint256)`

```solidity
function _createSingleTimestampArray(uint256 timestamp) internal pure returns (uint256[] memory) {
    uint256[] memory timestamps = new uint256[](1);
    timestamps[0] = timestamp;
    return timestamps;
}
```

### assertTrue(bool,string)

- **Kind**: internal
- **Source**: 1894:148:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertTrue(bool,string)`

```solidity
function assertTrue(bool data, string memory err) virtual internal pure {
    if (!data) {
        vm.assertTrue(data, err);
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

- **Vm::warp(uint256)**
- **Vm::prank(address)**
- **ECDSAPPSOracle::updatePPS(struct IECDSAPPSOracle.UpdatePPSArgs)**
- **ECDSAPPSOracle::noncePerStrategy(address)**
- **unknown::unknown**

## State Variable Reads

- **svStrategy** (`address`)
- **PPS** (`uint256`)
- **user** (`address`)
- **oracleECDSA** (`contract ECDSAPPSOracle`) [src/oracles/ECDSAPPSOracle.sol/contract_ECDSAPPSOracle.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ECDSAPPSOracleTest.test_OOGProtection() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: ECDSAPPSOracleTest._createValidProofs(address,uint256,uint256,uint256[]) (NodeID: 1)
  │   💬 Args: [svStrategy, PPS, timestamp1, new uint256[](0)]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: MessageHashUtils.toTypedDataHash(bytes32,bytes32) (NodeID: 2)
  │ │   💬 Args: [domainSeparator, structHash]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: ECDSAPPSOracleTest._sortSignerKeysByAddress(uint256[]) (NodeID: 3)
  │     💬 Args: [signerKeys]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: ECDSAPPSOracleTest._createSingleStrategyArray(address) (NodeID: 4)
  │   💬 Args: [svStrategy]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: ECDSAPPSOracleTest._createSingleProofArray(bytes[]) (NodeID: 5)
  │   💬 Args: [proofs1]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: ECDSAPPSOracleTest._createSinglePPSArray(uint256) (NodeID: 6)
  │   💬 Args: [PPS]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: ECDSAPPSOracleTest._createSingleTimestampArray(uint256) (NodeID: 7)
  │   💬 Args: [timestamp1]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: ECDSAPPSOracleTest._createValidProofs(address,uint256,uint256,uint256[]) (NodeID: 8)
  │   💬 Args: [svStrategy, PPS * 2, timestamp2, new uint256[](0)]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: MessageHashUtils.toTypedDataHash(bytes32,bytes32) (NodeID: 9)
  │ │   💬 Args: [domainSeparator, structHash]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: ECDSAPPSOracleTest._sortSignerKeysByAddress(uint256[]) (NodeID: 10)
  │     💬 Args: [signerKeys]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: ECDSAPPSOracleTest._createSingleStrategyArray(address) (NodeID: 11)
  │   💬 Args: [svStrategy]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: ECDSAPPSOracleTest._createSingleProofArray(bytes[]) (NodeID: 12)
  │   💬 Args: [proofs2]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: ECDSAPPSOracleTest._createSinglePPSArray(uint256) (NodeID: 13)
  │   💬 Args: [PPS * 2]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: ECDSAPPSOracleTest._createSingleTimestampArray(uint256) (NodeID: 14)
  │   💬 Args: [timestamp2]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 15)
  │   💬 Args: [nonceAfter == (nonceBefore + 1), "If success, nonce should increment"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 16)
  │   💬 Args: [nonceAfter, nonceBefore, "If OOG, nonce should not increment"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: ECDSAPPSOracleTest._createSingleStrategyArray(address) (NodeID: 17)
  │   💬 Args: [svStrategy]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: ECDSAPPSOracleTest._createSingleProofArray(bytes[]) (NodeID: 18)
  │   💬 Args: [proofs2]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: ECDSAPPSOracleTest._createSinglePPSArray(uint256) (NodeID: 19)
  │   💬 Args: [PPS * 2]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: ECDSAPPSOracleTest._createSingleTimestampArray(uint256) (NodeID: 20)
  │   💬 Args: [timestamp2]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 21)
      💬 Args: [oracleECDSA.noncePerStrategy(svStrategy), nonceBefore + 1, "Retry should succeed"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Test OOG protection (nonces not burned on OOG)
 @dev Validates that out-of-gas doesn't burn signatures
