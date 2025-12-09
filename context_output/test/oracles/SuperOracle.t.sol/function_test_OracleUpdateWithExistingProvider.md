# Function: test_OracleUpdateWithExistingProvider()

**Contract**: [test/oracles/SuperOracle.t.sol/contract_SuperOracleTest.md]

## Metadata

- **Contract**: SuperOracleTest
- **Signature**: `test_OracleUpdateWithExistingProvider()`
- **Visibility**: public
- **Source Range**: 47010:1154:624

## Implementation

```solidity
function test_OracleUpdateWithExistingProvider() public {
    address[] memory bases = new address[](1);
    bases[0] = address(mockETH);
    address[] memory quotes = new address[](1);
    quotes[0] = address(mockUSD);
    bytes32[] memory providers = new bytes32[](1);
    providers[0] = PROVIDER_1;
    address[] memory feeds = new address[](1);
    feeds[0] = address(mockFeed4);
    superOracle.queueOracleUpdate(bases, quotes, providers, feeds);
    vm.warp((block.timestamp + 1 weeks) + 1 seconds);
    mockFeed4.setUpdatedAt(block.timestamp);
    superOracle.executeOracleUpdate();
    (uint256 quoteAmount, , , ) = superOracle.getQuoteFromProvider(1e18, address(mockETH), address(mockUSD), PROVIDER_1);
    assertEq(quoteAmount, 2e6, "Quote should be $2000 from the updated feed");
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
- **SuperOracle::getQuoteFromProvider(uint256,address,address,bytes32)**

## State Variable Reads

- **mockETH** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **mockUSD** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **PROVIDER_1** (`bytes32`)
- **mockFeed4** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **superOracle** (`contract SuperOracle`) [src/oracles/SuperOracle.sol/contract_SuperOracle.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleTest.test_OracleUpdateWithExistingProvider() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
      💬 Args: [quoteAmount, 2e6, "Quote should be $2000 from the updated feed"]
      👁️  Def: internal
```
