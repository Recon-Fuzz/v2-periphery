# Function: getAssetOutput(address,address,uint256)

**Contract**: [lib/v2-core/test/mocks/unused-oracles/ERC7540YieldSourceOracle.sol/contract_ERC7540YieldSourceOracle.md]

## Metadata

- **Contract**: ERC7540YieldSourceOracle
- **Signature**: `getAssetOutput(address,address,uint256)`
- **Visibility**: public
- **Source Range**: 2072:262:498

## Implementation

```solidity
/// @inheritdoc AbstractYieldSourceOracle
function getAssetOutput(address yieldSourceAddress, address, uint256 sharesIn) override public view returns (uint256) {
    return IERC7540(yieldSourceAddress).convertToAssets(sharesIn);
}
```

## External Calls

- **IERC7540::convertToAssets(uint256)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC7540YieldSourceOracle.getAssetOutput(address,address,uint256) (NodeID: 0)
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
