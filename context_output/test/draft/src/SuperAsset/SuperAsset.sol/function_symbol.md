# Function: symbol()

**Contract**: [test/draft/src/SuperAsset/SuperAsset.sol/contract_SuperAsset.md]

## Metadata

- **Contract**: SuperAsset
- **Signature**: `symbol()`
- **Visibility**: public
- **Source Range**: 41131:98:548

## Implementation

```solidity
/// @inheritdoc ERC20
function symbol() override public view returns (string memory) {
    return tokenSymbol;
}
```

## State Variable Reads

- **tokenSymbol** (`string`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperAsset.symbol() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@inheritdoc ERC20

### Interface Documentation

 @dev Returns the symbol of the token.
