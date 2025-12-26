# Interface: IYearnStakingRewardsMulti

## Metadata

- **Name**: IYearnStakingRewardsMulti
- **Type**: Interface
- **Path**: lib/v2-core/src/vendor/yearn/IYearnStakingRewardsMulti.sol

## Public/External Functions

### getReward()

- **Signature**: `getReward()`
- **Visibility**: external
- **Source Range**: 227:30:479

**Signature:**
```solidity
/// @notice Claim any (and all) earned reward tokens.
///  @dev Can claim rewards even if no tokens still staked.
function getReward() external;;
```

### getOneReward(address)

- **Signature**: `getOneReward(address)`
- **Visibility**: external
- **Source Range**: 445:54:479

**Signature:**
```solidity
/// @notice Claim any one earned reward token.
///  @dev Can claim rewards even if no tokens still staked.
///  @param _rewardsToken Address of the rewards token to claim.
function getOneReward(address _rewardsToken) external;;
```
