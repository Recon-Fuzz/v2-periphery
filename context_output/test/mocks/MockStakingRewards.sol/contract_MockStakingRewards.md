# Contract: MockStakingRewards

## Metadata

- **Name**: MockStakingRewards
- **Type**: Contract
- **Path**: test/mocks/MockStakingRewards.sol

## State Variables

### rewardToken

```solidity
MockERC20 public rewardToken
```

**MockERC20**: [test/mocks/MockERC20.sol/contract_MockERC20.md]

## Public/External Functions

### constructor(address)

- **Signature**: `constructor(address)`
- **Visibility**: public
- **Source Range**: 174:88:602
- **Details**: [function_constructor_address.md](./function_constructor_address.md)

**Signature:**
```solidity
constructor(address _rewardToken);
```

### getReward()

- **Signature**: `getReward()`
- **Visibility**: public
- **Source Range**: 268:115:602
- **Details**: [function_getReward.md](./function_getReward.md)

**Signature:**
```solidity
function getReward() public;
```
