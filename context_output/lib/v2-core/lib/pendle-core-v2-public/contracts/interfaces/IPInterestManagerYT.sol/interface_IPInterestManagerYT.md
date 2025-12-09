# Interface: IPInterestManagerYT

## Metadata

- **Name**: IPInterestManagerYT
- **Type**: Interface
- **Path**: lib/v2-core/lib/pendle-core-v2-public/contracts/interfaces/IPInterestManagerYT.sol

## Events

### CollectInterestFee

```solidity
event CollectInterestFee(uint256 amountInterestFee);
```

## Public/External Functions

### userInterest(address)

- **Signature**: `userInterest(address)`
- **Visibility**: external
- **Source Range**: 164:105:301

**Signature:**
```solidity
function userInterest(address user) external view returns (uint128 lastPYIndex, uint128 accruedInterest);;
```
