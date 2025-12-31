# Interface: IVaultBankSource

## Metadata

- **Name**: IVaultBankSource
- **Type**: Interface
- **Path**: lib/v2-core/src/vendor/superform/IVaultBank.sol

## Errors

### CLAIM_FAILED

```solidity
error CLAIM_FAILED();
```

### INVALID_TOKEN

```solidity
error INVALID_TOKEN();
```

### INVALID_AMOUNT

```solidity
error INVALID_AMOUNT();
```

### INVALID_ACCOUNT

```solidity
error INVALID_ACCOUNT();
```

### TOKEN_NOT_FOUND

```solidity
error TOKEN_NOT_FOUND();
```

### NO_LOCKED_ASSETS

```solidity
error NO_LOCKED_ASSETS();
```

### INVALID_CLAIM_TARGET

```solidity
error INVALID_CLAIM_TARGET();
```

### INVALID_YIELD_SOURCE_ORACLE_ID

```solidity
error INVALID_YIELD_SOURCE_ORACLE_ID();
```

## Events

### SharesLocked

```solidity
event SharesLocked(bytes32 indexed yieldSourceOracleId, address indexed account, address indexed token, uint256 amount, uint256 srcChainId, uint256 dstChainId, uint256 nonce);
```

### SharesUnlocked

```solidity
event SharesUnlocked(bytes32 indexed yieldSourceOracleId, address indexed account, address indexed token, uint256 amount, uint256 srcChainId, uint256 dstChainId, uint256 nonce);
```

## Public/External Functions

### viewTotalLockedAsset(address)

- **Signature**: `viewTotalLockedAsset(address)`
- **Visibility**: external
- **Source Range**: 1550:77:472

**Signature:**
```solidity
/// @notice Get the total locked amount of a token
///  @param token The token to get the total locked amount for
function viewTotalLockedAsset(address token) external view returns (uint256);;
```

### viewAllLockedAssets()

- **Signature**: `viewAllLockedAssets()`
- **Visibility**: external
- **Source Range**: 1698:72:472

**Signature:**
```solidity
/// @notice Get all the locked assets of a destination chain
function viewAllLockedAssets() external view returns (address[] memory);;
```
