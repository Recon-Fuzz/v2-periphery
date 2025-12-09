# Contract: ModuleKitLogs

## Metadata

- **Name**: ModuleKitLogs
- **Type**: Contract
- **Path**: lib/v2-core/lib/modulekit/src/test/utils/Log.sol

## Events

### ModuleKit_NewAccount

```solidity
event ModuleKit_NewAccount(address account, string accountType);
```

### ModuleKit_Exec4337

```solidity
event ModuleKit_Exec4337(address sender);
```

### ModuleKit_AddExecutor

```solidity
event ModuleKit_AddExecutor(address account, address executor);
```

### ModuleKit_RemoveExecutor

```solidity
event ModuleKit_RemoveExecutor(address account, address executor);
```

### ModuleKit_AddValidator

```solidity
event ModuleKit_AddValidator(address account, address validator);
```

### ModuleKit_RemoveValidator

```solidity
event ModuleKit_RemoveValidator(address account, address validator);
```

### ModuleKit_SetFallback

```solidity
event ModuleKit_SetFallback(address account, bytes4 functionSig, address handler);
```

### ModuleKit_SetCondition

```solidity
event ModuleKit_SetCondition(address account, address executor);
```
