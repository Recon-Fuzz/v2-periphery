# Function: inspect(bytes)

**Contract**: [lib/v2-core/src/hooks/swappers/spectra/SpectraExchangeRedeemHook.sol/contract_SpectraExchangeRedeemHook.md]

## Metadata

- **Contract**: SpectraExchangeRedeemHook
- **Signature**: `inspect(bytes)`
- **Visibility**: external
- **Source Range**: 5135:232:393

## Implementation

```solidity
/// @inheritdoc ISuperHookInspector
function inspect(bytes calldata data) override external pure returns (bytes memory) {
    RedeemParams memory params = _decodeRedeemParams(data);
    return abi.encodePacked(params.asset, params.pt, params.recipient);
}
```

## Related Implementations

### _decodeRedeemParams(bytes)

- **Kind**: internal
- **Source**: 6081:835:393
- **Link**: `lib/v2-core/src/hooks/swappers/spectra/SpectraExchangeRedeemHook.sol:SpectraExchangeRedeemHook:_decodeRedeemParams(bytes)`

```solidity
function _decodeRedeemParams(bytes calldata data) private pure returns (RedeemParams memory params) {
    address asset = BytesLib.toAddress(data, 32);
    address pt = BytesLib.toAddress(data, 52);
    address recipient = BytesLib.toAddress(data, 72);
    uint256 minAssets = BytesLib.toUint256(data, 92);
    uint256 sharesToBurn = BytesLib.toUint256(data, 124);
    bool usePrevHookAmount = _decodeBool(data, 156);
    bytes memory encodedCommand = BytesLib.slice(data, 157, 1);
    bytes1 command = encodedCommand[0];
    return RedeemParams({pt: pt, asset: asset, recipient: recipient, minAssets: minAssets, sharesToBurn: sharesToBurn, usePrevHookAmount: usePrevHookAmount, command: command});
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

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SpectraExchangeRedeemHook.inspect(bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: SpectraExchangeRedeemHook._decodeRedeemParams(bytes) (NodeID: 1)
      💬 Args: [data]
      👁️  Def: private
    ├─ [2] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 2)
    │   💬 Args: [data, 32]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 3)
    │   💬 Args: [data, 52]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 4)
    │   💬 Args: [data, 72]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.toUint256(bytes,uint256) (NodeID: 5)
    │   💬 Args: [data, 92]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.toUint256(bytes,uint256) (NodeID: 6)
    │   💬 Args: [data, 124]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BaseHook._decodeBool(bytes,uint256) (NodeID: 7)
    │   💬 Args: [data, 156]
    │   👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: BytesLib.slice(bytes,uint256,uint256) (NodeID: 8)
        💬 Args: [data, 157, 1]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc ISuperHookInspector

### Interface Documentation

@notice Inspect the hook
 @param data The hook data to inspect
 @return argsEncoded The arguments of the hook encoded
