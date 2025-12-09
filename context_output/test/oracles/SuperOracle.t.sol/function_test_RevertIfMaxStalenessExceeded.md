# Function: test_RevertIfMaxStalenessExceeded()

**Contract**: [test/oracles/SuperOracle.t.sol/contract_SuperOracleTest.md]

## Metadata

- **Contract**: SuperOracleTest
- **Signature**: `test_RevertIfMaxStalenessExceeded()`
- **Visibility**: public
- **Source Range**: 22000:348:624

## Implementation

```solidity
function test_RevertIfMaxStalenessExceeded() public {
    superOracle.setDefaultStaleness(12 hours);
    vm.expectRevert(ISuperOracle.MAX_STALENESS_EXCEEDED.selector);
    superOracle.setFeedMaxStaleness(address(mockFeed1), 1 days);
}
```

## External Calls

- **SuperOracle::setDefaultStaleness(uint256)**
- **Vm::expectRevert(bytes4)**
- **SuperOracle::setFeedMaxStaleness(address,uint256)**

## State Variable Reads

- **superOracle** (`contract SuperOracle`) [src/oracles/SuperOracle.sol/contract_SuperOracle.md]
- **mockFeed1** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleTest.test_RevertIfMaxStalenessExceeded() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
