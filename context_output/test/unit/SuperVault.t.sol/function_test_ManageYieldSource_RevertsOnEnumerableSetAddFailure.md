# Function: test_ManageYieldSource_RevertsOnEnumerableSetAddFailure()

**Contract**: [test/unit/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_ManageYieldSource_RevertsOnEnumerableSetAddFailure()`
- **Visibility**: public
- **Source Range**: 120228:2322:660

## Implementation

```solidity
/// @notice Tests _addYieldSource reverts when EnumerableSet.add() fails (defensive check)
///  @dev Covers SuperVaultStrategy.sol:856 - EnumerableSet consistency check in _addYieldSource
///  @dev This tests inconsistent state where mapping is cleared but set still contains the source
function test_ManageYieldSource_RevertsOnEnumerableSetAddFailure() public {
    address yieldSourceAddr = address(0x1234);
    address oracleAddr = address(0x5678);
    vm.prank(manager);
    strategy.manageYieldSource(yieldSourceAddr, oracleAddr, ISuperVaultStrategy.YieldSourceAction.Add);
    ISuperVaultStrategy.YieldSource memory ys = strategy.getYieldSource(yieldSourceAddr);
    assertEq(ys.oracle, oracleAddr, "Yield source should be added");
    assertTrue(strategy.containsYieldSource(yieldSourceAddr), "Set should contain source");
    bytes32 mappingSlot = bytes32(uint256(13));
    bytes32 storageSlot = keccak256(abi.encode(yieldSourceAddr, mappingSlot));
    vm.store(address(strategy), storageSlot, bytes32(uint256(0)));
    ISuperVaultStrategy.YieldSource memory ysCorrupted = strategy.getYieldSource(yieldSourceAddr);
    assertEq(ysCorrupted.oracle, address(0), "Mapping should be cleared");
    assertTrue(strategy.containsYieldSource(yieldSourceAddr), "Set should still contain source");
    vm.prank(manager);
    vm.expectRevert(ISuperVaultStrategy.YIELD_SOURCE_ALREADY_EXISTS.selector);
    strategy.manageYieldSource(yieldSourceAddr, oracleAddr, ISuperVaultStrategy.YieldSourceAction.Add);
}
```

## Related Implementations

### assertEq(address,address,string)

- **Kind**: internal
- **Source**: 4179:177:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(address,address,string)`

```solidity
function assertEq(address left, address right, string memory err) virtual internal pure {
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

- **Vm::prank(address)**
- **SuperVaultStrategy::manageYieldSource(address,address,enum ISuperVaultStrategy.YieldSourceAction)**
- **SuperVaultStrategy::getYieldSource(address)**
- **SuperVaultStrategy::containsYieldSource(address)**
- **Vm::store(address,bytes32,bytes32)**
- **Vm::expectRevert(bytes4)**

## State Variable Reads

- **manager** (`address`)
- **strategy** (`contract SuperVaultStrategy`) [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_ManageYieldSource_RevertsOnEnumerableSetAddFailure() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 1)
  │   💬 Args: [ys.oracle, oracleAddr, "Yield source should be added"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 2)
  │   💬 Args: [strategy.containsYieldSource(yieldSourceAddr), "Set should contain source"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 3)
  │   💬 Args: [ysCorrupted.oracle, address(0), "Mapping should be cleared"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 4)
      💬 Args: [strategy.containsYieldSource(yieldSourceAddr), "Set should still contain source"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests _addYieldSource reverts when EnumerableSet.add() fails (defensive check)
 @dev Covers SuperVaultStrategy.sol:856 - EnumerableSet consistency check in _addYieldSource
 @dev This tests inconsistent state where mapping is cleared but set still contains the source
