# Function: toExecutions(address[],uint256[],bytes[])

**Contract**: [lib/v2-core/lib/modulekit/src/test/helpers/KernelHelpers.sol/contract_KernelHelpers.md]

## Metadata

- **Contract**: KernelHelpers
- **Signature**: `toExecutions(address[],uint256[],bytes[])`
- **Visibility**: public
- **Source Range**: 22255:602:235
- **Inherited From**: HelperBase

## Implementation

```solidity
/// @notice Convert arrays of targets, values, and callDatas to an array of Executions
///  @param targets address[] the array of targets
///  @param values uint256[] the array of values
///  @param callDatas bytes[] the array of callDatas
///  @return executions Execution[] the array of encoded executions
function toExecutions(address[] memory targets, uint256[] memory values, bytes[] memory callDatas) virtual public pure returns (Execution[] memory executions) {
    executions = new Execution[](targets.length);
    if ((targets.length != values.length) && (values.length != callDatas.length)) {
        revert("Length Mismatch");
    }
    for (uint256 i; i < targets.length; i++) {
        executions[i] = Execution({target: targets[i], value: values[i], callData: callDatas[i]});
    }
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: HelperBase.toExecutions(address[],uint256[],bytes[]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Convert arrays of targets, values, and callDatas to an array of Executions
 @param targets address[] the array of targets
 @param values uint256[] the array of values
 @param callDatas bytes[] the array of callDatas
 @return executions Execution[] the array of encoded executions
