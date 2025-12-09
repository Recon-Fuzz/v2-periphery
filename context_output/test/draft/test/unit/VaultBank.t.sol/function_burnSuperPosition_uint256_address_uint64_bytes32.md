# Function: burnSuperPosition(uint256,address,uint64,bytes32)

**Contract**: [test/draft/test/unit/VaultBank.t.sol/contract_TestVaultBank.md]

## Metadata

- **Contract**: TestVaultBank
- **Signature**: `burnSuperPosition(uint256,address,uint64,bytes32)`
- **Visibility**: external
- **Source Range**: 5569:567:552
- **Inherited From**: VaultBank

## Implementation

```solidity
/// @inheritdoc IVaultBank
function burnSuperPosition(uint256 amount_, address spAddress_, uint64 forChainId_, bytes32 yieldSourceOracleId_) override external {
    _burnSP(msg.sender, spAddress_, amount_);
    uint256 _nonce = nonces[forChainId_];
    nonces[forChainId_]++;
    emit SuperpositionsBurned(msg.sender, spAddress_, _spAssetsInfo[spAddress_].spToToken[forChainId_][yieldSourceOracleId_], amount_, forChainId_, _nonce);
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

- **nonces** (`mapping(uint64 => uint256)`)
- **_spAssetsInfo** (`mapping(address => struct IVaultBankDestination.SpAsset)`)

## State Variable Writes

- **nonces** (`mapping(uint64 => uint256)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: VaultBank.burnSuperPosition(uint256,address,uint64,bytes32) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: VaultBankDestination._burnSP(address,address,uint256) (NodeID: 1)
      💬 Args: [msg.sender, spAddress_, amount_]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc IVaultBank

### Interface Documentation

@notice Burns a synthetic asset
 @dev Should be requested by the account owning the SP assets
 @param amount The amount of the asset to burn
 @param spAddress The synthetic asset address
 @param forChainId The destination chain ID
 @param yieldSourceOracleId The yield source oracle ID
