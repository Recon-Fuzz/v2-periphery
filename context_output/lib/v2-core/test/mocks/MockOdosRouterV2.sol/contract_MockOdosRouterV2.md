# Contract: MockOdosRouterV2

## Metadata

- **Name**: MockOdosRouterV2
- **Type**: Contract
- **Path**: lib/v2-core/test/mocks/MockOdosRouterV2.sol

## Public/External Functions

### swap(struct IOdosRouterV2.swapTokenInfo,bytes,address,uint32)

- **Signature**: `swap(struct IOdosRouterV2.swapTokenInfo,bytes,address,uint32)`
- **Visibility**: external
- **Source Range**: 234:720:485
- **Details**: [function_swap_struct_IOdosRouterV2.swapTokenInfo_bytes_address_uint32.md](./function_swap_struct_IOdosRouterV2.swapTokenInfo_bytes_address_uint32.md)

**Signature:**
```solidity
function swap(IOdosRouterV2.swapTokenInfo memory tokenInfo, bytes calldata, address, uint32) external payable returns (uint256 amountOut);
```

### swapCompact()

- **Signature**: `swapCompact()`
- **Visibility**: external
- **Source Range**: 960:83:485
- **Details**: [function_swapCompact.md](./function_swapCompact.md)

**Signature:**
```solidity
function swapCompact() external payable returns (uint256);
```
