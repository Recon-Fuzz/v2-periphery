# Function: constructor(address)

**Contract**: [test/mocks/MockNativeETHHook.sol/contract_MockNativeETHHook.md]

## Metadata

- **Contract**: MockNativeETHHook
- **Signature**: `constructor(address)`
- **Visibility**: public
- **Source Range**: 1756:198:599

## Implementation

```solidity
constructor(address ethReceiver_) BaseHook(ISuperHook.HookType.OUTFLOW,HookSubTypes.MISC) {
    if (ethReceiver_ == address(0)) revert ZERO_ADDRESS();
    ETH_RECEIVER = ethReceiver_;
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

- **ETH_RECEIVER** (`address`)
- **hookType** (`enum ISuperHook.HookType`)
- **SUB_TYPE** (`bytes32`)

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: MockNativeETHHook.constructor(address) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: MockNativeETHHook
  └─ [1] 🏗️ CONSTRUCTOR: BaseHook.constructor(enum ISuperHook.HookType,bytes32) (NodeID: 1)
      💬 Args: [ISuperHook.HookType.OUTFLOW, HookSubTypes.MISC]
      🏗️  Contract: BaseHook
```
