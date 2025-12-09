# Function: exposed_setSuperPositionToToken(address,uint64,address,bytes32)

**Contract**: [test/draft/test/unit/VaultBank.t.sol/contract_TestVaultBank.md]

## Metadata

- **Contract**: TestVaultBank
- **Signature**: `exposed_setSuperPositionToToken(address,uint64,address,bytes32)`
- **Visibility**: external
- **Source Range**: 1476:290:570

## Implementation

```solidity
function exposed_setSuperPositionToToken(address spToken, uint64 srcChainId, address srcTokenAddress, bytes32 yieldSourceOracleId) external {
    _spAssetsInfo[spToken].spToToken[srcChainId][yieldSourceOracleId] = srcTokenAddress;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TestVaultBank.exposed_setSuperPositionToToken(address,uint64,address,bytes32) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
