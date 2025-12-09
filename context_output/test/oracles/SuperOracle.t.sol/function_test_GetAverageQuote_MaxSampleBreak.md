# Function: test_GetAverageQuote_MaxSampleBreak()

**Contract**: [test/oracles/SuperOracle.t.sol/contract_SuperOracleTest.md]

## Metadata

- **Contract**: SuperOracleTest
- **Signature**: `test_GetAverageQuote_MaxSampleBreak()`
- **Visibility**: public
- **Source Range**: 57060:1627:624

## Implementation

```solidity
/// @notice Tests _getAverageQuote breaks early at MAX_SAMPLE_PROVIDERS
///  @dev Covers SuperOracleBase.sol:504-506 - if (count == MAX_SAMPLE_PROVIDERS) break
function test_GetAverageQuote_MaxSampleBreak() public {
    address[] memory bases = new address[](7);
    address[] memory quotes = new address[](7);
    bytes32[] memory providers = new bytes32[](7);
    address[] memory feeds = new address[](7);
    for (uint256 i = 0; i < 7; i++) {
        bases[i] = address(mockETH);
        quotes[i] = address(mockUSD);
        providers[i] = keccak256(abi.encodePacked("Provider", i + 10));
        feeds[i] = address(new MockAggregator(1e8, 8));
    }
    superOracle.queueOracleUpdate(bases, quotes, providers, feeds);
    vm.warp(block.timestamp + 1 weeks);
    superOracle.executeOracleUpdate();
    for (uint256 i = 0; i < 7; i++) {
        MockAggregator(feeds[i]).setUpdatedAt(block.timestamp);
    }
    mockFeed1.setUpdatedAt(block.timestamp);
    mockFeed2.setUpdatedAt(block.timestamp);
    mockFeed3.setUpdatedAt(block.timestamp);
    (, , uint256 total, uint256 avail) = superOracle.getQuoteFromProvider(1e18, address(mockETH), address(mockUSD), AVERAGE_PROVIDER);
    assertEq(total, 10, "Should sample exactly 10 providers");
    assertEq(avail, 10, "All 10 should be available");
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
- **SuperOracle::executeOracleUpdate()**
- **MockAggregator::setUpdatedAt(uint256)**
- **SuperOracle::getQuoteFromProvider(uint256,address,address,bytes32)**

## State Variable Reads

- **mockETH** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **mockUSD** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **superOracle** (`contract SuperOracle`) [src/oracles/SuperOracle.sol/contract_SuperOracle.md]
- **mockFeed1** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **mockFeed2** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **mockFeed3** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **AVERAGE_PROVIDER** (`bytes32`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleTest.test_GetAverageQuote_MaxSampleBreak() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [total, 10, "Should sample exactly 10 providers"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
      💬 Args: [avail, 10, "All 10 should be available"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests _getAverageQuote breaks early at MAX_SAMPLE_PROVIDERS
 @dev Covers SuperOracleBase.sol:504-506 - if (count == MAX_SAMPLE_PROVIDERS) break
