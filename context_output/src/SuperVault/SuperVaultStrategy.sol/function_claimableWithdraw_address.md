# Function: claimableWithdraw(address)

**Contract**: [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]

## Metadata

- **Contract**: SuperVaultStrategy
- **Signature**: `claimableWithdraw(address)`
- **Visibility**: external
- **Source Range**: 27346:158:513

## Implementation

```solidity
/// @inheritdoc ISuperVaultStrategy
function claimableWithdraw(address controller) external view returns (uint256 claimableAssets) {
    return superVaultState[controller].maxWithdraw;
}
```

## State Variable Reads

- **superVaultState** (`mapping(address => struct ISuperVaultStrategy.SuperVaultState)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultStrategy.claimableWithdraw(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperVaultStrategy

### Interface Documentation

@notice Get the claimable withdraw amount (assets) for a controller
 @param controller The controller address
 @return claimableAssets The amount of assets claimable
