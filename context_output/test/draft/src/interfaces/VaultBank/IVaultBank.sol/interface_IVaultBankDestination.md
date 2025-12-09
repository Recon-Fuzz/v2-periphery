# Interface: IVaultBankDestination

## Metadata

- **Name**: IVaultBankDestination
- **Type**: Interface
- **Path**: test/draft/src/interfaces/VaultBank/IVaultBank.sol

## Structs

### SpAsset

```solidity
struct SpAsset {
    bool wasCreated;
    mapping(uint64 => mapping(bytes32 => address)) spToToken;
}
```

## Errors

### INVALID_BURN_AMOUNT

```solidity
error INVALID_BURN_AMOUNT();
```

### SUPERPOSITION_ASSET_NOT_FOUND

```solidity
error SUPERPOSITION_ASSET_NOT_FOUND();
```

## Public/External Functions

### getSuperPositionForAsset(uint64,address,bytes32)

- **Signature**: `getSuperPositionForAsset(uint64,address,bytes32)`
- **Visibility**: external
- **Source Range**: 2708:186:562

**Signature:**
```solidity
/// @notice Get the synthetic asset for a source asset
///  @param srcChainId The source chain ID
///  @param srcAsset The source asset
///  @param yieldSourceOracleId The yield source oracle ID
function getSuperPositionForAsset(uint64 srcChainId, address srcAsset, bytes32 yieldSourceOracleId) external view returns (address);;
```

### getAssetForSuperPosition(uint64,address,bytes32)

- **Signature**: `getAssetForSuperPosition(uint64,address,bytes32)`
- **Visibility**: external
- **Source Range**: 3115:191:562

**Signature:**
```solidity
/// @notice Get the source asset for a synthetic asset
///  @param srcChainId The source chain ID
///  @param superPosition The synthetic asset
///  @param yieldSourceOracleId The yield source oracle ID
function getAssetForSuperPosition(uint64 srcChainId, address superPosition, bytes32 yieldSourceOracleId) external view returns (address);;
```

### isSuperPositionCreated(address)

- **Signature**: `isSuperPositionCreated(address)`
- **Visibility**: external
- **Source Range**: 3410:84:562

**Signature:**
```solidity
/// @notice Check if a synthetic asset exists
///  @param superPosition The synthetic asset
function isSuperPositionCreated(address superPosition) external view returns (bool);;
```
