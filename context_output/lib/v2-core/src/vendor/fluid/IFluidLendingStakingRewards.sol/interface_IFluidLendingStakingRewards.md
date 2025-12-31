# Interface: IFluidLendingStakingRewards

## Metadata

- **Name**: IFluidLendingStakingRewards
- **Type**: Interface
- **Path**: lib/v2-core/src/vendor/fluid/IFluidLendingStakingRewards.sol

## Public/External Functions

### rewardsToken()

- **Signature**: `rewardsToken()`
- **Visibility**: external
- **Source Range**: 292:56:451

**Signature:**
```solidity
function rewardsToken() external view returns (address);;
```

### stakingToken()

- **Signature**: `stakingToken()`
- **Visibility**: external
- **Source Range**: 353:56:451

**Signature:**
```solidity
function stakingToken() external view returns (address);;
```

### balanceOf(address)

- **Signature**: `balanceOf(address)`
- **Visibility**: external
- **Source Range**: 414:68:451

**Signature:**
```solidity
function balanceOf(address account) external view returns (uint256);;
```

### rewardPerToken()

- **Signature**: `rewardPerToken()`
- **Visibility**: external
- **Source Range**: 487:74:451

**Signature:**
```solidity
function rewardPerToken() external view returns (uint256 rewardPerToken_);;
```

### getRewardForDuration()

- **Signature**: `getRewardForDuration()`
- **Visibility**: external
- **Source Range**: 566:64:451

**Signature:**
```solidity
function getRewardForDuration() external view returns (uint256);;
```

### earned(address)

- **Signature**: `earned(address)`
- **Visibility**: external
- **Source Range**: 635:65:451

**Signature:**
```solidity
function earned(address account) external view returns (uint256);;
```

### getReward()

- **Signature**: `getReward()`
- **Visibility**: external
- **Source Range**: 894:30:451

**Signature:**
```solidity
function getReward() external;;
```

### stakeWithPermit(uint256,uint256,uint8,bytes32,bytes32)

- **Signature**: `stakeWithPermit(uint256,uint256,uint8,bytes32,bytes32)`
- **Visibility**: external
- **Source Range**: 929:99:451

**Signature:**
```solidity
function stakeWithPermit(uint256 amount, uint256 deadline, uint8 v, bytes32 r, bytes32 s) external;;
```

### stake(uint256)

- **Signature**: `stake(uint256)`
- **Visibility**: external
- **Source Range**: 1033:40:451

**Signature:**
```solidity
function stake(uint256 amount) external;;
```

### withdraw(uint256)

- **Signature**: `withdraw(uint256)`
- **Visibility**: external
- **Source Range**: 1078:43:451

**Signature:**
```solidity
function withdraw(uint256 amount) external;;
```
