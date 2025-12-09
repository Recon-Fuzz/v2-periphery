# Function: test_GetQuoteFromProvider()

**Contract**: [test/oracles/SuperOracle.t.sol/contract_SuperOracleTest.md]

## Metadata

- **Contract**: SuperOracleTest
- **Signature**: `test_GetQuoteFromProvider()`
- **Visibility**: public
- **Source Range**: 7798:1281:624

## Implementation

```solidity
function test_GetQuoteFromProvider() public view {
    uint256 baseAmount = 1e18;
    (uint256 quoteAmount1, uint256 deviation1, uint256 totalProviders1, uint256 availableProviders1) = superOracle.getQuoteFromProvider(baseAmount, address(mockETH), address(mockUSD), PROVIDER_1);
    assertEq(quoteAmount1, 1.1e6, "Quote from provider 1 should be $1100");
    assertEq(deviation1, 0, "Deviation should be 0 for single provider");
    assertEq(totalProviders1, 1, "Total providers should be 1");
    assertEq(availableProviders1, 1, "Available providers should be 1");
    (uint256 quoteAmountAvg, uint256 deviationAvg, uint256 totalProvidersAvg, uint256 availableProvidersAvg) = superOracle.getQuoteFromProvider(baseAmount, address(mockETH), address(mockUSD), AVERAGE_PROVIDER);
    assertEq(quoteAmountAvg, 1e6, "Average quote should be $1000");
    assertGt(deviationAvg, 0, "Deviation should be greater than 0 for multiple providers");
    assertEq(totalProvidersAvg, 3, "Total providers should be 3");
    assertEq(availableProvidersAvg, 3, "Available providers should be 3");
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

### assertGt(uint256,uint256,string)

- **Kind**: internal
- **Source**: 14795:177:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertGt(uint256,uint256,string)`

```solidity
function assertGt(uint256 left, uint256 right, string memory err) virtual internal pure {
    if (left <= right) {
        vm.assertGt(left, right, err);
    }
}
```

## External Calls

- **SuperOracle::getQuoteFromProvider(uint256,address,address,bytes32)**

## State Variable Reads

- **superOracle** (`contract SuperOracle`) [src/oracles/SuperOracle.sol/contract_SuperOracle.md]
- **mockETH** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **mockUSD** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **PROVIDER_1** (`bytes32`)
- **AVERAGE_PROVIDER** (`bytes32`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleTest.test_GetQuoteFromProvider() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [quoteAmount1, 1.1e6, "Quote from provider 1 should be $1100"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
  │   💬 Args: [deviation1, 0, "Deviation should be 0 for single provider"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 3)
  │   💬 Args: [totalProviders1, 1, "Total providers should be 1"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 4)
  │   💬 Args: [availableProviders1, 1, "Available providers should be 1"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 5)
  │   💬 Args: [quoteAmountAvg, 1e6, "Average quote should be $1000"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 6)
  │   💬 Args: [deviationAvg, 0, "Deviation should be greater than 0 for multiple providers"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 7)
  │   💬 Args: [totalProvidersAvg, 3, "Total providers should be 3"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 8)
      💬 Args: [availableProvidersAvg, 3, "Available providers should be 3"]
      👁️  Def: internal
```
