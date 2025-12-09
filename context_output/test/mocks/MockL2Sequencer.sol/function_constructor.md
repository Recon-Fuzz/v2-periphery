# Function: constructor()

**Contract**: [test/mocks/MockL2Sequencer.sol/contract_MockL2Sequencer.md]

## Metadata

- **Contract**: MockL2Sequencer
- **Signature**: `constructor()`
- **Visibility**: public
- **Source Range**: 311:110:596

## Implementation

```solidity
constructor() {
    _answer = 0;
    _startedAt = block.timestamp;
}
```

## State Variable Writes

- **_answer** (`int256`)
- **_startedAt** (`uint256`)

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: MockL2Sequencer.constructor() (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: MockL2Sequencer
```
