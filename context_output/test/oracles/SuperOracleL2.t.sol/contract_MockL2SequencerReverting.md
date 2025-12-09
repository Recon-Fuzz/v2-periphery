# Contract: MockL2SequencerReverting

## Metadata

- **Name**: MockL2SequencerReverting
- **Type**: Contract
- **Path**: test/oracles/SuperOracleL2.t.sol
- **Documentation**: @notice Mock L2 sequencer that reverts on latestRoundData() call

## Public/External Functions

### latestRoundData()

- **Signature**: `latestRoundData()`
- **Visibility**: external
- **Source Range**: 78410:142:625
- **Details**: [function_latestRoundData.md](./function_latestRoundData.md)

**Signature:**
```solidity
function latestRoundData() external pure returns (uint80, int256, uint256, uint256, uint80);
```
