# Function: getAssetOutput(address,address,uint256)

**Contract**: [lib/v2-core/src/accounting/oracles/StakingYieldSourceOracle.sol/contract_StakingYieldSourceOracle.md]

## Metadata

- **Contract**: StakingYieldSourceOracle
- **Signature**: `getAssetOutput(address,address,uint256)`
- **Visibility**: public
- **Source Range**: 1571:131:357

## Implementation

```solidity
/// @inheritdoc AbstractYieldSourceOracle
function getAssetOutput(address, address, uint256 sharesIn) override public pure returns (uint256) {
    return sharesIn;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: StakingYieldSourceOracle.getAssetOutput(address,address,uint256) (NodeID: 0)
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
