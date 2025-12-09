# Function: test_ManageYieldSource_RevertsOnEnumerableSetRemoveFailure()

**Contract**: [test/unit/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_ManageYieldSource_RevertsOnEnumerableSetRemoveFailure()`
- **Visibility**: public
- **Source Range**: 122862:1979:660

## Implementation

```solidity
/// @notice Tests _removeYieldSource reverts when EnumerableSet.remove() fails (defensive check)
///  @dev Covers SuperVaultStrategy.sol:882 - EnumerableSet consistency check in _removeYieldSource
///  @dev This tests inconsistent state where mapping has value but set doesn't contain the source
function test_ManageYieldSource_RevertsOnEnumerableSetRemoveFailure() public {
    address yieldSourceAddr = address(0x1234);
    address oracleAddr = address(0x5678);
    vm.prank(manager);
    strategy.manageYieldSource(yieldSourceAddr, oracleAddr, ISuperVaultStrategy.YieldSourceAction.Add);
    assertTrue(strategy.containsYieldSource(yieldSourceAddr), "Set should contain source");
    vm.prank(manager);
    strategy.manageYieldSource(yieldSourceAddr, address(0), ISuperVaultStrategy.YieldSourceAction.Remove);
    assertFalse(strategy.containsYieldSource(yieldSourceAddr), "Set should not contain source");
    bytes32 mappingSlot = bytes32(uint256(13));
    bytes32 storageSlot = keccak256(abi.encode(yieldSourceAddr, mappingSlot));
    vm.store(address(strategy), storageSlot, bytes32(uint256(uint160(oracleAddr))));
    ISuperVaultStrategy.YieldSource memory ysCorrupted = strategy.getYieldSource(yieldSourceAddr);
    assertEq(ysCorrupted.oracle, oracleAddr, "Mapping should have oracle");
    assertFalse(strategy.containsYieldSource(yieldSourceAddr), "Set should not contain source");
    vm.prank(manager);
    vm.expectRevert(ISuperVaultStrategy.YIELD_SOURCE_NOT_FOUND.selector);
    strategy.manageYieldSource(yieldSourceAddr, address(0), ISuperVaultStrategy.YieldSourceAction.Remove);
}
```

## Related Implementations

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

## External Calls

- **Vm::prank(address)**
- **SuperVaultStrategy::manageYieldSource(address,address,enum ISuperVaultStrategy.YieldSourceAction)**
- **SuperVaultStrategy::containsYieldSource(address)**
- **Vm::store(address,bytes32,bytes32)**
- **SuperVaultStrategy::getYieldSource(address)**
- **Vm::expectRevert(bytes4)**

## State Variable Reads

- **manager** (`address`)
- **strategy** (`contract SuperVaultStrategy`) [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_ManageYieldSource_RevertsOnEnumerableSetRemoveFailure() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 1)
  │   💬 Args: [strategy.containsYieldSource(yieldSourceAddr), "Set should contain source"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 2)
  │   💬 Args: [strategy.containsYieldSource(yieldSourceAddr), "Set should not contain source"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 3)
  │   💬 Args: [ysCorrupted.oracle, oracleAddr, "Mapping should have oracle"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 4)
      💬 Args: [strategy.containsYieldSource(yieldSourceAddr), "Set should not contain source"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests _removeYieldSource reverts when EnumerableSet.remove() fails (defensive check)
 @dev Covers SuperVaultStrategy.sol:882 - EnumerableSet consistency check in _removeYieldSource
 @dev This tests inconsistent state where mapping has value but set doesn't contain the source
