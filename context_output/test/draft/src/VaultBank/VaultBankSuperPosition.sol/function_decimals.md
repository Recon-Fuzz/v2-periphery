# Function: decimals()

**Contract**: [test/draft/src/VaultBank/VaultBankSuperPosition.sol/contract_VaultBankSuperPosition.md]

## Metadata

- **Contract**: VaultBankSuperPosition
- **Signature**: `decimals()`
- **Visibility**: public
- **Source Range**: 1406:90:555

## Implementation

```solidity
/// @notice Get the number of decimals for the token
function decimals() override public view returns (uint8) {
    return _decimals;
}
```

## State Variable Reads

- **_decimals** (`uint8`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: VaultBankSuperPosition.decimals() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Get the number of decimals for the token

### Interface Documentation

 @dev Returns the decimals places of the token.
