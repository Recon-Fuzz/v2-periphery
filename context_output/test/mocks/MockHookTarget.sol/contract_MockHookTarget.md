# Contract: MockHookTarget

## Metadata

- **Name**: MockHookTarget
- **Type**: Contract
- **Path**: test/mocks/MockHookTarget.sol
- **Documentation**: @notice Mock contract to be targeted by hooks during testing

## State Variables

### shouldFailExecution

```solidity
bool public shouldFailExecution
```

## Events

### Executed

```solidity
event Executed();
```

### ExecutedWithData

```solidity
event ExecutedWithData(bytes data);
```

## Public/External Functions

### setShouldFailExecution(bool)

- **Signature**: `setShouldFailExecution(bool)`
- **Visibility**: external
- **Source Range**: 316:109:594
- **Details**: [function_setShouldFailExecution_bool.md](./function_setShouldFailExecution_bool.md)

**Signature:**
```solidity
function setShouldFailExecution(bool _shouldFail) external;
```

### execute()

- **Signature**: `execute()`
- **Visibility**: external
- **Source Range**: 431:161:594
- **Details**: [function_execute.md](./function_execute.md)

**Signature:**
```solidity
function execute() external;
```

### executeWithData(bytes)

- **Signature**: `executeWithData(bytes)`
- **Visibility**: external
- **Source Range**: 598:200:594
- **Details**: [function_executeWithData_bytes.md](./function_executeWithData_bytes.md)

**Signature:**
```solidity
function executeWithData(bytes calldata data) external;
```

### fallback()

- **Signature**: `fallback()`
- **Visibility**: external
- **Source Range**: 849:162:594
- **Details**: [function_fallback.md](./function_fallback.md)

**Signature:**
```solidity
fallback() external;
```

### receive()

- **Signature**: `receive()`
- **Visibility**: external
- **Source Range**: 1044:30:594
- **Details**: [function_receive.md](./function_receive.md)

**Signature:**
```solidity
receive() external payable;
```
