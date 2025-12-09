# Function: pendingCancelRedeemRequest(address)

**Contract**: [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]

## Metadata

- **Contract**: SuperVaultStrategy
- **Signature**: `pendingCancelRedeemRequest(address)`
- **Visibility**: external
- **Source Range**: 27550:163:513

## Implementation

```solidity
/// @inheritdoc ISuperVaultStrategy
function pendingCancelRedeemRequest(address controller) external view returns (bool) {
    return superVaultState[controller].pendingCancelRedeemRequest;
}
```

## State Variable Reads

- **superVaultState** (`mapping(address => struct ISuperVaultStrategy.SuperVaultState)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultStrategy.pendingCancelRedeemRequest(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperVaultStrategy

### Interface Documentation

@notice Get the pending cancellation for a redeem request for a controller
 @param controller The controller address
 @return isPending True if the redeem request is pending cancellation
