# Function: constructor()

**Contract**: [lib/v2-core/src/hooks/vaults/vault-bank/MintSuperPositionsHook.sol/contract_MintSuperPositionsHook.md]

## Metadata

- **Contract**: MintSuperPositionsHook
- **Signature**: `constructor()`
- **Visibility**: public
- **Source Range**: 1914:75:418

## Implementation

```solidity
constructor() BaseHook(HookType.NONACCOUNTING,HookSubTypes.VAULT_BANK) {}
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

- **hookType** (`enum ISuperHook.HookType`)
- **SUB_TYPE** (`bytes32`)

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: MintSuperPositionsHook.constructor() (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: MintSuperPositionsHook
  └─ [1] 🏗️ CONSTRUCTOR: BaseHook.constructor(enum ISuperHook.HookType,bytes32) (NodeID: 1)
      💬 Args: [HookType.NONACCOUNTING, HookSubTypes.VAULT_BANK]
      🏗️  Contract: BaseHook
```
