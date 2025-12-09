# Function: isICCWhitelisted(address)

**Contract**: [test/draft/src/SuperAsset/SuperAssetFactory.sol/contract_SuperAssetFactory.md]

## Metadata

- **Contract**: SuperAssetFactory
- **Signature**: `isICCWhitelisted(address)`
- **Visibility**: external
- **Source Range**: 2324:135:549

## Implementation

```solidity
/// @inheritdoc ISuperAssetFactory
function isICCWhitelisted(address icc) external view returns (bool) {
    return incentiveCalculationContractsWhitelist[icc];
}
```

## State Variable Reads

- **incentiveCalculationContractsWhitelist** (`mapping(address => bool)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperAssetFactory.isICCWhitelisted(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperAssetFactory

### Interface Documentation

@notice Checks if an Incentive Calculation Contract is whitelisted
 @param icc Address of the Incentive Calculation Contract
 @return isValid Whether the Incentive Calculation Contract is whitelisted
