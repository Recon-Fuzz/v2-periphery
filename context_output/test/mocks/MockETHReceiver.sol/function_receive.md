# Function: receive()

**Contract**: [test/mocks/MockETHReceiver.sol/contract_MockETHReceiver.md]

## Metadata

- **Contract**: MockETHReceiver
- **Signature**: `receive()`
- **Visibility**: external
- **Source Range**: 5947:158:590

## Implementation

```solidity
/// @notice Allows the contract to receive ETH
receive() external payable {
    totalReceived += msg.value;
    receiveCount++;
    emit ETHReceived(msg.sender, msg.value, totalReceived);
}
```

## State Variable Reads

- **totalReceived** (`uint256`)

## State Variable Writes

- **totalReceived** (`uint256`)
- **receiveCount** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockETHReceiver.receive() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@notice Allows the contract to receive ETH
