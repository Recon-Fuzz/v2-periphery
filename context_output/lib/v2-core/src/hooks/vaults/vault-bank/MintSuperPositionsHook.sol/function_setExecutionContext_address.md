# Function: setExecutionContext(address)

**Contract**: [lib/v2-core/src/hooks/vaults/vault-bank/MintSuperPositionsHook.sol/contract_MintSuperPositionsHook.md]

## Metadata

- **Contract**: MintSuperPositionsHook
- **Signature**: `setExecutionContext(address)`
- **Visibility**: external
- **Source Range**: 5193:135:364
- **Inherited From**: BaseHook

## Implementation

```solidity
/// @inheritdoc ISuperHook
function setExecutionContext(address caller) external {
    _createExecutionContext(caller);
    lastCaller = msg.sender;
}
```

## Related Implementations

### _createExecutionContext(address)

- **Kind**: internal
- **Source**: 12736:463:364
- **Link**: `lib/v2-core/src/hooks/BaseHook.sol:BaseHook:_createExecutionContext(address)`

```solidity
function _createExecutionContext(address caller) private returns (uint256) {
    executionNonce++;
    bytes32 key = _makeAccountContextKey(caller);
    uint256 currentNonce = executionNonce;
    assembly {
        tstore(key, currentNonce)
    }
    return executionNonce;
}
```

### _makeAccountContextKey(address)

- **Kind**: internal
- **Source**: 12565:165:364
- **Link**: `lib/v2-core/src/hooks/BaseHook.sol:BaseHook:_makeAccountContextKey(address)`

```solidity
function _makeAccountContextKey(address account) private pure returns (bytes32) {
    return keccak256(abi.encodePacked(ACCOUNT_CONTEXT_STORAGE, account));
}
```

## State Variable Reads

- **executionNonce** (`uint256`)
- **ACCOUNT_CONTEXT_STORAGE** (`bytes32`)

## State Variable Writes

- **lastCaller** (`address`)
- **executionNonce** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BaseHook.setExecutionContext(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: BaseHook._createExecutionContext(address) (NodeID: 1)
      💬 Args: [caller]
      👁️  Def: private
    └─ [2] ⚙️ FUNCTION: BaseHook._makeAccountContextKey(address) (NodeID: 2)
        💬 Args: [caller]
        👁️  Def: private
```

## Documentation

### Function Documentation

@inheritdoc ISuperHook

### Interface Documentation

@notice Sets the caller address that initiated the execution
 @dev Used for security validation between preExecute and postExecute calls
 @param caller The caller address for context identification
