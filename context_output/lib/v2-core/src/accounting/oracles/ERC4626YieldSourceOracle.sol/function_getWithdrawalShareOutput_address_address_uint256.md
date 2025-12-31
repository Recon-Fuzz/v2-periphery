# Function: getWithdrawalShareOutput(address,address,uint256)

**Contract**: [lib/v2-core/src/accounting/oracles/ERC4626YieldSourceOracle.sol/contract_ERC4626YieldSourceOracle.md]

## Metadata

- **Contract**: ERC4626YieldSourceOracle
- **Signature**: `getWithdrawalShareOutput(address,address,uint256)`
- **Visibility**: external
- **Source Range**: 1267:274:355

## Implementation

```solidity
/// @inheritdoc AbstractYieldSourceOracle
function getWithdrawalShareOutput(address yieldSourceAddress, address, uint256 assetsIn) override external view returns (uint256) {
    return IERC4626(yieldSourceAddress).previewWithdraw(assetsIn);
}
```

## External Calls

- **IERC4626::previewWithdraw(uint256)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC4626YieldSourceOracle.getWithdrawalShareOutput(address,address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc AbstractYieldSourceOracle

### Interface Documentation

@notice Calculates the amount of shares that would be burnt when withdrawing a given amount of assets
 @dev Used by oracles to simulate withdrawals and to derive the current exchange rate
 @param yieldSourceAddress The address of the yield-bearing token (e.g., aUSDC, cDAI)
 @param assetIn The address of the underlying asset to be withdrawn (e.g., USDC, DAI)
 @param assetsIn The amount of underlying assets to withdraw, denominated in the asset’s native units
 @return shares The amount of yield-bearing shares that would be burnt after withdrawal
