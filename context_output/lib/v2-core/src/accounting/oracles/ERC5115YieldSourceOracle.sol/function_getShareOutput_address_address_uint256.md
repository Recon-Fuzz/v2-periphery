# Function: getShareOutput(address,address,uint256)

**Contract**: [lib/v2-core/src/accounting/oracles/ERC5115YieldSourceOracle.sol/contract_ERC5115YieldSourceOracle.md]

## Metadata

- **Contract**: ERC5115YieldSourceOracle
- **Signature**: `getShareOutput(address,address,uint256)`
- **Visibility**: external
- **Source Range**: 2325:290:356

## Implementation

```solidity
/// @inheritdoc AbstractYieldSourceOracle
function getShareOutput(address yieldSourceAddress, address assetIn, uint256 assetsIn) override external view returns (uint256) {
    return IStandardizedYield(yieldSourceAddress).previewDeposit(assetIn, assetsIn);
}
```

## External Calls

- **IStandardizedYield::previewDeposit(address,uint256)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC5115YieldSourceOracle.getShareOutput(address,address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc AbstractYieldSourceOracle

### Interface Documentation

@notice Calculates the number of shares that would be received for a given amount of assets
 @dev Used for deposit simulations and to calculate current exchange rates
 @param yieldSourceAddress The yield-bearing token address (e.g., aUSDC, cDAI)
 @param assetIn The underlying asset being deposited (e.g., USDC, DAI)
 @param assetsIn The amount of underlying assets to deposit, in the asset's native units
 @return shares The number of yield-bearing shares that would be received
