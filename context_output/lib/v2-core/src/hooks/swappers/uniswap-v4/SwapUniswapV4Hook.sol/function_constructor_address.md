# Function: constructor(address)

**Contract**: [lib/v2-core/src/hooks/swappers/uniswap-v4/SwapUniswapV4Hook.sol/contract_SwapUniswapV4Hook.md]

## Metadata

- **Contract**: SwapUniswapV4Hook
- **Signature**: `constructor(address)`
- **Visibility**: public
- **Source Range**: 7686:155:394

## Implementation

```solidity
/// @notice Initialize the Uniswap V4 swap hook
///  @param poolManager_ The address of the Uniswap V4 Pool Manager
constructor(address poolManager_) BaseHook(ISuperHook.HookType.NONACCOUNTING,HookSubTypes.SWAP) {
    POOL_MANAGER = IPoolManager(poolManager_);
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

- **POOL_MANAGER** (`contract IPoolManager`) [lib/v2-core/lib/v4-core/src/interfaces/IPoolManager.sol/interface_IPoolManager.md]
- **hookType** (`enum ISuperHook.HookType`)
- **SUB_TYPE** (`bytes32`)

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: SwapUniswapV4Hook.constructor(address) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: SwapUniswapV4Hook
  └─ [1] 🏗️ CONSTRUCTOR: BaseHook.constructor(enum ISuperHook.HookType,bytes32) (NodeID: 1)
      💬 Args: [ISuperHook.HookType.NONACCOUNTING, HookSubTypes.SWAP]
      🏗️  Contract: BaseHook
```

## Documentation

### Function Documentation

@notice Initialize the Uniswap V4 swap hook
 @param poolManager_ The address of the Uniswap V4 Pool Manager
