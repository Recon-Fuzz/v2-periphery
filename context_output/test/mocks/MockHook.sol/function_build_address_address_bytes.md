# Function: build(address,address,bytes)

**Contract**: [test/mocks/MockHook.sol/contract_MockHook.md]

## Metadata

- **Contract**: MockHook
- **Signature**: `build(address,address,bytes)`
- **Visibility**: external
- **Source Range**: 1693:1042:593

## Implementation

```solidity
/// @dev Standard build pattern - MUST include preExecute first, postExecute last
///  @inheritdoc ISuperHook
function build(address prevHook, address account, bytes calldata hookData) virtual external view returns (Execution[] memory _executions) {
    Execution[] memory hookExecutions = _buildHookExecutions(prevHook, account, hookData);
    _executions = new Execution[](hookExecutions.length + 2);
    _executions[0] = Execution({target: address(this), value: 0, callData: abi.encodeCall(this.preExecute, (prevHook, account, hookData))});
    for (uint256 i = 0; i < hookExecutions.length; i++) {
        _executions[i + 1] = hookExecutions[i];
    }
    _executions[_executions.length - 1] = Execution({target: address(this), value: 0, callData: abi.encodeCall(this.postExecute, (prevHook, account, hookData))});
}
```

## Related Implementations

### _buildHookExecutions(address,address,bytes)

- **Kind**: internal
- **Source**: 2741:316:593
- **Link**: `test/mocks/MockHook.sol:MockHook:_buildHookExecutions(address,address,bytes)`

```solidity
function _buildHookExecutions(address, address, bytes calldata) internal view returns (Execution[] memory) {
    Execution[] memory result = new Execution[](executions.length);
    for (uint256 i = 0; i < executions.length; i++) {
        result[i] = executions[i];
    }
    return result;
}
```

## State Variable Reads

- **executions** (`struct Execution[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockHook.build(address,address,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: MockHook._buildHookExecutions(address,address,bytes) (NodeID: 1)
      💬 Args: [prevHook, account, hookData]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@dev Standard build pattern - MUST include preExecute first, postExecute last
 @inheritdoc ISuperHook

### Interface Documentation

@notice Builds the execution array for the hook operation
 @dev This is the core method where hooks define their on-chain interactions
      The returned executions are a sequence of contract calls to perform
      No state changes should occur in this method
 @param prevHook The address of the previous hook in the chain, or address(0) if first
 @param account The account to perform executions for (usually an ERC7579 account)
 @param data The hook-specific parameters and configuration data
 @return executions Array of Execution structs defining calls to make
