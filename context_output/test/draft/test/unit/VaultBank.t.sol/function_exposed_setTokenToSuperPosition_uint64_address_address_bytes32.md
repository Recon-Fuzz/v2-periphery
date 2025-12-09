# Function: exposed_setTokenToSuperPosition(uint64,address,address,bytes32)

**Contract**: [test/draft/test/unit/VaultBank.t.sol/contract_TestVaultBank.md]

## Metadata

- **Contract**: TestVaultBank
- **Signature**: `exposed_setTokenToSuperPosition(uint64,address,address,bytes32)`
- **Visibility**: external
- **Source Range**: 1772:288:570

## Implementation

```solidity
function exposed_setTokenToSuperPosition(uint64 srcChainId, address srcTokenAddress, address spToken, bytes32 yieldSourceOracleId) external {
    _tokenToSuperPosition[srcChainId][yieldSourceOracleId][srcTokenAddress] = spToken;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TestVaultBank.exposed_setTokenToSuperPosition(uint64,address,address,bytes32) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
