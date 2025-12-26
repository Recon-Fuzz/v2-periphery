# Function: constructor(address,address)

**Contract**: [lib/v2-core/src/adapters/AcrossV3Adapter.sol/contract_AcrossV3Adapter.md]

## Metadata

- **Contract**: AcrossV3Adapter
- **Signature**: `constructor(address,address)`
- **Visibility**: public
- **Source Range**: 1350:356:358

## Implementation

```solidity
constructor(address acrossSpokePool_, address superDestinationExecutor_) {
    if ((acrossSpokePool_ == address(0)) || (superDestinationExecutor_ == address(0))) {
        revert ADDRESS_NOT_VALID();
    }
    ACROSS_SPOKE_POOL = acrossSpokePool_;
    SUPER_DESTINATION_EXECUTOR = ISuperDestinationExecutor(superDestinationExecutor_);
}
```

## State Variable Writes

- **ACROSS_SPOKE_POOL** (`address`)
- **SUPER_DESTINATION_EXECUTOR** (`contract ISuperDestinationExecutor`) [lib/v2-core/src/interfaces/ISuperDestinationExecutor.sol/interface_ISuperDestinationExecutor.md]

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: AcrossV3Adapter.constructor(address,address) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: AcrossV3Adapter
```
