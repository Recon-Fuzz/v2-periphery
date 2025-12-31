# Function: build(address,address,bytes)

**Contract**: [lib/v2-core/src/hooks/swappers/pendle/PendleRouterSwapHook.sol/contract_PendleRouterSwapHook.md]

## Metadata

- **Contract**: PendleRouterSwapHook
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
- **Source**: 2650:1193:391
- **Link**: `lib/v2-core/src/hooks/swappers/pendle/PendleRouterSwapHook.sol:PendleRouterSwapHook:_buildHookExecutions(address,address,bytes)`

```solidity
/// @inheritdoc BaseHook
function _buildHookExecutions(address prevHook, address account, bytes calldata data) override internal view returns (Execution[] memory executions) {
    address pendleMarket = data.extractYieldSource();
    bool usePrevHookAmount = _decodeBool(data, USE_PREV_HOOK_AMOUNT_POSITION);
    uint256 value = BytesLib.toUint256(data, 53);
    bytes memory txData_ = data[85:];
    bytes memory updatedTxData = _validateTxData(data[85:], account, usePrevHookAmount, prevHook, pendleMarket);
    bytes memory finalTxData = usePrevHookAmount ? updatedTxData : txData_;
    (bool isTokenForPt, address tokenIn) = _extractTokenIn(finalTxData);
    uint256 netTokenIn = usePrevHookAmount ? ISuperHookResult(prevHook).getOutAmount(account) : value;
    uint256 execValue = (isTokenForPt && (tokenIn == address(0))) ? netTokenIn : 0;
    executions = new Execution[](1);
    executions[0] = Execution({target: address(PENDLE_ROUTER_V4), value: execValue, callData: finalTxData});
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

### _validateTxData(bytes,address,bool,address,address)

- **Kind**: internal
- **Source**: 8191:3134:391
- **Link**: `lib/v2-core/src/hooks/swappers/pendle/PendleRouterSwapHook.sol:PendleRouterSwapHook:_validateTxData(bytes,address,bool,address,address)`

```solidity
function _validateTxData(bytes calldata data, address account, bool usePrevHookAmount, address prevHook, address pendleMarket) private view returns (bytes memory updatedTxData) {
    bytes4 selector = bytes4(data[0:4]);
    if (selector == IPendleRouterV4.swapExactTokenForPt.selector) {
        (address receiver, address market, uint256 minPtOut, ApproxParams memory guessPtOut, TokenInput memory input, LimitOrderData memory limit) = abi.decode(data[4:], (address, address, uint256, ApproxParams, TokenInput, LimitOrderData));
        if (receiver != account) revert RECEIVER_NOT_VALID();
        if (market != pendleMarket) revert MARKET_NOT_VALID();
        if (minPtOut == 0) revert MIN_OUT_NOT_VALID();
        if (guessPtOut.guessMin > guessPtOut.guessMax) revert INVALID_GUESS_PT_OUT();
        if (guessPtOut.eps > 1e18) revert EPS_NOT_VALID();
        if ((input.tokenMintSy == address(0)) || (input.pendleSwap == address(0))) revert ADDRESS_NOT_VALID();
        if (usePrevHookAmount) {
            input.netTokenIn = ISuperHookResult(prevHook).getOutAmount(account);
        }
        if (input.netTokenIn == 0) revert AMOUNT_IN_NOT_VALID();
        if (limit.normalFills.length > 0) {
            _validateFillOrders(limit.normalFills);
        }
        if (limit.flashFills.length > 0) {
            _validateFillOrders(limit.flashFills);
        }
        updatedTxData = abi.encodeWithSelector(selector, receiver, market, minPtOut, guessPtOut, input, limit);
    } else if (selector == IPendleRouterV4.swapExactPtForToken.selector) {
        (address receiver, address market, uint256 exactPtIn, TokenOutput memory output, LimitOrderData memory limit) = abi.decode(data[4:], (address, address, uint256, TokenOutput, LimitOrderData));
        if (receiver != account) revert RECEIVER_NOT_VALID();
        if (market != pendleMarket) revert MARKET_NOT_VALID();
        if (usePrevHookAmount) {
            exactPtIn = ISuperHookResult(prevHook).getOutAmount(account);
        }
        if (exactPtIn == 0) revert AMOUNT_IN_NOT_VALID();
        if (output.minTokenOut == 0) revert MIN_OUT_NOT_VALID();
        if (limit.normalFills.length > 0) {
            _validateFillOrders(limit.normalFills);
        }
        if (limit.flashFills.length > 0) {
            _validateFillOrders(limit.flashFills);
        }
        updatedTxData = abi.encodeWithSelector(selector, receiver, market, exactPtIn, output, limit);
    } else {
        revert INVALID_SWAP_TYPE();
    }
}
```

### _validateFillOrders(struct FillOrderParams[])

- **Kind**: internal
- **Source**: 11331:263:391
- **Link**: `lib/v2-core/src/hooks/swappers/pendle/PendleRouterSwapHook.sol:PendleRouterSwapHook:_validateFillOrders(struct FillOrderParams[])`

```solidity
function _validateFillOrders(FillOrderParams[] memory fills) internal view {
    for (uint256 i; i < fills.length; ++i) {
        if (fills[i].makingAmount == 0) revert MAKING_AMOUNT_NOT_VALID();
        _validateOrder(fills[i].order);
    }
}
```

### _validateOrder(struct Order)

- **Kind**: internal
- **Source**: 11600:322:391
- **Link**: `lib/v2-core/src/hooks/swappers/pendle/PendleRouterSwapHook.sol:PendleRouterSwapHook:_validateOrder(struct Order)`

```solidity
function _validateOrder(Order memory order) internal view {
    if (order.expiry < block.timestamp) revert ORDER_EXPIRED();
    if ((order.maker == address(0)) || (order.receiver == address(0))) revert ADDRESS_NOT_VALID();
}
```

### _extractTokenIn(bytes)

- **Kind**: internal
- **Source**: 12684:614:391
- **Link**: `lib/v2-core/src/hooks/swappers/pendle/PendleRouterSwapHook.sol:PendleRouterSwapHook:_extractTokenIn(bytes)`

```solidity
function _extractTokenIn(bytes memory txData) private pure returns (bool isTokenForPt, address tokenIn) {
    bytes4 selector = bytes4(BytesLib.slice(txData, 0, 4));
    if (selector == IPendleRouterV4.swapExactTokenForPt.selector) {
        (, , , , TokenInput memory input, ) = abi.decode(BytesLib.slice(txData, 4, txData.length - 4), (address, address, uint256, ApproxParams, TokenInput, LimitOrderData));
        return (true, input.tokenIn);
    }
    return (false, address(0));
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

## External Calls

- **ISuperHookResult::getOutAmount(address)**
- **IAcrossSpokePoolV3::wrappedNativeToken()**
- **ISuperSignatureStorage::retrieveSignatureData(address)**

## State Variable Reads

- **USE_PREV_HOOK_AMOUNT_POSITION** (`uint256`)
- **PENDLE_ROUTER_V4** (`contract IPendleRouterV4`) [lib/v2-core/src/vendor/pendle/IPendleRouterV4.sol/interface_IPendleRouterV4.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BaseHook.build(address,address,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: PendleRouterSwapHook._buildHookExecutions(address,address,bytes) (NodeID: 1)
      💬 Args: [prevHook, account, hookData]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: HookDataDecoder.extractYieldSource(bytes) (NodeID: 2)
    │   💬 Args: [data]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 3)
    │     💬 Args: [data, 32]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BaseHook._decodeBool(bytes,uint256) (NodeID: 4)
    │   💬 Args: [data, USE_PREV_HOOK_AMOUNT_POSITION]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.toUint256(bytes,uint256) (NodeID: 5)
    │   💬 Args: [data, 53]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: PendleRouterSwapHook._validateTxData(bytes,address,bool,address,address) (NodeID: 6)
    │   💬 Args: [data[85:], account, usePrevHookAmount, prevHook, pendleMarket]
    │   👁️  Def: private
    │ ├─ [3] ⚙️ FUNCTION: PendleRouterSwapHook._validateFillOrders(struct FillOrderParams[]) (NodeID: 7)
    │ │   💬 Args: [limit.normalFills]
    │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: PendleRouterSwapHook._validateOrder(struct Order) (NodeID: 8)
    │ │     💬 Args: [fills[i].order]
    │ │     👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: PendleRouterSwapHook._validateFillOrders(struct FillOrderParams[]) (NodeID: 9)
    │ │   💬 Args: [limit.flashFills]
    │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: PendleRouterSwapHook._validateOrder(struct Order) (NodeID: 10)
    │ │     💬 Args: [fills[i].order]
    │ │     👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: PendleRouterSwapHook._validateFillOrders(struct FillOrderParams[]) (NodeID: 11)
    │ │   💬 Args: [limit.normalFills]
    │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: PendleRouterSwapHook._validateOrder(struct Order) (NodeID: 12)
    │ │     💬 Args: [fills[i].order]
    │ │     👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: PendleRouterSwapHook._validateFillOrders(struct FillOrderParams[]) (NodeID: 13)
    │     💬 Args: [limit.flashFills]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: PendleRouterSwapHook._validateOrder(struct Order) (NodeID: 14)
    │       💬 Args: [fills[i].order]
    │       👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: PendleRouterSwapHook._extractTokenIn(bytes) (NodeID: 15)
        💬 Args: [finalTxData]
        👁️  Def: private
      ├─ [3] ⚙️ FUNCTION: BytesLib.slice(bytes,uint256,uint256) (NodeID: 16)
      │   💬 Args: [txData, 0, 4]
      │   👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: BytesLib.slice(bytes,uint256,uint256) (NodeID: 17)
          💬 Args: [txData, 4, txData.length - 4]
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
