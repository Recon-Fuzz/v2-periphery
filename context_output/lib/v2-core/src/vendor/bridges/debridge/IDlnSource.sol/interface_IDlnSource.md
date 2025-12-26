# Interface: IDlnSource

## Metadata

- **Name**: IDlnSource
- **Type**: Interface
- **Path**: lib/v2-core/src/vendor/bridges/debridge/IDlnSource.sol

## Structs

### OrderCreation

```solidity
struct OrderCreation {
    address giveTokenAddress;
    uint256 giveAmount;
    bytes takeTokenAddress;
    uint256 takeAmount;
    uint256 takeChainId;
    bytes receiverDst;
    address givePatchAuthoritySrc;
    bytes orderAuthorityAddressDst;
    bytes allowedTakerDst;
    bytes externalCall;
    bytes allowedCancelBeneficiarySrc;
}
```

### ExternalCallEnvelopV1

```solidity
struct ExternalCallEnvelopV1 {
    address fallbackAddress;
    address executorAddress;
    uint160 executionFee;
    bool allowDelayedExecution;
    bool requireSuccessfullExecution;
    bytes payload;
}
```

## Public/External Functions

### createOrder(struct IDlnSource.OrderCreation,bytes,uint32,bytes)

- **Signature**: `createOrder(struct IDlnSource.OrderCreation,bytes,uint32,bytes)`
- **Visibility**: external
- **Source Range**: 2911:249:447

**Signature:**
```solidity
function createOrder(OrderCreation calldata _orderCreation, bytes calldata _affiliateFee, uint32 _referralCode, bytes calldata _permitEnvelope) external payable returns (bytes32 orderId);;
```

### globalFixedNativeFee()

- **Signature**: `globalFixedNativeFee()`
- **Visibility**: external
- **Source Range**: 3166:64:447

**Signature:**
```solidity
function globalFixedNativeFee() external view returns (uint256);;
```
