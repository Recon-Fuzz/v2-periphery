# Function: addICCToWhitelist(address)

**Contract**: [test/draft/src/SuperAsset/SuperAssetFactory.sol/contract_SuperAssetFactory.md]

## Metadata

- **Contract**: SuperAssetFactory
- **Signature**: `addICCToWhitelist(address)`
- **Visibility**: external
- **Source Range**: 1868:180:549

## Implementation

```solidity
/// @inheritdoc ISuperAssetFactory
function addICCToWhitelist(address icc) external {
    if (msg.sender != superRegistry) revert UNAUTHORIZED();
    incentiveCalculationContractsWhitelist[icc] = true;
}
```

## State Variable Reads

- **superRegistry** (`address`)

## State Variable Writes

- **incentiveCalculationContractsWhitelist** (`mapping(address => bool)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperAssetFactory.addICCToWhitelist(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperAssetFactory

### Interface Documentation

@notice Adds an Incentive Calculation Contract to the whitelist
 @param icc Address of the Incentive Calculation Contract
