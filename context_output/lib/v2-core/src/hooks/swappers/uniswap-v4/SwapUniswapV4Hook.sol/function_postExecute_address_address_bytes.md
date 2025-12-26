# Function: postExecute(address,address,bytes)

**Contract**: [lib/v2-core/src/hooks/swappers/uniswap-v4/SwapUniswapV4Hook.sol/contract_SwapUniswapV4Hook.md]

## Metadata

- **Contract**: SwapUniswapV4Hook
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
- **Source**: 9698:1328:394
- **Link**: `lib/v2-core/src/hooks/swappers/uniswap-v4/SwapUniswapV4Hook.sol:SwapUniswapV4Hook:_postExecute(address,address,bytes)`

```solidity
/// @inheritdoc BaseHook
function _postExecute(address, address account, bytes calldata data) override internal {
    bytes memory unlockData = _loadUnlockData();
    bytes memory unlockResult = POOL_MANAGER.unlock(unlockData);
    _clearUnlockData();
    uint256 outputAmount = abi.decode(unlockResult, (uint256));
    address outputToken = _getOutputToken(data);
    address dstReceiver = data.toAddress(68);
    uint256 currentBalance;
    if (outputToken == address(0)) {
        currentBalance = dstReceiver.balance;
    } else {
        currentBalance = IERC20(outputToken).balanceOf(dstReceiver);
    }
    uint256 trueOutputAmount = currentBalance - initialBalance;
    if (outputAmount != trueOutputAmount) revert OUTPUT_AMOUNT_DIFFERENT_THAN_TRUE();
    _setOutAmount(outputAmount, account);
}
```

### _loadUnlockData()

- **Kind**: internal
- **Source**: 30775:695:394
- **Link**: `lib/v2-core/src/hooks/swappers/uniswap-v4/SwapUniswapV4Hook.sol:SwapUniswapV4Hook:_loadUnlockData()`

```solidity
/// @notice Loads unlock data from transient storage
///  @dev Follows SignatureTransientStorage pattern: loads length first, then reconstructs data
///  @return out The retrieved unlock data
function _loadUnlockData() private view returns (bytes memory out) {
    bytes32 storageKey = PENDING_UNLOCK_DATA_SLOT;
    uint256 len;
    assembly {
        len := tload(storageKey)
    }
    out = new bytes(len);
    for (uint256 i; i < len; i += 32) {
        bytes32 word;
        assembly {
            word := tload(add(storageKey, div(add(i, 32), 32)))
        }
        assembly {
            mstore(add(add(out, 0x20), i), word)
        }
    }
}
```

### _clearUnlockData()

- **Kind**: internal
- **Source**: 31614:161:394
- **Link**: `lib/v2-core/src/hooks/swappers/uniswap-v4/SwapUniswapV4Hook.sol:SwapUniswapV4Hook:_clearUnlockData()`

```solidity
/// @notice Clears unlock data from transient storage
///  @dev Clears the length slot (data chunks will be automatically cleared)
function _clearUnlockData() private {
    bytes32 storageKey = PENDING_UNLOCK_DATA_SLOT;
    assembly {
        tstore(storageKey, 0)
    }
}
```

### _getOutputToken(bytes)

- **Kind**: internal
- **Source**: 29198:419:394
- **Link**: `lib/v2-core/src/hooks/swappers/uniswap-v4/SwapUniswapV4Hook.sol:SwapUniswapV4Hook:_getOutputToken(bytes)`

```solidity
/// @notice Gets the output token from hook data
///  @param data The hook data
///  @return outputToken The output token address
function _getOutputToken(bytes calldata data) internal pure returns (address outputToken) {
    address currency0 = data.toAddress(0);
    address currency1 = data.toAddress(20);
    bool zeroForOne = _decodeBool(data, 216);
    outputToken = zeroForOne ? currency1 : currency0;
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

### _decodeBool(bytes,uint256)

- **Kind**: internal
- **Source**: 11462:126:364
- **Link**: `lib/v2-core/src/hooks/BaseHook.sol:BaseHook:_decodeBool(bytes,uint256)`

```solidity
/// @notice Decodes a boolean value from a byte array at the specified offset
///  @dev Helper function for extracting boolean values from packed data
///       Used when parsing hook-specific data parameters
///  @param data The byte array containing the encoded data
///  @param offset The position in the array to read from
///  @return The decoded boolean value (true if byte is non-zero)
function _decodeBool(bytes memory data, uint256 offset) internal pure returns (bool) {
    return data[offset] != 0;
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
- **POOL_MANAGER** (`contract IPoolManager`) [lib/v2-core/lib/v4-core/src/interfaces/IPoolManager.sol/interface_IPoolManager.md]
- **initialBalance** (`uint256`)
- **PENDING_UNLOCK_DATA_SLOT** (`bytes32`)
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
  └─ [1] ⚙️ FUNCTION: SwapUniswapV4Hook._postExecute(address,address,bytes) (NodeID: 7)
      💬 Args: [prevHook, account, data]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: SwapUniswapV4Hook._loadUnlockData() (NodeID: 8)
    │   💬 Args: [no args]
    │   👁️  Def: private
    ├─ [2] ⚙️ FUNCTION: SwapUniswapV4Hook._clearUnlockData() (NodeID: 9)
    │   💬 Args: [no args]
    │   👁️  Def: private
    ├─ [2] ⚙️ FUNCTION: SwapUniswapV4Hook._getOutputToken(bytes) (NodeID: 10)
    │   💬 Args: [data]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 11)
    │ │   💬 Args: [data, 0]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 12)
    │ │   💬 Args: [data, 20]
    │ │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: BaseHook._decodeBool(bytes,uint256) (NodeID: 13)
    │     💬 Args: [data, 216]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 14)
    │   💬 Args: [data, 68]
    │   👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: BaseHook._setOutAmount(uint256,address) (NodeID: 15)
        💬 Args: [outputAmount, account]
        👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: BaseHook._getCurrentExecutionContext(address) (NodeID: 16)
      │   💬 Args: [caller]
      │   👁️  Def: private
      │ └─ [4] ⚙️ FUNCTION: BaseHook._makeAccountContextKey(address) (NodeID: 17)
      │     💬 Args: [caller]
      │     👁️  Def: private
      └─ [3] ⚙️ FUNCTION: BaseHook._makeKey(uint256,uint256) (NodeID: 18)
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
