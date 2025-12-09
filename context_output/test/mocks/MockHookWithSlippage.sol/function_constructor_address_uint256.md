# Function: constructor(address,uint256)

**Contract**: [test/mocks/MockHookWithSlippage.sol/contract_MockHookWithSlippage.md]

## Metadata

- **Contract**: MockHookWithSlippage
- **Signature**: `constructor(address,uint256)`
- **Visibility**: public
- **Source Range**: 474:244:595

## Implementation

```solidity
constructor(address _target, uint256 _outputAmount) BaseHook(ISuperHook.HookType.NONACCOUNTING,keccak256("MockHookWithSlippage")) {
    targetToReturn = _target;
    outputAmount = _outputAmount;
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
- **outputAmount** (`uint256`)
- **hookType** (`enum ISuperHook.HookType`)
- **SUB_TYPE** (`bytes32`)

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: MockHookWithSlippage.constructor(address,uint256) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: MockHookWithSlippage
  └─ [1] 🏗️ CONSTRUCTOR: BaseHook.constructor(enum ISuperHook.HookType,bytes32) (NodeID: 1)
      💬 Args: [ISuperHook.HookType.NONACCOUNTING, keccak256("MockHookWithSlippage")]
      🏗️  Contract: BaseHook
```
