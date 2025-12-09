# Function: calcValidationGas(struct PackedUserOperation,bytes32,address,bytes)

**Contract**: [lib/v2-core/lib/modulekit/src/test/utils/gas/UserOpGasLog.sol/contract_UserOpGasLog.md]

## Metadata

- **Contract**: UserOpGasLog
- **Signature**: `calcValidationGas(struct PackedUserOperation,bytes32,address,bytes)`
- **Visibility**: external
- **Source Range**: 739:484:247

## Implementation

```solidity
function calcValidationGas(PackedUserOperation memory userOp, bytes32 userOpHash, address, bytes memory) external returns (uint256 gasValidation) {
    IEntryPointSimulations.ValidationResult memory validationResult = simulation.simulateValidation(userOp);
    gasValidation = validationResult.returnInfo.preOpGas;
    _log[userOpHash].gasValidation = gasValidation;
}
```

## External Calls

- **EntryPointSimulations::simulateValidation(struct PackedUserOperation)**

## State Variable Reads

- **simulation** (`contract EntryPointSimulations`) [lib/v2-core/lib/modulekit/node_modules/@ERC4337/account-abstraction/contracts/core/EntryPointSimulations.sol/contract_EntryPointSimulations.md]

## State Variable Writes

- **_log** (`mapping(bytes32 => struct UserOpGasLog.GasLog)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: UserOpGasLog.calcValidationGas(struct PackedUserOperation,bytes32,address,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
