# Function: test_ValidateProofs_RevertsOnDuplicateSigner()

**Contract**: [test/oracles/ECDSAPPSOracle.t.sol/contract_ECDSAPPSOracleTest.md]

## Metadata

- **Contract**: ECDSAPPSOracleTest
- **Signature**: `test_ValidateProofs_RevertsOnDuplicateSigner()`
- **Visibility**: public
- **Source Range**: 65204:1206:622

## Implementation

```solidity
/// @notice Tests validateProofs reverts when duplicate signers are detected
///  @dev Covers ECDSAPPSOracle.sol:180 - INVALID_PROOF check for duplicate signers in _validateProofs
function test_ValidateProofs_RevertsOnDuplicateSigner() public {
    bytes32 structHash = keccak256(abi.encodePacked(oracleECDSA.UPDATE_PPS_TYPEHASH(), address(svStrategy), PPS, block.timestamp, oracleECDSA.noncePerStrategy(address(svStrategy))));
    bytes32 domainSeparator = oracleECDSA.domainSeparator();
    bytes32 digest = MessageHashUtils.toTypedDataHash(domainSeparator, structHash);
    (uint8 v, bytes32 r, bytes32 s) = vm.sign(validator1PrivateKey, digest);
    bytes memory signature = abi.encodePacked(r, s, v);
    bytes[] memory proofs = new bytes[](2);
    proofs[0] = signature;
    proofs[1] = signature;
    vm.expectRevert(IECDSAPPSOracle.INVALID_PROOF.selector);
    oracleECDSA.validateProofs(IECDSAPPSOracle.ValidationParams({strategy: address(svStrategy), proofs: proofs, pps: PPS, timestamp: block.timestamp}));
}
```

## Related Implementations

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

## External Calls

- **ECDSAPPSOracle::UPDATE_PPS_TYPEHASH()**
- **ECDSAPPSOracle::noncePerStrategy(address)**
- **ECDSAPPSOracle::domainSeparator()**
- **Vm::sign(uint256,bytes32)**
- **Vm::expectRevert(bytes4)**
- **ECDSAPPSOracle::validateProofs(struct IECDSAPPSOracle.ValidationParams)**

## State Variable Reads

- **oracleECDSA** (`contract ECDSAPPSOracle`) [src/oracles/ECDSAPPSOracle.sol/contract_ECDSAPPSOracle.md]
- **svStrategy** (`address`)
- **PPS** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ECDSAPPSOracleTest.test_ValidateProofs_RevertsOnDuplicateSigner() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: MessageHashUtils.toTypedDataHash(bytes32,bytes32) (NodeID: 1)
      💬 Args: [domainSeparator, structHash]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests validateProofs reverts when duplicate signers are detected
 @dev Covers ECDSAPPSOracle.sol:180 - INVALID_PROOF check for duplicate signers in _validateProofs
