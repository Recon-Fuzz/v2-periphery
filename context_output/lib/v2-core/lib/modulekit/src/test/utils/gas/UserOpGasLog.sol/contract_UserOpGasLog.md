# Contract: UserOpGasLog

## Metadata

- **Name**: UserOpGasLog
- **Type**: Contract
- **Path**: lib/v2-core/lib/modulekit/src/test/utils/gas/UserOpGasLog.sol

## State Variables

### simulation

```solidity
EntryPointSimulations public immutable simulation = new EntryPointSimulations()
```

**EntryPointSimulations**: [lib/v2-core/lib/modulekit/node_modules/@ERC4337/account-abstraction/contracts/core/EntryPointSimulations.sol/contract_EntryPointSimulations.md]

### _log

```solidity
mapping(bytes32 => GasLog) internal _log
```

## Structs

### GasLog

```solidity
struct GasLog {
    uint256 gasValidation;
    uint256 gasExecution;
}
```

## Public/External Functions

### getLog(bytes32)

- **Signature**: `getLog(bytes32)`
- **Visibility**: external
- **Source Range**: 494:239:247
- **Details**: [function_getLog_bytes32.md](./function_getLog_bytes32.md)

**Signature:**
```solidity
function getLog(bytes32 userOpHash) external view returns (uint256 gasValidation, uint256 gasExecution);
```

### calcValidationGas(struct PackedUserOperation,bytes32,address,bytes)

- **Signature**: `calcValidationGas(struct PackedUserOperation,bytes32,address,bytes)`
- **Visibility**: external
- **Source Range**: 739:484:247
- **Details**: [function_calcValidationGas_struct_PackedUserOperation_bytes32_address_bytes.md](./function_calcValidationGas_struct_PackedUserOperation_bytes32_address_bytes.md)

**Signature:**
```solidity
function calcValidationGas(PackedUserOperation memory userOp, bytes32 userOpHash, address, bytes memory) external returns (uint256 gasValidation);
```

### calcExecutionGas(struct PackedUserOperation,bytes32,address,bytes)

- **Signature**: `calcExecutionGas(struct PackedUserOperation,bytes32,address,bytes)`
- **Visibility**: external
- **Source Range**: 1229:610:247
- **Details**: [function_calcExecutionGas_struct_PackedUserOperation_bytes32_address_bytes.md](./function_calcExecutionGas_struct_PackedUserOperation_bytes32_address_bytes.md)

**Signature:**
```solidity
function calcExecutionGas(PackedUserOperation memory userOp, bytes32 userOpHash, address sender, bytes memory initCode) external returns (uint256 gasExecution);
```
