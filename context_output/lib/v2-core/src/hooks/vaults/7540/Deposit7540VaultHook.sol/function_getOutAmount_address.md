# Function: getOutAmount(address)

**Contract**: [lib/v2-core/src/hooks/vaults/7540/Deposit7540VaultHook.sol/contract_Deposit7540VaultHook.md]

## Metadata

- **Contract**: Deposit7540VaultHook
- **Signature**: `getOutAmount(address)`
- **Visibility**: public
- **Source Range**: 7837:142:364
- **Inherited From**: BaseHook

## Implementation

```solidity
function getOutAmount(address caller) public view returns (uint256) {
    return _getOutAmount(_getCurrentExecutionContext(caller));
}
```

## Related Implementations

### _getOutAmount(uint256)

- **Kind**: internal
- **Source**: 13607:205:364
- **Link**: `lib/v2-core/src/hooks/BaseHook.sol:BaseHook:_getOutAmount(uint256)`

```solidity
function _getOutAmount(uint256 context) private view returns (uint256 value) {
    bytes32 key = _makeKey(context, OUT_AMOUNT_OFFSET);
    assembly {
        value := tload(key)
    }
}
```

### _getCurrentExecutionContext(address)

- **Kind**: internal
- **Source**: 13205:216:364
- **Link**: `lib/v2-core/src/hooks/BaseHook.sol:BaseHook:_getCurrentExecutionContext(address)`

```solidity
function _getCurrentExecutionContext(address caller) private view returns (uint256 context) {
    bytes32 key = _makeAccountContextKey(caller);
    assembly {
        context := tload(key)
    }
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

### _makeKey(uint256,uint256)

- **Kind**: internal
- **Source**: 13427:174:364
- **Link**: `lib/v2-core/src/hooks/BaseHook.sol:BaseHook:_makeKey(uint256,uint256)`

```solidity
function _makeKey(uint256 context, uint256 offset) private pure returns (bytes32) {
    return keccak256(abi.encodePacked(HOOK_EXECUTION_STORAGE, context, offset));
}
```

## State Variable Reads

- **OUT_AMOUNT_OFFSET** (`uint256`)
- **ACCOUNT_CONTEXT_STORAGE** (`bytes32`)
- **HOOK_EXECUTION_STORAGE** (`bytes32`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BaseHook.getOutAmount(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: BaseHook._getOutAmount(uint256) (NodeID: 1)
      💬 Args: [_getCurrentExecutionContext(caller)]
      👁️  Def: private
    ├─ [2] ⚙️ FUNCTION: BaseHook._getCurrentExecutionContext(address) (NodeID: 3)
    │   💬 Args: [caller]
    │   👁️  Def: private
    │ └─ [3] ⚙️ FUNCTION: BaseHook._makeAccountContextKey(address) (NodeID: 4)
    │     💬 Args: [caller]
    │     👁️  Def: private
    └─ [2] ⚙️ FUNCTION: BaseHook._makeKey(uint256,uint256) (NodeID: 2)
        💬 Args: [context, OUT_AMOUNT_OFFSET]
        👁️  Def: private
```

## Documentation

### Interface Documentation

@notice The amount of tokens processed by the hook in a given caller context, subject to fees after update
 @dev This is the primary output value used by subsequent hooks
 @param caller The caller address for context identification
 @return The amount of tokens (assets or shares) processed
