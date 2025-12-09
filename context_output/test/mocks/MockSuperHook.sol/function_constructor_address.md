# Function: constructor(address)

**Contract**: [test/mocks/MockSuperHook.sol/contract_MockSuperHook.md]

## Metadata

- **Contract**: MockSuperHook
- **Signature**: `constructor(address)`
- **Visibility**: public
- **Source Range**: 738:223:604

## Implementation

```solidity
constructor(address _targetToReturn) BaseHook(ISuperHook.HookType.NONACCOUNTING,keccak256("MockSuperHook")) {
    targetToReturn = _targetToReturn;
    callDataToReturn = abi.encodeWithSignature("execute()");
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

- **targetToReturn** (`address`)
- **callDataToReturn** (`bytes`)
- **hookType** (`enum ISuperHook.HookType`)
- **SUB_TYPE** (`bytes32`)

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: MockSuperHook.constructor(address) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: MockSuperHook
  └─ [1] 🏗️ CONSTRUCTOR: BaseHook.constructor(enum ISuperHook.HookType,bytes32) (NodeID: 1)
      💬 Args: [ISuperHook.HookType.NONACCOUNTING, keccak256("MockSuperHook")]
      🏗️  Contract: BaseHook
```
