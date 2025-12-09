# Function: test_ContainsYieldSource()

**Contract**: [test/unit/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_ContainsYieldSource()`
- **Visibility**: public
- **Source Range**: 183926:1814:660

## Implementation

```solidity
/// @notice Tests containsYieldSource returns false when source doesn't exist, true after adding, and false after
///  removing @dev Covers SuperVaultStrategy.sol:630-632
function test_ContainsYieldSource() public {
    address yieldSourceAddr = address(0x1234);
    address oracleAddr = address(0x5678);
    bool containsBefore = strategy.containsYieldSource(yieldSourceAddr);
    assertFalse(containsBefore, "Should return false for non-existent yield source");
    address[] memory sources = new address[](1);
    address[] memory oracles = new address[](1);
    ISuperVaultStrategy.YieldSourceAction[] memory actionTypes = new ISuperVaultStrategy.YieldSourceAction[](1);
    sources[0] = yieldSourceAddr;
    oracles[0] = oracleAddr;
    actionTypes[0] = ISuperVaultStrategy.YieldSourceAction.Add;
    vm.prank(manager);
    strategy.manageYieldSources(sources, oracles, actionTypes);
    bool containsAfterAdd = strategy.containsYieldSource(yieldSourceAddr);
    assertTrue(containsAfterAdd, "Should return true after adding yield source");
    actionTypes[0] = ISuperVaultStrategy.YieldSourceAction.Remove;
    vm.prank(manager);
    strategy.manageYieldSources(sources, oracles, actionTypes);
    bool containsAfterRemove = strategy.containsYieldSource(yieldSourceAddr);
    assertFalse(containsAfterRemove, "Should return false after removing yield source");
    address anotherAddr = address(0x9999);
    bool containsOther = strategy.containsYieldSource(anotherAddr);
    assertFalse(containsOther, "Should return false for any non-existent yield source");
}
```

## Related Implementations

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

- **SuperVaultStrategy::containsYieldSource(address)**
- **Vm::prank(address)**
- **SuperVaultStrategy::manageYieldSources(address[],address[],enum ISuperVaultStrategy.YieldSourceAction[])**

## State Variable Reads

- **strategy** (`contract SuperVaultStrategy`) [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]
- **manager** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_ContainsYieldSource() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 1)
  │   💬 Args: [containsBefore, "Should return false for non-existent yield source"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 2)
  │   💬 Args: [containsAfterAdd, "Should return true after adding yield source"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 3)
  │   💬 Args: [containsAfterRemove, "Should return false after removing yield source"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 4)
      💬 Args: [containsOther, "Should return false for any non-existent yield source"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests containsYieldSource returns false when source doesn't exist, true after adding, and false after
 removing @dev Covers SuperVaultStrategy.sol:630-632
