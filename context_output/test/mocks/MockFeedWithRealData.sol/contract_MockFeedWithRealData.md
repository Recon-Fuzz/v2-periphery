# Contract: MockFeedWithRealData

## Metadata

- **Name**: MockFeedWithRealData
- **Type**: Contract
- **Path**: test/mocks/MockFeedWithRealData.sol
- **Documentation**: @dev the purpose of this contract is to mock a feed with real data
        it sets data to the latest round data of a chainlink feed
        but updates `updatedAt` to a specified timestamp.
        Reason is to continue forking and `vm.warp` calls without
        the feed being considered stale

## State Variables

### feed

```solidity
AggregatorV3Interface public feed
```

**AggregatorV3Interface**: [src/vendor/chainlink/AggregatorV3Interface.sol/interface_AggregatorV3Interface.md]

## Public/External Functions

### constructor(address)

- **Signature**: `constructor(address)`
- **Visibility**: public
- **Source Range**: 574:79:592
- **Details**: [function_constructor_address.md](./function_constructor_address.md)

**Signature:**
```solidity
constructor(address feed_);
```

### latestRoundData()

- **Signature**: `latestRoundData()`
- **Visibility**: external
- **Source Range**: 659:410:592
- **Details**: [function_latestRoundData.md](./function_latestRoundData.md)

**Signature:**
```solidity
function latestRoundData() external view returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound);
```

### decimals()

- **Signature**: `decimals()`
- **Visibility**: external
- **Source Range**: 1075:112:592
- **Details**: [function_decimals.md](./function_decimals.md)

**Signature:**
```solidity
function decimals() external view returns (uint8);
```
