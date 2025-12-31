# Function: claimableCancelRedeemRequest(address)

**Contract**: [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]

## Metadata

- **Contract**: SuperVaultStrategy
- **Signature**: `claimableCancelRedeemRequest(address)`
- **Visibility**: external
- **Source Range**: 27759:265:513

## Implementation

```solidity
/// @inheritdoc ISuperVaultStrategy
function claimableCancelRedeemRequest(address controller) external view returns (uint256 claimableShares) {
    if (!superVaultState[controller].pendingCancelRedeemRequest) return 0;
    return superVaultState[controller].claimableCancelRedeemRequest;
}
```

## State Variable Reads

- **superVaultState** (`mapping(address => struct ISuperVaultStrategy.SuperVaultState)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultStrategy.claimableCancelRedeemRequest(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperVaultStrategy

### Interface Documentation

@notice Get the claimable cancel redeem request amount (shares) for a controller
 @param controller The controller address
 @return claimableShares The amount of shares claimable
