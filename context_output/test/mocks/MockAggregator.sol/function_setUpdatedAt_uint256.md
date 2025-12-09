# Function: setUpdatedAt(uint256)

**Contract**: [test/mocks/MockAggregator.sol/contract_MockAggregator.md]

## Metadata

- **Contract**: MockAggregator
- **Signature**: `setUpdatedAt(uint256)`
- **Visibility**: external
- **Source Range**: 546:91:586

## Implementation

```solidity
function setUpdatedAt(uint256 updatedAt_) external {
    _updatedAt = updatedAt_;
}
```

## State Variable Writes

- **_updatedAt** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockAggregator.setUpdatedAt(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
