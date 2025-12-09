# Function: removeICCFromWhitelist(address)

**Contract**: [test/draft/src/SuperAsset/SuperAssetFactory.sol/contract_SuperAssetFactory.md]

## Metadata

- **Contract**: SuperAssetFactory
- **Signature**: `removeICCFromWhitelist(address)`
- **Visibility**: external
- **Source Range**: 2093:186:549

## Implementation

```solidity
/// @inheritdoc ISuperAssetFactory
function removeICCFromWhitelist(address icc) external {
    if (msg.sender != superRegistry) revert UNAUTHORIZED();
    incentiveCalculationContractsWhitelist[icc] = false;
}
```

## State Variable Reads

- **superRegistry** (`address`)

## State Variable Writes

- **incentiveCalculationContractsWhitelist** (`mapping(address => bool)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperAssetFactory.removeICCFromWhitelist(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperAssetFactory

### Interface Documentation

@notice Removes an Incentive Calculation Contract from the whitelist
 @param icc Address of the Incentive Calculation Contract
