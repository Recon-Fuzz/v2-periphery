# Function: build(address,address,bytes)

**Contract**: [lib/v2-core/src/hooks/stake/gearbox/GearboxUnstakeHook.sol/contract_GearboxUnstakeHook.md]

## Metadata

- **Contract**: GearboxUnstakeHook
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
- **Source**: 1429:872:385
- **Link**: `lib/v2-core/src/hooks/stake/gearbox/GearboxUnstakeHook.sol:GearboxUnstakeHook:_buildHookExecutions(address,address,bytes)`

```solidity
/// @inheritdoc BaseHook
function _buildHookExecutions(address prevHook, address account, bytes calldata data) override internal view returns (Execution[] memory executions) {
    address yieldSource = data.extractYieldSource();
    uint256 amount = _decodeAmount(data);
    bool usePrevHookAmount = _decodeBool(data, USE_PREV_HOOK_AMOUNT_POSITION);
    if (yieldSource == address(0)) revert ADDRESS_NOT_VALID();
    if (usePrevHookAmount) {
        amount = ISuperHookResultOutflow(prevHook).getOutAmount(account);
    }
    if (amount == 0) revert AMOUNT_NOT_VALID();
    executions = new Execution[](1);
    executions[0] = Execution({target: yieldSource, value: 0, callData: abi.encodeCall(IGearboxFarmingPool.withdraw, (amount))});
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
- **Source**: 3795:161:385
- **Link**: `lib/v2-core/src/hooks/stake/gearbox/GearboxUnstakeHook.sol:GearboxUnstakeHook:_decodeAmount(bytes)`

```solidity
function _decodeAmount(bytes memory data) private pure returns (uint256) {
    return BytesLib.toUint256(BytesLib.slice(data, AMOUNT_POSITION, 32), 0);
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

### slice(bytes,uint256,uint256)

- **Kind**: internal
- **Source**: 9250:2874:441
- **Link**: `lib/v2-core/src/vendor/BytesLib.sol:BytesLib:slice(bytes,uint256,uint256)`

```solidity
function slice(bytes memory _bytes, uint256 _start, uint256 _length) internal pure returns (bytes memory) {
    unchecked {
        require((_length + 31) >= _length, "slice_overflow");
    }
    require(_bytes.length >= (_start + _length), "slice_outOfBounds");
    bytes memory tempBytes;
    assembly {
        switch iszero(_length)
        case 0 {
            tempBytes := mload(0x40)
            let lengthmod := and(_length, 31)
            let mc := add(add(tempBytes, lengthmod), mul(0x20, iszero(lengthmod)))
            let end := add(mc, _length)
            for {
                let cc := add(add(add(_bytes, lengthmod), mul(0x20, iszero(lengthmod))), _start)
            } lt(mc, end) {
                mc := add(mc, 0x20)
                cc := add(cc, 0x20)
            } {
                mstore(mc, mload(cc))
            }
            mstore(tempBytes, _length)
            mstore(0x40, and(add(mc, 31), not(31)))
        }
        default {
            tempBytes := mload(0x40)
            mstore(tempBytes, 0)
            mstore(0x40, add(tempBytes, 0x20))
        }
    }
    return tempBytes;
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
  └─ [1] ⚙️ FUNCTION: GearboxUnstakeHook._buildHookExecutions(address,address,bytes) (NodeID: 1)
      💬 Args: [prevHook, account, hookData]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: HookDataDecoder.extractYieldSource(bytes) (NodeID: 2)
    │   💬 Args: [data]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 3)
    │     💬 Args: [data, 32]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: GearboxUnstakeHook._decodeAmount(bytes) (NodeID: 4)
    │   💬 Args: [data]
    │   👁️  Def: private
    │ └─ [3] ⚙️ FUNCTION: BytesLib.toUint256(bytes,uint256) (NodeID: 5)
    │     💬 Args: [BytesLib.slice(data, AMOUNT_POSITION, 32), 0]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: BytesLib.slice(bytes,uint256,uint256) (NodeID: 6)
    │       💬 Args: [data, AMOUNT_POSITION, 32]
    │       👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: BaseHook._decodeBool(bytes,uint256) (NodeID: 7)
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
