# Function: isSuperPositionCreated(address)

**Contract**: [test/draft/src/VaultBank/VaultBank.sol/contract_VaultBank.md]

## Metadata

- **Contract**: VaultBank
- **Signature**: `isSuperPositionCreated(address)`
- **Visibility**: external
- **Source Range**: 1646:147:553
- **Inherited From**: VaultBankDestination

## Implementation

```solidity
/// @inheritdoc IVaultBankDestination
function isSuperPositionCreated(address superPosition) external view returns (bool) {
    return _spAssetsInfo[superPosition].wasCreated;
}
```

## State Variable Reads

- **_spAssetsInfo** (`mapping(address => struct IVaultBankDestination.SpAsset)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: VaultBankDestination.isSuperPositionCreated(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc IVaultBankDestination

### Interface Documentation

@notice Check if a synthetic asset exists
 @param superPosition The synthetic asset
