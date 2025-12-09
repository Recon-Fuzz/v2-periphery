# Function: test_IsSecondaryManager()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_IsSecondaryManager()`
- **Visibility**: public
- **Source Range**: 57014:1406:661

## Implementation

```solidity
/// @notice Tests that isSecondaryManager correctly identifies secondary managers
function test_IsSecondaryManager() public {
    bool isSecondary = superVaultAggregator.isSecondaryManager(secondaryManager, strategy);
    assertTrue(isSecondary, "Existing secondary manager should return true");
    assertFalse(superVaultAggregator.isSecondaryManager(user, strategy), "Random user should not be secondary manager");
    assertFalse(superVaultAggregator.isSecondaryManager(manager, strategy), "Main manager should not be secondary manager");
    address newSecondaryManager = _deployAccount(0x25, "NewSecondaryManager");
    vm.prank(manager);
    superVaultAggregator.addSecondaryManager(strategy, newSecondaryManager);
    assertTrue(superVaultAggregator.isSecondaryManager(newSecondaryManager, strategy), "Newly added secondary manager should return true");
    vm.prank(manager);
    superVaultAggregator.removeSecondaryManager(strategy, newSecondaryManager);
    assertFalse(superVaultAggregator.isSecondaryManager(newSecondaryManager, strategy), "Removed secondary manager should return false");
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

### _deployAccount(uint256,string)

- **Kind**: internal
- **Source**: 3858:217:500
- **Link**: `lib/v2-core/test/utils/Helpers.sol:Helpers:_deployAccount(uint256,string)`

```solidity
function _deployAccount(uint256 key_, string memory name_) internal returns (address) {
    address _user = vm.addr(key_);
    vm.deal(_user, LARGE);
    vm.label(_user, name_);
    return _user;
}
```

## External Calls

- **SuperVaultAggregator::isSecondaryManager(address,address)**
- **Vm::prank(address)**
- **SuperVaultAggregator::addSecondaryManager(address,address)**
- **SuperVaultAggregator::removeSecondaryManager(address,address)**

## State Variable Reads

- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **secondaryManager** (`address`)
- **strategy** (`address`)
- **user** (`address`)
- **manager** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_IsSecondaryManager() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 1)
  │   💬 Args: [isSecondary, "Existing secondary manager should return true"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 2)
  │   💬 Args: [superVaultAggregator.isSecondaryManager(user, strategy), "Random user should not be secondary manager"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 3)
  │   💬 Args: [superVaultAggregator.isSecondaryManager(manager, strategy), "Main manager should not be secondary manager"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 4)
  │   💬 Args: [0x25, "NewSecondaryManager"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 5)
  │   💬 Args: [superVaultAggregator.isSecondaryManager(newSecondaryManager, strategy), "Newly added secondary manager should return true"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 6)
      💬 Args: [superVaultAggregator.isSecondaryManager(newSecondaryManager, strategy), "Removed secondary manager should return false"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests that isSecondaryManager correctly identifies secondary managers
