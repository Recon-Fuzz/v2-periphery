# Function: pendingRedeemRequest(address)

**Contract**: [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]

## Metadata

- **Contract**: SuperVaultStrategy
- **Signature**: `pendingRedeemRequest(address)`
- **Visibility**: external
- **Source Range**: 27132:168:513

## Implementation

```solidity
/// @inheritdoc ISuperVaultStrategy
function pendingRedeemRequest(address controller) external view returns (uint256 pendingShares) {
    return superVaultState[controller].pendingRedeemRequest;
}
```

## State Variable Reads

- **superVaultState** (`mapping(address => struct ISuperVaultStrategy.SuperVaultState)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultStrategy.pendingRedeemRequest(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperVaultStrategy

### Interface Documentation

@notice Get the pending redeem request amount (shares) for a controller
 @param controller The controller address
 @return pendingShares The amount of shares pending redemption
