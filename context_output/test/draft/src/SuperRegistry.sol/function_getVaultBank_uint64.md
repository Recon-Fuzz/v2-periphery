# Function: getVaultBank(uint64)

**Contract**: [test/draft/src/SuperRegistry.sol/contract_SuperRegistry.md]

## Metadata

- **Contract**: SuperRegistry
- **Signature**: `getVaultBank(uint64)`
- **Visibility**: external
- **Source Range**: 13678:123:550

## Implementation

```solidity
/// @inheritdoc ISuperRegistry
function getVaultBank(uint64 chainId) external view returns (address) {
    return _vaultBanksByChainId[chainId];
}
```

## State Variable Reads

- **_vaultBanksByChainId** (`mapping(uint64 => address)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperRegistry.getVaultBank(uint64) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperRegistry

### Interface Documentation

@notice Gets the vault bank address for a specific chain ID
 @param chainId The chain ID to get the vault bank for
 @return The vault bank address
