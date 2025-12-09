# Function: test_UpdatePPS_GasCost_TwoEntries()

**Contract**: [test/oracles/ECDSAPPSOracle.t.sol/contract_ECDSAPPSOracleTest.md]

## Metadata

- **Contract**: ECDSAPPSOracleTest
- **Signature**: `test_UpdatePPS_GasCost_TwoEntries()`
- **Visibility**: public
- **Source Range**: 10123:2324:622

## Implementation

```solidity
function test_UpdatePPS_GasCost_TwoEntries() public {
    (, address strategy2, ) = aggregatorSuperVault.createVault(ISuperVaultAggregator.VaultCreationParams({asset: address(asset), name: "Second TestVault", symbol: "TV2", mainManager: mockManager, secondaryManagers: new address[](0), minUpdateInterval: 5, maxStaleness: 300, feeConfig: ISuperVaultStrategy.FeeConfig({performanceFeeBps: 1000, managementFeeBps: 0, recipient: TREASURY})}));
    address[] memory strategies = new address[](2);
    strategies[0] = address(svStrategy);
    strategies[1] = strategy2;
    uint256[] memory ppss = new uint256[](2);
    ppss[0] = PPS;
    ppss[1] = PPS;
    uint256[] memory timestamps = new uint256[](2);
    timestamps[0] = block.timestamp;
    timestamps[1] = block.timestamp;
    if (uint160(strategies[0]) > uint160(strategies[1])) {
        (strategies[0], strategies[1]) = (strategies[1], strategies[0]);
        (ppss[0], ppss[1]) = (ppss[1], ppss[0]);
        (timestamps[0], timestamps[1]) = (timestamps[1], timestamps[0]);
    }
    bytes[][] memory proofsArray = new bytes[][](2);
    proofsArray[0] = _createValidProofsForStrategy(strategies[0], ppss[0], timestamps[0]);
    proofsArray[1] = _createValidProofsForStrategy(strategies[1], ppss[1], timestamps[1]);
    IECDSAPPSOracle.UpdatePPSArgs memory args = IECDSAPPSOracle.UpdatePPSArgs({strategies: strategies, proofsArray: proofsArray, ppss: ppss, timestamps: timestamps});
    uint256 gasBefore = gasleft();
    oracleECDSA.updatePPS(args);
    uint256 gasAfter = gasleft();
    uint256 gasUsed = gasBefore - gasAfter;
    emit log_named_uint("Gas used for updatePPS with 2 entries", gasUsed);
    emit log_named_uint("Incremental gas per entry (2 entries - 1 entry)", (gasUsed > 99_619) ? (gasUsed - 99_619) : 0);
}
```

## Related Implementations

### _createValidProofsForStrategy(address,uint256,uint256)

- **Kind**: internal
- **Source**: 16512:1203:622
- **Link**: `test/oracles/ECDSAPPSOracle.t.sol:ECDSAPPSOracleTest:_createValidProofsForStrategy(address,uint256,uint256)`

```solidity
/// @notice Helper to create valid proofs for any strategy (not just svStrategy)
function _createValidProofsForStrategy(address strategy_, uint256 pps, uint256 timestamp) internal view returns (bytes[] memory) {
    bytes32 structHash = keccak256(abi.encodePacked(oracleECDSA.UPDATE_PPS_TYPEHASH(), strategy_, pps, timestamp, oracleECDSA.noncePerStrategy(strategy_)));
    bytes32 domainSeparator = oracleECDSA.domainSeparator();
    bytes32 digest = MessageHashUtils.toTypedDataHash(domainSeparator, structHash);
    uint256[] memory signerKeys = new uint256[](2);
    signerKeys[0] = validator1PrivateKey;
    signerKeys[1] = validator2PrivateKey;
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

- **SuperVaultAggregator::createVault(struct ISuperVaultAggregator.VaultCreationParams)**
- **ECDSAPPSOracle::updatePPS(struct IECDSAPPSOracle.UpdatePPSArgs)**

## State Variable Reads

- **aggregatorSuperVault** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **mockManager** (`address`)
- **svStrategy** (`address`)
- **PPS** (`uint256`)
- **oracleECDSA** (`contract ECDSAPPSOracle`) [src/oracles/ECDSAPPSOracle.sol/contract_ECDSAPPSOracle.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ECDSAPPSOracleTest.test_UpdatePPS_GasCost_TwoEntries() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: ECDSAPPSOracleTest._createValidProofsForStrategy(address,uint256,uint256) (NodeID: 1)
  │   💬 Args: [strategies[0], ppss[0], timestamps[0]]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: MessageHashUtils.toTypedDataHash(bytes32,bytes32) (NodeID: 2)
  │ │   💬 Args: [domainSeparator, structHash]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: ECDSAPPSOracleTest._sortSignerKeysByAddress(uint256[]) (NodeID: 3)
  │     💬 Args: [signerKeys]
  │     👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: ECDSAPPSOracleTest._createValidProofsForStrategy(address,uint256,uint256) (NodeID: 4)
      💬 Args: [strategies[1], ppss[1], timestamps[1]]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: MessageHashUtils.toTypedDataHash(bytes32,bytes32) (NodeID: 5)
    │   💬 Args: [domainSeparator, structHash]
    │   👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: ECDSAPPSOracleTest._sortSignerKeysByAddress(uint256[]) (NodeID: 6)
        💬 Args: [signerKeys]
        👁️  Def: internal
```
