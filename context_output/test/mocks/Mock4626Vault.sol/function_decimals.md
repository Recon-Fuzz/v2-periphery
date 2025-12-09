# Function: decimals()

**Contract**: [test/mocks/Mock4626Vault.sol/contract_Mock4626Vault.md]

## Metadata

- **Contract**: Mock4626Vault
- **Signature**: `decimals()`
- **Visibility**: public
- **Source Range**: 1358:83:585

## Implementation

```solidity
function decimals() override public pure returns (uint8) {
    return 18;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Mock4626Vault.decimals() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Interface Documentation

 @dev Returns the decimals places of the token.
