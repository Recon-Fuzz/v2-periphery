# Function: inspect(bytes)

**Contract**: [lib/v2-core/src/hooks/bridges/debridge/DeBridgeSendOrderAndExecuteOnDstHook.sol/contract_DeBridgeSendOrderAndExecuteOnDstHook.md]

## Metadata

- **Contract**: DeBridgeSendOrderAndExecuteOnDstHook
- **Signature**: `inspect(bytes)`
- **Visibility**: external
- **Source Range**: 8325:593:369

## Implementation

```solidity
/// @inheritdoc ISuperHookInspector
function inspect(bytes calldata data) override external pure returns (bytes memory) {
    (IDlnSource.OrderCreation memory orderCreation, , , ) = _createOrder(data, "");
    return abi.encodePacked(orderCreation.giveTokenAddress, address(bytes20(orderCreation.takeTokenAddress)), address(bytes20(orderCreation.receiverDst)), address(bytes20(orderCreation.givePatchAuthoritySrc)), address(bytes20(orderCreation.orderAuthorityAddressDst)), address(bytes20(orderCreation.allowedCancelBeneficiarySrc)));
}
```

## Related Implementations

### _createOrder(bytes,bytes)

- **Kind**: internal
- **Source**: 10073:4225:369
- **Link**: `lib/v2-core/src/hooks/bridges/debridge/DeBridgeSendOrderAndExecuteOnDstHook.sol:DeBridgeSendOrderAndExecuteOnDstHook:_createOrder(bytes,bytes)`

```solidity
function _createOrder(bytes memory data, bytes memory sigData) internal pure returns (IDlnSource.OrderCreation memory orderCreation, uint256 value, bytes memory affiliateFee, uint32 referralCode) {
    LocalVars memory vars;
    vars.offset = 1;
    value = BytesLib.toUint256(data, vars.offset);
    vars.offset += 32;
    vars.giveTokenAddress = BytesLib.toAddress(data, vars.offset);
    vars.offset += 20;
    vars.giveAmount = BytesLib.toUint256(data, vars.offset);
    vars.offset += 32;
    vars.version = BytesLib.toUint8(data, vars.offset);
    vars.offset += 1;
    vars.fallbackAddress = BytesLib.toAddress(data, vars.offset);
    vars.offset += 20;
    vars.executorAddress = BytesLib.toAddress(data, vars.offset);
    vars.offset += 20;
    vars.executionFee = BytesLib.toUint256(data, vars.offset);
    vars.offset += 32;
    vars.allowDelayedExecution = _decodeBool(data, vars.offset);
    vars.offset += 1;
    vars.requireSuccessfulExecution = _decodeBool(data, vars.offset);
    vars.offset += 1;
    vars.len = BytesLib.toUint256(data, vars.offset);
    vars.offset += 32;
    vars.destinationMessage = BytesLib.slice(data, vars.offset, vars.len);
    vars.offset += vars.len;
    vars.len = BytesLib.toUint256(data, vars.offset);
    vars.offset += 32;
    vars.takeTokenAddress = BytesLib.slice(data, vars.offset, vars.len);
    vars.offset += vars.len;
    vars.takeAmount = BytesLib.toUint256(data, vars.offset);
    vars.offset += 32;
    vars.takeChainId = BytesLib.toUint256(data, vars.offset);
    vars.offset += 32;
    vars.len = BytesLib.toUint256(data, vars.offset);
    vars.offset += 32;
    vars.receiverDst = BytesLib.slice(data, vars.offset, vars.len);
    vars.offset += vars.len;
    vars.givePatchAuthoritySrc = BytesLib.toAddress(data, vars.offset);
    vars.offset += 20;
    vars.len = BytesLib.toUint256(data, vars.offset);
    vars.offset += 32;
    vars.orderAuthorityAddressDst = BytesLib.slice(data, vars.offset, vars.len);
    vars.offset += vars.len;
    vars.len = BytesLib.toUint256(data, vars.offset);
    vars.offset += 32;
    vars.allowedTakerDst = BytesLib.slice(data, vars.offset, vars.len);
    vars.offset += vars.len;
    vars.len = BytesLib.toUint256(data, vars.offset);
    vars.offset += 32;
    vars.allowedCancelBeneficiarySrc = BytesLib.slice(data, vars.offset, vars.len);
    vars.offset += vars.len;
    uint256 affiliateFeeLength = BytesLib.toUint256(data, vars.offset);
    vars.offset += 32;
    affiliateFee = BytesLib.slice(data, vars.offset, affiliateFeeLength);
    vars.offset += affiliateFeeLength;
    referralCode = BytesLib.toUint32(data, vars.offset);
    vars.offset += 4;
    orderCreation = IDlnSource.OrderCreation({giveTokenAddress: vars.giveTokenAddress, giveAmount: vars.giveAmount, takeTokenAddress: vars.takeTokenAddress, takeAmount: vars.takeAmount, takeChainId: vars.takeChainId, receiverDst: vars.receiverDst, givePatchAuthoritySrc: vars.givePatchAuthoritySrc, orderAuthorityAddressDst: vars.orderAuthorityAddressDst, allowedTakerDst: vars.allowedTakerDst, externalCall: _buildExternalCall(ExternalCallParams({destinationMessage: vars.destinationMessage, sigData: sigData, fallbackAddress: vars.fallbackAddress, executorAddress: vars.executorAddress, executionFee: vars.executionFee, allowDelayedExecution: vars.allowDelayedExecution, requireSuccessfulExecution: vars.requireSuccessfulExecution, version: vars.version})), allowedCancelBeneficiarySrc: vars.allowedCancelBeneficiarySrc});
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

### toUint8(bytes,uint256)

- **Kind**: internal
- **Source**: 12490:301:441
- **Link**: `lib/v2-core/src/vendor/BytesLib.sol:BytesLib:toUint8(bytes,uint256)`

```solidity
function toUint8(bytes memory _bytes, uint256 _start) internal pure returns (uint8) {
    require(_bytes.length >= (_start + 1), "toUint8_outOfBounds");
    uint8 tempUint;
    assembly {
        tempUint := mload(add(add(_bytes, 0x1), _start))
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

### toUint32(bytes,uint256)

- **Kind**: internal
- **Source**: 13108:305:441
- **Link**: `lib/v2-core/src/vendor/BytesLib.sol:BytesLib:toUint32(bytes,uint256)`

```solidity
function toUint32(bytes memory _bytes, uint256 _start) internal pure returns (uint32) {
    require(_bytes.length >= (_start + 4), "toUint32_outOfBounds");
    uint32 tempUint;
    assembly {
        tempUint := mload(add(add(_bytes, 0x4), _start))
    }
    return tempUint;
}
```

### _buildExternalCall(struct DeBridgeSendOrderAndExecuteOnDstHook.ExternalCallParams)

- **Kind**: internal
- **Source**: 14304:1139:369
- **Link**: `lib/v2-core/src/hooks/bridges/debridge/DeBridgeSendOrderAndExecuteOnDstHook.sol:DeBridgeSendOrderAndExecuteOnDstHook:_buildExternalCall(struct DeBridgeSendOrderAndExecuteOnDstHook.ExternalCallParams)`

```solidity
function _buildExternalCall(ExternalCallParams memory params) internal pure returns (bytes memory) {
    if (params.destinationMessage.length == 0) return bytes("");
    (bytes memory initData, bytes memory executorCalldata, address account, address[] memory dstTokens, uint256[] memory intentAmounts) = abi.decode(params.destinationMessage, (bytes, bytes, address, address[], uint256[]));
    IDlnSource.ExternalCallEnvelopV1 memory envelope = IDlnSource.ExternalCallEnvelopV1({payload: abi.encode(initData, executorCalldata, account, dstTokens, intentAmounts, params.sigData), fallbackAddress: params.fallbackAddress, executorAddress: params.executorAddress, executionFee: uint160(params.executionFee), allowDelayedExecution: params.allowDelayedExecution, requireSuccessfullExecution: params.requireSuccessfulExecution});
    return abi.encodePacked(params.version, abi.encode(envelope));
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: DeBridgeSendOrderAndExecuteOnDstHook.inspect(bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: DeBridgeSendOrderAndExecuteOnDstHook._createOrder(bytes,bytes) (NodeID: 1)
      💬 Args: [data, ""]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.toUint256(bytes,uint256) (NodeID: 2)
    │   💬 Args: [data, vars.offset]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 3)
    │   💬 Args: [data, vars.offset]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.toUint256(bytes,uint256) (NodeID: 4)
    │   💬 Args: [data, vars.offset]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.toUint8(bytes,uint256) (NodeID: 5)
    │   💬 Args: [data, vars.offset]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 6)
    │   💬 Args: [data, vars.offset]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 7)
    │   💬 Args: [data, vars.offset]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.toUint256(bytes,uint256) (NodeID: 8)
    │   💬 Args: [data, vars.offset]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BaseHook._decodeBool(bytes,uint256) (NodeID: 9)
    │   💬 Args: [data, vars.offset]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BaseHook._decodeBool(bytes,uint256) (NodeID: 10)
    │   💬 Args: [data, vars.offset]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.toUint256(bytes,uint256) (NodeID: 11)
    │   💬 Args: [data, vars.offset]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.slice(bytes,uint256,uint256) (NodeID: 12)
    │   💬 Args: [data, vars.offset, vars.len]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.toUint256(bytes,uint256) (NodeID: 13)
    │   💬 Args: [data, vars.offset]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.slice(bytes,uint256,uint256) (NodeID: 14)
    │   💬 Args: [data, vars.offset, vars.len]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.toUint256(bytes,uint256) (NodeID: 15)
    │   💬 Args: [data, vars.offset]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.toUint256(bytes,uint256) (NodeID: 16)
    │   💬 Args: [data, vars.offset]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.toUint256(bytes,uint256) (NodeID: 17)
    │   💬 Args: [data, vars.offset]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.slice(bytes,uint256,uint256) (NodeID: 18)
    │   💬 Args: [data, vars.offset, vars.len]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 19)
    │   💬 Args: [data, vars.offset]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.toUint256(bytes,uint256) (NodeID: 20)
    │   💬 Args: [data, vars.offset]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.slice(bytes,uint256,uint256) (NodeID: 21)
    │   💬 Args: [data, vars.offset, vars.len]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.toUint256(bytes,uint256) (NodeID: 22)
    │   💬 Args: [data, vars.offset]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.slice(bytes,uint256,uint256) (NodeID: 23)
    │   💬 Args: [data, vars.offset, vars.len]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.toUint256(bytes,uint256) (NodeID: 24)
    │   💬 Args: [data, vars.offset]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.slice(bytes,uint256,uint256) (NodeID: 25)
    │   💬 Args: [data, vars.offset, vars.len]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.toUint256(bytes,uint256) (NodeID: 26)
    │   💬 Args: [data, vars.offset]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.slice(bytes,uint256,uint256) (NodeID: 27)
    │   💬 Args: [data, vars.offset, affiliateFeeLength]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.toUint32(bytes,uint256) (NodeID: 28)
    │   💬 Args: [data, vars.offset]
    │   👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: DeBridgeSendOrderAndExecuteOnDstHook._buildExternalCall(struct DeBridgeSendOrderAndExecuteOnDstHook.ExternalCallParams) (NodeID: 29)
        💬 Args: [ExternalCallParams({destinationMessage: vars.destinationMessage, sigData: sigData, fallbackAddress: vars.fallbackAddress, executorAddress: vars.executorAddress, executionFee: vars.executionFee, allowDelayedExecution: vars.allowDelayedExecution, requireSuccessfulExecution: vars.requireSuccessfulExecution, version: vars.version})]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc ISuperHookInspector

### Interface Documentation

@notice Inspect the hook
 @param data The hook data to inspect
 @return argsEncoded The arguments of the hook encoded
