# Function: constructor(address)

**Contract**: [test/mocks/MockStakingRewards.sol/contract_MockStakingRewards.md]

## Metadata

- **Contract**: MockStakingRewards
- **Signature**: `constructor(address)`
- **Visibility**: public
- **Source Range**: 174:88:602

## Implementation

```solidity
constructor(address _rewardToken) {
    rewardToken = MockERC20(_rewardToken);
}
```

## State Variable Writes

- **rewardToken** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: MockStakingRewards.constructor(address) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: MockStakingRewards
```
