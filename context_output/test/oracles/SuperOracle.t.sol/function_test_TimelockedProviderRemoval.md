# Function: test_TimelockedProviderRemoval()

**Contract**: [test/oracles/SuperOracle.t.sol/contract_SuperOracleTest.md]

## Metadata

- **Contract**: SuperOracleTest
- **Signature**: `test_TimelockedProviderRemoval()`
- **Visibility**: public
- **Source Range**: 23424:1383:624

## Implementation

```solidity
function test_TimelockedProviderRemoval() public {
    bytes32[] memory providersToRemove = new bytes32[](1);
    providersToRemove[0] = PROVIDER_1;
    superOracle.queueProviderRemoval(providersToRemove);
    vm.expectRevert(ISuperOracle.PENDING_UPDATE_EXISTS.selector);
    superOracle.queueProviderRemoval(providersToRemove);
    vm.expectRevert(ISuperOracle.TIMELOCK_NOT_ELAPSED.selector);
    superOracle.executeProviderRemoval();
    vm.warp((block.timestamp + 1 hours) + 1 seconds);
    mockFeed2.setUpdatedAt(block.timestamp);
    mockFeed3.setUpdatedAt(block.timestamp);
    superOracle.executeProviderRemoval();
    bytes32[] memory activeProviders = superOracle.getActiveProviders();
    assertEq(activeProviders.length, 2, "Should have 2 providers after removal");
    for (uint256 i = 0; i < activeProviders.length; i++) {
        if (activeProviders[i] == PROVIDER_1) {
            revert("Provider 1 should have been removed");
        }
    }
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
- **Vm::expectRevert(bytes4)**
- **SuperOracle::executeProviderRemoval()**
- **Vm::warp(uint256)**
- **MockAggregator::setUpdatedAt(uint256)**
- **SuperOracle::getActiveProviders()**

## State Variable Reads

- **PROVIDER_1** (`bytes32`)
- **superOracle** (`contract SuperOracle`) [src/oracles/SuperOracle.sol/contract_SuperOracle.md]
- **mockFeed2** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **mockFeed3** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleTest.test_TimelockedProviderRemoval() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
      💬 Args: [activeProviders.length, 2, "Should have 2 providers after removal"]
      👁️  Def: internal
```
