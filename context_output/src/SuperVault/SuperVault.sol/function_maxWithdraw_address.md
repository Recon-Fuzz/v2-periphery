# Function: maxWithdraw(address)

**Contract**: [src/SuperVault/SuperVault.sol/contract_SuperVault.md]

## Metadata

- **Contract**: SuperVault
- **Signature**: `maxWithdraw(address)`
- **Visibility**: public
- **Source Range**: 16143:132:510

## Implementation

```solidity
/// @inheritdoc IERC4626
function maxWithdraw(address owner) override public view returns (uint256) {
    return strategy.claimableWithdraw(owner);
}
```

## External Calls

- **ISuperVaultStrategy::claimableWithdraw(address)**

## State Variable Reads

- **strategy** (`contract ISuperVaultStrategy`) [src/interfaces/SuperVault/ISuperVaultStrategy.sol/interface_ISuperVaultStrategy.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVault.maxWithdraw(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@inheritdoc IERC4626

### Interface Documentation

 @dev Returns the maximum amount of the underlying asset that can be withdrawn from the owner balance in the
 Vault, through a withdraw call.
 - MUST return a limited value if owner is subject to some withdrawal limit or timelock.
 - MUST NOT revert.
