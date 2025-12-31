# Interface: IAggregationExecutor

## Metadata

- **Name**: IAggregationExecutor
- **Type**: Interface
- **Path**: lib/v2-core/src/vendor/1inch/I1InchAggregationRouterV6.sol

## Public/External Functions

### execute(address)

- **Signature**: `execute(address)`
- **Visibility**: external
- **Source Range**: 9570:71:440

**Signature:**
```solidity
/// @notice propagates information about original msg.sender and executes arbitrary data
function execute(address msgSender) external payable returns (uint256);;
```
