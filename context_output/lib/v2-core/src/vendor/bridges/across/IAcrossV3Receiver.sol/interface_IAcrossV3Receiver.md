# Interface: IAcrossV3Receiver

## Metadata

- **Name**: IAcrossV3Receiver
- **Type**: Interface
- **Path**: lib/v2-core/src/vendor/bridges/across/IAcrossV3Receiver.sol

## Errors

### INVALID_SENDER

```solidity
error INVALID_SENDER();
```

## Events

### AcrossFundsReceivedAndExecuted

```solidity
event AcrossFundsReceivedAndExecuted(address indexed account);
```

### AcrossFundsReceivedButExecutionFailed

```solidity
event AcrossFundsReceivedButExecutionFailed(address indexed account);
```

### AcrossFundsReceivedButNotEnoughBalance

```solidity
event AcrossFundsReceivedButNotEnoughBalance(address indexed account);
```

## Public/External Functions

### handleV3AcrossMessage(address,uint256,address,bytes)

- **Signature**: `handleV3AcrossMessage(address,uint256,address,bytes)`
- **Visibility**: external
- **Source Range**: 1096:114:446

**Signature:**
```solidity
/// @notice Handle a message from the Across V3 bridge
///  @param tokenSent The token sent
///  @param amount The amount sent
///  @param relayer The relayer
///  @param message The message
function handleV3AcrossMessage(address tokenSent, uint256 amount, address relayer, bytes memory message) external;;
```
