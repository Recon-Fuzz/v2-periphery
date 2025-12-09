# Function: test_RemoveSecondaryManager_RevertManagerNotFound()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_RemoveSecondaryManager_RevertManagerNotFound()`
- **Visibility**: public
- **Source Range**: 35831:964:661

## Implementation

```solidity
/// @notice Tests that removeSecondaryManager reverts when manager is not found
function test_RemoveSecondaryManager_RevertManagerNotFound() public {
    address nonExistentManager = _deployAccount(0x22, "NonExistentManager");
    address[] memory secondaryManagers = superVaultAggregator.getSecondaryManagers(strategy);
    bool found = false;
    for (uint256 i = 0; i < secondaryManagers.length; i++) {
        if (secondaryManagers[i] == nonExistentManager) {
            found = true;
            break;
        }
    }
    assertFalse(found, "NonExistentManager should not be in secondary managers list");
    vm.prank(manager);
    vm.expectRevert(ISuperVaultAggregator.MANAGER_NOT_FOUND.selector);
    superVaultAggregator.removeSecondaryManager(strategy, nonExistentManager);
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

- **SuperVaultAggregator::getSecondaryManagers(address)**
- **Vm::prank(address)**
- **Vm::expectRevert(bytes4)**
- **SuperVaultAggregator::removeSecondaryManager(address,address)**

## State Variable Reads

- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`address`)
- **manager** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_RemoveSecondaryManager_RevertManagerNotFound() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 1)
  │   💬 Args: [0x22, "NonExistentManager"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 2)
      💬 Args: [found, "NonExistentManager should not be in secondary managers list"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests that removeSecondaryManager reverts when manager is not found
