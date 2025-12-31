# Function: preExecute(address,address,bytes)

**Contract**: [lib/v2-core/src/hooks/swappers/1inch/Swap1InchHook.sol/contract_Swap1InchHook.md]

## Metadata

- **Contract**: Swap1InchHook
- **Signature**: `preExecute(address,address,bytes)`
- **Visibility**: external
- **Source Range**: 6572:390:364
- **Inherited From**: BaseHook

## Implementation

```solidity
/// @inheritdoc ISuperHook
function preExecute(address prevHook, address account, bytes calldata data) external {
    if (msg.sender != account) revert UNAUTHORIZED_CALLER();
    uint256 context = _getCurrentExecutionContext(account);
    if (_getPreExecuteMutex(context)) revert PRE_EXECUTE_ALREADY_CALLED();
    _setPreExecuteMutex(context, true);
    _preExecute(prevHook, account, data);
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

### _makeKey(uint256,uint256)

- **Kind**: internal
- **Source**: 13427:174:364
- **Link**: `lib/v2-core/src/hooks/BaseHook.sol:BaseHook:_makeKey(uint256,uint256)`

```solidity
function _makeKey(uint256 context, uint256 offset) private pure returns (bytes32) {
    return keccak256(abi.encodePacked(HOOK_EXECUTION_STORAGE, context, offset));
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

### _preExecute(address,address,bytes)

- **Kind**: internal
- **Source**: 5903:153:387
- **Link**: `lib/v2-core/src/hooks/swappers/1inch/Swap1InchHook.sol:Swap1InchHook:_preExecute(address,address,bytes)`

```solidity
function _preExecute(address, address account, bytes calldata data) override internal {
    _setOutAmount(_getBalance(data, account), account);
}
```

### _setOutAmount(uint256,address)

- **Kind**: internal
- **Source**: 13818:253:364
- **Link**: `lib/v2-core/src/hooks/BaseHook.sol:BaseHook:_setOutAmount(uint256,address)`

```solidity
function _setOutAmount(uint256 value, address caller) internal {
    uint256 context = _getCurrentExecutionContext(caller);
    bytes32 key = _makeKey(context, OUT_AMOUNT_OFFSET);
    assembly {
        tstore(key, value)
    }
}
```

### _getBalance(bytes,address)

- **Kind**: internal
- **Source**: 14212:467:387
- **Link**: `lib/v2-core/src/hooks/swappers/1inch/Swap1InchHook.sol:Swap1InchHook:_getBalance(bytes,address)`

```solidity
function _getBalance(bytes calldata data, address account) private view returns (uint256) {
    address dstToken = address(bytes20(data[:20]));
    address dstReceiver = address(bytes20(data[20:40]));
    if (dstReceiver == address(0)) {
        dstReceiver = account;
    }
    if ((dstToken == NATIVE) || (dstToken == address(0))) {
        return dstReceiver.balance;
    }
    return IERC20(dstToken).balanceOf(dstReceiver);
}
```

## State Variable Reads

- **ACCOUNT_CONTEXT_STORAGE** (`bytes32`)
- **PRE_EXECUTE_MUTEX_OFFSET** (`uint256`)
- **HOOK_EXECUTION_STORAGE** (`bytes32`)
- **OUT_AMOUNT_OFFSET** (`uint256`)
- **NATIVE** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BaseHook.preExecute(address,address,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: BaseHook._getCurrentExecutionContext(address) (NodeID: 1)
  │   💬 Args: [account]
  │   👁️  Def: private
  │ └─ [2] ⚙️ FUNCTION: BaseHook._makeAccountContextKey(address) (NodeID: 2)
  │     💬 Args: [caller]
  │     👁️  Def: private
  ├─ [1] ⚙️ FUNCTION: BaseHook._getPreExecuteMutex(uint256) (NodeID: 3)
  │   💬 Args: [context]
  │   👁️  Def: private
  │ └─ [2] ⚙️ FUNCTION: BaseHook._makeKey(uint256,uint256) (NodeID: 4)
  │     💬 Args: [context, PRE_EXECUTE_MUTEX_OFFSET]
  │     👁️  Def: private
  ├─ [1] ⚙️ FUNCTION: BaseHook._setPreExecuteMutex(uint256,bool) (NodeID: 5)
  │   💬 Args: [context, true]
  │   👁️  Def: private
  │ └─ [2] ⚙️ FUNCTION: BaseHook._makeKey(uint256,uint256) (NodeID: 6)
  │     💬 Args: [context, PRE_EXECUTE_MUTEX_OFFSET]
  │     👁️  Def: private
  └─ [1] ⚙️ FUNCTION: Swap1InchHook._preExecute(address,address,bytes) (NodeID: 7)
      💬 Args: [prevHook, account, data]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: BaseHook._setOutAmount(uint256,address) (NodeID: 8)
        💬 Args: [_getBalance(data, account), account]
        👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: Swap1InchHook._getBalance(bytes,address) (NodeID: 12)
      │   💬 Args: [data, account]
      │   👁️  Def: private
      ├─ [3] ⚙️ FUNCTION: BaseHook._getCurrentExecutionContext(address) (NodeID: 9)
      │   💬 Args: [caller]
      │   👁️  Def: private
      │ └─ [4] ⚙️ FUNCTION: BaseHook._makeAccountContextKey(address) (NodeID: 10)
      │     💬 Args: [caller]
      │     👁️  Def: private
      └─ [3] ⚙️ FUNCTION: BaseHook._makeKey(uint256,uint256) (NodeID: 11)
          💬 Args: [context, OUT_AMOUNT_OFFSET]
          👁️  Def: private
```

## Documentation

### Function Documentation

@inheritdoc ISuperHook

### Interface Documentation

@notice Prepares the hook for execution
 @dev Called before the main execution, used to validate inputs and set execution context
      This method may perform state changes to set up the hook's execution state
 @param prevHook The address of the previous hook in the chain, or address(0) if first
 @param account The account to perform operations for
 @param data The hook-specific parameters and configuration data
