# Function: constructor(address)

**Contract**: [lib/v2-core/src/hooks/swappers/pendle/PendleRouterSwapHook.sol/contract_PendleRouterSwapHook.md]

## Metadata

- **Contract**: PendleRouterSwapHook
- **Signature**: `constructor(address)`
- **Visibility**: public
- **Source Range**: 2203:228:391

## Implementation

```solidity
constructor(address pendleRouterV4_) BaseHook(HookType.NONACCOUNTING,HookSubTypes.PTYT) {
    if (pendleRouterV4_ == address(0)) revert ADDRESS_NOT_VALID();
    PENDLE_ROUTER_V4 = IPendleRouterV4(pendleRouterV4_);
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

- **PENDLE_ROUTER_V4** (`contract IPendleRouterV4`) [lib/v2-core/src/vendor/pendle/IPendleRouterV4.sol/interface_IPendleRouterV4.md]
- **hookType** (`enum ISuperHook.HookType`)
- **SUB_TYPE** (`bytes32`)

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: PendleRouterSwapHook.constructor(address) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: PendleRouterSwapHook
  └─ [1] 🏗️ CONSTRUCTOR: BaseHook.constructor(enum ISuperHook.HookType,bytes32) (NodeID: 1)
      💬 Args: [HookType.NONACCOUNTING, HookSubTypes.PTYT]
      🏗️  Contract: BaseHook
```
