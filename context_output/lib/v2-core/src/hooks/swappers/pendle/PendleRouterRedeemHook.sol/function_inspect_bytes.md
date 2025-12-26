# Function: inspect(bytes)

**Contract**: [lib/v2-core/src/hooks/swappers/pendle/PendleRouterRedeemHook.sol/contract_PendleRouterRedeemHook.md]

## Metadata

- **Contract**: PendleRouterRedeemHook
- **Signature**: `inspect(bytes)`
- **Visibility**: external
- **Source Range**: 5040:231:390

## Implementation

```solidity
/// @inheritdoc ISuperHookInspector
function inspect(bytes calldata data) override external view returns (bytes memory) {
    DecodedParams memory params = _decodeAndValidateData(data);
    return abi.encodePacked(params.yt, params.pt, params.tokenOut);
}
```

## Related Implementations

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

## External Calls

- **address::staticcall(bytes memory)**
- **IStandardizedYield::isValidTokenOut(address)**

## State Variable Reads

- **TOKEN_OUTPUT_OFFSET** (`uint256`)
- **USE_PREV_HOOK_AMOUNT_POSITION** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: PendleRouterRedeemHook.inspect(bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: PendleRouterRedeemHook._decodeAndValidateData(bytes) (NodeID: 1)
      💬 Args: [data]
      👁️  Def: private
    ├─ [2] ⚙️ FUNCTION: BytesLib.toUint256(bytes,uint256) (NodeID: 2)
    │   💬 Args: [data, 0]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 3)
    │   💬 Args: [data, 32]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 4)
    │   💬 Args: [data, 52]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 5)
    │   💬 Args: [data, 72]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.toUint256(bytes,uint256) (NodeID: 6)
    │   💬 Args: [data, 92]
    │   👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: BaseHook._decodeBool(bytes,uint256) (NodeID: 7)
        💬 Args: [data, USE_PREV_HOOK_AMOUNT_POSITION]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc ISuperHookInspector

### Interface Documentation

@notice Inspect the hook
 @param data The hook data to inspect
 @return argsEncoded The arguments of the hook encoded
