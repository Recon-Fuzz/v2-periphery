# Function: getLog(bytes32)

**Contract**: [lib/v2-core/lib/modulekit/src/test/utils/gas/UserOpGasLog.sol/contract_UserOpGasLog.md]

## Metadata

- **Contract**: UserOpGasLog
- **Signature**: `getLog(bytes32)`
- **Visibility**: external
- **Source Range**: 494:239:247

## Implementation

```solidity
function getLog(bytes32 userOpHash) external view returns (uint256 gasValidation, uint256 gasExecution) {
    GasLog memory log = _log[userOpHash];
    return (log.gasValidation, log.gasExecution);
}
```

## State Variable Reads

- **_log** (`mapping(bytes32 => struct UserOpGasLog.GasLog)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: UserOpGasLog.getLog(bytes32) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
