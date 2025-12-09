# Function: exposed_burnSP(address,address,uint256)

**Contract**: [test/draft/test/unit/VaultBank.t.sol/contract_TestVaultBank.md]

## Metadata

- **Contract**: TestVaultBank
- **Signature**: `exposed_burnSP(address,address,uint256)`
- **Visibility**: external
- **Source Range**: 2066:145:570

## Implementation

```solidity
function exposed_burnSP(address account, address superPosition, uint256 amount) external {
    _burnSP(account, superPosition, amount);
}
```

## Related Implementations

### _burnSP(address,address,uint256)

- **Kind**: internal
- **Source**: 3118:447:553
- **Link**: `test/draft/src/VaultBank/VaultBankDestination.sol:VaultBankDestination:_burnSP(address,address,uint256)`

```solidity
function _burnSP(address account, address superPosition, uint256 amount) internal {
    if (!_spAssetsInfo[superPosition].wasCreated) revert SUPERPOSITION_ASSET_NOT_FOUND();
    if (amount > VaultBankSuperPosition(superPosition).balanceOf(account)) revert INVALID_BURN_AMOUNT();
    VaultBankSuperPosition(superPosition).burn(account, amount);
}
```

## State Variable Reads

- **_spAssetsInfo** (`mapping(address => struct IVaultBankDestination.SpAsset)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TestVaultBank.exposed_burnSP(address,address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: VaultBankDestination._burnSP(address,address,uint256) (NodeID: 1)
      💬 Args: [account, superPosition, amount]
      👁️  Def: internal
```
