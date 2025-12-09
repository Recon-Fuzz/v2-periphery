# Function: test_StdDevWithSingleProvider()

**Contract**: [test/oracles/SuperOracle.t.sol/contract_SuperOracleTest.md]

## Metadata

- **Contract**: SuperOracleTest
- **Signature**: `test_StdDevWithSingleProvider()`
- **Visibility**: public
- **Source Range**: 43617:844:624

## Implementation

```solidity
function test_StdDevWithSingleProvider() public {
    bytes32[] memory providersToRemove = new bytes32[](2);
    providersToRemove[0] = PROVIDER_1;
    providersToRemove[1] = PROVIDER_2;
    superOracle.queueProviderRemoval(providersToRemove);
    vm.warp((block.timestamp + 1 hours) + 1 seconds);
    mockFeed3.setUpdatedAt(block.timestamp);
    superOracle.executeProviderRemoval();
    (, uint256 deviation, , ) = superOracle.getQuoteFromProvider(1e18, address(mockETH), address(mockUSD), AVERAGE_PROVIDER);
    assertEq(deviation, 0, "Deviation should be zero with single provider");
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

- **SuperOracle::queueProviderRemoval(bytes32[])**
- **Vm::warp(uint256)**
- **MockAggregator::setUpdatedAt(uint256)**
- **SuperOracle::executeProviderRemoval()**
- **SuperOracle::getQuoteFromProvider(uint256,address,address,bytes32)**

## State Variable Reads

- **PROVIDER_1** (`bytes32`)
- **PROVIDER_2** (`bytes32`)
- **superOracle** (`contract SuperOracle`) [src/oracles/SuperOracle.sol/contract_SuperOracle.md]
- **mockFeed3** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **mockETH** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **mockUSD** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **AVERAGE_PROVIDER** (`bytes32`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleTest.test_StdDevWithSingleProvider() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
      💬 Args: [deviation, 0, "Deviation should be zero with single provider"]
      👁️  Def: internal
```
