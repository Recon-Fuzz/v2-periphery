# Interface: IAcrossSpokePoolV3

## Metadata

- **Name**: IAcrossSpokePoolV3
- **Type**: Interface
- **Path**: lib/v2-core/src/vendor/bridges/across/IAcrossSpokePoolV3.sol

## Structs

### V3RelayData

```solidity
///               STRUCTS               *
struct V3RelayData {
    address depositor;
    address recipient;
    address exclusiveRelayer;
    address inputToken;
    address outputToken;
    uint256 inputAmount;
    uint256 outputAmount;
    uint256 originChainId;
    uint32 depositId;
    uint32 fillDeadline;
    uint32 exclusivityDeadline;
    bytes message;
}
```

### V3SlowFill

```solidity
struct V3SlowFill {
    V3RelayData relayData;
    uint256 chainId;
    uint256 updatedOutputAmount;
}
```

### V3RelayExecutionParams

```solidity
struct V3RelayExecutionParams {
    V3RelayData relay;
    bytes32 relayHash;
    uint256 updatedOutputAmount;
    address updatedRecipient;
    bytes updatedMessage;
    uint256 repaymentChainId;
}
```

### V3RelayExecutionEventInfo

```solidity
struct V3RelayExecutionEventInfo {
    address updatedRecipient;
    bytes updatedMessage;
    uint256 updatedOutputAmount;
    FillType fillType;
}
```

## Errors

### DisabledRoute

```solidity
///               ERRORS                *
error DisabledRoute();
```

### InvalidQuoteTimestamp

```solidity
error InvalidQuoteTimestamp();
```

### InvalidFillDeadline

```solidity
error InvalidFillDeadline();
```

### InvalidExclusiveRelayer

```solidity
error InvalidExclusiveRelayer();
```

### MsgValueDoesNotMatchInputAmount

```solidity
error MsgValueDoesNotMatchInputAmount();
```

### NotExclusiveRelayer

```solidity
error NotExclusiveRelayer();
```

### NoSlowFillsInExclusivityWindow

```solidity
error NoSlowFillsInExclusivityWindow();
```

### RelayFilled

```solidity
error RelayFilled();
```

### InvalidSlowFillRequest

```solidity
error InvalidSlowFillRequest();
```

### ExpiredFillDeadline

```solidity
error ExpiredFillDeadline();
```

### InvalidMerkleProof

```solidity
error InvalidMerkleProof();
```

### InvalidChainId

```solidity
error InvalidChainId();
```

### InvalidMerkleLeaf

```solidity
error InvalidMerkleLeaf();
```

### ClaimedMerkleLeaf

```solidity
error ClaimedMerkleLeaf();
```

### InvalidPayoutAdjustmentPct

```solidity
error InvalidPayoutAdjustmentPct();
```

### WrongERC7683OrderId

```solidity
error WrongERC7683OrderId();
```

### LowLevelCallFailed

```solidity
error LowLevelCallFailed(bytes data);
```

## Events

### V3FundsDeposited

```solidity
///               EVENTS                *
event V3FundsDeposited(address inputToken, address outputToken, uint256 inputAmount, uint256 outputAmount, uint256 indexed destinationChainId, uint32 indexed depositId, uint32 quoteTimestamp, uint32 fillDeadline, uint32 exclusivityDeadline, address indexed depositor, address recipient, address exclusiveRelayer, bytes message);
```

### RequestedSpeedUpV3Deposit

```solidity
event RequestedSpeedUpV3Deposit(uint256 updatedOutputAmount, uint32 indexed depositId, address indexed depositor, address updatedRecipient, bytes updatedMessage, bytes depositorSignature);
```

### FilledV3Relay

```solidity
event FilledV3Relay(address inputToken, address outputToken, uint256 inputAmount, uint256 outputAmount, uint256 repaymentChainId, uint256 indexed originChainId, uint32 indexed depositId, uint32 fillDeadline, uint32 exclusivityDeadline, address exclusiveRelayer, address indexed relayer, address depositor, address recipient, bytes message, V3RelayExecutionEventInfo relayExecutionInfo);
```

### RequestedV3SlowFill

```solidity
event RequestedV3SlowFill(address inputToken, address outputToken, uint256 inputAmount, uint256 outputAmount, uint256 indexed originChainId, uint32 indexed depositId, uint32 fillDeadline, uint32 exclusivityDeadline, address exclusiveRelayer, address depositor, address recipient, bytes message);
```

## Enums

### FillStatus

```solidity
///               ENUMS                 *
enum FillStatus {
    Unfilled,
    RequestedSlowFill,
    Filled
}
```

### FillType

```solidity
enum FillType {
    FastFill,
    ReplacedSlowFill,
    SlowFill
}
```

## Public/External Functions

### depositV3(address,address,address,address,uint256,uint256,uint256,address,uint32,uint32,uint32,bytes)

- **Signature**: `depositV3(address,address,address,address,uint256,uint256,uint256,address,uint32,uint32,uint32,bytes)`
- **Visibility**: external
- **Source Range**: 5994:426:445

**Signature:**
```solidity
///               FUNCTIONS             *
function depositV3(address depositor, address recipient, address inputToken, address outputToken, uint256 inputAmount, uint256 outputAmount, uint256 destinationChainId, address exclusiveRelayer, uint32 quoteTimestamp, uint32 fillDeadline, uint32 exclusivityDeadline, bytes calldata message) external payable;;
```

### depositV3Now(address,address,address,address,uint256,uint256,uint256,address,uint32,uint32,bytes)

- **Signature**: `depositV3Now(address,address,address,address,uint256,uint256,uint256,address,uint32,uint32,bytes)`
- **Visibility**: external
- **Source Range**: 6426:404:445

**Signature:**
```solidity
function depositV3Now(address depositor, address recipient, address inputToken, address outputToken, uint256 inputAmount, uint256 outputAmount, uint256 destinationChainId, address exclusiveRelayer, uint32 fillDeadlineOffset, uint32 exclusivityDeadline, bytes calldata message) external payable;;
```

### speedUpV3Deposit(address,uint32,uint256,address,bytes,bytes)

- **Signature**: `speedUpV3Deposit(address,uint32,uint256,address,bytes,bytes)`
- **Visibility**: external
- **Source Range**: 6836:255:445

**Signature:**
```solidity
function speedUpV3Deposit(address depositor, uint32 depositId, uint256 updatedOutputAmount, address updatedRecipient, bytes calldata updatedMessage, bytes calldata depositorSignature) external;;
```

### fillV3Relay(struct IAcrossSpokePoolV3.V3RelayData,uint256)

- **Signature**: `fillV3Relay(struct IAcrossSpokePoolV3.V3RelayData,uint256)`
- **Visibility**: external
- **Source Range**: 7097:88:445

**Signature:**
```solidity
function fillV3Relay(V3RelayData calldata relayData, uint256 repaymentChainId) external;;
```

### fillV3RelayWithUpdatedDeposit(struct IAcrossSpokePoolV3.V3RelayData,uint256,uint256,address,bytes,bytes)

- **Signature**: `fillV3RelayWithUpdatedDeposit(struct IAcrossSpokePoolV3.V3RelayData,uint256,uint256,address,bytes,bytes)`
- **Visibility**: external
- **Source Range**: 7191:289:445

**Signature:**
```solidity
function fillV3RelayWithUpdatedDeposit(V3RelayData calldata relayData, uint256 repaymentChainId, uint256 updatedOutputAmount, address updatedRecipient, bytes calldata updatedMessage, bytes calldata depositorSignature) external;;
```

### requestV3SlowFill(struct IAcrossSpokePoolV3.V3RelayData)

- **Signature**: `requestV3SlowFill(struct IAcrossSpokePoolV3.V3RelayData)`
- **Visibility**: external
- **Source Range**: 7486:68:445

**Signature:**
```solidity
function requestV3SlowFill(V3RelayData calldata relayData) external;;
```

### executeV3SlowRelayLeaf(struct IAcrossSpokePoolV3.V3SlowFill,uint32,bytes32[])

- **Signature**: `executeV3SlowRelayLeaf(struct IAcrossSpokePoolV3.V3SlowFill,uint32,bytes32[])`
- **Visibility**: external
- **Source Range**: 7560:160:445

**Signature:**
```solidity
function executeV3SlowRelayLeaf(V3SlowFill calldata slowFillLeaf, uint32 rootBundleId, bytes32[] calldata proof) external;;
```

### wrappedNativeToken()

- **Signature**: `wrappedNativeToken()`
- **Visibility**: external
- **Source Range**: 7726:62:445

**Signature:**
```solidity
function wrappedNativeToken() external view returns (address);;
```
