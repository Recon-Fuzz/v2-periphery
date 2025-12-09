# Function: getTokenData(address)

**Contract**: [test/draft/src/SuperAsset/SuperAsset.sol/contract_SuperAsset.md]

## Metadata

- **Contract**: SuperAsset
- **Signature**: `getTokenData(address)`
- **Visibility**: external
- **Source Range**: 27915:118:548

## Implementation

```solidity
/// @inheritdoc ISuperAsset
function getTokenData(address token) external view returns (TokenData memory) {
    return tokenData[token];
}
```

## State Variable Reads

- **tokenData** (`mapping(address => struct ISuperAsset.TokenData)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperAsset.getTokenData(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperAsset

### Interface Documentation

@notice Returns the token data for a given token
 @param token The token address
 @return TokenData structure containing the token data
