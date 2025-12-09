# Function: constructor(address)

**Contract**: [test/mocks/SuperVaultManageYieldSourceHook.sol/contract_SuperVaultManageYieldSourceHook.md]

## Metadata

- **Contract**: SuperVaultManageYieldSourceHook
- **Signature**: `constructor(address)`
- **Visibility**: public
- **Source Range**: 1218:186:611

## Implementation

```solidity
constructor(address _strategy) BaseHook(HookType.NONACCOUNTING,HookSubTypes.CLAIM) {
    if (_strategy == address(0)) revert ADDRESS_NOT_VALID();
    strategy = _strategy;
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

- **strategy** (`address`)
- **hookType** (`enum ISuperHook.HookType`)
- **SUB_TYPE** (`bytes32`)

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: SuperVaultManageYieldSourceHook.constructor(address) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: SuperVaultManageYieldSourceHook
  └─ [1] 🏗️ CONSTRUCTOR: BaseHook.constructor(enum ISuperHook.HookType,bytes32) (NodeID: 1)
      💬 Args: [HookType.NONACCOUNTING, HookSubTypes.CLAIM]
      🏗️  Contract: BaseHook
```
