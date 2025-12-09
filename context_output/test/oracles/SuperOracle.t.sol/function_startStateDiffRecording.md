# Function: startStateDiffRecording()

**Contract**: [test/oracles/SuperOracle.t.sol/contract_SuperOracleTest.md]

## Metadata

- **Contract**: SuperOracleTest
- **Signature**: `startStateDiffRecording()`
- **Visibility**: public
- **Source Range**: 4253:96:500
- **Inherited From**: Helpers

## Implementation

```solidity
function startStateDiffRecording() public {
    Vm(VM_ADDR).startStateDiffRecording();
}
```

## External Calls

- **Vm::startStateDiffRecording()**

## State Variable Reads

- **VM_ADDR** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Helpers.startStateDiffRecording() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
