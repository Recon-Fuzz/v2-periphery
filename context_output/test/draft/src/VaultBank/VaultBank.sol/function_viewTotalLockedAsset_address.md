# Function: viewTotalLockedAsset(address)

**Contract**: [test/draft/src/VaultBank/VaultBank.sol/contract_VaultBank.md]

## Metadata

- **Contract**: VaultBank
- **Signature**: `viewTotalLockedAsset(address)`
- **Visibility**: external
- **Source Range**: 1339:122:554
- **Inherited From**: VaultBankSource

## Implementation

```solidity
/// @inheritdoc IVaultBankSource
function viewTotalLockedAsset(address token) external view returns (uint256) {
    return _lockedAmounts[token];
}
```

## State Variable Reads

- **_lockedAmounts** (`mapping(address => uint256)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: VaultBankSource.viewTotalLockedAsset(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc IVaultBankSource

### Interface Documentation

@notice Get the total locked amount of a token
 @param token The token to get the total locked amount for
