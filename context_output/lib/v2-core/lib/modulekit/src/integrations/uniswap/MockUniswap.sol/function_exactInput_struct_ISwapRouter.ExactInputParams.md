# Function: exactInput(struct ISwapRouter.ExactInputParams)

**Contract**: [lib/v2-core/lib/modulekit/src/integrations/uniswap/MockUniswap.sol/contract_MockUniswap.md]

## Metadata

- **Contract**: MockUniswap
- **Signature**: `exactInput(struct ISwapRouter.ExactInputParams)`
- **Visibility**: external
- **Source Range**: 567:183:194

## Implementation

```solidity
function exactInput(ExactInputParams calldata params) override external payable returns (uint256 amountOut) {
    return params.amountIn;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockUniswap.exactInput(struct ISwapRouter.ExactInputParams) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Swaps `amountIn` of one token for as much as possible of another along the specified
 path
 @param params The parameters necessary for the multi-hop swap, encoded as `ExactInputParams`
 in calldata
 @return amountOut The amount of the received token
