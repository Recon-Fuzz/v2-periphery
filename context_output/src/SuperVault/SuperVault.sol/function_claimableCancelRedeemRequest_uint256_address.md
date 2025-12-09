# Function: claimableCancelRedeemRequest(uint256,address)

**Contract**: [src/SuperVault/SuperVault.sol/contract_SuperVault.md]

## Metadata

- **Contract**: SuperVault
- **Signature**: `claimableCancelRedeemRequest(uint256,address)`
- **Visibility**: external
- **Source Range**: 13516:252:510

## Implementation

```solidity
/// @inheritdoc IERC7540CancelRedeem
function claimableCancelRedeemRequest(uint256, address controller) external view returns (uint256 claimableShares) {
    return strategy.claimableCancelRedeemRequest(controller);
}
```

## External Calls

- **ISuperVaultStrategy::claimableCancelRedeemRequest(address)**

## State Variable Reads

- **strategy** (`contract ISuperVaultStrategy`) [src/interfaces/SuperVault/ISuperVaultStrategy.sol/interface_ISuperVaultStrategy.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVault.claimableCancelRedeemRequest(uint256,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc IERC7540CancelRedeem

### Interface Documentation

 @dev Returns the amount of shares that were canceled from a redeem Request, and can now be claimed.
 - MUST NOT show any variations depending on the caller.
