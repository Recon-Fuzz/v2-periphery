# Function: constructor()

**Contract**: [lib/v2-core/src/hooks/vaults/5115/Deposit5115VaultHook.sol/contract_Deposit5115VaultHook.md]

## Metadata

- **Contract**: Deposit5115VaultHook
- **Signature**: `constructor()`
- **Visibility**: public
- **Source Range**: 1546:65:403

## Implementation

```solidity
constructor() BaseHook(HookType.INFLOW,HookSubTypes.ERC5115) {}
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
┌─ [0] 🏗️ CONSTRUCTOR: Deposit5115VaultHook.constructor() (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: Deposit5115VaultHook
  └─ [1] 🏗️ CONSTRUCTOR: BaseHook.constructor(enum ISuperHook.HookType,bytes32) (NodeID: 1)
      💬 Args: [HookType.INFLOW, HookSubTypes.ERC5115]
      🏗️  Contract: BaseHook
```
