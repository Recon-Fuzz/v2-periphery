# Function: decimals()

**Contract**: [test/mocks/RuggableVault.sol/contract_RuggableVault.md]

## Metadata

- **Contract**: RuggableVault
- **Signature**: `decimals()`
- **Visibility**: public
- **Source Range**: 2405:113:609

## Implementation

```solidity
function decimals() override(ERC20, IERC20Metadata) public view returns (uint8) {
    return _decimals;
}
```

## State Variable Reads

- **_decimals** (`uint8`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: RuggableVault.decimals() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Interface Documentation

 @dev Returns the decimals places of the token.
