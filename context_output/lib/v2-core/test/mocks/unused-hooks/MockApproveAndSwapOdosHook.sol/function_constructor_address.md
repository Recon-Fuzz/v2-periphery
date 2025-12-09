# Function: constructor(address)

**Contract**: [lib/v2-core/test/mocks/unused-hooks/MockApproveAndSwapOdosHook.sol/contract_MockApproveAndSwapOdosHook.md]

## Metadata

- **Contract**: MockApproveAndSwapOdosHook
- **Signature**: `constructor(address)`
- **Visibility**: public
- **Source Range**: 1879:204:496

## Implementation

```solidity
constructor(address _routerV2) BaseHook(HookType.NONACCOUNTING,HookSubTypes.SWAP) {
    if (_routerV2 == address(0)) revert ADDRESS_NOT_VALID();
    odosRouterV2 = IOdosRouterV2(_routerV2);
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

- **odosRouterV2** (`contract IOdosRouterV2`) [lib/v2-core/src/vendor/odos/IOdosRouterV2.sol/interface_IOdosRouterV2.md]
- **hookType** (`enum ISuperHook.HookType`)
- **SUB_TYPE** (`bytes32`)

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: MockApproveAndSwapOdosHook.constructor(address) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: MockApproveAndSwapOdosHook
  └─ [1] 🏗️ CONSTRUCTOR: BaseHook.constructor(enum ISuperHook.HookType,bytes32) (NodeID: 1)
      💬 Args: [HookType.NONACCOUNTING, HookSubTypes.SWAP]
      🏗️  Contract: BaseHook
```
