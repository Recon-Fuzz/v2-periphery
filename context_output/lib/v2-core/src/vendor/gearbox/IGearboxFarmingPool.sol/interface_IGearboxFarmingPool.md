# Interface: IGearboxFarmingPool

## Metadata

- **Name**: IGearboxFarmingPool
- **Type**: Interface
- **Path**: lib/v2-core/src/vendor/gearbox/IGearboxFarmingPool.sol

## Events

### DistributorChanged

```solidity
event DistributorChanged(address oldDistributor, address newDistributor);
```

### RewardUpdated

```solidity
event RewardUpdated(uint256 reward, uint256 duration);
```

## Public/External Functions

### balanceOf(address)

- **Signature**: `balanceOf(address)`
- **Visibility**: external
- **Source Range**: 701:68:452

**Signature:**
```solidity
function balanceOf(address account) external view returns (uint256);;
```

### distributor()

- **Signature**: `distributor()`
- **Visibility**: external
- **Source Range**: 774:55:452

**Signature:**
```solidity
function distributor() external view returns (address);;
```

### farmInfo()

- **Signature**: `farmInfo()`
- **Visibility**: external
- **Source Range**: 834:56:452

**Signature:**
```solidity
function farmInfo() external view returns (Info memory);;
```

### farmed(address)

- **Signature**: `farmed(address)`
- **Visibility**: external
- **Source Range**: 895:65:452

**Signature:**
```solidity
function farmed(address account) external view returns (uint256);;
```

### stakingToken()

- **Signature**: `stakingToken()`
- **Visibility**: external
- **Source Range**: 965:56:452

**Signature:**
```solidity
function stakingToken() external view returns (address);;
```

### rewardsToken()

- **Signature**: `rewardsToken()`
- **Visibility**: external
- **Source Range**: 1026:56:452

**Signature:**
```solidity
function rewardsToken() external view returns (address);;
```

### deposit(uint256)

- **Signature**: `deposit(uint256)`
- **Visibility**: external
- **Source Range**: 1276:42:452

**Signature:**
```solidity
function deposit(uint256 amount) external;;
```

### withdraw(uint256)

- **Signature**: `withdraw(uint256)`
- **Visibility**: external
- **Source Range**: 1323:43:452

**Signature:**
```solidity
function withdraw(uint256 amount) external;;
```

### claim()

- **Signature**: `claim()`
- **Visibility**: external
- **Source Range**: 1371:26:452

**Signature:**
```solidity
function claim() external;;
```

### exit()

- **Signature**: `exit()`
- **Visibility**: external
- **Source Range**: 1402:25:452

**Signature:**
```solidity
function exit() external;;
```
