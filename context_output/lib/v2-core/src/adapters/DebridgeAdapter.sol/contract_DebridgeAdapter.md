# Contract: DebridgeAdapter

## Metadata

- **Name**: DebridgeAdapter
- **Type**: Contract
- **Path**: lib/v2-core/src/adapters/DebridgeAdapter.sol
- **Documentation**: @title DebridgeAdapter
   @author Superform Labs
   @notice Receives messages from the Debridge protocol and forwards them to the SuperDestinationExecutor.
   @notice This contract acts as a translator between the Debridge protocol and the core Superform execution logic.

## Implements Interfaces

- **IExternalCallExecutor** [lib/v2-core/src/vendor/bridges/debridge/IExternalCallExecutor.sol/interface_IExternalCallExecutor.md]

## State Variables

### SUPER_DESTINATION_EXECUTOR

```solidity
ISuperDestinationExecutor public immutable SUPER_DESTINATION_EXECUTOR
```

**ISuperDestinationExecutor**: [lib/v2-core/src/interfaces/ISuperDestinationExecutor.sol/interface_ISuperDestinationExecutor.md]

### DLN_DESTINATION

```solidity
address public immutable DLN_DESTINATION
```

## Errors

### ADDRESS_NOT_VALID

```solidity
error ADDRESS_NOT_VALID();
```

### ON_ETHER_RECEIVED_FAILED

```solidity
error ON_ETHER_RECEIVED_FAILED();
```

### ONLY_EXTERNAL_CALL_ADAPTER

```solidity
error ONLY_EXTERNAL_CALL_ADAPTER();
```

## Public/External Functions

### constructor(address,address)

- **Signature**: `constructor(address,address)`
- **Visibility**: public
- **Source Range**: 1487:542:359
- **Details**: [function_constructor_address_address.md](./function_constructor_address_address.md)

**Signature:**
```solidity
constructor(address dlnDestination, address superDestinationExecutor_);
```

### onEtherReceived(bytes32,address,bytes)

- **Signature**: `onEtherReceived(bytes32,address,bytes)`
- **Visibility**: external
- **Source Range**: 2443:1193:359
- **Details**: [function_onEtherReceived_bytes32_address_bytes.md](./function_onEtherReceived_bytes32_address_bytes.md)

**Signature:**
```solidity
/// @inheritdoc IExternalCallExecutor
function onEtherReceived(bytes32, address, bytes memory _payload) external payable onlyExternalCallAdapter() returns (bool callSucceeded, bytes memory callResult);
```

### onERC20Received(bytes32,address,uint256,address,bytes)

- **Signature**: `onERC20Received(bytes32,address,uint256,address,bytes)`
- **Visibility**: external
- **Source Range**: 3684:1166:359
- **Details**: [function_onERC20Received_bytes32_address_uint256_address_bytes.md](./function_onERC20Received_bytes32_address_uint256_address_bytes.md)

**Signature:**
```solidity
/// @inheritdoc IExternalCallExecutor
function onERC20Received(bytes32, address _token, uint256 _transferredAmount, address, bytes memory _payload) external onlyExternalCallAdapter() returns (bool callSucceeded, bytes memory callResult);
```
