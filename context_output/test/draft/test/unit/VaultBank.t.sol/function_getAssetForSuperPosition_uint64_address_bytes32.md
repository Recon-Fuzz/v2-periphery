# Function: getAssetForSuperPosition(uint64,address,bytes32)

**Contract**: [test/draft/test/unit/VaultBank.t.sol/contract_TestVaultBank.md]

## Metadata

- **Contract**: TestVaultBank
- **Signature**: `getAssetForSuperPosition(uint64,address,bytes32)`
- **Visibility**: external
- **Source Range**: 1308:290:553
- **Inherited From**: VaultBankDestination

## Implementation

```solidity
/// @inheritdoc IVaultBankDestination
function getAssetForSuperPosition(uint64 srcChainId, address superPosition, bytes32 yieldSourceOracleId) external view returns (address) {
    return _spAssetsInfo[superPosition].spToToken[srcChainId][yieldSourceOracleId];
}
```

## State Variable Reads

- **_spAssetsInfo** (`mapping(address => struct IVaultBankDestination.SpAsset)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: VaultBankDestination.getAssetForSuperPosition(uint64,address,bytes32) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc IVaultBankDestination

### Interface Documentation

@notice Get the source asset for a synthetic asset
 @param srcChainId The source chain ID
 @param superPosition The synthetic asset
 @param yieldSourceOracleId The yield source oracle ID
