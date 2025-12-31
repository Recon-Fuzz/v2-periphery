# Function: batchSetUptimeFeed(address[],address[],uint256[])

**Contract**: [src/oracles/SuperOracleL2.sol/contract_SuperOracleL2.md]

## Metadata

- **Contract**: SuperOracleL2
- **Signature**: `batchSetUptimeFeed(address[],address[],uint256[])`
- **Visibility**: external
- **Source Range**: 2047:1152:536

## Implementation

```solidity
/// @inheritdoc ISuperOracleL2
function batchSetUptimeFeed(address[] calldata dataOracles, address[] calldata uptimeOracles, uint256[] calldata gracePeriods_) override external {
    if (msg.sender != SUPER_GOVERNOR) revert UNAUTHORIZED_UPDATE_AUTHORITY();
    uint256 length = dataOracles.length;
    if (length == 0) revert ZERO_ARRAY_LENGTH();
    if ((length != uptimeOracles.length) || (length != gracePeriods_.length)) {
        revert ARRAY_LENGTH_MISMATCH();
    }
    for (uint256 i; i < length; ++i) {
        address dataOracle = dataOracles[i];
        address uptimeOracle = uptimeOracles[i];
        uint256 gracePeriod = gracePeriods_[i];
        if ((gracePeriod != 0) && (gracePeriod < MIN_GRACE_PERIOD_TIME)) revert GRACE_PERIOD_TOO_LOW();
        if ((dataOracle == address(0)) || (uptimeOracle == address(0))) revert ZERO_ADDRESS();
        uptimeFeeds[dataOracle] = uptimeOracle;
        gracePeriods[uptimeOracle] = gracePeriod;
        emit UptimeFeedSet(dataOracle, uptimeOracle);
        emit GracePeriodSet(uptimeOracle, gracePeriod);
    }
}
```

## State Variable Reads

- **MIN_GRACE_PERIOD_TIME** (`uint256`)

## State Variable Writes

- **uptimeFeeds** (`mapping(address => address)`)
- **gracePeriods** (`mapping(address => uint256)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleL2.batchSetUptimeFeed(address[],address[],uint256[]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperOracleL2

### Interface Documentation

@notice Set uptime feeds for multiple data oracles in batch
 @param dataOracles Array of data oracle addresses to set uptime feeds for
 @param uptimeOracles Array of uptime feed addresses to set
 @param gracePeriods Array of grace periods in seconds after sequencer restart
