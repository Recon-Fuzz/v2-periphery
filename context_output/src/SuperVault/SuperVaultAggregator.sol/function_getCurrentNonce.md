# Function: getCurrentNonce()

**Contract**: [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]

## Metadata

- **Contract**: SuperVaultAggregator
- **Signature**: `getCurrentNonce()`
- **Visibility**: external
- **Source Range**: 42319:102:511

## Implementation

```solidity
/// @inheritdoc ISuperVaultAggregator
function getCurrentNonce() external view returns (uint256) {
    return _vaultCreationNonce;
}
```

## State Variable Reads

- **_vaultCreationNonce** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregator.getCurrentNonce() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperVaultAggregator

### Interface Documentation

@notice Returns the current vault creation nonce
 @dev This nonce is incremented every time a new vault is created
 @return Current vault creation nonce
