# Function: test_ProcessIndividualStrategy_CatchErrorString()

**Contract**: [test/oracles/ECDSAPPSOracle.t.sol/contract_ECDSAPPSOracleTest.md]

## Metadata

- **Contract**: ECDSAPPSOracleTest
- **Signature**: `test_ProcessIndividualStrategy_CatchErrorString()`
- **Visibility**: public
- **Source Range**: 104282:2977:622

## Implementation

```solidity
/// @notice Tests the catch Error(string memory reason) block in _processIndividualStrategy
///  @dev Covers ECDSAPPSOracle.sol:260-262 - catch block for string-based reverts
///  @dev This catch block handles old-style require/revert with string messages
function test_ProcessIndividualStrategy_CatchErrorString() public {
    uint256 nonValidatorPrivKey = 0x999;
    bytes32 structHash = keccak256(abi.encodePacked(oracleECDSA.UPDATE_PPS_TYPEHASH(), address(svStrategy), PPS, block.timestamp, oracleECDSA.noncePerStrategy(address(svStrategy))));
    bytes32 digest = MessageHashUtils.toTypedDataHash(oracleECDSA.domainSeparator(), structHash);
    (uint8 v, bytes32 r, bytes32 s) = vm.sign(nonValidatorPrivKey, digest);
    bytes[] memory proofs = new bytes[](1);
    proofs[0] = abi.encodePacked(r, s, v);
    address[] memory strategies = new address[](1);
    strategies[0] = address(svStrategy);
    bytes[][] memory proofsArray = new bytes[][](1);
    proofsArray[0] = proofs;
    uint256[] memory ppss = new uint256[](1);
    ppss[0] = PPS;
    uint256[] memory timestamps = new uint256[](1);
    timestamps[0] = block.timestamp;
    vm.expectEmit(true, false, false, false);
    emit IECDSAPPSOracle.ProofValidationFailedLowLevel(address(svStrategy), new bytes(0));
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

- **ECDSAPPSOracle::UPDATE_PPS_TYPEHASH()**
- **ECDSAPPSOracle::noncePerStrategy(address)**
- **ECDSAPPSOracle::domainSeparator()**
- **Vm::sign(uint256,bytes32)**
- **Vm::expectEmit(bool,bool,bool,bool)**
- **ECDSAPPSOracle::updatePPS(struct IECDSAPPSOracle.UpdatePPSArgs)**

## State Variable Reads

- **oracleECDSA** (`contract ECDSAPPSOracle`) [src/oracles/ECDSAPPSOracle.sol/contract_ECDSAPPSOracle.md]
- **svStrategy** (`address`)
- **PPS** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ECDSAPPSOracleTest.test_ProcessIndividualStrategy_CatchErrorString() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: MessageHashUtils.toTypedDataHash(bytes32,bytes32) (NodeID: 1)
      💬 Args: [oracleECDSA.domainSeparator(), structHash]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests the catch Error(string memory reason) block in _processIndividualStrategy
 @dev Covers ECDSAPPSOracle.sol:260-262 - catch block for string-based reverts
 @dev This catch block handles old-style require/revert with string messages
