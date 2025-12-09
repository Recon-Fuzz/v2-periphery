# Function: getProposedStrategyHooksRoot(address)

**Contract**: [test/recon/helpers/UnsafeSuperVaultAggregator.sol/contract_UnsafeSuperVaultAggregator.md]

## Metadata

- **Contract**: UnsafeSuperVaultAggregator
- **Signature**: `getProposedStrategyHooksRoot(address)`
- **Visibility**: external
- **Source Range**: 47427:259:634

## Implementation

```solidity
/// @inheritdoc ISuperVaultAggregator
function getProposedStrategyHooksRoot(address strategy) external view returns (bytes32 root, uint256 effectiveTime) {
    return (_strategyData[strategy].proposedHooksRoot, _strategyData[strategy].hooksRootEffectiveTime);
}
```

## State Variable Reads

- **_strategyData** (`mapping(address => struct ISuperVaultAggregator.StrategyData)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: UnsafeSuperVaultAggregator.getProposedStrategyHooksRoot(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperVaultAggregator

### Interface Documentation

@notice Gets the proposed strategy hooks root and effective time
 @param strategy Address of the strategy
 @return root The proposed strategy hooks Merkle root
 @return effectiveTime The timestamp when the proposed root becomes effective
