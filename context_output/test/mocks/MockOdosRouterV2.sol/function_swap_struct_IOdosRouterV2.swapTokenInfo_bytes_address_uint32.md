# Function: swap(struct IOdosRouterV2.swapTokenInfo,bytes,address,uint32)

**Contract**: [test/mocks/MockOdosRouterV2.sol/contract_MockOdosRouterV2.md]

## Metadata

- **Contract**: MockOdosRouterV2
- **Signature**: `swap(struct IOdosRouterV2.swapTokenInfo,bytes,address,uint32)`
- **Visibility**: external
- **Source Range**: 715:782:600

## Implementation

```solidity
/// @notice Simulates a swap with a 0.5% fee
///  @param tokenInfo Swap token information
///  @return amountOut The minimum output amount
function swap(IOdosRouterV2.swapTokenInfo memory tokenInfo, bytes calldata, address, uint32) external payable returns (uint256 amountOut) {
    if (tokenInfo.inputToken != address(0)) {
        IERC20(tokenInfo.inputToken).safeTransferFrom(msg.sender, address(this), tokenInfo.inputAmount);
    }
    if (tokenInfo.outputToken != address(0)) {
        uint256 outputAmount = tokenInfo.outputQuote - ((tokenInfo.outputQuote * 50) / 10_000);
        IERC20(tokenInfo.outputToken).safeTransfer(msg.sender, outputAmount);
    } else {
        payable(msg.sender).transfer(tokenInfo.outputQuote);
    }
    return tokenInfo.outputMin;
}
```

## External Calls

- **IERC20::safeTransferFrom(contract IERC20,address,address,uint256)**
- **IERC20::safeTransfer(contract IERC20,address,uint256)**

## Native Transfers

- **unknown** (computed)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockOdosRouterV2.swap(struct IOdosRouterV2.swapTokenInfo,bytes,address,uint32) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@notice Simulates a swap with a 0.5% fee
 @param tokenInfo Swap token information
 @return amountOut The minimum output amount
