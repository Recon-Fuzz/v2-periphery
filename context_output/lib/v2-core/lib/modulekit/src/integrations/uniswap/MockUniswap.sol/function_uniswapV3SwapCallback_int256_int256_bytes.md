# Function: uniswapV3SwapCallback(int256,int256,bytes)

**Contract**: [lib/v2-core/lib/modulekit/src/integrations/uniswap/MockUniswap.sol/contract_MockUniswap.md]

## Metadata

- **Contract**: MockUniswap
- **Signature**: `uniswapV3SwapCallback(int256,int256,bytes)`
- **Visibility**: external
- **Source Range**: 195:165:194

## Implementation

```solidity
function uniswapV3SwapCallback(int256 amount0Delta, int256 amount1Delta, bytes calldata data) override external {}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockUniswap.uniswapV3SwapCallback(int256,int256,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Called to `msg.sender` after executing a swap via IUniswapV3Pool#swap.
 @dev In the implementation you must pay the pool tokens owed for the swap.
 The caller of this method must be checked to be a UniswapV3Pool deployed by the canonical
 UniswapV3Factory.
 amount0Delta and amount1Delta can both be 0 if no tokens were swapped.
 @param amount0Delta The amount of token0 that was sent (negative) or must be received
 (positive) by the pool by
 the end of the swap. If positive, the callback must send that amount of token0 to the pool.
 @param amount1Delta The amount of token1 that was sent (negative) or must be received
 (positive) by the pool by
 the end of the swap. If positive, the callback must send that amount of token1 to the pool.
 @param data Any data passed through by the caller via the IUniswapV3PoolActions#swap call
