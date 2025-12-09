# Function: exposed_markAsSyntheticAsset(address)

**Contract**: [test/draft/test/unit/VaultBank.t.sol/contract_TestVaultBank.md]

## Metadata

- **Contract**: TestVaultBank
- **Signature**: `exposed_markAsSyntheticAsset(address)`
- **Visibility**: external
- **Source Range**: 1349:121:570

## Implementation

```solidity
function exposed_markAsSyntheticAsset(address spToken) external {
    _spAssetsInfo[spToken].wasCreated = true;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TestVaultBank.exposed_markAsSyntheticAsset(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
