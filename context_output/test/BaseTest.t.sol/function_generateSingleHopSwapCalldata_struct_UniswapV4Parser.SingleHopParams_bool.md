# Function: generateSingleHopSwapCalldata(struct UniswapV4Parser.SingleHopParams,bool)

**Contract**: [test/BaseTest.t.sol/contract_BaseTest.md]

## Metadata

- **Contract**: BaseTest
- **Signature**: `generateSingleHopSwapCalldata(struct UniswapV4Parser.SingleHopParams,bool)`
- **Visibility**: public
- **Source Range**: 3828:1408:506
- **Inherited From**: UniswapV4Parser

## Implementation

```solidity
/// @notice Generate hook data for single-hop V4 swap
///  @dev Creates properly encoded data matching SwapUniswapV4Hook expectations
///  @param params The swap parameters
///  @param usePrevHookAmount Whether to use previous hook's output
///  @return hookData Encoded hook data ready for execution
function generateSingleHopSwapCalldata(SingleHopParams memory params, bool usePrevHookAmount) public pure returns (bytes memory hookData) {
    hookData = abi.encodePacked(params.poolKey.currency0, params.poolKey.currency1, uint32(params.poolKey.fee), uint32(int32(params.poolKey.tickSpacing)), params.poolKey.hooks, params.dstReceiver, uint256(params.sqrtPriceLimitX96), params.originalAmountIn, params.originalMinAmountOut, params.maxSlippageDeviationBps, params.zeroForOne ? bytes1(0x01) : bytes1(0x00), usePrevHookAmount ? bytes1(0x01) : bytes1(0x00), params.additionalData);
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: UniswapV4Parser.generateSingleHopSwapCalldata(struct UniswapV4Parser.SingleHopParams,bool) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Generate hook data for single-hop V4 swap
 @dev Creates properly encoded data matching SwapUniswapV4Hook expectations
 @param params The swap parameters
 @param usePrevHookAmount Whether to use previous hook's output
 @return hookData Encoded hook data ready for execution
