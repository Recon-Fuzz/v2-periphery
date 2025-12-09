# Contract: MockL2SequencerGasConsumer

## Metadata

- **Name**: MockL2SequencerGasConsumer
- **Type**: Contract
- **Path**: test/oracles/SuperOracleL2.t.sol
- **Documentation**: @notice Mock L2 sequencer that consumes most gas before reverting
   @dev Used to test the INSUFFICIENT_GAS_FOR_EXTERNAL_CALL path with revertOnError=false

## Public/External Functions

### latestRoundData()

- **Signature**: `latestRoundData()`
- **Visibility**: external
- **Source Range**: 80195:642:625
- **Details**: [function_latestRoundData.md](./function_latestRoundData.md)

**Signature:**
```solidity
function latestRoundData() external view returns (uint80, int256, uint256, uint256, uint80);
```
