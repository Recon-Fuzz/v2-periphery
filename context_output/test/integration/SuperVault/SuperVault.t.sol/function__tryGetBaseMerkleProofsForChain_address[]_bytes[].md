# Function: _tryGetBaseMerkleProofsForChain(address[],bytes[])

**Contract**: [test/integration/SuperVault/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `_tryGetBaseMerkleProofsForChain(address[],bytes[])`
- **Visibility**: external
- **Source Range**: 168702:254:580

## Implementation

```solidity
///  @notice External function to get Base merkle proofs (needed for try-catch)
///  @param hookAddresses Array of hook addresses
///  @param argsForProofs Array of encoded arguments
///  @return proofs Array of merkle proofs
function _tryGetBaseMerkleProofsForChain(address[] memory hookAddresses, bytes[] memory argsForProofs) external returns (bytes32[][] memory proofs) {
    return _getMerkleProofsForChain(BASE, hookAddresses, argsForProofs);
}
```

## Related Implementations

### _getMerkleProofsForChain(uint256,address[],bytes[])

- **Kind**: internal
- **Source**: 8495:422:672
- **Link**: `test/utils/merkle/helper/MerkleReader.sol:MerkleReader:_getMerkleProofsForChain(uint256,address[],bytes[])`

```solidity
///  @notice Get Merkle proofs for multiple hooks for a specific chain
///  @param chainId The chain ID to use for merkle operations
///  @param hookAddresses Array of hook contract addresses
///  @param encodedHookArgs Array of packed-encoded hook arguments corresponding to each hook
///  @return proofs Array of Merkle proofs for each hook/args combination
function _getMerkleProofsForChain(uint256 chainId, address[] memory hookAddresses, bytes[] memory encodedHookArgs) internal returns (bytes32[][] memory proofs) {
    uint256 originalChainId = currentChainId;
    _setMerkleChainId(chainId);
    proofs = _getMerkleProofsForHooks(hookAddresses, encodedHookArgs);
    _setMerkleChainId(originalChainId);
}
```

### _setMerkleChainId(uint256)

- **Kind**: internal
- **Source**: 1578:325:672
- **Link**: `test/utils/merkle/helper/MerkleReader.sol:MerkleReader:_setMerkleChainId(uint256)`

```solidity
///  @notice Set the chain ID for merkle operations
///  @param chainId The chain ID to use
function _setMerkleChainId(uint256 chainId) internal {
    currentChainId = chainId;
    basePathForRoot = string.concat("/test/utils/merkle/output/jsGeneratedRoot_", vm.toString(currentChainId));
    basePathForTreeDump = string.concat("/test/utils/merkle/output/jsTreeDump_", vm.toString(currentChainId));
}
```

### _getMerkleProofsForHooks(address[],bytes[])

- **Kind**: internal
- **Source**: 6398:1705:672
- **Link**: `test/utils/merkle/helper/MerkleReader.sol:MerkleReader:_getMerkleProofsForHooks(address[],bytes[])`

```solidity
///  @notice Get Merkle proofs for multiple hooks with specific arguments (OPTIMIZED)
///  @dev Uses efficient JS-based lookup to avoid gas-expensive Solidity operations
///  @param hookAddresses Array of hook contract addresses
///  @param encodedHookArgs Array of packed-encoded hook arguments corresponding to each hook
///  @return proofs Array of Merkle proofs for each hook/args combination
function _getMerkleProofsForHooks(address[] memory hookAddresses, bytes[] memory encodedHookArgs) internal returns (bytes32[][] memory proofs) {
    if (hookAddresses.length != encodedHookArgs.length) revert InvalidArrayLengths();
    if (hookAddresses.length == 0) revert EmptyInput();
    string memory addressesArg = "";
    string memory argsArg = "";
    for (uint256 i = 0; i < hookAddresses.length; i++) {
        if (i > 0) {
            addressesArg = string.concat(addressesArg, ",");
            argsArg = string.concat(argsArg, ",");
        }
        addressesArg = string.concat(addressesArg, vm.toString(hookAddresses[i]));
        argsArg = string.concat(argsArg, vm.toString(encodedHookArgs[i]));
    }
    string[] memory cmd = new string[](6);
    cmd[0] = "node";
    cmd[1] = string.concat(vm.projectRoot(), "/test/utils/merkle/merkle-js/efficient-proof-lookup.js");
    cmd[2] = "batch";
    cmd[3] = addressesArg;
    cmd[4] = argsArg;
    cmd[5] = vm.toString(currentChainId);
    bytes memory result = vm.ffi(cmd);
    string memory resultStr = string(result);
    proofs = abi.decode(vm.parseJson(resultStr), (bytes32[][]));
    return proofs;
}
```

## State Variable Reads

- **currentChainId** (`uint256`)

## State Variable Writes

- **currentChainId** (`uint256`)
- **basePathForRoot** (`string`)
- **basePathForTreeDump** (`string`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest._tryGetBaseMerkleProofsForChain(address[],bytes[]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: MerkleReader._getMerkleProofsForChain(uint256,address[],bytes[]) (NodeID: 1)
      💬 Args: [BASE, hookAddresses, argsForProofs]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: MerkleReader._setMerkleChainId(uint256) (NodeID: 2)
    │   💬 Args: [chainId]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: MerkleReader._getMerkleProofsForHooks(address[],bytes[]) (NodeID: 3)
    │   💬 Args: [hookAddresses, encodedHookArgs]
    │   👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: MerkleReader._setMerkleChainId(uint256) (NodeID: 4)
        💬 Args: [originalChainId]
        👁️  Def: internal
```

## Documentation

### Function Documentation

 @notice External function to get Base merkle proofs (needed for try-catch)
 @param hookAddresses Array of hook addresses
 @param argsForProofs Array of encoded arguments
 @return proofs Array of merkle proofs
