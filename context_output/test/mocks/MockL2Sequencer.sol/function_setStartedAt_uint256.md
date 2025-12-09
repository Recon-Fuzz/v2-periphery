# Function: setStartedAt(uint256)

**Contract**: [test/mocks/MockL2Sequencer.sol/contract_MockL2Sequencer.md]

## Metadata

- **Contract**: MockL2Sequencer
- **Signature**: `setStartedAt(uint256)`
- **Visibility**: external
- **Source Range**: 515:89:596

## Implementation

```solidity
function setStartedAt(uint256 startedAt) external {
    _startedAt = startedAt;
}
```

## State Variable Writes

- **_startedAt** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockL2Sequencer.setStartedAt(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
