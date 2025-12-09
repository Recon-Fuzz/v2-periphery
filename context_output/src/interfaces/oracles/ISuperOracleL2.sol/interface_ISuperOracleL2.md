# Interface: ISuperOracleL2

## Metadata

- **Name**: ISuperOracleL2
- **Type**: Interface
- **Path**: src/interfaces/oracles/ISuperOracleL2.sol
- **Documentation**: @title ISuperOracleL2
   @author Superform Labs
   @notice Interface for Layer 2 Oracle for Superform

## Errors

### NO_UPTIME_FEED

```solidity
/// @notice Error when no uptime feed is configured for the data oracle
error NO_UPTIME_FEED();
```

### SEQUENCER_DOWN

```solidity
/// @notice Error when the L2 sequencer is down
error SEQUENCER_DOWN();
```

### GRACE_PERIOD_NOT_OVER

```solidity
/// @notice Error when the grace period after sequencer restart is not over
error GRACE_PERIOD_NOT_OVER();
```

### GRACE_PERIOD_TOO_LOW

```solidity
/// @notice Error when the grace period after sequencer restart is too low
error GRACE_PERIOD_TOO_LOW();
```

## Events

### UptimeFeedSet

```solidity
/// @notice Emitted when an uptime feed is set for a data oracle
///  @param dataOracle The data oracle address
///  @param uptimeOracle The uptime feed address
event UptimeFeedSet(address dataOracle, address uptimeOracle);
```

### GracePeriodSet

```solidity
/// @notice Emitted when a grace period is set for an uptime oracle
///  @param uptimeOracle The uptime oracle address
///  @param gracePeriod The grace period in seconds
event GracePeriodSet(address uptimeOracle, uint256 gracePeriod);
```

## Public/External Functions

### batchSetUptimeFeed(address[],address[],uint256[])

- **Signature**: `batchSetUptimeFeed(address[],address[],uint256[])`
- **Visibility**: external
- **Source Range**: 1943:174:525

**Signature:**
```solidity
/// @notice Set uptime feeds for multiple data oracles in batch
///  @param dataOracles Array of data oracle addresses to set uptime feeds for
///  @param uptimeOracles Array of uptime feed addresses to set
///  @param gracePeriods Array of grace periods in seconds after sequencer restart
function batchSetUptimeFeed(address[] calldata dataOracles, address[] calldata uptimeOracles, uint256[] calldata gracePeriods) external;;
```
