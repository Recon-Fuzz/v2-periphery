# Function: isWhitelistedIncentiveToken(address)

**Contract**: [test/draft/src/SuperRegistry.sol/contract_SuperRegistry.md]

## Metadata

- **Contract**: SuperRegistry
- **Signature**: `isWhitelistedIncentiveToken(address)`
- **Visibility**: external
- **Source Range**: 14832:140:550

## Implementation

```solidity
/// @inheritdoc ISuperRegistry
function isWhitelistedIncentiveToken(address token) external view returns (bool) {
    return _isWhitelistedIncentiveToken[token];
}
```

## State Variable Reads

- **_isWhitelistedIncentiveToken** (`mapping(address => bool)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperRegistry.isWhitelistedIncentiveToken(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperRegistry

### Interface Documentation

@notice Checks if a token is whitelisted as an incentive token
 @param token The address of the token to check
 @return True if the token is whitelisted as an incentive token, false otherwise
