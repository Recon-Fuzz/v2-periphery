# Function: _tryGetBaseMerkleRoot()

**Contract**: [test/integration/SuperVault/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `_tryGetBaseMerkleRoot()`
- **Visibility**: external
- **Source Range**: 167191:280:580

## Implementation

```solidity
///  @notice Try to get Base chain merkle root, with fallback to single-leaf
///  @return root The merkle root for Base chain
function _tryGetBaseMerkleRoot() external returns (bytes32 root) {
    _setMerkleChainId(BASE);
    return _getMerkleRoot();
}
```

## Related Implementations

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

### _getMerkleRoot()

- **Kind**: internal
- **Source**: 2026:392:672
- **Link**: `test/utils/merkle/helper/MerkleReader.sol:MerkleReader:_getMerkleRoot()`

```solidity
///  @notice Get the Merkle root from the jsGeneratedRoot file
///  @return root The Merkle root
function _getMerkleRoot() internal view returns (bytes32 root) {
    LocalVars memory v;
    string memory rootFilePath = string.concat(vm.projectRoot(), basePathForRoot, ".json");
    v.rootJson = vm.readFile(rootFilePath);
    v.encodedRoot = vm.parseJson(v.rootJson, ".root");
    root = abi.decode(v.encodedRoot, (bytes32));
    console2.logBytes32(root);
}
```

### logBytes32(bytes32)

- **Kind**: internal
- **Source**: 5820:123:26
- **Link**: `lib/forge-std/src/console.sol:console:logBytes32(bytes32)`

```solidity
function logBytes32(bytes32 p0) internal pure {
    _sendLogPayload(abi.encodeWithSignature("log(bytes32)", p0));
}
```

### _sendLogPayload(bytes)

- **Kind**: internal
- **Source**: 8891:133:23
- **Link**: `lib/forge-std/src/StdUtils.sol:StdUtils:_sendLogPayload(bytes)`

```solidity
function _sendLogPayload(bytes memory payload) internal pure {
    _castLogPayloadViewToPure(_sendLogPayloadView)(payload);
}
```

### _castLogPayloadViewToPure(function (bytes)

- **Kind**: internal
- **Source**: 8650:235:23
- **Link**: `lib/forge-std/src/StdUtils.sol:StdUtils:_castLogPayloadViewToPure(function (bytes) view)`

```solidity
function _castLogPayloadViewToPure(function(bytes memory) internal view fnIn) internal pure returns (function(bytes memory) internal pure fnOut) {
    assembly {
        fnOut := fnIn
    }
}
```

## State Variable Reads

- **currentChainId** (`uint256`)
- **basePathForRoot** (`string`)

## State Variable Writes

- **currentChainId** (`uint256`)
- **basePathForRoot** (`string`)
- **basePathForTreeDump** (`string`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest._tryGetBaseMerkleRoot() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: MerkleReader._setMerkleChainId(uint256) (NodeID: 1)
  │   💬 Args: [BASE]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: MerkleReader._getMerkleRoot() (NodeID: 2)
      💬 Args: [no args]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: console.logBytes32(bytes32) (NodeID: 3)
        💬 Args: [root]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 4)
          💬 Args: [abi.encodeWithSignature("log(bytes32)", p0)]
          👁️  Def: internal
        └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 5)
            💬 Args: [_sendLogPayloadView]
            👁️  Def: internal
```

## Documentation

### Function Documentation

 @notice Try to get Base chain merkle root, with fallback to single-leaf
 @return root The merkle root for Base chain
