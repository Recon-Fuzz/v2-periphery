# Interface: IRewardManager

## Metadata

- **Name**: IRewardManager
- **Type**: Interface
- **Path**: lib/v2-core/lib/pendle-core-v2-public/contracts/interfaces/IRewardManager.sol

## Public/External Functions

### userReward(address,address)

- **Signature**: `userReward(address,address)`
- **Visibility**: external
- **Source Range**: 101:104:305

**Signature:**
```solidity
function userReward(address token, address user) external view returns (uint128 index, uint128 accrued);;
```
