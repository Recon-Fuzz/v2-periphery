# Function: swap(struct IOdosRouterV2.swapTokenInfo,bytes,address,uint32)

**Contract**: [lib/v2-core/test/mocks/MockOdosRouterV2.sol/contract_MockOdosRouterV2.md]

## Metadata

- **Contract**: MockOdosRouterV2
- **Signature**: `swap(struct IOdosRouterV2.swapTokenInfo,bytes,address,uint32)`
- **Visibility**: external
- **Source Range**: 234:720:485

## Implementation

```solidity
function swap(IOdosRouterV2.swapTokenInfo memory tokenInfo, bytes calldata, address, uint32) external payable returns (uint256 amountOut) {
    if (tokenInfo.inputToken != address(0)) {
        ERC20(tokenInfo.inputToken).transferFrom(msg.sender, address(this), tokenInfo.inputAmount);
    }
    if (tokenInfo.outputToken != address(0)) {
        ERC20(tokenInfo.outputToken).transfer(msg.sender, tokenInfo.outputQuote - ((tokenInfo.outputQuote * 50) / 10_000));
    } else {
        payable(msg.sender).transfer(tokenInfo.outputQuote);
    }
    return tokenInfo.outputMin;
}
```

## External Calls

- **ERC20::transferFrom(address,address,uint256)**
- **ERC20::transfer(address,uint256)**

## Native Transfers

- **unknown** (computed)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockOdosRouterV2.swap(struct IOdosRouterV2.swapTokenInfo,bytes,address,uint32) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
