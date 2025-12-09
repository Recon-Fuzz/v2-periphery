# Function: decimals()

**Contract**: [src/SuperVault/SuperVault.sol/contract_SuperVault.md]

## Metadata

- **Contract**: SuperVault
- **Signature**: `decimals()`
- **Visibility**: public
- **Source Range**: 14625:142:510

## Implementation

```solidity
/// @inheritdoc IERC20Metadata
function decimals() virtual override(ERC20Upgradeable, IERC20Metadata) public view returns (uint8) {
    return _underlyingDecimals;
}
```

## State Variable Reads

- **_underlyingDecimals** (`uint8`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVault.decimals() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@inheritdoc IERC20Metadata

### Interface Documentation

 @dev Returns the decimals places of the token.
