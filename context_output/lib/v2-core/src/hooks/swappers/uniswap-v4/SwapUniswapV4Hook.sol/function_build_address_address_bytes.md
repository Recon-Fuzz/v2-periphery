# Function: build(address,address,bytes)

**Contract**: [lib/v2-core/src/hooks/swappers/uniswap-v4/SwapUniswapV4Hook.sol/contract_SwapUniswapV4Hook.md]

## Metadata

- **Contract**: SwapUniswapV4Hook
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
- **Source**: 8176:630:394
- **Link**: `lib/v2-core/src/hooks/swappers/uniswap-v4/SwapUniswapV4Hook.sol:SwapUniswapV4Hook:_buildHookExecutions(address,address,bytes)`

```solidity
/// @inheritdoc BaseHook
function _buildHookExecutions(address prevHook, address account, bytes calldata data) override internal view returns (Execution[] memory executions) {
    (address inputToken, uint256 amountIn) = _getTransferParams(prevHook, account, data);
    if (inputToken != address(0)) {
        executions = new Execution[](1);
        executions[0] = Execution({target: inputToken, value: 0, callData: abi.encodeWithSelector(IERC20.transfer.selector, address(this), amountIn)});
    }
}
```

### _getTransferParams(address,address,bytes)

- **Kind**: internal
- **Source**: 23930:841:394
- **Link**: `lib/v2-core/src/hooks/swappers/uniswap-v4/SwapUniswapV4Hook.sol:SwapUniswapV4Hook:_getTransferParams(address,address,bytes)`

```solidity
/// @notice Extract transfer parameters without causing stack depth issues
///  @param prevHook The previous hook in the chain
///  @param account The account executing the hook
///  @param data The encoded hook data
///  @return inputToken The input token address
///  @return amountIn The amount to transfer
function _getTransferParams(address prevHook, address account, bytes calldata data) internal view returns (address inputToken, uint256 amountIn) {
    address currency0 = data.toAddress(0);
    address currency1 = data.toAddress(20);
    bool zeroForOne = _decodeBool(data, 216);
    bool usePrevHookAmount = _decodeBool(data, 217);
    inputToken = zeroForOne ? currency0 : currency1;
    if (usePrevHookAmount) {
        amountIn = ISuperHookResult(prevHook).getOutAmount(account);
    } else {
        amountIn = data.toUint256(120);
    }
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

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BaseHook.build(address,address,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: SwapUniswapV4Hook._buildHookExecutions(address,address,bytes) (NodeID: 1)
      💬 Args: [prevHook, account, hookData]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: SwapUniswapV4Hook._getTransferParams(address,address,bytes) (NodeID: 2)
        💬 Args: [prevHook, account, data]
        👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 3)
      │   💬 Args: [data, 0]
      │   👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 4)
      │   💬 Args: [data, 20]
      │   👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: BaseHook._decodeBool(bytes,uint256) (NodeID: 5)
      │   💬 Args: [data, 216]
      │   👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: BaseHook._decodeBool(bytes,uint256) (NodeID: 6)
      │   💬 Args: [data, 217]
      │   👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: BytesLib.toUint256(bytes,uint256) (NodeID: 7)
          💬 Args: [data, 120]
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
