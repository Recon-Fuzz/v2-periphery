# Function: constructor(address)

**Contract**: [lib/v2-core/src/hooks/tokens/permit2/BatchTransferFromHook.sol/contract_BatchTransferFromHook.md]

## Metadata

- **Contract**: BatchTransferFromHook
- **Signature**: `constructor(address)`
- **Visibility**: public
- **Source Range**: 2233:232:398

## Implementation

```solidity
constructor(address permit2_) BaseHook(HookType.NONACCOUNTING,HookSubTypes.TOKEN) {
    if (permit2_ == address(0)) revert ADDRESS_NOT_VALID();
    PERMIT_2 = permit2_;
    PERMIT_2_INTERFACE = IPermit2(permit2_);
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

- **PERMIT_2** (`address`)
- **PERMIT_2_INTERFACE** (`contract IPermit2`) [lib/v2-core/src/vendor/uniswap/permit2/IPermit2.sol/interface_IPermit2.md]
- **hookType** (`enum ISuperHook.HookType`)
- **SUB_TYPE** (`bytes32`)

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: BatchTransferFromHook.constructor(address) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: BatchTransferFromHook
  └─ [1] 🏗️ CONSTRUCTOR: BaseHook.constructor(enum ISuperHook.HookType,bytes32) (NodeID: 1)
      💬 Args: [HookType.NONACCOUNTING, HookSubTypes.TOKEN]
      🏗️  Contract: BaseHook
```
