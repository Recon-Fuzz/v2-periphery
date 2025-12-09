# Function: postExecute(address,address,bytes)

**Contract**: [lib/v2-core/src/hooks/vaults/ethena/EthenaCooldownSharesHook.sol/contract_EthenaCooldownSharesHook.md]

## Metadata

- **Contract**: EthenaCooldownSharesHook
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
- **Source**: 3486:162:416
- **Link**: `lib/v2-core/src/hooks/vaults/ethena/EthenaCooldownSharesHook.sol:EthenaCooldownSharesHook:_postExecute(address,address,bytes)`

```solidity
function _postExecute(address, address account, bytes calldata data) override internal {
    usedShares = usedShares - _getSharesBalance(account, data);
}
```

### _getSharesBalance(address,bytes)

- **Kind**: internal
- **Source**: 3985:170:416
- **Link**: `lib/v2-core/src/hooks/vaults/ethena/EthenaCooldownSharesHook.sol:EthenaCooldownSharesHook:_getSharesBalance(address,bytes)`

```solidity
function _getSharesBalance(address account, bytes memory data) private view returns (uint256) {
    return IERC20(data.extractYieldSource()).balanceOf(account);
}
```

### extractYieldSource(bytes)

- **Kind**: internal
- **Source**: 396:131:432
- **Link**: `lib/v2-core/src/libraries/HookDataDecoder.sol:HookDataDecoder:extractYieldSource(bytes)`

```solidity
function extractYieldSource(bytes memory data) internal pure returns (address) {
    return BytesLib.toAddress(data, 32);
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

## State Variable Reads

- **ACCOUNT_CONTEXT_STORAGE** (`bytes32`)
- **POST_EXECUTE_MUTEX_OFFSET** (`uint256`)
- **HOOK_EXECUTION_STORAGE** (`bytes32`)

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
  └─ [1] ⚙️ FUNCTION: EthenaCooldownSharesHook._postExecute(address,address,bytes) (NodeID: 7)
      💬 Args: [prevHook, account, data]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: EthenaCooldownSharesHook._getSharesBalance(address,bytes) (NodeID: 8)
        💬 Args: [account, data]
        👁️  Def: private
      └─ [3] ⚙️ FUNCTION: HookDataDecoder.extractYieldSource(bytes) (NodeID: 9)
          💬 Args: [data]
          👁️  Def: internal
        └─ [4] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 10)
            💬 Args: [data, 32]
            👁️  Def: internal
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
