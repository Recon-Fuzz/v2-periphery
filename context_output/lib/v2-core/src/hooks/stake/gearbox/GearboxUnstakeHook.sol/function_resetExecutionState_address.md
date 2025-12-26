# Function: resetExecutionState(address)

**Contract**: [lib/v2-core/src/hooks/stake/gearbox/GearboxUnstakeHook.sol/contract_GearboxUnstakeHook.md]

## Metadata

- **Contract**: GearboxUnstakeHook
- **Signature**: `resetExecutionState(address)`
- **Visibility**: external
- **Source Range**: 8016:316:364
- **Inherited From**: BaseHook

## Implementation

```solidity
/// @inheritdoc ISuperHook
function resetExecutionState(address caller) external onlyLastCaller() {
    uint256 context = _getCurrentExecutionContext(caller);
    if ((!_getPreExecuteMutex(context)) || (!_getPostExecuteMutex(context))) {
        revert INCOMPLETE_HOOK_EXECUTION();
    }
    _clearExecutionState(context);
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

### _clearExecutionState(uint256)

- **Kind**: internal
- **Source**: 14935:153:364
- **Link**: `lib/v2-core/src/hooks/BaseHook.sol:BaseHook:_clearExecutionState(uint256)`

```solidity
function _clearExecutionState(uint256 context) private {
    _setPreExecuteMutex(context, false);
    _setPostExecuteMutex(context, false);
}
```

### _setPreExecuteMutex(uint256,bool)

- **Kind**: internal
- **Source**: 14298:200:364
- **Link**: `lib/v2-core/src/hooks/BaseHook.sol:BaseHook:_setPreExecuteMutex(uint256,bool)`

```solidity
function _setPreExecuteMutex(uint256 context, bool value) private {
    bytes32 key = _makeKey(context, PRE_EXECUTE_MUTEX_OFFSET);
    assembly {
        tstore(key, value)
    }
}
```

### _setPostExecuteMutex(uint256,bool)

- **Kind**: internal
- **Source**: 14727:202:364
- **Link**: `lib/v2-core/src/hooks/BaseHook.sol:BaseHook:_setPostExecuteMutex(uint256,bool)`

```solidity
function _setPostExecuteMutex(uint256 context, bool value) private {
    bytes32 key = _makeKey(context, POST_EXECUTE_MUTEX_OFFSET);
    assembly {
        tstore(key, value)
    }
}
```

### onlyLastCaller()

- **Kind**: modifier
- **Source**: 4861:112:364
- **Link**: `lib/v2-core/src/hooks/BaseHook.sol:BaseHook:onlyLastCaller()`

```solidity
modifier onlyLastCaller() {
    if (msg.sender != lastCaller) revert UNAUTHORIZED_CALLER();
    _;
}
```

## State Variable Reads

- **ACCOUNT_CONTEXT_STORAGE** (`bytes32`)
- **POST_EXECUTE_MUTEX_OFFSET** (`uint256`)
- **HOOK_EXECUTION_STORAGE** (`bytes32`)
- **PRE_EXECUTE_MUTEX_OFFSET** (`uint256`)
- **lastCaller** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BaseHook.resetExecutionState(address) (NodeID: 0)
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
  ├─ [1] ⚙️ FUNCTION: BaseHook._clearExecutionState(uint256) (NodeID: 7)
  │   💬 Args: [context]
  │   👁️  Def: private
  │ ├─ [2] ⚙️ FUNCTION: BaseHook._setPreExecuteMutex(uint256,bool) (NodeID: 8)
  │ │   💬 Args: [context, false]
  │ │   👁️  Def: private
  │ │ └─ [3] ⚙️ FUNCTION: BaseHook._makeKey(uint256,uint256) (NodeID: 9)
  │ │     💬 Args: [context, PRE_EXECUTE_MUTEX_OFFSET]
  │ │     👁️  Def: private
  │ └─ [2] ⚙️ FUNCTION: BaseHook._setPostExecuteMutex(uint256,bool) (NodeID: 10)
  │     💬 Args: [context, false]
  │     👁️  Def: private
  │   └─ [3] ⚙️ FUNCTION: BaseHook._makeKey(uint256,uint256) (NodeID: 11)
  │       💬 Args: [context, POST_EXECUTE_MUTEX_OFFSET]
  │       👁️  Def: private
  └─ [1] 🔒 MODIFIER: BaseHook.onlyLastCaller() (NodeID: 12)
      💬 Args: [no args]
```

## Documentation

### Function Documentation

@inheritdoc ISuperHook

### Interface Documentation

@notice Resets hook mutexes
 @param caller The caller address for context identification
