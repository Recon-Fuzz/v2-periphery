# Function: constructor(address)

**Contract**: [lib/v2-core/src/hooks/swappers/spectra/SpectraExchangeDepositHook.sol/contract_SpectraExchangeDepositHook.md]

## Metadata

- **Contract**: SpectraExchangeDepositHook
- **Signature**: `constructor(address)`
- **Visibility**: public
- **Source Range**: 2171:193:392

## Implementation

```solidity
constructor(address router_) BaseHook(HookType.NONACCOUNTING,HookSubTypes.PTYT) {
    if (router_ == address(0)) revert ADDRESS_NOT_VALID();
    ROUTER = ISpectraRouter(router_);
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

- **ROUTER** (`contract ISpectraRouter`) [lib/v2-core/src/vendor/spectra/ISpectraRouter.sol/interface_ISpectraRouter.md]
- **hookType** (`enum ISuperHook.HookType`)
- **SUB_TYPE** (`bytes32`)

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: SpectraExchangeDepositHook.constructor(address) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: SpectraExchangeDepositHook
  └─ [1] 🏗️ CONSTRUCTOR: BaseHook.constructor(enum ISuperHook.HookType,bytes32) (NodeID: 1)
      💬 Args: [HookType.NONACCOUNTING, HookSubTypes.PTYT]
      🏗️  Contract: BaseHook
```
