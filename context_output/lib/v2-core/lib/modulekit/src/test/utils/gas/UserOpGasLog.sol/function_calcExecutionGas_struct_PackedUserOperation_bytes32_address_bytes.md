# Function: calcExecutionGas(struct PackedUserOperation,bytes32,address,bytes)

**Contract**: [lib/v2-core/lib/modulekit/src/test/utils/gas/UserOpGasLog.sol/contract_UserOpGasLog.md]

## Metadata

- **Contract**: UserOpGasLog
- **Signature**: `calcExecutionGas(struct PackedUserOperation,bytes32,address,bytes)`
- **Visibility**: external
- **Source Range**: 1229:610:247

## Implementation

```solidity
function calcExecutionGas(PackedUserOperation memory userOp, bytes32 userOpHash, address sender, bytes memory initCode) external returns (uint256 gasExecution) {
    IEntryPointSimulations.ExecutionResult memory executionResult = simulation.simulateHandleOp(userOp, sender, initCode);
    gasExecution = executionResult.paid;
    _log[userOpHash].gasExecution = gasExecution;
}
```

## External Calls

- **EntryPointSimulations::simulateHandleOp(struct PackedUserOperation,address,bytes)**

## State Variable Reads

- **simulation** (`contract EntryPointSimulations`) [lib/v2-core/lib/modulekit/node_modules/@ERC4337/account-abstraction/contracts/core/EntryPointSimulations.sol/contract_EntryPointSimulations.md]

## State Variable Writes

- **_log** (`mapping(bytes32 => struct UserOpGasLog.GasLog)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: UserOpGasLog.calcExecutionGas(struct PackedUserOperation,bytes32,address,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
