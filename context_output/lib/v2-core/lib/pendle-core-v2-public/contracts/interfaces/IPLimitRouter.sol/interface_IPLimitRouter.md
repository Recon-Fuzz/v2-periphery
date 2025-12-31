# Interface: IPLimitRouter

## Metadata

- **Name**: IPLimitRouter
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

### OrderStatus

```solidity
struct OrderStatus {
    uint128 filledAmount;
    uint128 remaining;
}
```

## Events

### OrderCanceled

```solidity
event OrderCanceled(address indexed maker, bytes32 indexed orderHash);
```

### OrderFilledV2

```solidity
event OrderFilledV2(bytes32 indexed orderHash, OrderType indexed orderType, address indexed YT, address token, uint256 netInputFromMaker, uint256 netOutputToMaker, uint256 feeAmount, uint256 notionalVolume, address maker, address taker);
```

### LnFeeRateRootsSet

```solidity
event LnFeeRateRootsSet(address[] YTs, uint256[] lnFeeRateRoots);
```

### OrderFilled

```solidity
event OrderFilled(bytes32 indexed orderHash, OrderType indexed orderType, address indexed YT, address token, uint256 netInputFromMaker, uint256 netOutputToMaker, uint256 feeAmount, uint256 notionalVolume);
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

### fill(struct FillOrderParams[],address,uint256,bytes,bytes)

- **Signature**: `fill(struct FillOrderParams[],address,uint256,bytes,bytes)`
- **Visibility**: external
- **Source Range**: 2220:288:302

**Signature:**
```solidity
function fill(FillOrderParams[] memory params, address receiver, uint256 maxTaking, bytes calldata optData, bytes calldata callback) external returns (uint256 actualMaking, uint256 actualTaking, uint256 totalFee, bytes memory callbackReturn);;
```

### feeRecipient()

- **Signature**: `feeRecipient()`
- **Visibility**: external
- **Source Range**: 2514:56:302

**Signature:**
```solidity
function feeRecipient() external view returns (address);;
```

### hashOrder(struct Order)

- **Signature**: `hashOrder(struct Order)`
- **Visibility**: external
- **Source Range**: 2576:71:302

**Signature:**
```solidity
function hashOrder(Order memory order) external view returns (bytes32);;
```

### cancelSingle(struct Order)

- **Signature**: `cancelSingle(struct Order)`
- **Visibility**: external
- **Source Range**: 2653:53:302

**Signature:**
```solidity
function cancelSingle(Order calldata order) external;;
```

### cancelBatch(struct Order[])

- **Signature**: `cancelBatch(struct Order[])`
- **Visibility**: external
- **Source Range**: 2712:55:302

**Signature:**
```solidity
function cancelBatch(Order[] calldata orders) external;;
```

### orderStatusesRaw(bytes32[])

- **Signature**: `orderStatusesRaw(bytes32[])`
- **Visibility**: external
- **Source Range**: 2773:157:302

**Signature:**
```solidity
function orderStatusesRaw(bytes32[] memory orderHashes) external view returns (uint256[] memory remainingsRaw, uint256[] memory filledAmounts);;
```

### orderStatuses(bytes32[])

- **Signature**: `orderStatuses(bytes32[])`
- **Visibility**: external
- **Source Range**: 2936:151:302

**Signature:**
```solidity
function orderStatuses(bytes32[] memory orderHashes) external view returns (uint256[] memory remainings, uint256[] memory filledAmounts);;
```

### DOMAIN_SEPARATOR()

- **Signature**: `DOMAIN_SEPARATOR()`
- **Visibility**: external
- **Source Range**: 3093:60:302

**Signature:**
```solidity
function DOMAIN_SEPARATOR() external view returns (bytes32);;
```

### simulate(address,bytes)

- **Signature**: `simulate(address,bytes)`
- **Visibility**: external
- **Source Range**: 3159:72:302

**Signature:**
```solidity
function simulate(address target, bytes calldata data) external payable;;
```

### WNATIVE()

- **Signature**: `WNATIVE()`
- **Visibility**: external
- **Source Range**: 3237:51:302

**Signature:**
```solidity
function WNATIVE() external view returns (address);;
```

### _checkSig(struct Order,bytes)

- **Signature**: `_checkSig(struct Order,bytes)`
- **Visibility**: external
- **Source Range**: 3294:268:302

**Signature:**
```solidity
function _checkSig(Order memory order, bytes memory signature) external view returns (bytes32, uint256, uint256);;
```
