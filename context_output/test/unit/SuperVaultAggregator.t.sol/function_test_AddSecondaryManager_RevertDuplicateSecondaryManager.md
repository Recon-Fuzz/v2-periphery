# Function: test_AddSecondaryManager_RevertDuplicateSecondaryManager()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_AddSecondaryManager_RevertDuplicateSecondaryManager()`
- **Visibility**: public
- **Source Range**: 33281:1055:661

## Implementation

```solidity
/// @notice Tests that addSecondaryManager reverts when trying to add duplicate secondary manager
function test_AddSecondaryManager_RevertDuplicateSecondaryManager() public {
    address newSecondaryManager = _deployAccount(0x20, "NewSecondaryManager");
    vm.prank(manager);
    superVaultAggregator.addSecondaryManager(strategy, newSecondaryManager);
    address[] memory secondaryManagers = superVaultAggregator.getSecondaryManagers(strategy);
    bool found = false;
    for (uint256 i = 0; i < secondaryManagers.length; i++) {
        if (secondaryManagers[i] == newSecondaryManager) {
            found = true;
            break;
        }
    }
    assertTrue(found, "New secondary manager should be added");
    vm.prank(manager);
    vm.expectRevert(ISuperVaultAggregator.MANAGER_ALREADY_EXISTS.selector);
    superVaultAggregator.addSecondaryManager(strategy, newSecondaryManager);
}
```

## Related Implementations

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
- **SuperVaultAggregator::addSecondaryManager(address,address)**
- **SuperVaultAggregator::getSecondaryManagers(address)**
- **Vm::expectRevert(bytes4)**

## State Variable Reads

- **manager** (`address`)
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_AddSecondaryManager_RevertDuplicateSecondaryManager() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 1)
  │   💬 Args: [0x20, "NewSecondaryManager"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 2)
      💬 Args: [found, "New secondary manager should be added"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests that addSecondaryManager reverts when trying to add duplicate secondary manager
