# Function: getAssetOutput(address,address,uint256)

**Contract**: [lib/v2-core/src/accounting/oracles/ERC5115YieldSourceOracle.sol/contract_ERC5115YieldSourceOracle.md]

## Metadata

- **Contract**: ERC5115YieldSourceOracle
- **Signature**: `getAssetOutput(address,address,uint256)`
- **Visibility**: public
- **Source Range**: 3155:289:356

## Implementation

```solidity
/// @inheritdoc AbstractYieldSourceOracle
function getAssetOutput(address yieldSourceAddress, address assetOut, uint256 sharesIn) override public view returns (uint256) {
    return IStandardizedYield(yieldSourceAddress).previewRedeem(assetOut, sharesIn);
}
```

## External Calls

- **IStandardizedYield::previewRedeem(address,uint256)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC5115YieldSourceOracle.getAssetOutput(address,address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@inheritdoc AbstractYieldSourceOracle

### Interface Documentation

@notice Calculates the number of underlying assets that would be received for a given amount of shares
 @dev Used for withdrawal simulations and to calculate current yield
 @param yieldSourceAddress The yield-bearing token address (e.g., aUSDC, cDAI)
 @param assetIn The underlying asset to receive (e.g., USDC, DAI)
 @param sharesIn The amount of yield-bearing shares to redeem
 @return assets The number of underlying assets that would be received
