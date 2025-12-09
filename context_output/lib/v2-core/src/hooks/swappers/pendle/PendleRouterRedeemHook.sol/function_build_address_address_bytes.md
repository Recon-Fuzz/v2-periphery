# Function: build(address,address,bytes)

**Contract**: [lib/v2-core/src/hooks/swappers/pendle/PendleRouterRedeemHook.sol/contract_PendleRouterRedeemHook.md]

## Metadata

- **Contract**: PendleRouterRedeemHook
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
- **Source**: 3361:1083:390
- **Link**: `lib/v2-core/src/hooks/swappers/pendle/PendleRouterRedeemHook.sol:PendleRouterRedeemHook:_buildHookExecutions(address,address,bytes)`

```solidity
/// @inheritdoc BaseHook
function _buildHookExecutions(address prevHook, address account, bytes calldata data) override internal view returns (Execution[] memory executions) {
    DecodedParams memory params = _decodeAndValidateData(data);
    uint256 finalAmount = _determineFinalAmount(params.amountFromData, params.usePrevHookAmount, prevHook, account);
    executions = new Execution[](3);
    executions[0] = Execution({target: params.pt, value: 0, callData: abi.encodeCall(IERC20.approve, (address(PENDLE_ROUTER_V4), finalAmount))});
    executions[1] = Execution({target: params.yt, value: 0, callData: abi.encodeCall(IERC20.approve, (address(PENDLE_ROUTER_V4), finalAmount))});
    executions[2] = Execution({target: address(PENDLE_ROUTER_V4), value: 0, callData: abi.encodeCall(IPendleRouterV4.redeemPyToToken, (account, params.yt, finalAmount, params.output))});
}
```

### _decodeAndValidateData(bytes)

- **Kind**: internal
- **Source**: 6093:1931:390
- **Link**: `lib/v2-core/src/hooks/swappers/pendle/PendleRouterRedeemHook.sol:PendleRouterRedeemHook:_decodeAndValidateData(bytes)`

```solidity
/// @dev Decodes hook data based on packed encoding, validates parameters, and returns them.
function _decodeAndValidateData(bytes calldata data) private view returns (DecodedParams memory params) {
    if (data.length < TOKEN_OUTPUT_OFFSET) revert INVALID_DATA_LENGTH();
    params.amountFromData = BytesLib.toUint256(data, 0);
    params.yt = BytesLib.toAddress(data, 32);
    params.pt = BytesLib.toAddress(data, 52);
    params.tokenOut = BytesLib.toAddress(data, 72);
    params.minTokenOut = BytesLib.toUint256(data, 92);
    params.usePrevHookAmount = _decodeBool(data, USE_PREV_HOOK_AMOUNT_POSITION);
    if (params.yt == address(0)) revert YT_NOT_VALID();
    if (params.tokenOut == address(0)) revert TOKEN_OUT_NOT_VALID();
    if (params.minTokenOut == 0) revert MIN_TOKEN_OUT_NOT_VALID();
    params.output = abi.decode(data[TOKEN_OUTPUT_OFFSET:], (TokenOutput));
    if (params.output.tokenOut != params.tokenOut) revert TOKEN_OUT_NOT_VALID();
    if (params.output.minTokenOut != params.minTokenOut) revert MIN_TOKEN_OUT_NOT_VALID();
    (bool ok, bytes memory ret) = params.yt.staticcall(abi.encodeWithSignature("SY()"));
    if ((!ok) || (ret.length < 32)) revert SY_NOT_VALID();
    if (!IStandardizedYield(abi.decode(ret, (address))).isValidTokenOut(params.tokenOut)) revert TOKEN_OUT_NOT_LISTED();
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

### _determineFinalAmount(uint256,bool,address,address)

- **Kind**: internal
- **Source**: 8115:601:390
- **Link**: `lib/v2-core/src/hooks/swappers/pendle/PendleRouterRedeemHook.sol:PendleRouterRedeemHook:_determineFinalAmount(uint256,bool,address,address)`

```solidity
/// @dev Determines the final amount to use based on the flag and previous hook.
function _determineFinalAmount(uint256 amountFromData, bool usePrevHookAmount, address prevHook, address account) private view returns (uint256 finalAmount) {
    if (usePrevHookAmount) {
        finalAmount = ISuperHookResult(prevHook).getOutAmount(account);
        if (finalAmount == 0) revert AMOUNT_NOT_VALID();
    } else {
        if (amountFromData == 0) revert AMOUNT_NOT_VALID();
        finalAmount = amountFromData;
    }
}
```

## State Variable Reads

- **PENDLE_ROUTER_V4** (`contract IPendleRouterV4`) [lib/v2-core/src/vendor/pendle/IPendleRouterV4.sol/interface_IPendleRouterV4.md]
- **TOKEN_OUTPUT_OFFSET** (`uint256`)
- **USE_PREV_HOOK_AMOUNT_POSITION** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BaseHook.build(address,address,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: PendleRouterRedeemHook._buildHookExecutions(address,address,bytes) (NodeID: 1)
      💬 Args: [prevHook, account, hookData]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: PendleRouterRedeemHook._decodeAndValidateData(bytes) (NodeID: 2)
    │   💬 Args: [data]
    │   👁️  Def: private
    │ ├─ [3] ⚙️ FUNCTION: BytesLib.toUint256(bytes,uint256) (NodeID: 3)
    │ │   💬 Args: [data, 0]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 4)
    │ │   💬 Args: [data, 32]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 5)
    │ │   💬 Args: [data, 52]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 6)
    │ │   💬 Args: [data, 72]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: BytesLib.toUint256(bytes,uint256) (NodeID: 7)
    │ │   💬 Args: [data, 92]
    │ │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: BaseHook._decodeBool(bytes,uint256) (NodeID: 8)
    │     💬 Args: [data, USE_PREV_HOOK_AMOUNT_POSITION]
    │     👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: PendleRouterRedeemHook._determineFinalAmount(uint256,bool,address,address) (NodeID: 9)
        💬 Args: [params.amountFromData, params.usePrevHookAmount, prevHook, account]
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
