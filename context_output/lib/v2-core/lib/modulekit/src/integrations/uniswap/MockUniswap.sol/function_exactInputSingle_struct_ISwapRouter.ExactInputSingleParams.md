# Function: exactInputSingle(struct ISwapRouter.ExactInputSingleParams)

**Contract**: [lib/v2-core/lib/modulekit/src/integrations/uniswap/MockUniswap.sol/contract_MockUniswap.md]

## Metadata

- **Contract**: MockUniswap
- **Signature**: `exactInputSingle(struct ISwapRouter.ExactInputSingleParams)`
- **Visibility**: external
- **Source Range**: 366:195:194

## Implementation

```solidity
function exactInputSingle(ExactInputSingleParams calldata params) override external payable returns (uint256 amountOut) {
    return params.amountIn;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockUniswap.exactInputSingle(struct ISwapRouter.ExactInputSingleParams) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Swaps `amountIn` of one token for as much as possible of another token
 @param params The parameters necessary for the swap, encoded as `ExactInputSingleParams` in
 calldata
 @return amountOut The amount of the received token
