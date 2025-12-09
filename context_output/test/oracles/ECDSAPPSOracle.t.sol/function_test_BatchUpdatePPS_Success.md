# Function: test_BatchUpdatePPS_Success()

**Contract**: [test/oracles/ECDSAPPSOracle.t.sol/contract_ECDSAPPSOracleTest.md]

## Metadata

- **Contract**: ECDSAPPSOracleTest
- **Signature**: `test_BatchUpdatePPS_Success()`
- **Visibility**: public
- **Source Range**: 37768:2679:622

## Implementation

```solidity
function test_BatchUpdatePPS_Success() public {
    BatchTestData memory data;
    data.strategy1 = address(svStrategy);
    (, data.strategy2, ) = aggregatorSuperVault.createVault(ISuperVaultAggregator.VaultCreationParams({asset: address(asset), name: "Secondary TestVault", symbol: "STV", mainManager: mockManager, secondaryManagers: new address[](0), minUpdateInterval: 5, maxStaleness: 300, feeConfig: ISuperVaultStrategy.FeeConfig({performanceFeeBps: 1000, managementFeeBps: 0, recipient: TREASURY})}));
    vm.warp(block.timestamp + 1 days);
    data.strategies = new address[](2);
    data.strategies[0] = data.strategy1;
    data.strategies[1] = data.strategy2;
    data.ppss = new uint256[](2);
    data.ppss[0] = PPS;
    data.ppss[1] = PPS * 2;
    data.validatorSets = new uint256[](2);
    data.validatorSets[0] = 2;
    data.validatorSets[1] = 2;
    data.totalValidatorsList = new uint256[](2);
    data.totalValidatorsList[0] = 3;
    data.totalValidatorsList[1] = 3;
    data.timestamps = new uint256[](2);
    data.timestamps[0] = block.timestamp;
    data.timestamps[1] = block.timestamp;
    if (uint160(data.strategy1) > uint160(data.strategy2)) {
        address temp = data.strategies[0];
        data.strategies[0] = data.strategies[1];
        data.strategies[1] = temp;
        uint256 tempPPS = data.ppss[0];
        data.ppss[0] = data.ppss[1];
        data.ppss[1] = tempPPS;
    }
    data.proofsArray = new bytes[][](2);
    data.proofsArray[0] = _createValidProofs(data.strategies[0], data.ppss[0], data.timestamps[0], new uint256[](0));
    data.proofsArray[1] = _createValidProofs(data.strategies[1], data.ppss[1], data.timestamps[1], new uint256[](0));
    data.updateAuthorities = new address[](2);
    data.updateAuthorities[0] = user;
    data.updateAuthorities[1] = user;
    vm.prank(user);
    oracleECDSA.updatePPS(IECDSAPPSOracle.UpdatePPSArgs({strategies: data.strategies, proofsArray: data.proofsArray, ppss: data.ppss, timestamps: data.timestamps}));
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

- **SuperVaultAggregator::createVault(struct ISuperVaultAggregator.VaultCreationParams)**
- **Vm::warp(uint256)**
- **Vm::prank(address)**
- **ECDSAPPSOracle::updatePPS(struct IECDSAPPSOracle.UpdatePPSArgs)**

## State Variable Reads

- **svStrategy** (`address`)
- **aggregatorSuperVault** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **mockManager** (`address`)
- **PPS** (`uint256`)
- **user** (`address`)
- **oracleECDSA** (`contract ECDSAPPSOracle`) [src/oracles/ECDSAPPSOracle.sol/contract_ECDSAPPSOracle.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ECDSAPPSOracleTest.test_BatchUpdatePPS_Success() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: ECDSAPPSOracleTest._createValidProofs(address,uint256,uint256,uint256[]) (NodeID: 1)
  │   💬 Args: [data.strategies[0], data.ppss[0], data.timestamps[0], new uint256[](0)]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: MessageHashUtils.toTypedDataHash(bytes32,bytes32) (NodeID: 2)
  │ │   💬 Args: [domainSeparator, structHash]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: ECDSAPPSOracleTest._sortSignerKeysByAddress(uint256[]) (NodeID: 3)
  │     💬 Args: [signerKeys]
  │     👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: ECDSAPPSOracleTest._createValidProofs(address,uint256,uint256,uint256[]) (NodeID: 4)
      💬 Args: [data.strategies[1], data.ppss[1], data.timestamps[1], new uint256[](0)]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: MessageHashUtils.toTypedDataHash(bytes32,bytes32) (NodeID: 5)
    │   💬 Args: [domainSeparator, structHash]
    │   👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: ECDSAPPSOracleTest._sortSignerKeysByAddress(uint256[]) (NodeID: 6)
        💬 Args: [signerKeys]
        👁️  Def: internal
```
