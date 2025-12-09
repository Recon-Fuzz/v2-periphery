# Function: inspect(bytes)

**Contract**: [lib/v2-core/src/hooks/tokens/permit2/BatchTransferFromHook.sol/contract_BatchTransferFromHook.md]

## Metadata

- **Contract**: BatchTransferFromHook
- **Signature**: `inspect(bytes)`
- **Visibility**: external
- **Source Range**: 6152:612:398

## Implementation

```solidity
/// @inheritdoc ISuperHookInspector
function inspect(bytes calldata data) override external pure returns (bytes memory packed) {
    uint256 tokensLength = BytesLib.toUint256(data, 20);
    bytes memory tokensData = BytesLib.slice(data, 84, 20 * tokensLength);
    address[] memory tokens = new address[](tokensLength);
    for (uint256 i; i < tokensLength; i++) {
        tokens[i] = BytesLib.toAddress(tokensData, i * 20);
    }
    packed = abi.encodePacked(BytesLib.toAddress(data, 0));
    for (uint256 i; i < tokensLength; ++i) {
        packed = abi.encodePacked(packed, tokens[i]);
    }
}
```

## Related Implementations

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

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BatchTransferFromHook.inspect(bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: BytesLib.toUint256(bytes,uint256) (NodeID: 1)
  │   💬 Args: [data, 20]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BytesLib.slice(bytes,uint256,uint256) (NodeID: 2)
  │   💬 Args: [data, 84, 20 * tokensLength]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 3)
  │   💬 Args: [tokensData, i * 20]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 4)
      💬 Args: [data, 0]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc ISuperHookInspector

### Interface Documentation

@notice Inspect the hook
 @param data The hook data to inspect
 @return argsEncoded The arguments of the hook encoded
