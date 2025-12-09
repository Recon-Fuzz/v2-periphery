# Function: getShareOutput(address,address,uint256)

**Contract**: [lib/v2-core/test/mocks/unused-oracles/ERC7540YieldSourceOracle.sol/contract_ERC7540YieldSourceOracle.md]

## Metadata

- **Contract**: ERC7540YieldSourceOracle
- **Signature**: `getShareOutput(address,address,uint256)`
- **Visibility**: external
- **Source Range**: 1293:264:498

## Implementation

```solidity
/// @inheritdoc AbstractYieldSourceOracle
function getShareOutput(address yieldSourceAddress, address, uint256 assetsIn) override external view returns (uint256) {
    return IERC7540(yieldSourceAddress).convertToShares(assetsIn);
}
```

## External Calls

- **IERC7540::convertToShares(uint256)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC7540YieldSourceOracle.getShareOutput(address,address,uint256) (NodeID: 0)
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
