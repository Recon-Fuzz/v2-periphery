# Function: test_RevertIfAllProvidersInvalid()

**Contract**: [test/oracles/SuperOracle.t.sol/contract_SuperOracleTest.md]

## Metadata

- **Contract**: SuperOracleTest
- **Signature**: `test_RevertIfAllProvidersInvalid()`
- **Visibility**: public
- **Source Range**: 22354:582:624

## Implementation

```solidity
function test_RevertIfAllProvidersInvalid() public {
    vm.warp(block.timestamp + 3 days);
    mockFeed1.setUpdatedAt(block.timestamp - 2 days);
    mockFeed2.setUpdatedAt(block.timestamp - 2 days);
    mockFeed3.setUpdatedAt(block.timestamp - 2 days);
    vm.expectRevert(ISuperOracle.NO_VALID_REPORTED_PRICES.selector);
    superOracle.getQuoteFromProvider(1e18, address(mockETH), address(mockUSD), AVERAGE_PROVIDER);
}
```

## External Calls

- **Vm::warp(uint256)**
- **MockAggregator::setUpdatedAt(uint256)**
- **Vm::expectRevert(bytes4)**
- **SuperOracle::getQuoteFromProvider(uint256,address,address,bytes32)**

## State Variable Reads

- **mockFeed1** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **mockFeed2** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **mockFeed3** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **superOracle** (`contract SuperOracle`) [src/oracles/SuperOracle.sol/contract_SuperOracle.md]
- **mockETH** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **mockUSD** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **AVERAGE_PROVIDER** (`bytes32`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleTest.test_RevertIfAllProvidersInvalid() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
