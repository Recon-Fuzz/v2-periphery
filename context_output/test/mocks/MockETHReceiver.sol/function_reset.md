# Function: reset()

**Contract**: [test/mocks/MockETHReceiver.sol/contract_MockETHReceiver.md]

## Metadata

- **Contract**: MockETHReceiver
- **Signature**: `reset()`
- **Visibility**: external
- **Source Range**: 5470:86:590

## Implementation

```solidity
/// @notice Reset counters for testing
function reset() external {
    totalReceived = 0;
    receiveCount = 0;
}
```

## State Variable Writes

- **totalReceived** (`uint256`)
- **receiveCount** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockETHReceiver.reset() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@notice Reset counters for testing
