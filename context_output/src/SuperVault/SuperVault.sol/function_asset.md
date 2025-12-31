# Function: asset()

**Contract**: [src/SuperVault/SuperVault.sol/contract_SuperVault.md]

## Metadata

- **Contract**: SuperVault
- **Signature**: `asset()`
- **Visibility**: public
- **Source Range**: 14802:103:510

## Implementation

```solidity
/// @inheritdoc IERC4626
function asset() virtual override public view returns (address) {
    return address(_asset);
}
```

## State Variable Reads

- **_asset** (`contract IERC20`) [lib/v2-core/lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVault.asset() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@inheritdoc IERC4626

### Interface Documentation

 @dev Returns the address of the underlying token used for the Vault for accounting, depositing, and withdrawing.
 - MUST be an ERC-20 token contract.
 - MUST NOT revert.
