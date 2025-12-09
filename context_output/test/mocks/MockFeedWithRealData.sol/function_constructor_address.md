# Function: constructor(address)

**Contract**: [test/mocks/MockFeedWithRealData.sol/contract_MockFeedWithRealData.md]

## Metadata

- **Contract**: MockFeedWithRealData
- **Signature**: `constructor(address)`
- **Visibility**: public
- **Source Range**: 574:79:592

## Implementation

```solidity
constructor(address feed_) {
    feed = AggregatorV3Interface(feed_);
}
```

## State Variable Writes

- **feed** (`contract AggregatorV3Interface`) [src/vendor/chainlink/AggregatorV3Interface.sol/interface_AggregatorV3Interface.md]

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: MockFeedWithRealData.constructor(address) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: MockFeedWithRealData
```
