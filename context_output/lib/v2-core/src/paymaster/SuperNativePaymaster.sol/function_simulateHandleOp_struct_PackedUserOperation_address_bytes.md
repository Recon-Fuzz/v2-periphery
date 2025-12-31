# Function: simulateHandleOp(struct PackedUserOperation,address,bytes)

**Contract**: [lib/v2-core/src/paymaster/SuperNativePaymaster.sol/contract_SuperNativePaymaster.md]

## Metadata

- **Contract**: SuperNativePaymaster
- **Signature**: `simulateHandleOp(struct PackedUserOperation,address,bytes)`
- **Visibility**: external
- **Source Range**: 3724:573:436

## Implementation

```solidity
/// @notice Simulate the handling of a user operation.
///  @dev used by Bundler to validate a user operation before executing it.
///  @dev `EntryPointSimulations` is not deployed. This works only with an `eth_call` while changing
///       the bytecode of `EntryPoint` with the one from `EntryPointSimulations`.
///  @param op The user operation to simulate.
///  @param target The target address of the user operation.
///  @param callData The call data for the user operation.
function simulateHandleOp(PackedUserOperation calldata op, address target, bytes calldata callData) external payable returns (IEntryPointSimulations.ExecutionResult memory) {
    if (msg.value == 0) {
        revert EMPTY_MESSAGE_VALUE();
    }
    IEntryPointSimulations entryPointWithSimulations = _getEntryPointWithSimulations();
    entryPointWithSimulations.depositTo{value: msg.value}(address(this));
    return entryPointWithSimulations.simulateHandleOp(op, target, callData);
}
```

## Related Implementations

### _getEntryPointWithSimulations()

- **Kind**: internal
- **Source**: 8222:154:436
- **Link**: `lib/v2-core/src/paymaster/SuperNativePaymaster.sol:SuperNativePaymaster:_getEntryPointWithSimulations()`

```solidity
function _getEntryPointWithSimulations() private view returns (IEntryPointSimulations) {
    return IEntryPointSimulations(address(entryPoint));
}
```

## External Calls

- **unknown::unknown**
- **IEntryPointSimulations::simulateHandleOp(struct PackedUserOperation,address,bytes)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperNativePaymaster.simulateHandleOp(struct PackedUserOperation,address,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: SuperNativePaymaster._getEntryPointWithSimulations() (NodeID: 1)
      💬 Args: [no args]
      👁️  Def: private
```

## Documentation

### Function Documentation

@notice Simulate the handling of a user operation.
 @dev used by Bundler to validate a user operation before executing it.
 @dev `EntryPointSimulations` is not deployed. This works only with an `eth_call` while changing
      the bytecode of `EntryPoint` with the one from `EntryPointSimulations`.
 @param op The user operation to simulate.
 @param target The target address of the user operation.
 @param callData The call data for the user operation.
