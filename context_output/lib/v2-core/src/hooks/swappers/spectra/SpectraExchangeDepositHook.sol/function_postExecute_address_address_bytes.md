# Function: postExecute(address,address,bytes)

**Contract**: [lib/v2-core/src/hooks/swappers/spectra/SpectraExchangeDepositHook.sol/contract_SpectraExchangeDepositHook.md]

## Metadata

- **Contract**: SpectraExchangeDepositHook
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
- **Source**: 6401:178:392
- **Link**: `lib/v2-core/src/hooks/swappers/spectra/SpectraExchangeDepositHook.sol:SpectraExchangeDepositHook:_postExecute(address,address,bytes)`

```solidity
function _postExecute(address, address account, bytes calldata data) override internal {
    _setOutAmount(_getBalance(data, account) - getOutAmount(account), account);
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

### getOutAmount(address)

- **Kind**: internal
- **Source**: 7837:142:364
- **Link**: `lib/v2-core/src/hooks/BaseHook.sol:BaseHook:getOutAmount(address)`

```solidity
function getOutAmount(address caller) public view returns (uint256) {
    return _getOutAmount(_getCurrentExecutionContext(caller));
}
```

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

### _getBalance(bytes,address)

- **Kind**: internal
- **Source**: 14066:304:392
- **Link**: `lib/v2-core/src/hooks/swappers/spectra/SpectraExchangeDepositHook.sol:SpectraExchangeDepositHook:_getBalance(bytes,address)`

```solidity
function _getBalance(bytes calldata data, address account) private view returns (uint256) {
    address tokenOut = _decodeTokenOut(data[TX_DATA_POSITION:]);
    if (tokenOut == address(0)) {
        return account.balance;
    }
    return IERC20(tokenOut).balanceOf(account);
}
```

### _decodeTokenOut(bytes)

- **Kind**: internal
- **Source**: 12630:1242:392
- **Link**: `lib/v2-core/src/hooks/swappers/spectra/SpectraExchangeDepositHook.sol:SpectraExchangeDepositHook:_decodeTokenOut(bytes)`

```solidity
function _decodeTokenOut(bytes calldata data) internal pure returns (address tokenOut) {
    bytes4 selector = bytes4(data[0:4]);
    bytes memory commandsData;
    bytes[] memory inputs;
    if (selector == bytes4(keccak256("execute(bytes,bytes[])"))) {
        (commandsData, inputs) = abi.decode(data[4:], (bytes, bytes[]));
    } else if (selector == bytes4(keccak256("execute(bytes,bytes[],uint256)"))) {
        (commandsData, inputs, ) = abi.decode(data[4:], (bytes, bytes[], uint256));
    } else {
        revert INVALID_SELECTOR();
    }
    uint256 inputsLength = inputs.length;
    uint256[] memory commands = _validateCommands(commandsData, inputsLength);
    uint256 commandsLength = commands.length;
    for (uint256 i; i < commandsLength; ++i) {
        uint256 command = commands[i];
        bytes memory input = inputs[i];
        if (command == SpectraCommands.DEPOSIT_ASSET_IN_PT) {
            (tokenOut, , , ) = abi.decode(input, (address, uint256, address, address));
        } else if (command == SpectraCommands.DEPOSIT_ASSET_IN_IBT) {
            (tokenOut, , ) = abi.decode(input, (address, uint256, address));
        }
    }
}
```

### _validateCommands(bytes,uint256)

- **Kind**: internal
- **Source**: 11752:872:392
- **Link**: `lib/v2-core/src/hooks/swappers/spectra/SpectraExchangeDepositHook.sol:SpectraExchangeDepositHook:_validateCommands(bytes,uint256)`

```solidity
function _validateCommands(bytes memory _commands, uint256 inputsLength) private pure returns (uint256[] memory commands) {
    uint256 commandsLength = _commands.length;
    if (commandsLength != inputsLength) {
        revert LENGTH_MISMATCH();
    }
    commands = new uint256[](commandsLength);
    for (uint256 i; i < commandsLength; ++i) {
        bytes1 commandType = _commands[i];
        uint256 command = uint8(commandType & SpectraCommands.COMMAND_TYPE_MASK);
        if (((command != SpectraCommands.DEPOSIT_ASSET_IN_PT) && (command != SpectraCommands.DEPOSIT_ASSET_IN_IBT)) && (command != SpectraCommands.TRANSFER_FROM)) {
            revert INVALID_COMMAND();
        }
        commands[i] = command;
    }
}
```

## State Variable Reads

- **ACCOUNT_CONTEXT_STORAGE** (`bytes32`)
- **POST_EXECUTE_MUTEX_OFFSET** (`uint256`)
- **HOOK_EXECUTION_STORAGE** (`bytes32`)
- **OUT_AMOUNT_OFFSET** (`uint256`)
- **TX_DATA_POSITION** (`uint256`)

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
  └─ [1] ⚙️ FUNCTION: SpectraExchangeDepositHook._postExecute(address,address,bytes) (NodeID: 7)
      💬 Args: [prevHook, account, data]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: BaseHook._setOutAmount(uint256,address) (NodeID: 8)
        💬 Args: [_getBalance(data, account) - getOutAmount(account), account]
        👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: BaseHook.getOutAmount(address) (NodeID: 12)
      │   💬 Args: [account]
      │   👁️  Def: public
      │ └─ [4] ⚙️ FUNCTION: BaseHook._getOutAmount(uint256) (NodeID: 13)
      │     💬 Args: [_getCurrentExecutionContext(caller)]
      │     👁️  Def: private
      │   ├─ [5] ⚙️ FUNCTION: BaseHook._getCurrentExecutionContext(address) (NodeID: 15)
      │   │   💬 Args: [caller]
      │   │   👁️  Def: private
      │   │ └─ [6] ⚙️ FUNCTION: BaseHook._makeAccountContextKey(address) (NodeID: 16)
      │   │     💬 Args: [caller]
      │   │     👁️  Def: private
      │   └─ [5] ⚙️ FUNCTION: BaseHook._makeKey(uint256,uint256) (NodeID: 14)
      │       💬 Args: [context, OUT_AMOUNT_OFFSET]
      │       👁️  Def: private
      ├─ [3] ⚙️ FUNCTION: SpectraExchangeDepositHook._getBalance(bytes,address) (NodeID: 17)
      │   💬 Args: [data, account]
      │   👁️  Def: private
      │ └─ [4] ⚙️ FUNCTION: SpectraExchangeDepositHook._decodeTokenOut(bytes) (NodeID: 18)
      │     💬 Args: [data[TX_DATA_POSITION:]]
      │     👁️  Def: internal
      │   └─ [5] ⚙️ FUNCTION: SpectraExchangeDepositHook._validateCommands(bytes,uint256) (NodeID: 19)
      │       💬 Args: [commandsData, inputsLength]
      │       👁️  Def: private
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

@notice Finalizes the hook after execution
 @dev Called after the main execution, used to update hook state and calculate results
      Sets output values (outAmount, usedShares, etc.) for subsequent hooks
 @param prevHook The address of the previous hook in the chain, or address(0) if first
 @param account The account operations were performed for
 @param data The hook-specific parameters and configuration data
