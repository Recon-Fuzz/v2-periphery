# Function: constructor(int256,uint8)

**Contract**: [test/mocks/MockAggregator.sol/contract_MockAggregator.md]

## Metadata

- **Contract**: MockAggregator
- **Signature**: `constructor(int256,uint8)`
- **Visibility**: public
- **Source Range**: 308:148:586

## Implementation

```solidity
constructor(int256 answer_, uint8 decimals_) {
    _answer = answer_;
    _decimals = decimals_;
    _updatedAt = block.timestamp;
}
```

## State Variable Writes

- **_answer** (`int256`)
- **_decimals** (`uint8`)
- **_updatedAt** (`uint256`)

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: MockAggregator.constructor(int256,uint8) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: MockAggregator
```
