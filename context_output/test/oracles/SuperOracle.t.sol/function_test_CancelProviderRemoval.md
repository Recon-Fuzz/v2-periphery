# Function: test_CancelProviderRemoval()

**Contract**: [test/oracles/SuperOracle.t.sol/contract_SuperOracleTest.md]

## Metadata

- **Contract**: SuperOracleTest
- **Signature**: `test_CancelProviderRemoval()`
- **Visibility**: public
- **Source Range**: 29074:2468:624

## Implementation

```solidity
function test_CancelProviderRemoval() public {
    bytes32[] memory providersToRemove = new bytes32[](2);
    providersToRemove[0] = PROVIDER_1;
    providersToRemove[1] = PROVIDER_2;
    superOracle.queueProviderRemoval(providersToRemove);
    bytes32[] memory activeProvidersBefore = superOracle.getActiveProviders();
    assertEq(activeProvidersBefore.length, 3, "Should still have 3 providers before cancellation");
    vm.expectEmit(true, false, false, false);
    emit ISuperOracle.ProviderRemovalCancelled(providersToRemove);
    superOracle.cancelProviderRemoval();
    bytes32[] memory activeProvidersAfter = superOracle.getActiveProviders();
    assertEq(activeProvidersAfter.length, 3, "Should still have 3 providers after cancellation");
    (uint256 quoteAmount1, , , ) = superOracle.getQuoteFromProvider(1e18, address(mockETH), address(mockUSD), PROVIDER_1);
    assertEq(quoteAmount1, 1.1e6, "Should still be able to get quote from Provider 1");
    (uint256 quoteAmount2, , , ) = superOracle.getQuoteFromProvider(1e18, address(mockETH), address(mockUSD), PROVIDER_2);
    assertEq(quoteAmount2, 1e6, "Should still be able to get quote from Provider 2");
    bool isProvider1Set = superOracle.isProviderSet(PROVIDER_1);
    bool isProvider2Set = superOracle.isProviderSet(PROVIDER_2);
    assertTrue(isProvider1Set, "Provider 1 should still be set");
    assertTrue(isProvider2Set, "Provider 2 should still be set");
    superOracle.queueProviderRemoval(providersToRemove);
    vm.warp((block.timestamp + 1 hours) + 1 seconds);
    mockFeed3.setUpdatedAt(block.timestamp);
    superOracle.executeProviderRemoval();
    bytes32[] memory activeProvidersAfterExecution = superOracle.getActiveProviders();
    assertEq(activeProvidersAfterExecution.length, 1, "Should have 1 provider after execution");
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

### assertTrue(bool,string)

- **Kind**: internal
- **Source**: 1894:148:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertTrue(bool,string)`

```solidity
function assertTrue(bool data, string memory err) virtual internal pure {
    if (!data) {
        vm.assertTrue(data, err);
    }
}
```

## External Calls

- **SuperOracle::queueProviderRemoval(bytes32[])**
- **SuperOracle::getActiveProviders()**
- **Vm::expectEmit(bool,bool,bool,bool)**
- **SuperOracle::cancelProviderRemoval()**
- **SuperOracle::getQuoteFromProvider(uint256,address,address,bytes32)**
- **SuperOracle::isProviderSet(bytes32)**
- **Vm::warp(uint256)**
- **MockAggregator::setUpdatedAt(uint256)**
- **SuperOracle::executeProviderRemoval()**

## State Variable Reads

- **PROVIDER_1** (`bytes32`)
- **PROVIDER_2** (`bytes32`)
- **superOracle** (`contract SuperOracle`) [src/oracles/SuperOracle.sol/contract_SuperOracle.md]
- **mockETH** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **mockUSD** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **mockFeed3** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleTest.test_CancelProviderRemoval() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [activeProvidersBefore.length, 3, "Should still have 3 providers before cancellation"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
  │   💬 Args: [activeProvidersAfter.length, 3, "Should still have 3 providers after cancellation"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 3)
  │   💬 Args: [quoteAmount1, 1.1e6, "Should still be able to get quote from Provider 1"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 4)
  │   💬 Args: [quoteAmount2, 1e6, "Should still be able to get quote from Provider 2"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 5)
  │   💬 Args: [isProvider1Set, "Provider 1 should still be set"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 6)
  │   💬 Args: [isProvider2Set, "Provider 2 should still be set"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 7)
      💬 Args: [activeProvidersAfterExecution.length, 1, "Should have 1 provider after execution"]
      👁️  Def: internal
```
