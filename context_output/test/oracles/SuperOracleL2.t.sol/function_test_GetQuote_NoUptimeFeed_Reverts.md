# Function: test_GetQuote_NoUptimeFeed_Reverts()

**Contract**: [test/oracles/SuperOracleL2.t.sol/contract_SuperOracleL2Test.md]

## Metadata

- **Contract**: SuperOracleL2Test
- **Signature**: `test_GetQuote_NoUptimeFeed_Reverts()`
- **Visibility**: public
- **Source Range**: 21393:1158:625

## Implementation

```solidity
function test_GetQuote_NoUptimeFeed_Reverts() public {
    MockAggregator newDataFeed = new MockAggregator(int256(INITIAL_PRICE), uint8(PRICE_DECIMALS));
    address[] memory bases = new address[](1);
    address[] memory quotes = new address[](1);
    bytes32[] memory providers = new bytes32[](1);
    address[] memory feeds = new address[](1);
    bases[0] = address(baseToken);
    quotes[0] = address(quoteToken);
    providers[0] = keccak256("NEW_PROVIDER");
    feeds[0] = address(newDataFeed);
    oracle.queueOracleUpdate(bases, quotes, providers, feeds);
    vm.warp(block.timestamp + 7 days);
    oracle.executeOracleUpdate();
    bytes memory encodedError = abi.encodeWithSelector(ISuperOracleL2.NO_UPTIME_FEED.selector);
    vm.expectRevert(encodedError);
    oracle.getQuoteFromProvider(1 * (10 ** 15), address(baseToken), address(quoteToken), keccak256("NEW_PROVIDER"));
}
```

## External Calls

- **SuperOracleL2::queueOracleUpdate(address[],address[],bytes32[],address[])**
- **Vm::warp(uint256)**
- **SuperOracleL2::executeOracleUpdate()**
- **Vm::expectRevert(bytes)**
- **SuperOracleL2::getQuoteFromProvider(uint256,address,address,bytes32)**

## State Variable Reads

- **INITIAL_PRICE** (`uint256`)
- **PRICE_DECIMALS** (`uint256`)
- **baseToken** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **quoteToken** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **oracle** (`contract SuperOracleL2`) [src/oracles/SuperOracleL2.sol/contract_SuperOracleL2.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleL2Test.test_GetQuote_NoUptimeFeed_Reverts() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
