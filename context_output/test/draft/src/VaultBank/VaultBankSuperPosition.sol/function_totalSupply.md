# Function: totalSupply()

**Contract**: [test/draft/src/VaultBank/VaultBankSuperPosition.sol/contract_VaultBankSuperPosition.md]

## Metadata

- **Contract**: VaultBankSuperPosition
- **Signature**: `totalSupply()`
- **Visibility**: public
- **Source Range**: 2803:97:267
- **Inherited From**: ERC20

## Implementation

```solidity
/// @inheritdoc IERC20
function totalSupply() virtual public view returns (uint256) {
    return _totalSupply;
}
```

## State Variable Reads

- **_totalSupply** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC20.totalSupply() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@inheritdoc IERC20

### Interface Documentation

 @dev Returns the value of tokens in existence.
