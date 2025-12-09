# Function: test_UpdatePPS_InvalidReplay()

**Contract**: [test/oracles/ECDSAPPSOracle.t.sol/contract_ECDSAPPSOracleTest.md]

## Metadata

- **Contract**: ECDSAPPSOracleTest
- **Signature**: `test_UpdatePPS_InvalidReplay()`
- **Visibility**: public
- **Source Range**: 17721:1525:622

## Implementation

```solidity
function test_UpdatePPS_InvalidReplay() public {
    bytes[] memory proofs = _createValidProofs(address(svStrategy), PPS, block.timestamp, new uint256[](0));
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
    vm.expectEmit(true, false, false, false);
    emit IECDSAPPSOracle.ProofValidationFailedLowLevel(address(svStrategy), abi.encodeWithSelector(IECDSAPPSOracle.INVALID_VALIDATOR.selector));
    oracleECDSA.updatePPS(IECDSAPPSOracle.UpdatePPSArgs({strategies: strategies, proofsArray: proofsArray, ppss: ppss, timestamps: timestamps}));
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

## External Calls

- **ECDSAPPSOracle::updatePPS(struct IECDSAPPSOracle.UpdatePPSArgs)**
- **Vm::expectEmit(bool,bool,bool,bool)**

## State Variable Reads

- **svStrategy** (`address`)
- **PPS** (`uint256`)
- **oracleECDSA** (`contract ECDSAPPSOracle`) [src/oracles/ECDSAPPSOracle.sol/contract_ECDSAPPSOracle.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ECDSAPPSOracleTest.test_UpdatePPS_InvalidReplay() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: ECDSAPPSOracleTest._createValidProofs(address,uint256,uint256,uint256[]) (NodeID: 1)
      💬 Args: [address(svStrategy), PPS, block.timestamp, new uint256[](0)]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: MessageHashUtils.toTypedDataHash(bytes32,bytes32) (NodeID: 2)
    │   💬 Args: [domainSeparator, structHash]
    │   👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: ECDSAPPSOracleTest._sortSignerKeysByAddress(uint256[]) (NodeID: 3)
        💬 Args: [signerKeys]
        👁️  Def: internal
```
