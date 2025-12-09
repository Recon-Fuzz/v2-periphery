# Contract: MockOdosRouterV2

## Metadata

- **Name**: MockOdosRouterV2
- **Type**: Contract
- **Path**: test/mocks/MockOdosRouterV2.sol
- **Documentation**: @notice Mock Odos Router V2 that properly handles non-standard ERC20 tokens like USDT
   @dev Uses SafeERC20 to handle tokens that don't return bool from transfer/transferFrom

## Public/External Functions

### swap(struct IOdosRouterV2.swapTokenInfo,bytes,address,uint32)

- **Signature**: `swap(struct IOdosRouterV2.swapTokenInfo,bytes,address,uint32)`
- **Visibility**: external
- **Source Range**: 715:782:600
- **Details**: [function_swap_struct_IOdosRouterV2.swapTokenInfo_bytes_address_uint32.md](./function_swap_struct_IOdosRouterV2.swapTokenInfo_bytes_address_uint32.md)

**Signature:**
```solidity
/// @notice Simulates a swap with a 0.5% fee
///  @param tokenInfo Swap token information
///  @return amountOut The minimum output amount
function swap(IOdosRouterV2.swapTokenInfo memory tokenInfo, bytes calldata, address, uint32) external payable returns (uint256 amountOut);
```

### swapCompact()

- **Signature**: `swapCompact()`
- **Visibility**: external
- **Source Range**: 1544:83:600
- **Details**: [function_swapCompact.md](./function_swapCompact.md)

**Signature:**
```solidity
/// @notice Compact swap placeholder
function swapCompact() external payable returns (uint256);
```
