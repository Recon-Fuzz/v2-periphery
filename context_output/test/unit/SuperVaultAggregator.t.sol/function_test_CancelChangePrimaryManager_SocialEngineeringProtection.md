# Function: test_CancelChangePrimaryManager_SocialEngineeringProtection()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_CancelChangePrimaryManager_SocialEngineeringProtection()`
- **Visibility**: public
- **Source Range**: 92999:1769:661

## Implementation

```solidity
/// @notice Tests social engineering protection scenario
function test_CancelChangePrimaryManager_SocialEngineeringProtection() public {
    address attacker = _deployAccount(0xBF, "Attacker");
    vm.prank(manager);
    superVaultAggregator.addSecondaryManager(strategy, attacker);
    vm.prank(attacker);
    superVaultAggregator.proposeChangePrimaryManager(strategy, attacker, treasury);
    vm.warp(block.timestamp + 3 days);
    vm.prank(manager);
    superVaultAggregator.cancelChangePrimaryManager(strategy);
    assertEq(superVaultAggregator.getMainManager(strategy), manager, "Manager should retain control");
    (address proposedManager, ) = superVaultAggregator.getPendingManagerChange(strategy);
    assertEq(proposedManager, address(0), "Proposal should be cleared");
    vm.prank(manager);
    superVaultAggregator.removeSecondaryManager(strategy, attacker);
    address[] memory secondaryManagers = superVaultAggregator.getSecondaryManagers(strategy);
    bool attackerFound = false;
    for (uint256 i = 0; i < secondaryManagers.length; i++) {
        if (secondaryManagers[i] == attacker) {
            attackerFound = true;
        }
    }
    assertFalse(attackerFound, "Attacker should be removed");
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

- **Vm::prank(address)**
- **SuperVaultAggregator::addSecondaryManager(address,address)**
- **SuperVaultAggregator::proposeChangePrimaryManager(address,address,address)**
- **Vm::warp(uint256)**
- **SuperVaultAggregator::cancelChangePrimaryManager(address)**
- **SuperVaultAggregator::getMainManager(address)**
- **SuperVaultAggregator::getPendingManagerChange(address)**
- **SuperVaultAggregator::removeSecondaryManager(address,address)**
- **SuperVaultAggregator::getSecondaryManagers(address)**

## State Variable Reads

- **manager** (`address`)
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`address`)
- **treasury** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_CancelChangePrimaryManager_SocialEngineeringProtection() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 1)
  │   💬 Args: [0xBF, "Attacker"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 2)
  │   💬 Args: [superVaultAggregator.getMainManager(strategy), manager, "Manager should retain control"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 3)
  │   💬 Args: [proposedManager, address(0), "Proposal should be cleared"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 4)
      💬 Args: [attackerFound, "Attacker should be removed"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests social engineering protection scenario
