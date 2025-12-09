# Function: decimals()

**Contract**: [test/mocks/RuggableConvertVault.sol/contract_RuggableConvertVault.md]

## Metadata

- **Contract**: RuggableConvertVault
- **Signature**: `decimals()`
- **Visibility**: public
- **Source Range**: 2021:113:608

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
┌─ [0] ⚙️ FUNCTION: RuggableConvertVault.decimals() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Interface Documentation

 @dev Returns the decimals places of the token.
