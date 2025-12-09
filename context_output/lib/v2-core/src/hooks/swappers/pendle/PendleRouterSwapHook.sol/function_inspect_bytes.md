# Function: inspect(bytes)

**Contract**: [lib/v2-core/src/hooks/swappers/pendle/PendleRouterSwapHook.sol/contract_PendleRouterSwapHook.md]

## Metadata

- **Contract**: PendleRouterSwapHook
- **Signature**: `inspect(bytes)`
- **Visibility**: external
- **Source Range**: 4279:3188:391

## Implementation

```solidity
/// @inheritdoc ISuperHookInspector
function inspect(bytes calldata data) override external pure returns (bytes memory packed) {
    bytes calldata txData_ = data[85:];
    bytes4 selector = bytes4(txData_[0:4]);
    if (selector == IPendleRouterV4.swapExactTokenForPt.selector) {
        (address receiver, address market, , , TokenInput memory input, LimitOrderData memory limit) = abi.decode(txData_[4:], (address, address, uint256, ApproxParams, TokenInput, LimitOrderData));
        packed = abi.encodePacked(data.extractYieldSource(), receiver, market, input.tokenIn, input.tokenMintSy, input.pendleSwap, input.swapData.extRouter, limit.limitRouter);
        uint256 normalFillsLen = limit.normalFills.length;
        for (uint256 i; i < normalFillsLen; i++) {
            packed = abi.encodePacked(packed, limit.normalFills[i].order.token, limit.normalFills[i].order.YT, limit.normalFills[i].order.maker, limit.normalFills[i].order.receiver);
        }
        uint256 flashFillsLen = limit.flashFills.length;
        for (uint256 i; i < flashFillsLen; i++) {
            packed = abi.encodePacked(packed, limit.flashFills[i].order.token, limit.flashFills[i].order.YT, limit.flashFills[i].order.maker, limit.flashFills[i].order.receiver);
        }
    } else if (selector == IPendleRouterV4.swapExactPtForToken.selector) {
        (address receiver, address market, , TokenOutput memory output, LimitOrderData memory limit) = abi.decode(txData_[4:], (address, address, uint256, TokenOutput, LimitOrderData));
        packed = abi.encodePacked(data.extractYieldSource(), receiver, market, output.tokenOut, output.tokenRedeemSy, output.pendleSwap, output.swapData.extRouter);
        uint256 normalFillsLen = limit.normalFills.length;
        for (uint256 i; i < normalFillsLen; i++) {
            packed = abi.encodePacked(packed, limit.normalFills[i].order.token, limit.normalFills[i].order.YT, limit.normalFills[i].order.maker, limit.normalFills[i].order.receiver);
        }
        uint256 flashFillsLen = limit.flashFills.length;
        for (uint256 i; i < flashFillsLen; i++) {
            packed = abi.encodePacked(packed, limit.flashFills[i].order.token, limit.flashFills[i].order.YT, limit.flashFills[i].order.maker, limit.flashFills[i].order.receiver);
        }
    }
}
```

## Related Implementations

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

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: PendleRouterSwapHook.inspect(bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: HookDataDecoder.extractYieldSource(bytes) (NodeID: 1)
  │   💬 Args: [data]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 2)
  │     💬 Args: [data, 32]
  │     👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: HookDataDecoder.extractYieldSource(bytes) (NodeID: 3)
      💬 Args: [data]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 4)
        💬 Args: [data, 32]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc ISuperHookInspector

### Interface Documentation

@notice Inspect the hook
 @param data The hook data to inspect
 @return argsEncoded The arguments of the hook encoded
