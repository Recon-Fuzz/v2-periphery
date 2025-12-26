# Function: pendingCancelRedeemRequest(uint256,address)

**Contract**: [src/SuperVault/SuperVault.sol/contract_SuperVault.md]

## Metadata

- **Contract**: SuperVault
- **Signature**: `pendingCancelRedeemRequest(uint256,address)`
- **Visibility**: external
- **Source Range**: 13217:252:510

## Implementation

```solidity
/// @inheritdoc IERC7540CancelRedeem
function pendingCancelRedeemRequest(uint256, address controller) external view returns (bool isPending) {
    isPending = strategy.pendingCancelRedeemRequest(controller);
}
```

## External Calls

- **ISuperVaultStrategy::pendingCancelRedeemRequest(address)**

## State Variable Reads

- **strategy** (`contract ISuperVaultStrategy`) [src/interfaces/SuperVault/ISuperVaultStrategy.sol/interface_ISuperVaultStrategy.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVault.pendingCancelRedeemRequest(uint256,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc IERC7540CancelRedeem

### Interface Documentation

 @dev Returns whether the redeem Request is pending cancelation
 - MUST NOT show any variations depending on the caller.
