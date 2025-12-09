# Function: executeWithData(bytes)

**Contract**: [test/mocks/MockETHReceiver.sol/contract_MockETHReceiver.md]

## Metadata

- **Contract**: MockETHReceiver
- **Signature**: `executeWithData(bytes)`
- **Visibility**: external
- **Source Range**: 5198:223:590

## Implementation

```solidity
/// @notice Execute function with data parameter
function executeWithData(bytes calldata) external payable {
    emit ExecuteCalled(msg.sender, msg.value);
    if (msg.value > 0) {
        totalReceived += msg.value;
        receiveCount++;
    }
}
```

## State Variable Writes

- **totalReceived** (`uint256`)
- **receiveCount** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockETHReceiver.executeWithData(bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@notice Execute function with data parameter
