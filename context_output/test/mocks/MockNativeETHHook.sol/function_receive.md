# Function: receive()

**Contract**: [test/mocks/MockNativeETHHook.sol/contract_MockNativeETHHook.md]

## Metadata

- **Contract**: MockNativeETHHook
- **Signature**: `receive()`
- **Visibility**: external
- **Source Range**: 6415:83:599

## Implementation

```solidity
/// @notice Allows the hook to receive ETH
receive() external payable {
    emit ETHReceived(msg.sender, msg.value);
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockNativeETHHook.receive() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@notice Allows the hook to receive ETH
