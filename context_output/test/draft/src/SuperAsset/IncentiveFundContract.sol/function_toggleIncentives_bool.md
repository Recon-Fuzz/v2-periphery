# Function: toggleIncentives(bool)

**Contract**: [test/draft/src/SuperAsset/IncentiveFundContract.sol/contract_IncentiveFundContract.md]

## Metadata

- **Contract**: IncentiveFundContract
- **Signature**: `toggleIncentives(bool)`
- **Visibility**: external
- **Source Range**: 3945:145:547

## Implementation

```solidity
/// @inheritdoc IIncentiveFundContract
function toggleIncentives(bool enabled) external onlyManager() {
    incentivesActive = enabled;
    emit IncentivesToggled(enabled);
}
```

## Related Implementations

### onlyManager()

- **Kind**: modifier
- **Source**: 1591:299:547
- **Link**: `test/draft/src/SuperAsset/IncentiveFundContract.sol:IncentiveFundContract:onlyManager()`

```solidity
modifier onlyManager() {
    ISuperAssetFactory factory = ISuperAssetFactory(superRegistry.getAddress(superRegistry.SUPER_ASSET_FACTORY()));
    address manager = factory.getIncentiveFundManager(address(superAsset));
    if (msg.sender != manager) revert UNAUTHORIZED();
    _;
}
```

## State Variable Reads

- **superRegistry** (`contract ISuperRegistry`) [test/draft/src/interfaces/ISuperRegistry.sol/interface_ISuperRegistry.md]
- **superAsset** (`contract ISuperAsset`) [test/draft/src/interfaces/SuperAsset/ISuperAsset.sol/interface_ISuperAsset.md]

## State Variable Writes

- **incentivesActive** (`bool`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: IncentiveFundContract.toggleIncentives(bool) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] 🔒 MODIFIER: IncentiveFundContract.onlyManager() (NodeID: 1)
      💬 Args: [no args]
```

## Documentation

### Function Documentation

@inheritdoc IIncentiveFundContract

### Interface Documentation

@notice Toggles incentives
 @param enabled Whether incentives are enabled
