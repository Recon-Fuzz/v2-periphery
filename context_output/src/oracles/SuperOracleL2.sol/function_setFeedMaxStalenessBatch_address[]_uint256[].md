# Function: setFeedMaxStalenessBatch(address[],uint256[])

**Contract**: [src/oracles/SuperOracleL2.sol/contract_SuperOracleL2.md]

## Metadata

- **Contract**: SuperOracleL2
- **Signature**: `setFeedMaxStalenessBatch(address[],uint256[])`
- **Visibility**: external
- **Source Range**: 5198:518:535
- **Inherited From**: SuperOracleBase

## Implementation

```solidity
/// @inheritdoc ISuperOracle
function setFeedMaxStalenessBatch(address[] calldata feeds, uint256[] calldata newMaxStalenessList) external {
    if (msg.sender != SUPER_GOVERNOR) revert UNAUTHORIZED_UPDATE_AUTHORITY();
    uint256 length = feeds.length;
    if (length == 0) revert ZERO_ARRAY_LENGTH();
    if (length != newMaxStalenessList.length) {
        revert ARRAY_LENGTH_MISMATCH();
    }
    for (uint256 i; i < length; ++i) {
        _setFeedMaxStaleness(feeds[i], newMaxStalenessList[i]);
    }
}
```

## Related Implementations

### _setFeedMaxStaleness(address,uint256)

- **Kind**: internal
- **Source**: 13190:395:535
- **Link**: `src/oracles/SuperOracleBase.sol:SuperOracleBase:_setFeedMaxStaleness(address,uint256)`

```solidity
/// @notice Internal setter for feed-specific staleness limits
///  @param feed Oracle feed address
///  @param newMaxStaleness Maximum staleness in seconds (0 means use defaultStaleness)
///  @dev If newMaxStaleness > defaultStaleness, reverts with MAX_STALENESS_EXCEEDED.
///       Setting to 0 resets to defaultStaleness.
function _setFeedMaxStaleness(address feed, uint256 newMaxStaleness) internal {
    if (newMaxStaleness > defaultStaleness) {
        revert MAX_STALENESS_EXCEEDED();
    }
    if (newMaxStaleness == 0) {
        newMaxStaleness = defaultStaleness;
    }
    feedMaxStaleness[feed] = newMaxStaleness;
    emit FeedMaxStalenessUpdated(feed, newMaxStaleness);
}
```

## State Variable Reads

- **SUPER_GOVERNOR** (`address`)
- **defaultStaleness** (`uint256`)

## State Variable Writes

- **feedMaxStaleness** (`mapping(address => uint256)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleBase.setFeedMaxStalenessBatch(address[],uint256[]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: SuperOracleBase._setFeedMaxStaleness(address,uint256) (NodeID: 1)
      💬 Args: [feeds[i], newMaxStalenessList[i]]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc ISuperOracle

### Interface Documentation

@notice Set the maximum staleness period for multiple providers
 @param feeds Array of feed addresses
 @param newMaxStalenessList Array of new maximum staleness periods in seconds
