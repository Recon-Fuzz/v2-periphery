# Function: getProposedGlobalHooksRoot()

**Contract**: [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]

## Metadata

- **Contract**: SuperVaultAggregator
- **Signature**: `getProposedGlobalHooksRoot()`
- **Visibility**: external
- **Source Range**: 50141:179:511

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
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregator.getProposedGlobalHooksRoot() (NodeID: 0)
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
