# Function: test_UpdatePPS_UnsortedSignersReverts()

**Contract**: [test/oracles/ECDSAPPSOracle.t.sol/contract_ECDSAPPSOracleTest.md]

## Metadata

- **Contract**: ECDSAPPSOracleTest
- **Signature**: `test_UpdatePPS_UnsortedSignersReverts()`
- **Visibility**: public
- **Source Range**: 25071:2721:622

## Implementation

```solidity
function test_UpdatePPS_UnsortedSignersReverts() public {
    uint256[] memory signerKeys = new uint256[](2);
    address addr1 = vm.addr(validator1PrivateKey);
    address addr2 = vm.addr(validator2PrivateKey);
    if (addr1 > addr2) {
        signerKeys[0] = validator1PrivateKey;
        signerKeys[1] = validator2PrivateKey;
    } else {
        signerKeys[0] = validator2PrivateKey;
        signerKeys[1] = validator1PrivateKey;
    }
    bytes32 structHash = keccak256(abi.encodePacked(oracleECDSA.UPDATE_PPS_TYPEHASH(), address(svStrategy), PPS, PPS_STDEV, uint256(2), uint256(3), block.timestamp, oracleECDSA.noncePerStrategy(address(svStrategy))));
    bytes32 domainSeparator = oracleECDSA.domainSeparator();
    bytes32 digest = MessageHashUtils.toTypedDataHash(domainSeparator, structHash);
    bytes[] memory proofs = new bytes[](2);
    for (uint256 i = 0; i < 2; i++) {
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(signerKeys[i], digest);
        proofs[i] = abi.encodePacked(r, s, v);
    }
    vm.prank(user);
    vm.expectEmit(true, false, false, false);
    emit IECDSAPPSOracle.ProofValidationFailedLowLevel(address(svStrategy), abi.encodeWithSelector(IECDSAPPSOracle.INVALID_PROOF.selector));
    address[] memory strategies = new address[](1);
    strategies[0] = address(svStrategy);
    bytes[][] memory proofsArray = new bytes[][](1);
    proofsArray[0] = proofs;
    uint256[] memory ppss = new uint256[](1);
    ppss[0] = PPS;
    uint256[] memory validatorSets = new uint256[](1);
    validatorSets[0] = 2;
    uint256[] memory totalValidators = new uint256[](1);
    totalValidators[0] = 3;
    uint256[] memory timestamps = new uint256[](1);
    timestamps[0] = block.timestamp;
    oracleECDSA.updatePPS(IECDSAPPSOracle.UpdatePPSArgs({strategies: strategies, proofsArray: proofsArray, ppss: ppss, timestamps: timestamps}));
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

- **Vm::addr(uint256)**
- **ECDSAPPSOracle::UPDATE_PPS_TYPEHASH()**
- **ECDSAPPSOracle::noncePerStrategy(address)**
- **ECDSAPPSOracle::domainSeparator()**
- **Vm::sign(uint256,bytes32)**
- **Vm::prank(address)**
- **Vm::expectEmit(bool,bool,bool,bool)**
- **ECDSAPPSOracle::updatePPS(struct IECDSAPPSOracle.UpdatePPSArgs)**

## State Variable Reads

- **oracleECDSA** (`contract ECDSAPPSOracle`) [src/oracles/ECDSAPPSOracle.sol/contract_ECDSAPPSOracle.md]
- **svStrategy** (`address`)
- **PPS** (`uint256`)
- **PPS_STDEV** (`uint256`)
- **user** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ECDSAPPSOracleTest.test_UpdatePPS_UnsortedSignersReverts() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: MessageHashUtils.toTypedDataHash(bytes32,bytes32) (NodeID: 1)
      💬 Args: [domainSeparator, structHash]
      👁️  Def: internal
```
