# Function: test_NegativeOracleValues()

**Contract**: [test/oracles/SuperOracle.t.sol/contract_SuperOracleTest.md]

## Metadata

- **Contract**: SuperOracleTest
- **Signature**: `test_NegativeOracleValues()`
- **Visibility**: public
- **Source Range**: 26108:957:624

## Implementation

```solidity
function test_NegativeOracleValues() public {
    mockFeed1.setAnswer(-1e8);
    vm.expectRevert(ISuperOracle.ORACLE_UNTRUSTED_DATA.selector);
    superOracle.getQuoteFromProvider(1e18, address(mockETH), address(mockUSD), PROVIDER_1);
    (uint256 quoteAmount, , uint256 totalProviders, uint256 availableProviders) = superOracle.getQuoteFromProvider(1e18, address(mockETH), address(mockUSD), AVERAGE_PROVIDER);
    assertEq(quoteAmount, 0.95e6, "Average quote should be $950 excluding negative provider");
    assertEq(totalProviders, 3, "Total providers should still be 3");
    assertEq(availableProviders, 2, "Available providers should be 2 (1 is negative)");
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

- **MockAggregator::setAnswer(int256)**
- **Vm::expectRevert(bytes4)**
- **SuperOracle::getQuoteFromProvider(uint256,address,address,bytes32)**

## State Variable Reads

- **mockFeed1** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **superOracle** (`contract SuperOracle`) [src/oracles/SuperOracle.sol/contract_SuperOracle.md]
- **mockETH** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **mockUSD** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **PROVIDER_1** (`bytes32`)
- **AVERAGE_PROVIDER** (`bytes32`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleTest.test_NegativeOracleValues() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [quoteAmount, 0.95e6, "Average quote should be $950 excluding negative provider"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
  │   💬 Args: [totalProviders, 3, "Total providers should still be 3"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 3)
      💬 Args: [availableProviders, 2, "Available providers should be 2 (1 is negative)"]
      👁️  Def: internal
```
