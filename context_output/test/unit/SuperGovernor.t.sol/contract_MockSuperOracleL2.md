# Contract: MockSuperOracleL2

## Metadata

- **Name**: MockSuperOracleL2
- **Type**: Contract
- **Path**: test/unit/SuperGovernor.t.sol
- **Documentation**: @notice Mock SuperOracleL2 for testing batchSetOracleUptimeFeed delegation

## State Variables

### _batchSetUptimeFeedCalled

```solidity
bool private _batchSetUptimeFeedCalled
```

## Public/External Functions

### batchSetUptimeFeed(address[],address[],uint256[])

- **Signature**: `batchSetUptimeFeed(address[],address[],uint256[])`
- **Visibility**: external
- **Source Range**: 136244:146:659
- **Details**: [function_batchSetUptimeFeed_address[]_address[]_uint256[].md](./function_batchSetUptimeFeed_address[]_address[]_uint256[].md)

**Signature:**
```solidity
function batchSetUptimeFeed(address[] calldata, address[] calldata, uint256[] calldata) external;
```

### batchSetUptimeFeedCalled()

- **Signature**: `batchSetUptimeFeedCalled()`
- **Visibility**: external
- **Source Range**: 136396:114:659
- **Details**: [function_batchSetUptimeFeedCalled.md](./function_batchSetUptimeFeedCalled.md)

**Signature:**
```solidity
function batchSetUptimeFeedCalled() external view returns (bool);
```
