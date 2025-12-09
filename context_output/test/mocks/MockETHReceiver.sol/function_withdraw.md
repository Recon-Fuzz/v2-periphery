# Function: withdraw()

**Contract**: [test/mocks/MockETHReceiver.sol/contract_MockETHReceiver.md]

## Metadata

- **Contract**: MockETHReceiver
- **Signature**: `withdraw()`
- **Visibility**: external
- **Source Range**: 5609:97:590

## Implementation

```solidity
/// @notice Withdraw all ETH (for cleanup)
function withdraw() external {
    payable(msg.sender).transfer(address(this).balance);
}
```

## Native Transfers

- **unknown** (computed)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockETHReceiver.withdraw() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@notice Withdraw all ETH (for cleanup)
