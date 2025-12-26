# Function: validateHookCompliance(address,address,address,bytes)

**Contract**: [lib/v2-core/src/executors/SuperDestinationExecutor.sol/contract_SuperDestinationExecutor.md]

## Metadata

- **Contract**: SuperDestinationExecutor
- **Signature**: `validateHookCompliance(address,address,address,bytes)`
- **Visibility**: public
- **Source Range**: 5492:1189:362
- **Inherited From**: SuperExecutorBase

## Implementation

```solidity
/// @notice Validates that hook follows secure execution pattern
function validateHookCompliance(address hook, address prevHook, address account, bytes memory hookData) public view returns (Execution[] memory) {
    Execution[] memory empty = new Execution[](0);
    Execution[] memory executions = ISuperHook(hook).build(prevHook, account, hookData);
    if (executions.length < 2) return empty;
    if (executions[0].target != hook) return empty;
    bytes4 firstSelector = bytes4(executions[0].callData);
    if (firstSelector != ISuperHook.preExecute.selector) return empty;
    uint256 lastIdx = executions.length - 1;
    if (executions[lastIdx].target != hook) return empty;
    bytes4 lastSelector = bytes4(executions[lastIdx].callData);
    if (lastSelector != ISuperHook.postExecute.selector) return empty;
    for (uint256 i = 1; i < lastIdx; i++) {
        if (executions[i].target == hook) return empty;
    }
    return executions;
}
```

## External Calls

- **ISuperHook::build(address,address,bytes)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperExecutorBase.validateHookCompliance(address,address,address,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Validates that hook follows secure execution pattern
