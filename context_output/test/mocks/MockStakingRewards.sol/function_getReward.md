# Function: getReward()

**Contract**: [test/mocks/MockStakingRewards.sol/contract_MockStakingRewards.md]

## Metadata

- **Contract**: MockStakingRewards
- **Signature**: `getReward()`
- **Visibility**: public
- **Source Range**: 268:115:602

## Implementation

```solidity
function getReward() public {
    rewardToken.transfer(msg.sender, rewardToken.balanceOf(address(this)));
}
```

## External Calls

- **MockERC20::transfer(address,uint256)**
- **MockERC20::balanceOf(address)**

## Native Transfers

- **rewardToken** (state variable) [test/mocks/MockERC20.sol/contract_MockERC20.md]

## State Variable Reads

- **rewardToken** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockStakingRewards.getReward() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
