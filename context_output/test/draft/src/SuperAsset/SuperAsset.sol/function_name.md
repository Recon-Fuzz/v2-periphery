# Function: name()

**Contract**: [test/draft/src/SuperAsset/SuperAsset.sol/contract_SuperAsset.md]

## Metadata

- **Contract**: SuperAsset
- **Signature**: `name()`
- **Visibility**: public
- **Source Range**: 41005:94:548

## Implementation

```solidity
/// @inheritdoc ERC20
function name() override public view returns (string memory) {
    return tokenName;
}
```

## State Variable Reads

- **tokenName** (`string`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperAsset.name() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@inheritdoc ERC20

### Interface Documentation

 @dev Returns the name of the token.
