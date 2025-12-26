# Function: constructor(address)

**Contract**: [lib/v2-core/src/hooks/swappers/1inch/Swap1InchHook.sol/contract_Swap1InchHook.md]

## Metadata

- **Contract**: Swap1InchHook
- **Signature**: `constructor(address)`
- **Visibility**: public
- **Source Range**: 2245:269:387

## Implementation

```solidity
constructor(address aggregationRouter_) BaseHook(HookType.NONACCOUNTING,HookSubTypes.SWAP) {
    if (aggregationRouter_ == address(0)) {
        revert ZERO_ADDRESS();
    }
    AGGREGATION_ROUTER = I1InchAggregationRouterV6(aggregationRouter_);
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

- **AGGREGATION_ROUTER** (`contract I1InchAggregationRouterV6`) [lib/v2-core/src/vendor/1inch/I1InchAggregationRouterV6.sol/interface_I1InchAggregationRouterV6.md]
- **hookType** (`enum ISuperHook.HookType`)
- **SUB_TYPE** (`bytes32`)

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: Swap1InchHook.constructor(address) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: Swap1InchHook
  └─ [1] 🏗️ CONSTRUCTOR: BaseHook.constructor(enum ISuperHook.HookType,bytes32) (NodeID: 1)
      💬 Args: [HookType.NONACCOUNTING, HookSubTypes.SWAP]
      🏗️  Contract: BaseHook
```
