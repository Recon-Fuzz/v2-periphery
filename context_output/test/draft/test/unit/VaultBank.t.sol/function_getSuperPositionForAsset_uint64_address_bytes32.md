# Function: getSuperPositionForAsset(uint64,address,bytes32)

**Contract**: [test/draft/test/unit/VaultBank.t.sol/contract_TestVaultBank.md]

## Metadata

- **Contract**: TestVaultBank
- **Signature**: `getSuperPositionForAsset(uint64,address,bytes32)`
- **Visibility**: external
- **Source Range**: 982:278:553
- **Inherited From**: VaultBankDestination

## Implementation

```solidity
/// @inheritdoc IVaultBankDestination
function getSuperPositionForAsset(uint64 srcChainId, address srcAsset, bytes32 yieldSourceOracleId) external view returns (address) {
    return _tokenToSuperPosition[srcChainId][yieldSourceOracleId][srcAsset];
}
```

## State Variable Reads

- **_tokenToSuperPosition** (`mapping(uint64 => mapping(bytes32 => mapping(address => address)))`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: VaultBankDestination.getSuperPositionForAsset(uint64,address,bytes32) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc IVaultBankDestination

### Interface Documentation

@notice Get the synthetic asset for a source asset
 @param srcChainId The source chain ID
 @param srcAsset The source asset
 @param yieldSourceOracleId The yield source oracle ID
