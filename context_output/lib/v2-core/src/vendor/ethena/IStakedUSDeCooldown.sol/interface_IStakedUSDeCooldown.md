# Interface: IStakedUSDeCooldown

## Metadata

- **Name**: IStakedUSDeCooldown
- **Type**: Interface
- **Path**: lib/v2-core/src/vendor/ethena/IStakedUSDeCooldown.sol

## Implements Interfaces

- **IStakedUSDe** [lib/v2-core/src/vendor/ethena/IStakedUSDeCooldown.sol/interface_IStakedUSDe.md]

## Errors

### InvalidAmount (inherited from IStakedUSDe)

```solidity
/// @notice Error emitted shares or assets equal zero.
error InvalidAmount();
```

### InvalidToken (inherited from IStakedUSDe)

```solidity
/// @notice Error emitted when owner attempts to rescue USDe tokens.
error InvalidToken();
```

### MinSharesViolation (inherited from IStakedUSDe)

```solidity
/// @notice Error emitted when a small non-zero share amount remains, which risks donations attack
error MinSharesViolation();
```

### OperationNotAllowed (inherited from IStakedUSDe)

```solidity
/// @notice Error emitted when owner is not allowed to perform an operation
error OperationNotAllowed();
```

### StillVesting (inherited from IStakedUSDe)

```solidity
/// @notice Error emitted when there is still unvested amount
error StillVesting();
```

### CantBlacklistOwner (inherited from IStakedUSDe)

```solidity
/// @notice Error emitted when owner or blacklist manager attempts to blacklist owner
error CantBlacklistOwner();
```

### InvalidZeroAddress (inherited from IStakedUSDe)

```solidity
/// @notice Error emitted when the zero address is given
error InvalidZeroAddress();
```

### ExcessiveRedeemAmount

```solidity
/// @notice Error emitted when the shares amount to redeem is greater than the shares balance of the owner
error ExcessiveRedeemAmount();
```

### ExcessiveWithdrawAmount

```solidity
/// @notice Error emitted when the shares amount to withdraw is greater than the shares balance of the owner
error ExcessiveWithdrawAmount();
```

### InvalidCooldown

```solidity
/// @notice Error emitted when cooldown value is invalid
error InvalidCooldown();
```

## Events

### RewardsReceived (inherited from IStakedUSDe)

```solidity
/// @notice Event emitted when the rewards are received
event RewardsReceived(uint256 amount);
```

### LockedAmountRedistributed (inherited from IStakedUSDe)

```solidity
/// @notice Event emitted when the balance from an FULL_RESTRICTED_STAKER_ROLE user are redistributed
event LockedAmountRedistributed(address indexed from, address indexed to, uint256 amount);
```

### CooldownDurationUpdated

```solidity
/// @notice Event emitted when cooldown duration updates
event CooldownDurationUpdated(uint24 previousDuration, uint24 newDuration);
```

## Public/External Functions

### cooldownAssets(uint256)

- **Signature**: `cooldownAssets(uint256)`
- **Visibility**: external
- **Source Range**: 2063:74:450

**Signature:**
```solidity
function cooldownAssets(uint256 assets) external returns (uint256 shares);;
```

### cooldownShares(uint256)

- **Signature**: `cooldownShares(uint256)`
- **Visibility**: external
- **Source Range**: 2143:74:450

**Signature:**
```solidity
function cooldownShares(uint256 shares) external returns (uint256 assets);;
```

### unstake(address)

- **Signature**: `unstake(address)`
- **Visibility**: external
- **Source Range**: 2223:44:450

**Signature:**
```solidity
function unstake(address receiver) external;;
```

### setCooldownDuration(uint24)

- **Signature**: `setCooldownDuration(uint24)`
- **Visibility**: external
- **Source Range**: 2273:55:450

**Signature:**
```solidity
function setCooldownDuration(uint24 duration) external;;
```

### transferInRewards(uint256) (inherited from IStakedUSDe)

- **Signature**: `transferInRewards(uint256)`
- **Visibility**: external
- **Source Range**: 1246:52:450

**Signature:**
```solidity
function transferInRewards(uint256 amount) external;;
```

### rescueTokens(address,uint256,address) (inherited from IStakedUSDe)

- **Signature**: `rescueTokens(address,uint256,address)`
- **Visibility**: external
- **Source Range**: 1304:74:450

**Signature:**
```solidity
function rescueTokens(address token, uint256 amount, address to) external;;
```

### getUnvestedAmount() (inherited from IStakedUSDe)

- **Signature**: `getUnvestedAmount()`
- **Visibility**: external
- **Source Range**: 1384:61:450

**Signature:**
```solidity
function getUnvestedAmount() external view returns (uint256);;
```
