# Function: pendingRedeemRequest(uint256,address)

**Contract**: [src/SuperVault/SuperVault.sol/contract_SuperVault.md]

## Metadata

- **Contract**: SuperVault
- **Signature**: `pendingRedeemRequest(uint256,address)`
- **Visibility**: external
- **Source Range**: 12677:234:510

## Implementation

```solidity
/// @inheritdoc IERC7540Redeem
function pendingRedeemRequest(uint256, address controller) external view returns (uint256 pendingShares) {
    return strategy.pendingRedeemRequest(controller);
}
```

## External Calls

- **ISuperVaultStrategy::pendingRedeemRequest(address)**

## State Variable Reads

- **strategy** (`contract ISuperVaultStrategy`) [src/interfaces/SuperVault/ISuperVaultStrategy.sol/interface_ISuperVaultStrategy.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVault.pendingRedeemRequest(uint256,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc IERC7540Redeem

### Interface Documentation

 @dev Returns the amount of requested shares in Pending state.
 - MUST NOT include any shares in Claimable state for redeem or withdraw.
 - MUST NOT show any variations depending on the caller.
 - MUST NOT revert unless due to integer overflow caused by an unreasonably large input.
