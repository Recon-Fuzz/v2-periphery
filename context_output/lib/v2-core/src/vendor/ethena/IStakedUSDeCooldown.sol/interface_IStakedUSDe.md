# Interface: IStakedUSDe

## Metadata

- **Name**: IStakedUSDe
- **Type**: Interface
- **Path**: lib/v2-core/src/vendor/ethena/IStakedUSDeCooldown.sol

## Errors

### InvalidAmount

```solidity
/// @notice Error emitted shares or assets equal zero.
error InvalidAmount();
```

### InvalidToken

```solidity
/// @notice Error emitted when owner attempts to rescue USDe tokens.
error InvalidToken();
```

### MinSharesViolation

```solidity
/// @notice Error emitted when a small non-zero share amount remains, which risks donations attack
error MinSharesViolation();
```

### OperationNotAllowed

```solidity
/// @notice Error emitted when owner is not allowed to perform an operation
error OperationNotAllowed();
```

### StillVesting

```solidity
/// @notice Error emitted when there is still unvested amount
error StillVesting();
```

### CantBlacklistOwner

```solidity
/// @notice Error emitted when owner or blacklist manager attempts to blacklist owner
error CantBlacklistOwner();
```

### InvalidZeroAddress

```solidity
/// @notice Error emitted when the zero address is given
error InvalidZeroAddress();
```

## Events

### RewardsReceived

```solidity
/// @notice Event emitted when the rewards are received
event RewardsReceived(uint256 amount);
```

### LockedAmountRedistributed

```solidity
/// @notice Event emitted when the balance from an FULL_RESTRICTED_STAKER_ROLE user are redistributed
event LockedAmountRedistributed(address indexed from, address indexed to, uint256 amount);
```

## Public/External Functions

### transferInRewards(uint256)

- **Signature**: `transferInRewards(uint256)`
- **Visibility**: external
- **Source Range**: 1246:52:450

**Signature:**
```solidity
function transferInRewards(uint256 amount) external;;
```

### rescueTokens(address,uint256,address)

- **Signature**: `rescueTokens(address,uint256,address)`
- **Visibility**: external
- **Source Range**: 1304:74:450

**Signature:**
```solidity
function rescueTokens(address token, uint256 amount, address to) external;;
```

### getUnvestedAmount()

- **Signature**: `getUnvestedAmount()`
- **Visibility**: external
- **Source Range**: 1384:61:450

**Signature:**
```solidity
function getUnvestedAmount() external view returns (uint256);;
```
