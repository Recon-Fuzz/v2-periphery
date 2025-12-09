# Interface: IPLimitOrderType

## Metadata

- **Name**: IPLimitOrderType
- **Type**: Interface
- **Path**: lib/v2-core/lib/pendle-core-v2-public/contracts/interfaces/IPLimitRouter.sol

## Structs

### StaticOrder

```solidity
struct StaticOrder {
    uint256 salt;
    uint256 expiry;
    uint256 nonce;
    OrderType orderType;
    address token;
    address YT;
    address maker;
    address receiver;
    uint256 makingAmount;
    uint256 lnImpliedRate;
    uint256 failSafeRate;
}
```

### FillResults

```solidity
struct FillResults {
    uint256 totalMaking;
    uint256 totalTaking;
    uint256 totalFee;
    uint256 totalNotionalVolume;
    uint256[] netMakings;
    uint256[] netTakings;
    uint256[] netFees;
    uint256[] notionalVolumes;
}
```

## Enums

### OrderType

```solidity
enum OrderType {
    SY_FOR_PT,
    PT_FOR_SY,
    SY_FOR_YT,
    YT_FOR_SY
}
```
