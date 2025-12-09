# Function: simulateValidation(struct PackedUserOperation)

**Contract**: [lib/v2-core/src/paymaster/SuperNativePaymaster.sol/contract_SuperNativePaymaster.md]

## Metadata

- **Contract**: SuperNativePaymaster
- **Signature**: `simulateValidation(struct PackedUserOperation)`
- **Visibility**: external
- **Source Range**: 4682:489:436

## Implementation

```solidity
/// @notice Simulate the validation of a user operation.
///  @dev used by Bundler to validate a user operation before executing it.
///  @dev `EntryPointSimulations` is not deployed. This works only with an `eth_call` while changing
///       the bytecode of `EntryPoint` with the one from `EntryPointSimulations`.
///  @param op The user operation to simulate.
function simulateValidation(PackedUserOperation calldata op) external payable returns (IEntryPointSimulations.ValidationResult memory) {
    if (msg.value == 0) {
        revert EMPTY_MESSAGE_VALUE();
    }
    IEntryPointSimulations entryPointWithSimulations = _getEntryPointWithSimulations();
    entryPointWithSimulations.depositTo{value: msg.value}(address(this));
    return entryPointWithSimulations.simulateValidation(op);
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
- **IEntryPointSimulations::simulateValidation(struct PackedUserOperation)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperNativePaymaster.simulateValidation(struct PackedUserOperation) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: SuperNativePaymaster._getEntryPointWithSimulations() (NodeID: 1)
      💬 Args: [no args]
      👁️  Def: private
```

## Documentation

### Function Documentation

@notice Simulate the validation of a user operation.
 @dev used by Bundler to validate a user operation before executing it.
 @dev `EntryPointSimulations` is not deployed. This works only with an `eth_call` while changing
      the bytecode of `EntryPoint` with the one from `EntryPointSimulations`.
 @param op The user operation to simulate.
