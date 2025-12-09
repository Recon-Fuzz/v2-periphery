# Function: postExecute(address,address,bytes)

**Contract**: [lib/v2-core/src/hooks/tokens/erc20/ApproveERC20Hook.sol/contract_ApproveERC20Hook.md]

## Metadata

- **Contract**: ApproveERC20Hook
- **Signature**: `postExecute(address,address,bytes)`
- **Visibility**: external
- **Source Range**: 6999:395:364
- **Inherited From**: BaseHook

## Implementation

```solidity
/// @inheritdoc ISuperHook
function postExecute(address prevHook, address account, bytes calldata data) external {
    if (msg.sender != account) revert UNAUTHORIZED_CALLER();
    uint256 context = _getCurrentExecutionContext(account);
    if (_getPostExecuteMutex(context)) revert POST_EXECUTE_ALREADY_CALLED();
    _setPostExecuteMutex(context, true);
    _postExecute(prevHook, account, data);
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

### _postExecute(address,address,bytes)

- **Kind**: internal
- **Source**: 3285:278:396
- **Link**: `lib/v2-core/src/hooks/tokens/erc20/ApproveERC20Hook.sol:ApproveERC20Hook:_postExecute(address,address,bytes)`

```solidity
function _postExecute(address, address account, bytes calldata data) override internal {
    address token = BytesLib.toAddress(data, 0);
    address spender = BytesLib.toAddress(data, 20);
    _setOutAmount(IERC20(token).allowance(account, spender), account);
}
```

### toAddress(bytes,uint256)

- **Kind**: internal
- **Source**: 12130:354:441
- **Link**: `lib/v2-core/src/vendor/BytesLib.sol:BytesLib:toAddress(bytes,uint256)`

```solidity
function toAddress(bytes memory _bytes, uint256 _start) internal pure returns (address) {
    require(_bytes.length >= (_start + 20), "toAddress_outOfBounds");
    address tempAddress;
    assembly {
        tempAddress := div(mload(add(add(_bytes, 0x20), _start)), 0x1000000000000000000000000)
    }
    return tempAddress;
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

## State Variable Reads

- **ACCOUNT_CONTEXT_STORAGE** (`bytes32`)
- **POST_EXECUTE_MUTEX_OFFSET** (`uint256`)
- **HOOK_EXECUTION_STORAGE** (`bytes32`)
- **OUT_AMOUNT_OFFSET** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BaseHook.postExecute(address,address,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: BaseHook._getCurrentExecutionContext(address) (NodeID: 1)
  │   💬 Args: [account]
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
  ├─ [1] ⚙️ FUNCTION: BaseHook._setPostExecuteMutex(uint256,bool) (NodeID: 5)
  │   💬 Args: [context, true]
  │   👁️  Def: private
  │ └─ [2] ⚙️ FUNCTION: BaseHook._makeKey(uint256,uint256) (NodeID: 6)
  │     💬 Args: [context, POST_EXECUTE_MUTEX_OFFSET]
  │     👁️  Def: private
  └─ [1] ⚙️ FUNCTION: ApproveERC20Hook._postExecute(address,address,bytes) (NodeID: 7)
      💬 Args: [prevHook, account, data]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 8)
    │   💬 Args: [data, 0]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 9)
    │   💬 Args: [data, 20]
    │   👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: BaseHook._setOutAmount(uint256,address) (NodeID: 10)
        💬 Args: [IERC20(token).allowance(account, spender), account]
        👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: BaseHook._getCurrentExecutionContext(address) (NodeID: 11)
      │   💬 Args: [caller]
      │   👁️  Def: private
      │ └─ [4] ⚙️ FUNCTION: BaseHook._makeAccountContextKey(address) (NodeID: 12)
      │     💬 Args: [caller]
      │     👁️  Def: private
      └─ [3] ⚙️ FUNCTION: BaseHook._makeKey(uint256,uint256) (NodeID: 13)
          💬 Args: [context, OUT_AMOUNT_OFFSET]
          👁️  Def: private
```

## Documentation

### Function Documentation

@inheritdoc ISuperHook

### Interface Documentation

@notice Finalizes the hook after execution
 @dev Called after the main execution, used to update hook state and calculate results
      Sets output values (outAmount, usedShares, etc.) for subsequent hooks
 @param prevHook The address of the previous hook in the chain, or address(0) if first
 @param account The account operations were performed for
 @param data The hook-specific parameters and configuration data
