# Function: test_RevertIfAverageProvider()

**Contract**: [test/oracles/SuperOracle.t.sol/contract_SuperOracleTest.md]

## Metadata

- **Contract**: SuperOracleTest
- **Signature**: `test_RevertIfAverageProvider()`
- **Visibility**: public
- **Source Range**: 20274:667:624

## Implementation

```solidity
function test_RevertIfAverageProvider() public {
    address[] memory bases = new address[](1);
    bases[0] = address(mockBTC);
    address[] memory quotes = new address[](1);
    quotes[0] = address(mockUSD);
    bytes32[] memory providers = new bytes32[](1);
    providers[0] = AVERAGE_PROVIDER;
    address[] memory feeds = new address[](1);
    feeds[0] = address(mockFeed4);
    vm.expectRevert(ISuperOracle.AVERAGE_PROVIDER_NOT_ALLOWED.selector);
    superOracle.queueOracleUpdate(bases, quotes, providers, feeds);
}
```

## External Calls

- **Vm::expectRevert(bytes4)**
- **SuperOracle::queueOracleUpdate(address[],address[],bytes32[],address[])**

## State Variable Reads

- **mockBTC** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **mockUSD** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **AVERAGE_PROVIDER** (`bytes32`)
- **mockFeed4** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **superOracle** (`contract SuperOracle`) [src/oracles/SuperOracle.sol/contract_SuperOracle.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleTest.test_RevertIfAverageProvider() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
