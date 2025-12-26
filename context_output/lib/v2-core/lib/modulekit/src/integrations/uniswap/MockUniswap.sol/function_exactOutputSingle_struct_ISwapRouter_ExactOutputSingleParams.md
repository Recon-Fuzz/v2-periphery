# Function: exactOutputSingle(struct ISwapRouter.ExactOutputSingleParams)

**Contract**: [lib/v2-core/lib/modulekit/src/integrations/uniswap/MockUniswap.sol/contract_MockUniswap.md]

## Metadata

- **Contract**: MockUniswap
- **Signature**: `exactOutputSingle(struct ISwapRouter.ExactOutputSingleParams)`
- **Visibility**: external
- **Source Range**: 756:197:194

## Implementation

```solidity
function exactOutputSingle(ExactOutputSingleParams calldata params) override external payable returns (uint256 amountIn) {
    return params.amountOut;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockUniswap.exactOutputSingle(struct ISwapRouter.ExactOutputSingleParams) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Swaps as little as possible of one token for `amountOut` of another token
 @param params The parameters necessary for the swap, encoded as `ExactOutputSingleParams` in
 calldata
 @return amountIn The amount of the input token
