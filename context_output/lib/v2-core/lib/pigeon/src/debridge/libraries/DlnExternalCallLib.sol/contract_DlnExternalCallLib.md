# Contract: DlnExternalCallLib

## Metadata

- **Name**: DlnExternalCallLib
- **Type**: Contract
- **Path**: lib/v2-core/lib/pigeon/src/debridge/libraries/DlnExternalCallLib.sol

## Structs

### ExternalCallEnvelopV1

```solidity
struct ExternalCallEnvelopV1 {
    address fallbackAddress;
    address executorAddress;
    uint160 executionFee;
    bool allowDelayedExecution;
    bool requireSuccessfullExecution;
    bytes payload;
}
```

### ExternalCallPayload

```solidity
struct ExternalCallPayload {
    address to;
    uint32 txGas;
    bytes callData;
}
```
