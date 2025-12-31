# Function: constructor(address)

**Contract**: [lib/v2-core/src/hooks/claim/merkl/MerklClaimRewardHook.sol/contract_MerklClaimRewardHook.md]

## Metadata

- **Contract**: MerklClaimRewardHook
- **Signature**: `constructor(address)`
- **Visibility**: public
- **Source Range**: 1901:198:373

## Implementation

```solidity
constructor(address distributor_) BaseHook(HookType.NONACCOUNTING,HookSubTypes.CLAIM) {
    if (distributor_ == address(0)) revert ADDRESS_NOT_VALID();
    DISTRIBUTOR = distributor_;
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

- **DISTRIBUTOR** (`address`)
- **hookType** (`enum ISuperHook.HookType`)
- **SUB_TYPE** (`bytes32`)

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: MerklClaimRewardHook.constructor(address) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: MerklClaimRewardHook
  └─ [1] 🏗️ CONSTRUCTOR: BaseHook.constructor(enum ISuperHook.HookType,bytes32) (NodeID: 1)
      💬 Args: [HookType.NONACCOUNTING, HookSubTypes.CLAIM]
      🏗️  Contract: BaseHook
```
