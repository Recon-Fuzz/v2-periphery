# Function: constructor(address,address)

**Contract**: [test/draft/src/SuperAsset/SuperAssetFactory.sol/contract_SuperAssetFactory.md]

## Metadata

- **Contract**: SuperAssetFactory
- **Signature**: `constructor(address,address)`
- **Visibility**: public
- **Source Range**: 1440:383:549

## Implementation

```solidity
constructor(address _superGovernor, address _superRegistry) {
    if ((_superGovernor == address(0)) || (_superRegistry == address(0))) revert ZERO_ADDRESS();
    superGovernor = _superGovernor;
    superRegistry = _superRegistry;
    superAssetImplementation = address(new SuperAsset());
    incentiveFundImplementation = address(new IncentiveFundContract());
}
```

## State Variable Writes

- **superGovernor** (`address`)
- **superRegistry** (`address`)
- **superAssetImplementation** (`address`)
- **incentiveFundImplementation** (`address`)

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: SuperAssetFactory.constructor(address,address) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: SuperAssetFactory
```
