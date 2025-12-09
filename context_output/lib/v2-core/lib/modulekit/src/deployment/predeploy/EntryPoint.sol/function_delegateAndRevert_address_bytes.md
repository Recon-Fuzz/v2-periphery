# Function: delegateAndRevert(address,bytes)

**Contract**: [lib/v2-core/lib/modulekit/src/deployment/predeploy/EntryPoint.sol/contract_EntryPointSimulationsPatch.md]

## Metadata

- **Contract**: EntryPointSimulationsPatch
- **Signature**: `delegateAndRevert(address,bytes)`
- **Visibility**: external
- **Source Range**: 29869:198:89
- **Inherited From**: EntryPoint

## Implementation

```solidity
/// @inheritdoc IEntryPoint
function delegateAndRevert(address target, bytes calldata data) external {
    (bool success, bytes memory ret) = target.delegatecall(data);
    revert DelegateAndRevert(success, ret);
}
```

## External Calls

- **address::delegatecall(bytes calldata)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: EntryPoint.delegateAndRevert(address,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc IEntryPoint

### Interface Documentation

 Helper method for dry-run testing.
 @dev calling this method, the EntryPoint will make a delegatecall to the given data, and report (via revert) the result.
  The method always revert, so is only useful off-chain for dry run calls, in cases where state-override to replace
  actual EntryPoint code is less convenient.
 @param target a target contract to make a delegatecall from entrypoint
 @param data data to pass to target in a delegatecall
