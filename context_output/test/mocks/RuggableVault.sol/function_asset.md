# Function: asset()

**Contract**: [test/mocks/RuggableVault.sol/contract_RuggableVault.md]

## Metadata

- **Contract**: RuggableVault
- **Signature**: `asset()`
- **Visibility**: public
- **Source Range**: 2304:95:609

## Implementation

```solidity
function asset() override public view returns (address) {
    return address(_asset);
}
```

## State Variable Reads

- **_asset** (`contract IERC20`) [lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: RuggableVault.asset() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Interface Documentation

 @dev Returns the address of the underlying token used for the Vault for accounting, depositing, and withdrawing.
 - MUST be an ERC-20 token contract.
 - MUST NOT revert.
