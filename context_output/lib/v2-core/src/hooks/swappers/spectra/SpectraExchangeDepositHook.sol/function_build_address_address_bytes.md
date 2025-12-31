# Function: build(address,address,bytes)

**Contract**: [lib/v2-core/src/hooks/swappers/spectra/SpectraExchangeDepositHook.sol/contract_SpectraExchangeDepositHook.md]

## Metadata

- **Contract**: SpectraExchangeDepositHook
- **Signature**: `build(address,address,bytes)`
- **Visibility**: external
- **Source Range**: 5451:1084:364
- **Inherited From**: BaseHook

## Implementation

```solidity
/// @dev Standard build pattern - MUST include preExecute first, postExecute last
///  @inheritdoc ISuperHook
function build(address prevHook, address account, bytes calldata hookData) virtual external view returns (Execution[] memory executions) {
    Execution[] memory hookExecutions = _buildHookExecutions(prevHook, account, hookData);
    executions = new Execution[](hookExecutions.length + 2);
    executions[0] = Execution({target: address(this), value: 0, callData: abi.encodeCall(this.preExecute, (prevHook, account, hookData))});
    for (uint256 i = 0; i < hookExecutions.length; i++) {
        executions[i + 1] = hookExecutions[i];
    }
    executions[executions.length - 1] = Execution({target: address(this), value: 0, callData: abi.encodeCall(this.postExecute, (prevHook, account, hookData))});
}
```

## Related Implementations

### _buildHookExecutions(address,address,bytes)

- **Kind**: internal
- **Source**: 2583:908:392
- **Link**: `lib/v2-core/src/hooks/swappers/spectra/SpectraExchangeDepositHook.sol:SpectraExchangeDepositHook:_buildHookExecutions(address,address,bytes)`

```solidity
/// @inheritdoc BaseHook
function _buildHookExecutions(address prevHook, address account, bytes calldata data) override internal view returns (Execution[] memory executions) {
    address pt = data.extractYieldSource();
    bool usePrevHookAmount = _decodeBool(data, USE_PREV_HOOK_AMOUNT_POSITION);
    uint256 value = abi.decode(data[53:TX_DATA_POSITION], (uint256));
    bytes memory txData_ = data[TX_DATA_POSITION:];
    bytes memory updatedTxData = _validateTxData(data[TX_DATA_POSITION:], account, usePrevHookAmount, prevHook, pt);
    executions = new Execution[](1);
    executions[0] = Execution({target: address(ROUTER), value: (usePrevHookAmount && (value > 0)) ? ISuperHookResult(prevHook).getOutAmount(account) : value, callData: usePrevHookAmount ? updatedTxData : txData_});
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

### _validateTxData(bytes,address,bool,address,address)

- **Kind**: internal
- **Source**: 7245:4501:392
- **Link**: `lib/v2-core/src/hooks/swappers/spectra/SpectraExchangeDepositHook.sol:SpectraExchangeDepositHook:_validateTxData(bytes,address,bool,address,address)`

```solidity
function _validateTxData(bytes calldata data, address account, bool usePrevHookAmount, address prevHook, address pt) private view returns (bytes memory updatedTxData) {
    ValidateTxDataParams memory params;
    params.selector = bytes4(data[0:4]);
    if (params.selector == bytes4(keccak256("execute(bytes,bytes[])"))) {
        (params.commandsData, params.inputs) = abi.decode(data[4:], (bytes, bytes[]));
        params.inputsLength = params.inputs.length;
        params.updatedInputs = new bytes[](params.inputsLength);
    } else if (params.selector == bytes4(keccak256("execute(bytes,bytes[],uint256)"))) {
        (params.commandsData, params.inputs, params.deadline) = abi.decode(data[4:], (bytes, bytes[], uint256));
        if (params.deadline < block.timestamp) revert INVALID_DEADLINE();
        params.inputsLength = params.inputs.length;
        params.updatedInputs = new bytes[](params.inputsLength);
    } else {
        revert INVALID_SELECTOR();
    }
    params.commands = _validateCommands(params.commandsData, params.inputsLength);
    params.commandsLength = params.commands.length;
    if (params.commands[params.commandsLength - 1] == SpectraCommands.TRANSFER_FROM) {
        revert INVALID_LAST_COMMAND();
    }
    for (uint256 i; i < params.commandsLength; ++i) {
        uint256 command = params.commands[i];
        bytes memory input = params.inputs[i];
        if (command == SpectraCommands.DEPOSIT_ASSET_IN_PT) {
            (params.pt, params.assets, params.ptRecipient, params.ytRecipient, params.minShares) = abi.decode(input, (address, uint256, address, address, uint256));
            if (params.minShares == 0) revert INVALID_MIN_SHARES();
            if (params.pt != pt) revert INVALID_PT();
            if ((params.ptRecipient != account) || (params.ytRecipient != account)) revert INVALID_RECIPIENT();
            if (usePrevHookAmount) {
                params.assets = ISuperHookResult(prevHook).getOutAmount(account);
            }
            if (params.assets == 0) revert AMOUNT_NOT_VALID();
            params.updatedInputs[i] = abi.encode(params.pt, params.assets, params.ptRecipient, params.ytRecipient, params.minShares);
        } else if (command == SpectraCommands.DEPOSIT_ASSET_IN_IBT) {
            (params.ibt, params.assets, params.recipient) = abi.decode(input, (address, uint256, address));
            if (params.ibt == address(0)) revert INVALID_IBT();
            if (params.recipient != account) revert INVALID_RECIPIENT();
            if (usePrevHookAmount) {
                params.assets = ISuperHookResult(prevHook).getOutAmount(account);
            }
            if (params.assets == 0) revert AMOUNT_NOT_VALID();
            params.updatedInputs[i] = abi.encode(params.ibt, params.assets, params.recipient);
        } else if (command == SpectraCommands.TRANSFER_FROM) {
            (params.transferToken, params.assets) = abi.decode(input, (address, uint256));
            if (params.transferToken == address(0)) revert INVALID_TRANSFER_TOKEN();
            if (usePrevHookAmount) {
                params.assets = ISuperHookResult(prevHook).getOutAmount(account);
            }
            if (params.assets == 0) revert AMOUNT_NOT_VALID();
            params.updatedInputs[i] = abi.encode(params.transferToken, params.assets);
        }
    }
    if (params.selector == bytes4(keccak256("execute(bytes,bytes[])"))) {
        updatedTxData = abi.encodeWithSelector(params.selector, params.commandsData, params.updatedInputs);
    } else if (params.selector == bytes4(keccak256("execute(bytes,bytes[],uint256)"))) {
        updatedTxData = abi.encodeWithSelector(params.selector, params.commandsData, params.updatedInputs, params.deadline);
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

## External Calls

- **ISuperHookResult::getOutAmount(address)**
- **IAcrossSpokePoolV3::wrappedNativeToken()**
- **ISuperSignatureStorage::retrieveSignatureData(address)**

## State Variable Reads

- **USE_PREV_HOOK_AMOUNT_POSITION** (`uint256`)
- **TX_DATA_POSITION** (`uint256`)
- **ROUTER** (`contract ISpectraRouter`) [lib/v2-core/src/vendor/spectra/ISpectraRouter.sol/interface_ISpectraRouter.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BaseHook.build(address,address,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: SpectraExchangeDepositHook._buildHookExecutions(address,address,bytes) (NodeID: 1)
      💬 Args: [prevHook, account, hookData]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: HookDataDecoder.extractYieldSource(bytes) (NodeID: 2)
    │   💬 Args: [data]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 3)
    │     💬 Args: [data, 32]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BaseHook._decodeBool(bytes,uint256) (NodeID: 4)
    │   💬 Args: [data, USE_PREV_HOOK_AMOUNT_POSITION]
    │   👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: SpectraExchangeDepositHook._validateTxData(bytes,address,bool,address,address) (NodeID: 5)
        💬 Args: [data[TX_DATA_POSITION:], account, usePrevHookAmount, prevHook, pt]
        👁️  Def: private
      └─ [3] ⚙️ FUNCTION: SpectraExchangeDepositHook._validateCommands(bytes,uint256) (NodeID: 6)
          💬 Args: [params.commandsData, params.inputsLength]
          👁️  Def: private
```

## Documentation

### Function Documentation

@dev Standard build pattern - MUST include preExecute first, postExecute last
 @inheritdoc ISuperHook

### Interface Documentation

@notice Builds the execution array for the hook operation
 @dev This is the core method where hooks define their on-chain interactions
      The returned executions are a sequence of contract calls to perform
      No state changes should occur in this method
 @param prevHook The address of the previous hook in the chain, or address(0) if first
 @param account The account to perform executions for (usually an ERC7579 account)
 @param data The hook-specific parameters and configuration data
 @return executions Array of Execution structs defining calls to make
