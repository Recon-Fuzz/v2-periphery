# Interface: IPLimitRouterCallback

## Metadata

- **Name**: IPLimitRouterCallback
- **Type**: Interface
- **Path**: lib/v2-core/lib/pendle-core-v2-public/contracts/interfaces/IPLimitRouter.sol

## Implements Interfaces

- **IPLimitOrderType** [lib/v2-core/lib/pendle-core-v2-public/contracts/interfaces/IPLimitRouter.sol/interface_IPLimitOrderType.md]

## Structs

### StaticOrder (inherited from IPLimitOrderType)

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

### FillResults (inherited from IPLimitOrderType)

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

### OrderType (inherited from IPLimitOrderType)

```solidity
enum OrderType {
    SY_FOR_PT,
    PT_FOR_SY,
    SY_FOR_YT,
    YT_FOR_SY
}
```

## Public/External Functions

### limitRouterCallback(uint256,uint256,uint256,bytes)

- **Signature**: `limitRouterCallback(uint256,uint256,uint256,bytes)`
- **Visibility**: external
- **Source Range**: 1332:180:302

**Signature:**
```solidity
function limitRouterCallback(uint256 actualMaking, uint256 actualTaking, uint256 totalFee, bytes memory data) external returns (bytes memory);;
```
