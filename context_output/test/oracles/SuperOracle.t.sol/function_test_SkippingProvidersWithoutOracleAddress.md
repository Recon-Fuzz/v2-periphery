# Function: test_SkippingProvidersWithoutOracleAddress()

**Contract**: [test/oracles/SuperOracle.t.sol/contract_SuperOracleTest.md]

## Metadata

- **Contract**: SuperOracleTest
- **Signature**: `test_SkippingProvidersWithoutOracleAddress()`
- **Visibility**: public
- **Source Range**: 34848:3068:624

## Implementation

```solidity
function test_SkippingProvidersWithoutOracleAddress() public {
    address[] memory bases = new address[](1);
    bases[0] = address(mockBTC);
    address[] memory quotes = new address[](1);
    quotes[0] = address(mockUSD);
    bytes32[] memory providers = new bytes32[](1);
    bytes32 BTC_ONLY_PROVIDER = bytes32(keccak256("BTC_ONLY_PROVIDER"));
    providers[0] = BTC_ONLY_PROVIDER;
    address[] memory feeds = new address[](1);
    feeds[0] = address(mockFeed4);
    superOracle.queueOracleUpdate(bases, quotes, providers, feeds);
    vm.warp((block.timestamp + 1 weeks) + 1 seconds);
    mockFeed4.setUpdatedAt(block.timestamp);
    superOracle.executeOracleUpdate();
    bytes32[] memory activeProviders = superOracle.getActiveProviders();
    assertEq(activeProviders.length, 4, "Should have 4 active providers");
    mockFeed1.setUpdatedAt(block.timestamp);
    mockFeed2.setUpdatedAt(block.timestamp);
    mockFeed3.setUpdatedAt(block.timestamp);
    (uint256 quoteAmount, , uint256 totalProviders, uint256 availableProviders) = superOracle.getQuoteFromProvider(1e18, address(mockETH), address(mockUSD), AVERAGE_PROVIDER);
    assertEq(totalProviders, 3, "Total providers should be 3");
    assertEq(availableProviders, 3, "Only 3 providers should be available for ETH/USD");
    assertEq(quoteAmount, 1e6, "Average quote should still be $1000 from the 3 ETH/USD providers");
    (uint256 btcQuoteAmount, , uint256 btcTotalProviders, uint256 btcAvailableProviders) = superOracle.getQuoteFromProvider(1e8, address(mockBTC), address(mockUSD), AVERAGE_PROVIDER);
    assertEq(btcTotalProviders, 1, "Total providers should be 1");
    assertEq(btcAvailableProviders, 1, "Only 1 provider should be available for BTC/USD");
    assertEq(btcQuoteAmount, 2e6, "Quote should be $20000 from the only BTC/USD provider");
}
```

## Related Implementations

### assertEq(uint256,uint256,string)

- **Kind**: internal
- **Source**: 2823:177:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256,string)`

```solidity
function assertEq(uint256 left, uint256 right, string memory err) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right, err);
    }
}
```

## External Calls

- **SuperOracle::queueOracleUpdate(address[],address[],bytes32[],address[])**
- **Vm::warp(uint256)**
- **MockAggregator::setUpdatedAt(uint256)**
- **SuperOracle::executeOracleUpdate()**
- **SuperOracle::getActiveProviders()**
- **SuperOracle::getQuoteFromProvider(uint256,address,address,bytes32)**

## State Variable Reads

- **mockBTC** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **mockUSD** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **mockFeed4** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **superOracle** (`contract SuperOracle`) [src/oracles/SuperOracle.sol/contract_SuperOracle.md]
- **mockFeed1** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **mockFeed2** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **mockFeed3** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **mockETH** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **AVERAGE_PROVIDER** (`bytes32`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleTest.test_SkippingProvidersWithoutOracleAddress() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [activeProviders.length, 4, "Should have 4 active providers"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
  │   💬 Args: [totalProviders, 3, "Total providers should be 3"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 3)
  │   💬 Args: [availableProviders, 3, "Only 3 providers should be available for ETH/USD"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 4)
  │   💬 Args: [quoteAmount, 1e6, "Average quote should still be $1000 from the 3 ETH/USD providers"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 5)
  │   💬 Args: [btcTotalProviders, 1, "Total providers should be 1"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 6)
  │   💬 Args: [btcAvailableProviders, 1, "Only 1 provider should be available for BTC/USD"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 7)
      💬 Args: [btcQuoteAmount, 2e6, "Quote should be $20000 from the only BTC/USD provider"]
      👁️  Def: internal
```
