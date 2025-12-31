# Function: inspect(bytes)

**Contract**: [lib/v2-core/src/hooks/swappers/spectra/SpectraExchangeDepositHook.sol/contract_SpectraExchangeDepositHook.md]

## Metadata

- **Contract**: SpectraExchangeDepositHook
- **Signature**: `inspect(bytes)`
- **Visibility**: external
- **Source Range**: 3927:2121:392

## Implementation

```solidity
/// @inheritdoc ISuperHookInspector
function inspect(bytes calldata data) override external pure returns (bytes memory packed) {
    bytes calldata txData_ = data[TX_DATA_POSITION:];
    ValidateTxDataParams memory params;
    params.selector = bytes4(txData_[0:4]);
    if (params.selector == bytes4(keccak256("execute(bytes,bytes[])"))) {
        (params.commandsData, params.inputs) = abi.decode(txData_[4:], (bytes, bytes[]));
        params.inputsLength = params.inputs.length;
        params.updatedInputs = new bytes[](params.inputsLength);
    } else if (params.selector == bytes4(keccak256("execute(bytes,bytes[],uint256)"))) {
        (params.commandsData, params.inputs, params.deadline) = abi.decode(txData_[4:], (bytes, bytes[], uint256));
        params.inputsLength = params.inputs.length;
        params.updatedInputs = new bytes[](params.inputsLength);
    }
    params.commands = _validateCommands(params.commandsData, params.inputsLength);
    params.commandsLength = params.commands.length;
    packed = abi.encodePacked(data.extractYieldSource());
    for (uint256 i; i < params.commandsLength; ++i) {
        uint256 command = params.commands[i];
        bytes memory input = params.inputs[i];
        if (command == SpectraCommands.DEPOSIT_ASSET_IN_PT) {
            (params.pt, params.assets, params.ptRecipient, params.ytRecipient, params.minShares) = abi.decode(input, (address, uint256, address, address, uint256));
            packed = abi.encodePacked(packed, params.pt, params.ptRecipient, params.ytRecipient);
        } else if (command == SpectraCommands.DEPOSIT_ASSET_IN_IBT) {
            (params.ibt, params.assets, params.recipient) = abi.decode(input, (address, uint256, address));
            packed = abi.encodePacked(packed, params.ibt, params.recipient);
        } else if (command == SpectraCommands.TRANSFER_FROM) {
            (params.transferToken) = abi.decode(input, (address));
            packed = abi.encodePacked(packed, params.transferToken);
        }
    }
}
```

## Related Implementations

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

- **TX_DATA_POSITION** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SpectraExchangeDepositHook.inspect(bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: SpectraExchangeDepositHook._validateCommands(bytes,uint256) (NodeID: 1)
  │   💬 Args: [params.commandsData, params.inputsLength]
  │   👁️  Def: private
  └─ [1] ⚙️ FUNCTION: HookDataDecoder.extractYieldSource(bytes) (NodeID: 2)
      💬 Args: [data]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 3)
        💬 Args: [data, 32]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc ISuperHookInspector

### Interface Documentation

@notice Inspect the hook
 @param data The hook data to inspect
 @return argsEncoded The arguments of the hook encoded
