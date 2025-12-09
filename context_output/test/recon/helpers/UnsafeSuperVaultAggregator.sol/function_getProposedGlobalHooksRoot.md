# Function: getProposedGlobalHooksRoot()

**Contract**: [test/recon/helpers/UnsafeSuperVaultAggregator.sol/contract_UnsafeSuperVaultAggregator.md]

## Metadata

- **Contract**: UnsafeSuperVaultAggregator
- **Signature**: `getProposedGlobalHooksRoot()`
- **Visibility**: external
- **Source Range**: 46675:179:634

## Implementation

```solidity
/// @inheritdoc ISuperVaultAggregator
function getProposedGlobalHooksRoot() external view returns (bytes32 root, uint256 effectiveTime) {
    return (_proposedGlobalHooksRoot, _globalHooksRootEffectiveTime);
}
```

## State Variable Reads

- **_proposedGlobalHooksRoot** (`bytes32`)
- **_globalHooksRootEffectiveTime** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: UnsafeSuperVaultAggregator.getProposedGlobalHooksRoot() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperVaultAggregator

### Interface Documentation

@notice Gets the proposed global hooks root and effective time
 @return root The proposed global hooks Merkle root
 @return effectiveTime The timestamp when the proposed root becomes effective
