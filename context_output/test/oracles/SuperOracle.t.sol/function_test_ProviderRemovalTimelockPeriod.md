# Function: test_ProviderRemovalTimelockPeriod()

**Contract**: [test/oracles/SuperOracle.t.sol/contract_SuperOracleTest.md]

## Metadata

- **Contract**: SuperOracleTest
- **Signature**: `test_ProviderRemovalTimelockPeriod()`
- **Visibility**: public
- **Source Range**: 24813:1289:624

## Implementation

```solidity
function test_ProviderRemovalTimelockPeriod() public {
    bytes32[] memory providersToRemove = new bytes32[](1);
    providersToRemove[0] = PROVIDER_1;
    superOracle.queueProviderRemoval(providersToRemove);
    vm.expectRevert(ISuperOracle.TIMELOCK_NOT_ELAPSED.selector);
    superOracle.executeProviderRemoval();
    vm.warp((block.timestamp + 59 minutes) + 59 seconds);
    vm.expectRevert(ISuperOracle.TIMELOCK_NOT_ELAPSED.selector);
    superOracle.executeProviderRemoval();
    vm.warp(block.timestamp + 2 seconds);
    mockFeed2.setUpdatedAt(block.timestamp);
    mockFeed3.setUpdatedAt(block.timestamp);
    superOracle.executeProviderRemoval();
    bytes32[] memory activeProviders = superOracle.getActiveProviders();
    assertEq(activeProviders.length, 2, "Should have 2 providers after removal");
    assertFalse(superOracle.isProviderSet(PROVIDER_1), "Provider 1 should not be set");
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

### assertFalse(bool,string)

- **Kind**: internal
- **Source**: 2179:149:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertFalse(bool,string)`

```solidity
function assertFalse(bool data, string memory err) virtual internal pure {
    if (data) {
        vm.assertFalse(data, err);
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
- **SuperOracle::isProviderSet(bytes32)**

## State Variable Reads

- **PROVIDER_1** (`bytes32`)
- **superOracle** (`contract SuperOracle`) [src/oracles/SuperOracle.sol/contract_SuperOracle.md]
- **mockFeed2** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **mockFeed3** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleTest.test_ProviderRemovalTimelockPeriod() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [activeProviders.length, 2, "Should have 2 providers after removal"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 2)
      💬 Args: [superOracle.isProviderSet(PROVIDER_1), "Provider 1 should not be set"]
      👁️  Def: internal
```
