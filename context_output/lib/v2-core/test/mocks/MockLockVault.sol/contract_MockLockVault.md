# Contract: MockLockVault

## Metadata

- **Name**: MockLockVault
- **Type**: Contract
- **Path**: lib/v2-core/test/mocks/MockLockVault.sol

## Public/External Functions

### lock(address,address,address,uint256)

- **Signature**: `lock(address,address,address,uint256)`
- **Visibility**: external
- **Source Range**: 158:165:484
- **Details**: [function_lock_address_address_address_uint256.md](./function_lock_address_address_address_uint256.md)

**Signature:**
```solidity
function lock(address account, address token, address, uint256 amount) external;
```

### unlock(address,address,uint256)

- **Signature**: `unlock(address,address,uint256)`
- **Visibility**: external
- **Source Range**: 329:128:484
- **Details**: [function_unlock_address_address_uint256.md](./function_unlock_address_address_uint256.md)

**Signature:**
```solidity
function unlock(address account, address token, uint256 amount) external;
```
