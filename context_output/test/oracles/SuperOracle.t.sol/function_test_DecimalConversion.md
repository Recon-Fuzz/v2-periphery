# Function: test_DecimalConversion()

**Contract**: [test/oracles/SuperOracle.t.sol/contract_SuperOracleTest.md]

## Metadata

- **Contract**: SuperOracleTest
- **Signature**: `test_DecimalConversion()`
- **Visibility**: public
- **Source Range**: 33443:1399:624

## Implementation

```solidity
function test_DecimalConversion() public {
    MockAggregator mockFeed6Dec = new MockAggregator(1.1e6, 6);
    address[] memory bases = new address[](1);
    bases[0] = address(mockETH);
    address[] memory quotes = new address[](1);
    quotes[0] = address(mockUSD);
    bytes32[] memory providers = new bytes32[](1);
    providers[0] = bytes32(keccak256("6DecProvider"));
    address[] memory feeds = new address[](1);
    feeds[0] = address(mockFeed6Dec);
    superOracle.queueOracleUpdate(bases, quotes, providers, feeds);
    vm.warp((block.timestamp + 1 weeks) + 1 seconds);
    mockFeed6Dec.setUpdatedAt(block.timestamp);
    superOracle.executeOracleUpdate();
    (uint256 quoteAmount, , , ) = superOracle.getQuoteFromProvider(1e18, address(mockETH), address(mockUSD), bytes32(keccak256("6DecProvider")));
    assertEq(quoteAmount, 1.1e6, "Quote should be $1100 with correct decimal conversion");
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
- **superOracle** (`contract SuperOracle`) [src/oracles/SuperOracle.sol/contract_SuperOracle.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleTest.test_DecimalConversion() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
      💬 Args: [quoteAmount, 1.1e6, "Quote should be $1100 with correct decimal conversion"]
      👁️  Def: internal
```
