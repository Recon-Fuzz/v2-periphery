# Function: constructor(address,address)

**Contract**: [lib/v2-core/src/adapters/DebridgeAdapter.sol/contract_DebridgeAdapter.md]

## Metadata

- **Contract**: DebridgeAdapter
- **Signature**: `constructor(address,address)`
- **Visibility**: public
- **Source Range**: 1487:542:359

## Implementation

```solidity
constructor(address dlnDestination, address superDestinationExecutor_) {
    if ((superDestinationExecutor_ == address(0)) || (dlnDestination == address(0))) {
        revert ADDRESS_NOT_VALID();
    }
    SUPER_DESTINATION_EXECUTOR = ISuperDestinationExecutor(superDestinationExecutor_);
    address _externalCallAdapter = IDlnDestination(dlnDestination).externalCallAdapter();
    if (_externalCallAdapter == address(0)) {
        revert ADDRESS_NOT_VALID();
    }
    DLN_DESTINATION = dlnDestination;
}
```

## External Calls

- **IDlnDestination::externalCallAdapter()**

## State Variable Writes

- **SUPER_DESTINATION_EXECUTOR** (`contract ISuperDestinationExecutor`) [lib/v2-core/src/interfaces/ISuperDestinationExecutor.sol/interface_ISuperDestinationExecutor.md]
- **DLN_DESTINATION** (`address`)

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: DebridgeAdapter.constructor(address,address) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: DebridgeAdapter
```
