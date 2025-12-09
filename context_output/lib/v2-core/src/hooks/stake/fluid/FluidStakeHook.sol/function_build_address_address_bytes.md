# Function: build(address,address,bytes)

**Contract**: [lib/v2-core/src/hooks/stake/fluid/FluidStakeHook.sol/contract_FluidStakeHook.md]

## Metadata

- **Contract**: FluidStakeHook
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
- **Source**: 1534:870:381
- **Link**: `lib/v2-core/src/hooks/stake/fluid/FluidStakeHook.sol:FluidStakeHook:_buildHookExecutions(address,address,bytes)`

```solidity
/// @inheritdoc BaseHook
function _buildHookExecutions(address prevHook, address account, bytes calldata data) override internal view returns (Execution[] memory executions) {
    address yieldSource = data.extractYieldSource();
    uint256 amount = _decodeAmount(data);
    bool usePrevHookAmount = _decodeBool(data, USE_PREV_HOOK_AMOUNT_POSITION);
    if (yieldSource == address(0)) revert ADDRESS_NOT_VALID();
    if (usePrevHookAmount) {
        amount = ISuperHookResult(prevHook).getOutAmount(account);
    }
    if (amount == 0) revert AMOUNT_NOT_VALID();
    executions = new Execution[](1);
    executions[0] = Execution({target: yieldSource, value: 0, callData: abi.encodeCall(IFluidLendingStakingRewards.stake, (amount))});
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

### _decodeAmount(bytes)

- **Kind**: internal
- **Source**: 3831:138:381
- **Link**: `lib/v2-core/src/hooks/stake/fluid/FluidStakeHook.sol:FluidStakeHook:_decodeAmount(bytes)`

```solidity
function _decodeAmount(bytes memory data) private pure returns (uint256) {
    return BytesLib.toUint256(data, AMOUNT_POSITION);
}
```

### toUint256(bytes,uint256)

- **Kind**: internal
- **Source**: 14359:311:441
- **Link**: `lib/v2-core/src/vendor/BytesLib.sol:BytesLib:toUint256(bytes,uint256)`

```solidity
function toUint256(bytes memory _bytes, uint256 _start) internal pure returns (uint256) {
    require(_bytes.length >= (_start + 32), "toUint256_outOfBounds");
    uint256 tempUint;
    assembly {
        tempUint := mload(add(add(_bytes, 0x20), _start))
    }
    return tempUint;
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

## State Variable Reads

- **USE_PREV_HOOK_AMOUNT_POSITION** (`uint256`)
- **AMOUNT_POSITION** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BaseHook.build(address,address,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: FluidStakeHook._buildHookExecutions(address,address,bytes) (NodeID: 1)
      💬 Args: [prevHook, account, hookData]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: HookDataDecoder.extractYieldSource(bytes) (NodeID: 2)
    │   💬 Args: [data]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 3)
    │     💬 Args: [data, 32]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: FluidStakeHook._decodeAmount(bytes) (NodeID: 4)
    │   💬 Args: [data]
    │   👁️  Def: private
    │ └─ [3] ⚙️ FUNCTION: BytesLib.toUint256(bytes,uint256) (NodeID: 5)
    │     💬 Args: [data, AMOUNT_POSITION]
    │     👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: BaseHook._decodeBool(bytes,uint256) (NodeID: 6)
        💬 Args: [data, USE_PREV_HOOK_AMOUNT_POSITION]
        👁️  Def: internal
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
