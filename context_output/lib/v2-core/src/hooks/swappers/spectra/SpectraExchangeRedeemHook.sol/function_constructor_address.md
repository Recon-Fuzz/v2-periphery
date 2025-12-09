# Function: constructor(address)

**Contract**: [lib/v2-core/src/hooks/swappers/spectra/SpectraExchangeRedeemHook.sol/contract_SpectraExchangeRedeemHook.md]

## Metadata

- **Contract**: SpectraExchangeRedeemHook
- **Signature**: `constructor(address)`
- **Visibility**: public
- **Source Range**: 2663:177:393

## Implementation

```solidity
constructor(address router_) BaseHook(HookType.NONACCOUNTING,HookSubTypes.PTYT) {
    if (router_ == address(0)) revert ADDRESS_NOT_VALID();
    ROUTER = router_;
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

- **ROUTER** (`address`)
- **hookType** (`enum ISuperHook.HookType`)
- **SUB_TYPE** (`bytes32`)

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: SpectraExchangeRedeemHook.constructor(address) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: SpectraExchangeRedeemHook
  └─ [1] 🏗️ CONSTRUCTOR: BaseHook.constructor(enum ISuperHook.HookType,bytes32) (NodeID: 1)
      💬 Args: [HookType.NONACCOUNTING, HookSubTypes.PTYT]
      🏗️  Contract: BaseHook
```
