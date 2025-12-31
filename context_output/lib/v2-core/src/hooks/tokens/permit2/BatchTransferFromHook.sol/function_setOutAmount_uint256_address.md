# Function: setOutAmount(uint256,address)

**Contract**: [lib/v2-core/src/hooks/tokens/permit2/BatchTransferFromHook.sol/contract_BatchTransferFromHook.md]

## Metadata

- **Contract**: BatchTransferFromHook
- **Signature**: `setOutAmount(uint256,address)`
- **Visibility**: external
- **Source Range**: 7437:394:364
- **Inherited From**: BaseHook

## Implementation

```solidity
/// @inheritdoc ISuperHookSetter
function setOutAmount(uint256 _outAmount, address caller) external {
    uint256 context = _getCurrentExecutionContext(caller);
    if (_getPreExecuteMutex(context) || _getPostExecuteMutex(context)) {
        revert CANNOT_SET_OUT_AMOUNT();
    }
    bytes32 key = _makeKey(context, OUT_AMOUNT_OFFSET);
    assembly {
        tstore(key, _outAmount)
    }
}
```

## Related Implementations

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

### _getPostExecuteMutex(uint256)

- **Kind**: internal
- **Source**: 14504:217:364
- **Link**: `lib/v2-core/src/hooks/BaseHook.sol:BaseHook:_getPostExecuteMutex(uint256)`

```solidity
function _getPostExecuteMutex(uint256 context) private view returns (bool value) {
    bytes32 key = _makeKey(context, POST_EXECUTE_MUTEX_OFFSET);
    assembly {
        value := tload(key)
    }
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

### _getPreExecuteMutex(uint256)

- **Kind**: internal
- **Source**: 14077:215:364
- **Link**: `lib/v2-core/src/hooks/BaseHook.sol:BaseHook:_getPreExecuteMutex(uint256)`

```solidity
function _getPreExecuteMutex(uint256 context) private view returns (bool value) {
    bytes32 key = _makeKey(context, PRE_EXECUTE_MUTEX_OFFSET);
    assembly {
        value := tload(key)
    }
}
```

## State Variable Reads

- **OUT_AMOUNT_OFFSET** (`uint256`)
- **ACCOUNT_CONTEXT_STORAGE** (`bytes32`)
- **POST_EXECUTE_MUTEX_OFFSET** (`uint256`)
- **HOOK_EXECUTION_STORAGE** (`bytes32`)
- **PRE_EXECUTE_MUTEX_OFFSET** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BaseHook.setOutAmount(uint256,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: BaseHook._getCurrentExecutionContext(address) (NodeID: 1)
  │   💬 Args: [caller]
  │   👁️  Def: private
  │ └─ [2] ⚙️ FUNCTION: BaseHook._makeAccountContextKey(address) (NodeID: 2)
  │     💬 Args: [caller]
  │     👁️  Def: private
  ├─ [1] ⚙️ FUNCTION: BaseHook._getPostExecuteMutex(uint256) (NodeID: 3)
  │   💬 Args: [context]
  │   👁️  Def: private
  │ └─ [2] ⚙️ FUNCTION: BaseHook._makeKey(uint256,uint256) (NodeID: 4)
  │     💬 Args: [context, POST_EXECUTE_MUTEX_OFFSET]
  │     👁️  Def: private
  ├─ [1] ⚙️ FUNCTION: BaseHook._getPreExecuteMutex(uint256) (NodeID: 5)
  │   💬 Args: [context]
  │   👁️  Def: private
  │ └─ [2] ⚙️ FUNCTION: BaseHook._makeKey(uint256,uint256) (NodeID: 6)
  │     💬 Args: [context, PRE_EXECUTE_MUTEX_OFFSET]
  │     👁️  Def: private
  └─ [1] ⚙️ FUNCTION: BaseHook._makeKey(uint256,uint256) (NodeID: 7)
      💬 Args: [context, OUT_AMOUNT_OFFSET]
      👁️  Def: private
```

## Documentation

### Function Documentation

@inheritdoc ISuperHookSetter

### Interface Documentation

@notice Sets the output amount for the hook
 @dev Used for updating `outAmount` when fees were deducted
 @param outAmount The amount of tokens processed by the hook
 @param caller The caller address for context identification
