# Function: decimals()

**Contract**: [test/mocks/MockFeedWithRealData.sol/contract_MockFeedWithRealData.md]

## Metadata

- **Contract**: MockFeedWithRealData
- **Signature**: `decimals()`
- **Visibility**: external
- **Source Range**: 1075:112:592

## Implementation

```solidity
function decimals() external view returns (uint8) {
    return AggregatorV3Interface(feed).decimals();
}
```

## External Calls

- **AggregatorV3Interface::decimals()**

## State Variable Reads

- **feed** (`contract AggregatorV3Interface`) [src/vendor/chainlink/AggregatorV3Interface.sol/interface_AggregatorV3Interface.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockFeedWithRealData.decimals() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
