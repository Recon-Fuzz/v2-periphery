# Function: decimals()

**Contract**: [test/mocks/MockAggregator.sol/contract_MockAggregator.md]

## Metadata

- **Contract**: MockAggregator
- **Signature**: `decimals()`
- **Visibility**: external
- **Source Range**: 643:83:586

## Implementation

```solidity
function decimals() external view returns (uint8) {
    return _decimals;
}
```

## State Variable Reads

- **_decimals** (`uint8`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockAggregator.decimals() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
