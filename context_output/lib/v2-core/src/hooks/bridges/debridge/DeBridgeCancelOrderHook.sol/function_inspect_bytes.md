# Function: inspect(bytes)

**Contract**: [lib/v2-core/src/hooks/bridges/debridge/DeBridgeCancelOrderHook.sol/contract_DeBridgeCancelOrderHook.md]

## Metadata

- **Contract**: DeBridgeCancelOrderHook
- **Signature**: `inspect(bytes)`
- **Visibility**: external
- **Source Range**: 6249:513:368

## Implementation

```solidity
/// @inheritdoc ISuperHookInspector
function inspect(bytes calldata data) override external pure returns (bytes memory) {
    (Order memory order, , ) = _createOrder(data);
    return abi.encodePacked(order.giveTokenAddress, address(bytes20(order.takeTokenAddress)), address(bytes20(order.receiverDst)), address(bytes20(order.givePatchAuthoritySrc)), address(bytes20(order.orderAuthorityAddressDst)), address(bytes20(order.allowedCancelBeneficiarySrc)));
}
```

## Related Implementations

### _createOrder(bytes)

- **Kind**: internal
- **Source**: 6956:2588:368
- **Link**: `lib/v2-core/src/hooks/bridges/debridge/DeBridgeCancelOrderHook.sol:DeBridgeCancelOrderHook:_createOrder(bytes)`

```solidity
function _createOrder(bytes memory data) internal pure returns (Order memory vars, uint256 value, uint256 executionFee) {
    uint256 offset = 0;
    value = BytesLib.toUint256(data, offset);
    offset += 32;
    vars.makerOrderNonce = BytesLib.toUint64(data, offset);
    offset += 8;
    uint256 makerSrcLen = BytesLib.toUint256(data, offset);
    offset += 32;
    vars.makerSrc = BytesLib.slice(data, offset, makerSrcLen);
    offset += makerSrcLen;
    uint256 giveTokenAddressLen = BytesLib.toUint256(data, offset);
    offset += 32;
    vars.giveTokenAddress = BytesLib.slice(data, offset, giveTokenAddressLen);
    offset += giveTokenAddressLen;
    vars.giveAmount = BytesLib.toUint256(data, offset);
    offset += 32;
    vars.giveChainId = BytesLib.toUint256(data, offset);
    offset += 32;
    vars.takeChainId = BytesLib.toUint256(data, offset);
    offset += 32;
    uint256 takeTokenAddressLen = BytesLib.toUint256(data, offset);
    offset += 32;
    vars.takeTokenAddress = BytesLib.slice(data, offset, takeTokenAddressLen);
    offset += takeTokenAddressLen;
    vars.takeAmount = BytesLib.toUint256(data, offset);
    offset += 32;
    uint256 receiverDstLen = BytesLib.toUint256(data, offset);
    offset += 32;
    vars.receiverDst = BytesLib.slice(data, offset, receiverDstLen);
    offset += receiverDstLen;
    uint256 givePatchAuthoritySrcLen = BytesLib.toUint256(data, offset);
    offset += 32;
    vars.givePatchAuthoritySrc = BytesLib.slice(data, offset, givePatchAuthoritySrcLen);
    offset += givePatchAuthoritySrcLen;
    uint256 orderAuthorityAddressDstLen = BytesLib.toUint256(data, offset);
    offset += 32;
    vars.orderAuthorityAddressDst = BytesLib.slice(data, offset, orderAuthorityAddressDstLen);
    offset += orderAuthorityAddressDstLen;
    uint256 allowedTakerDstLen = BytesLib.toUint256(data, offset);
    offset += 32;
    vars.allowedTakerDst = BytesLib.slice(data, offset, allowedTakerDstLen);
    offset += allowedTakerDstLen;
    uint256 allowedCancelBeneficiarySrcLen = BytesLib.toUint256(data, offset);
    offset += 32;
    vars.allowedCancelBeneficiarySrc = BytesLib.slice(data, offset, allowedCancelBeneficiarySrcLen);
    offset += allowedCancelBeneficiarySrcLen;
    vars.externalCall = "";
    executionFee = BytesLib.toUint256(data, offset);
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

### toUint64(bytes,uint256)

- **Kind**: internal
- **Source**: 13419:305:441
- **Link**: `lib/v2-core/src/vendor/BytesLib.sol:BytesLib:toUint64(bytes,uint256)`

```solidity
function toUint64(bytes memory _bytes, uint256 _start) internal pure returns (uint64) {
    require(_bytes.length >= (_start + 8), "toUint64_outOfBounds");
    uint64 tempUint;
    assembly {
        tempUint := mload(add(add(_bytes, 0x8), _start))
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

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: DeBridgeCancelOrderHook.inspect(bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: DeBridgeCancelOrderHook._createOrder(bytes) (NodeID: 1)
      💬 Args: [data]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.toUint256(bytes,uint256) (NodeID: 2)
    │   💬 Args: [data, offset]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.toUint64(bytes,uint256) (NodeID: 3)
    │   💬 Args: [data, offset]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.toUint256(bytes,uint256) (NodeID: 4)
    │   💬 Args: [data, offset]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.slice(bytes,uint256,uint256) (NodeID: 5)
    │   💬 Args: [data, offset, makerSrcLen]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.toUint256(bytes,uint256) (NodeID: 6)
    │   💬 Args: [data, offset]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.slice(bytes,uint256,uint256) (NodeID: 7)
    │   💬 Args: [data, offset, giveTokenAddressLen]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.toUint256(bytes,uint256) (NodeID: 8)
    │   💬 Args: [data, offset]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.toUint256(bytes,uint256) (NodeID: 9)
    │   💬 Args: [data, offset]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.toUint256(bytes,uint256) (NodeID: 10)
    │   💬 Args: [data, offset]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.toUint256(bytes,uint256) (NodeID: 11)
    │   💬 Args: [data, offset]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.slice(bytes,uint256,uint256) (NodeID: 12)
    │   💬 Args: [data, offset, takeTokenAddressLen]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.toUint256(bytes,uint256) (NodeID: 13)
    │   💬 Args: [data, offset]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.toUint256(bytes,uint256) (NodeID: 14)
    │   💬 Args: [data, offset]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.slice(bytes,uint256,uint256) (NodeID: 15)
    │   💬 Args: [data, offset, receiverDstLen]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.toUint256(bytes,uint256) (NodeID: 16)
    │   💬 Args: [data, offset]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.slice(bytes,uint256,uint256) (NodeID: 17)
    │   💬 Args: [data, offset, givePatchAuthoritySrcLen]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.toUint256(bytes,uint256) (NodeID: 18)
    │   💬 Args: [data, offset]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.slice(bytes,uint256,uint256) (NodeID: 19)
    │   💬 Args: [data, offset, orderAuthorityAddressDstLen]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.toUint256(bytes,uint256) (NodeID: 20)
    │   💬 Args: [data, offset]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.slice(bytes,uint256,uint256) (NodeID: 21)
    │   💬 Args: [data, offset, allowedTakerDstLen]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.toUint256(bytes,uint256) (NodeID: 22)
    │   💬 Args: [data, offset]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.slice(bytes,uint256,uint256) (NodeID: 23)
    │   💬 Args: [data, offset, allowedCancelBeneficiarySrcLen]
    │   👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: BytesLib.toUint256(bytes,uint256) (NodeID: 24)
        💬 Args: [data, offset]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc ISuperHookInspector

### Interface Documentation

@notice Inspect the hook
 @param data The hook data to inspect
 @return argsEncoded The arguments of the hook encoded
