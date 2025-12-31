# Function: constructor(address)

**Contract**: [lib/v2-core/src/hooks/bridges/debridge/DeBridgeCancelOrderHook.sol/contract_DeBridgeCancelOrderHook.md]

## Metadata

- **Contract**: DeBridgeCancelOrderHook
- **Signature**: `constructor(address)`
- **Visibility**: public
- **Source Range**: 5215:212:368

## Implementation

```solidity
constructor(address dlnDestination_) BaseHook(HookType.NONACCOUNTING,HookSubTypes.BRIDGE) {
    if (dlnDestination_ == address(0)) revert ADDRESS_NOT_VALID();
    DLN_DESTINATION = dlnDestination_;
}
```

## Related Implementations

### (enum ISuperHook.HookType,bytes32)

- **Kind**: internal
- **Source**: 4728:127:364
- **Link**: `lib/v2-core/src/hooks/BaseHook.sol:BaseHook:constructor(enum ISuperHook.HookType,bytes32)`

```solidity
/// @notice Initializes the hook with its type and subtype
///  @dev Sets immutable parameters that define the hook's behavior
///  @param hookType_ The type classification for this hook (NONACCOUNTING, INFLOW, OUTFLOW)
///  @param subType_ The specific subtype identifier for specialized hook functionality
constructor(ISuperHook.HookType hookType_, bytes32 subType_) {
    hookType = hookType_;
    SUB_TYPE = subType_;
}
```

## State Variable Writes

- **DLN_DESTINATION** (`address`)
- **hookType** (`enum ISuperHook.HookType`)
- **SUB_TYPE** (`bytes32`)

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: DeBridgeCancelOrderHook.constructor(address) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: DeBridgeCancelOrderHook
  └─ [1] 🏗️ CONSTRUCTOR: BaseHook.constructor(enum ISuperHook.HookType,bytes32) (NodeID: 1)
      💬 Args: [HookType.NONACCOUNTING, HookSubTypes.BRIDGE]
      🏗️  Contract: BaseHook
```
