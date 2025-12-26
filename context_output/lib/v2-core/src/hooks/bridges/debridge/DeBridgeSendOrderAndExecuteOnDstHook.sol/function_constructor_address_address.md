# Function: constructor(address,address)

**Contract**: [lib/v2-core/src/hooks/bridges/debridge/DeBridgeSendOrderAndExecuteOnDstHook.sol/contract_DeBridgeSendOrderAndExecuteOnDstHook.md]

## Metadata

- **Contract**: DeBridgeSendOrderAndExecuteOnDstHook
- **Signature**: `constructor(address,address)`
- **Visibility**: public
- **Source Range**: 5834:272:369

## Implementation

```solidity
constructor(address dlnSource_, address validator_) BaseHook(HookType.NONACCOUNTING,HookSubTypes.BRIDGE) {
    if ((dlnSource_ == address(0)) || (validator_ == address(0))) revert ADDRESS_NOT_VALID();
    DLN_SOURCE = dlnSource_;
    VALIDATOR = validator_;
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

- **DLN_SOURCE** (`address`)
- **VALIDATOR** (`address`)
- **hookType** (`enum ISuperHook.HookType`)
- **SUB_TYPE** (`bytes32`)

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: DeBridgeSendOrderAndExecuteOnDstHook.constructor(address,address) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: DeBridgeSendOrderAndExecuteOnDstHook
  └─ [1] 🏗️ CONSTRUCTOR: BaseHook.constructor(enum ISuperHook.HookType,bytes32) (NodeID: 1)
      💬 Args: [HookType.NONACCOUNTING, HookSubTypes.BRIDGE]
      🏗️  Contract: BaseHook
```
