# Function: asset()

**Contract**: [test/mocks/Mock4626Vault.sol/contract_Mock4626Vault.md]

## Metadata

- **Contract**: Mock4626Vault
- **Signature**: `asset()`
- **Visibility**: public
- **Source Range**: 1089:86:585

## Implementation

```solidity
function asset() override public view returns (address) {
    return _asset;
}
```

## State Variable Reads

- **_asset** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Mock4626Vault.asset() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Interface Documentation

 @dev Returns the address of the underlying token used for the Vault for accounting, depositing, and withdrawing.
 - MUST be an ERC-20 token contract.
 - MUST NOT revert.
