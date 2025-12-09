# Function: getCurrentNonce()

**Contract**: [test/recon/helpers/UnsafeSuperVaultAggregator.sol/contract_UnsafeSuperVaultAggregator.md]

## Metadata

- **Contract**: UnsafeSuperVaultAggregator
- **Signature**: `getCurrentNonce()`
- **Visibility**: external
- **Source Range**: 40392:102:634

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
┌─ [0] ⚙️ FUNCTION: UnsafeSuperVaultAggregator.getCurrentNonce() (NodeID: 0)
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
