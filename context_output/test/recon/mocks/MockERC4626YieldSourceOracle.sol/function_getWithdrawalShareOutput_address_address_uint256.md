# Function: getWithdrawalShareOutput(address,address,uint256)

**Contract**: [test/recon/mocks/MockERC4626YieldSourceOracle.sol/contract_MockERC4626YieldSourceOracle.md]

## Metadata

- **Contract**: MockERC4626YieldSourceOracle
- **Signature**: `getWithdrawalShareOutput(address,address,uint256)`
- **Visibility**: external
- **Source Range**: 974:257:638

## Implementation

```solidity
function getWithdrawalShareOutput(address yieldSourceAddress, address, uint256 assetsIn) external view returns (uint256) {
    return IERC4626(yieldSourceAddress).previewWithdraw(assetsIn);
}
```

## External Calls

- **IERC4626::previewWithdraw(uint256)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockERC4626YieldSourceOracle.getWithdrawalShareOutput(address,address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Calculates the amount of shares that would be burnt when withdrawing a given amount of assets
 @dev Used by oracles to simulate withdrawals and to derive the current exchange rate
 @param yieldSourceAddress The address of the yield-bearing token (e.g., aUSDC, cDAI)
 @param assetIn The address of the underlying asset to be withdrawn (e.g., USDC, DAI)
 @param assetsIn The amount of underlying assets to withdraw, denominated in the asset’s native units
 @return shares The amount of yield-bearing shares that would be burnt after withdrawal
