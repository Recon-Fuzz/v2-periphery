# Function: test_RemoveSecondaryManager_RevertUnauthorized()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_RemoveSecondaryManager_RevertUnauthorized()`
- **Visibility**: public
- **Source Range**: 34432:1309:661

## Implementation

```solidity
/// @notice Tests that removeSecondaryManager reverts when caller is not main manager
function test_RemoveSecondaryManager_RevertUnauthorized() public {
    address[] memory secondaryManagers = superVaultAggregator.getSecondaryManagers(strategy);
    assertTrue(secondaryManagers.length > 0, "Should have at least one secondary manager");
    vm.prank(user);
    vm.expectRevert(ISuperVaultAggregator.UNAUTHORIZED_UPDATE_AUTHORITY.selector);
    superVaultAggregator.removeSecondaryManager(strategy, secondaryManager);
    vm.prank(secondaryManager);
    vm.expectRevert(ISuperVaultAggregator.UNAUTHORIZED_UPDATE_AUTHORITY.selector);
    superVaultAggregator.removeSecondaryManager(strategy, secondaryManager);
    address anotherSecondary = _deployAccount(0x21, "AnotherSecondary");
    vm.prank(manager);
    superVaultAggregator.addSecondaryManager(strategy, anotherSecondary);
    vm.prank(anotherSecondary);
    vm.expectRevert(ISuperVaultAggregator.UNAUTHORIZED_UPDATE_AUTHORITY.selector);
    superVaultAggregator.removeSecondaryManager(strategy, secondaryManager);
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

- **SuperVaultAggregator::getSecondaryManagers(address)**
- **Vm::prank(address)**
- **Vm::expectRevert(bytes4)**
- **SuperVaultAggregator::removeSecondaryManager(address,address)**
- **SuperVaultAggregator::addSecondaryManager(address,address)**

## State Variable Reads

- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`address`)
- **user** (`address`)
- **secondaryManager** (`address`)
- **manager** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_RemoveSecondaryManager_RevertUnauthorized() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 1)
  │   💬 Args: [secondaryManagers.length > 0, "Should have at least one secondary manager"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 2)
      💬 Args: [0x21, "AnotherSecondary"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests that removeSecondaryManager reverts when caller is not main manager
