# Function: test_UpdatePPS_GasCost_Comprehensive()

**Contract**: [test/oracles/ECDSAPPSOracle.t.sol/contract_ECDSAPPSOracleTest.md]

## Metadata

- **Contract**: ECDSAPPSOracleTest
- **Signature**: `test_UpdatePPS_GasCost_Comprehensive()`
- **Visibility**: public
- **Source Range**: 12622:3799:622

## Implementation

```solidity
/// @notice Comprehensive gas measurement test with 1-5 entries
///  @dev This test measures ACTUAL transaction gas (not gasleft) by using Foundry's gas tracking
function test_UpdatePPS_GasCost_Comprehensive() public {
    address[] memory allStrategies = new address[](5);
    allStrategies[0] = svStrategy;
    for (uint256 i = 1; i < 5; i++) {
        (, address newStrategy, ) = aggregatorSuperVault.createVault(ISuperVaultAggregator.VaultCreationParams({asset: address(asset), name: string(abi.encodePacked("TestVault", vm.toString(i + 1))), symbol: string(abi.encodePacked("TV", vm.toString(i + 1))), mainManager: mockManager, secondaryManagers: new address[](0), minUpdateInterval: 5, maxStaleness: 300, feeConfig: ISuperVaultStrategy.FeeConfig({performanceFeeBps: 1000, managementFeeBps: 0, recipient: TREASURY})}));
        allStrategies[i] = newStrategy;
    }
    for (uint256 i = 0; i < allStrategies.length; i++) {
        for (uint256 j = i + 1; j < allStrategies.length; j++) {
            if (uint160(allStrategies[i]) > uint160(allStrategies[j])) {
                (allStrategies[i], allStrategies[j]) = (allStrategies[j], allStrategies[i]);
            }
        }
    }
    emit log("=== COMPREHENSIVE GAS MEASUREMENT ===");
    emit log("Testing updatePPS with 1 to 5 entries");
    emit log("");
    uint256[] memory gasResults = new uint256[](5);
    for (uint256 numEntries = 1; numEntries <= 5; numEntries++) {
        address[] memory strategies = new address[](numEntries);
        uint256[] memory ppss = new uint256[](numEntries);
        uint256[] memory timestamps = new uint256[](numEntries);
        bytes[][] memory proofsArray = new bytes[][](numEntries);
        for (uint256 i = 0; i < numEntries; i++) {
            strategies[i] = allStrategies[i];
            ppss[i] = PPS;
            timestamps[i] = block.timestamp;
            proofsArray[i] = _createValidProofsForStrategy(strategies[i], ppss[i], timestamps[i]);
        }
        IECDSAPPSOracle.UpdatePPSArgs memory args = IECDSAPPSOracle.UpdatePPSArgs({strategies: strategies, proofsArray: proofsArray, ppss: ppss, timestamps: timestamps});
        uint256 gasStart = gasleft();
        oracleECDSA.updatePPS(args);
        uint256 gasEnd = gasleft();
        gasResults[numEntries - 1] = gasStart - gasEnd;
        emit log_named_uint(string(abi.encodePacked("Entries: ", vm.toString(numEntries), " | Execution gas")), gasResults[numEntries - 1]);
        vm.warp(block.timestamp + 10);
    }
    emit log("");
    emit log("=== INCREMENTAL GAS PER ENTRY ===");
    uint256 totalIncremental = 0;
    for (uint256 i = 1; i < 5; i++) {
        uint256 incremental = gasResults[i] - gasResults[i - 1];
        totalIncremental += incremental;
        emit log_named_uint(string(abi.encodePacked("From ", vm.toString(i), " to ", vm.toString(i + 1), " entries")), incremental);
    }
    uint256 avgIncremental = totalIncremental / 4;
    emit log("");
    emit log_named_uint("Average incremental gas per entry", avgIncremental);
    emit log_named_uint("Recommended GAS_PER_ENTRY (+10%)", (avgIncremental * 110) / 100);
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
- **Vm::toString(uint256)**
- **ECDSAPPSOracle::updatePPS(struct IECDSAPPSOracle.UpdatePPSArgs)**
- **Vm::warp(uint256)**

## State Variable Reads

- **svStrategy** (`address`)
- **aggregatorSuperVault** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **mockManager** (`address`)
- **PPS** (`uint256`)
- **oracleECDSA** (`contract ECDSAPPSOracle`) [src/oracles/ECDSAPPSOracle.sol/contract_ECDSAPPSOracle.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ECDSAPPSOracleTest.test_UpdatePPS_GasCost_Comprehensive() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: ECDSAPPSOracleTest._createValidProofsForStrategy(address,uint256,uint256) (NodeID: 1)
      💬 Args: [strategies[i], ppss[i], timestamps[i]]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: MessageHashUtils.toTypedDataHash(bytes32,bytes32) (NodeID: 2)
    │   💬 Args: [domainSeparator, structHash]
    │   👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: ECDSAPPSOracleTest._sortSignerKeysByAddress(uint256[]) (NodeID: 3)
        💬 Args: [signerKeys]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Comprehensive gas measurement test with 1-5 entries
 @dev This test measures ACTUAL transaction gas (not gasleft) by using Foundry's gas tracking
