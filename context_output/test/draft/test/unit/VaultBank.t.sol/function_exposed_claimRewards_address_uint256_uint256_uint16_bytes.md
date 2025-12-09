# Function: exposed_claimRewards(address,uint256,uint256,uint16,bytes)

**Contract**: [test/draft/test/unit/VaultBank.t.sol/contract_TestVaultBank.md]

## Metadata

- **Contract**: TestVaultBank
- **Signature**: `exposed_claimRewards(address,uint256,uint256,uint16,bytes)`
- **Visibility**: external
- **Source Range**: 2217:311:570

## Implementation

```solidity
function exposed_claimRewards(address target, uint256 gasLimit, uint256 value, uint16 maxReturnDataCopy, bytes calldata data) external returns (bytes memory) {
    return _claimRewards(target, gasLimit, value, maxReturnDataCopy, data);
}
```

## Related Implementations

### _claimRewards(address,uint256,uint256,uint16,bytes)

- **Kind**: internal
- **Source**: 3544:500:554
- **Link**: `test/draft/src/VaultBank/VaultBankSource.sol:VaultBankSource:_claimRewards(address,uint256,uint256,uint16,bytes)`

```solidity
function _claimRewards(address target, uint256 gasLimit, uint256 value, uint16 maxReturnDataCopy, bytes calldata data) internal returns (bytes memory) {
    if ((target == address(0)) || (target == address(this))) revert INVALID_CLAIM_TARGET();
    (bool success, bytes memory result) = target.excessivelySafeCall(gasLimit, value, maxReturnDataCopy, data);
    if (!success) revert CLAIM_FAILED();
    return result;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TestVaultBank.exposed_claimRewards(address,uint256,uint256,uint16,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: VaultBankSource._claimRewards(address,uint256,uint256,uint16,bytes) (NodeID: 1)
      💬 Args: [target, gasLimit, value, maxReturnDataCopy, data]
      👁️  Def: internal
```
