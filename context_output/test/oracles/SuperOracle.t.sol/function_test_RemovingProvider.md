# Function: test_RemovingProvider()

**Contract**: [test/oracles/SuperOracle.t.sol/contract_SuperOracleTest.md]

## Metadata

- **Contract**: SuperOracleTest
- **Signature**: `test_RemovingProvider()`
- **Visibility**: public
- **Source Range**: 12679:1955:624

## Implementation

```solidity
function test_RemovingProvider() public {
    bytes32[] memory providersToRemoveRevert = new bytes32[](24);
    for (uint256 i = 0; i < 24; i++) {
        providersToRemoveRevert[i] = bytes32(keccak256(abi.encodePacked(i)));
    }
    vm.expectRevert(ISuperOracle.TOO_MANY_PROVIDERS.selector);
    superOracle.queueProviderRemoval(providersToRemoveRevert);
    bytes32[] memory providersToRemove = new bytes32[](1);
    providersToRemove[0] = PROVIDER_3;
    superOracle.queueProviderRemoval(providersToRemove);
    vm.warp((block.timestamp + 1 hours) + 1 seconds);
    mockFeed1.setUpdatedAt(block.timestamp);
    mockFeed2.setUpdatedAt(block.timestamp);
    superOracle.executeProviderRemoval();
    bytes32[] memory activeProviders = superOracle.getActiveProviders();
    assertEq(activeProviders.length, 2, "Should now have 2 active providers");
    for (uint256 i = 0; i < activeProviders.length; i++) {
        if (activeProviders[i] == PROVIDER_3) {
            revert("Provider 3 should have been removed");
        }
    }
    (uint256 quoteAmount, , , ) = superOracle.getQuoteFromProvider(1e18, address(mockETH), address(mockUSD), AVERAGE_PROVIDER);
    assertEq(quoteAmount, 1.05e6, "Average quote should be $1050 after removal");
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

- **Vm::expectRevert(bytes4)**
- **SuperOracle::queueProviderRemoval(bytes32[])**
- **Vm::warp(uint256)**
- **MockAggregator::setUpdatedAt(uint256)**
- **SuperOracle::executeProviderRemoval()**
- **SuperOracle::getActiveProviders()**
- **SuperOracle::getQuoteFromProvider(uint256,address,address,bytes32)**

## State Variable Reads

- **superOracle** (`contract SuperOracle`) [src/oracles/SuperOracle.sol/contract_SuperOracle.md]
- **PROVIDER_3** (`bytes32`)
- **mockFeed1** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **mockFeed2** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **mockETH** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **mockUSD** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **AVERAGE_PROVIDER** (`bytes32`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleTest.test_RemovingProvider() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [activeProviders.length, 2, "Should now have 2 active providers"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
      💬 Args: [quoteAmount, 1.05e6, "Average quote should be $1050 after removal"]
      👁️  Def: internal
```
