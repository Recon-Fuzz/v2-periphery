# Function: build(address,address,bytes)

**Contract**: [lib/v2-core/src/hooks/swappers/spectra/SpectraExchangeRedeemHook.sol/contract_SpectraExchangeRedeemHook.md]

## Metadata

- **Contract**: SpectraExchangeRedeemHook
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
- **Source**: 3056:1648:393
- **Link**: `lib/v2-core/src/hooks/swappers/spectra/SpectraExchangeRedeemHook.sol:SpectraExchangeRedeemHook:_buildHookExecutions(address,address,bytes)`

```solidity
/// @inheritdoc BaseHook
function _buildHookExecutions(address prevHook, address account, bytes calldata data) override internal view returns (Execution[] memory executions) {
    RedeemParams memory params = _decodeRedeemParams(data);
    if (params.recipient == address(0)) revert INVALID_RECIPIENT();
    if ((params.command != REDEEM_IBT_FOR_ASSET) && (params.command != REDEEM_PT_FOR_ASSET)) revert INVALID_COMMAND();
    if (params.usePrevHookAmount) {
        params.sharesToBurn = ISuperHookResult(prevHook).getOutAmount(account);
    }
    if (params.sharesToBurn == 0) revert AMOUNT_NOT_VALID();
    executions = new Execution[](1);
    bytes memory callData;
    if (params.command == REDEEM_IBT_FOR_ASSET) {
        if (params.asset == address(0)) revert INVALID_ASSET();
        callData = _createRedeemIbtForAssetCallData(params.asset, params.sharesToBurn, params.recipient);
    } else if (params.command == REDEEM_PT_FOR_ASSET) {
        if (params.pt == address(0)) revert INVALID_PT();
        if (params.minAssets == 0) revert INVALID_MIN_ASSETS();
        callData = _createRedeemPtForAssetCallData(params.pt, params.sharesToBurn, params.recipient, params.minAssets);
    }
    executions[0] = Execution({target: ROUTER, value: 0, callData: callData});
}
```

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

### _createRedeemIbtForAssetCallData(address,uint256,address)

- **Kind**: internal
- **Source**: 6922:480:393
- **Link**: `lib/v2-core/src/hooks/swappers/spectra/SpectraExchangeRedeemHook.sol:SpectraExchangeRedeemHook:_createRedeemIbtForAssetCallData(address,uint256,address)`

```solidity
function _createRedeemIbtForAssetCallData(address asset, uint256 sharesToBurn, address recipient) private pure returns (bytes memory callData) {
    bytes memory command = new bytes(1);
    command[0] = REDEEM_IBT_FOR_ASSET;
    bytes[] memory inputs = new bytes[](1);
    inputs[0] = abi.encode(asset, sharesToBurn, recipient);
    callData = abi.encodeWithSelector(SELECTOR, command, inputs);
}
```

### _createRedeemPtForAssetCallData(address,uint256,address,uint256)

- **Kind**: internal
- **Source**: 7408:510:393
- **Link**: `lib/v2-core/src/hooks/swappers/spectra/SpectraExchangeRedeemHook.sol:SpectraExchangeRedeemHook:_createRedeemPtForAssetCallData(address,uint256,address,uint256)`

```solidity
function _createRedeemPtForAssetCallData(address pt, uint256 sharesToBurn, address recipient, uint256 minAssets) private pure returns (bytes memory callData) {
    bytes memory command = new bytes(1);
    command[0] = REDEEM_PT_FOR_ASSET;
    bytes[] memory inputs = new bytes[](1);
    inputs[0] = abi.encode(pt, sharesToBurn, recipient, minAssets);
    callData = abi.encodeWithSelector(SELECTOR, command, inputs);
}
```

## External Calls

- **ISuperHookResult::getOutAmount(address)**
- **IAcrossSpokePoolV3::wrappedNativeToken()**
- **ISuperSignatureStorage::retrieveSignatureData(address)**

## State Variable Reads

- **REDEEM_IBT_FOR_ASSET** (`bytes1`)
- **REDEEM_PT_FOR_ASSET** (`bytes1`)
- **ROUTER** (`address`)
- **SELECTOR** (`bytes4`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BaseHook.build(address,address,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: SpectraExchangeRedeemHook._buildHookExecutions(address,address,bytes) (NodeID: 1)
      💬 Args: [prevHook, account, hookData]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: SpectraExchangeRedeemHook._decodeRedeemParams(bytes) (NodeID: 2)
    │   💬 Args: [data]
    │   👁️  Def: private
    │ ├─ [3] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 3)
    │ │   💬 Args: [data, 32]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 4)
    │ │   💬 Args: [data, 52]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 5)
    │ │   💬 Args: [data, 72]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: BytesLib.toUint256(bytes,uint256) (NodeID: 6)
    │ │   💬 Args: [data, 92]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: BytesLib.toUint256(bytes,uint256) (NodeID: 7)
    │ │   💬 Args: [data, 124]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: BaseHook._decodeBool(bytes,uint256) (NodeID: 8)
    │ │   💬 Args: [data, 156]
    │ │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: BytesLib.slice(bytes,uint256,uint256) (NodeID: 9)
    │     💬 Args: [data, 157, 1]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: SpectraExchangeRedeemHook._createRedeemIbtForAssetCallData(address,uint256,address) (NodeID: 10)
    │   💬 Args: [params.asset, params.sharesToBurn, params.recipient]
    │   👁️  Def: private
    └─ [2] ⚙️ FUNCTION: SpectraExchangeRedeemHook._createRedeemPtForAssetCallData(address,uint256,address,uint256) (NodeID: 11)
        💬 Args: [params.pt, params.sharesToBurn, params.recipient, params.minAssets]
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
