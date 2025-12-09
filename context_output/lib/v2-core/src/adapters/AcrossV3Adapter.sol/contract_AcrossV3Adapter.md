# Contract: AcrossV3Adapter

## Metadata

- **Name**: AcrossV3Adapter
- **Type**: Contract
- **Path**: lib/v2-core/src/adapters/AcrossV3Adapter.sol
- **Documentation**: @title AcrossV3Adapter
   @author Superform Labs
   @notice Receives messages from the Across V3 protocol and forwards them to the SuperDestinationExecutor.
   @notice This contract acts as a translator between the Across V3 protocol and the core Superform execution logic.

## Implements Interfaces

- **IAcrossV3Receiver** [lib/v2-core/src/vendor/bridges/across/IAcrossV3Receiver.sol/interface_IAcrossV3Receiver.md]

## State Variables

### ACROSS_SPOKE_POOL

```solidity
address public immutable ACROSS_SPOKE_POOL
```

### SUPER_DESTINATION_EXECUTOR

```solidity
ISuperDestinationExecutor public immutable SUPER_DESTINATION_EXECUTOR
```

**ISuperDestinationExecutor**: [lib/v2-core/src/interfaces/ISuperDestinationExecutor.sol/interface_ISuperDestinationExecutor.md]

## Errors

### INVALID_SENDER (inherited from IAcrossV3Receiver)

```solidity
error INVALID_SENDER();
```

### ADDRESS_NOT_VALID

```solidity
error ADDRESS_NOT_VALID();
```

## Events

### AcrossFundsReceivedAndExecuted (inherited from IAcrossV3Receiver)

```solidity
event AcrossFundsReceivedAndExecuted(address indexed account);
```

### AcrossFundsReceivedButExecutionFailed (inherited from IAcrossV3Receiver)

```solidity
event AcrossFundsReceivedButExecutionFailed(address indexed account);
```

### AcrossFundsReceivedButNotEnoughBalance (inherited from IAcrossV3Receiver)

```solidity
event AcrossFundsReceivedButNotEnoughBalance(address indexed account);
```

## Public/External Functions

### constructor(address,address)

- **Signature**: `constructor(address,address)`
- **Visibility**: public
- **Source Range**: 1350:356:358
- **Details**: [function_constructor_address_address.md](./function_constructor_address_address.md)

**Signature:**
```solidity
constructor(address acrossSpokePool_, address superDestinationExecutor_);
```

### handleV3AcrossMessage(address,uint256,address,bytes)

- **Signature**: `handleV3AcrossMessage(address,uint256,address,bytes)`
- **Visibility**: external
- **Source Range**: 1942:1629:358
- **Details**: [function_handleV3AcrossMessage_address_uint256_address_bytes.md](./function_handleV3AcrossMessage_address_uint256_address_bytes.md)

**Signature:**
```solidity
/// @inheritdoc IAcrossV3Receiver
function handleV3AcrossMessage(address tokenSent, uint256 amount, address, bytes memory message) override external;
```
