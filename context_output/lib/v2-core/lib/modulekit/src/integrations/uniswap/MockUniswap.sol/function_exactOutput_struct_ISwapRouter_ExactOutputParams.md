# Function: exactOutput(struct ISwapRouter.ExactOutputParams)

**Contract**: [lib/v2-core/lib/modulekit/src/integrations/uniswap/MockUniswap.sol/contract_MockUniswap.md]

## Metadata

- **Contract**: MockUniswap
- **Signature**: `exactOutput(struct ISwapRouter.ExactOutputParams)`
- **Visibility**: external
- **Source Range**: 959:185:194

## Implementation

```solidity
function exactOutput(ExactOutputParams calldata params) override external payable returns (uint256 amountIn) {
    return params.amountOut;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockUniswap.exactOutput(struct ISwapRouter.ExactOutputParams) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Swaps as little as possible of one token for `amountOut` of another along the
 specified path (reversed)
 @param params The parameters necessary for the multi-hop swap, encoded as
 `ExactOutputParams` in calldata
 @return amountIn The amount of the input token
