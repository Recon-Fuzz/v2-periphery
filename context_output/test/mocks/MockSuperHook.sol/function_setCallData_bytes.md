# Function: setCallData(bytes)

**Contract**: [test/mocks/MockSuperHook.sol/contract_MockSuperHook.md]

## Metadata

- **Contract**: MockSuperHook
- **Signature**: `setCallData(bytes)`
- **Visibility**: external
- **Source Range**: 1219:101:604

## Implementation

```solidity
function setCallData(bytes calldata _callData) external {
    callDataToReturn = _callData;
}
```

## State Variable Writes

- **callDataToReturn** (`bytes`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockSuperHook.setCallData(bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
