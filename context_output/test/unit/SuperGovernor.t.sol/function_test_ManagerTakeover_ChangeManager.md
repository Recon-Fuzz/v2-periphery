# Function: test_ManagerTakeover_ChangeManager()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_ManagerTakeover_ChangeManager()`
- **Visibility**: public
- **Source Range**: 21377:377:659

## Implementation

```solidity
/// @notice Tests changing a manager for a strategy
function test_ManagerTakeover_ChangeManager() public {
    address feeRecipient = _deployAccount(0x2C, "FeeRecipient");
    vm.prank(sGovernor);
    superGovernor.changePrimaryManager(strategy1, newManager, feeRecipient);
    assertEq(ISuperVaultAggregator(superVaultAggregator).getMainManager(strategy1), newManager);
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

### assertEq(address,address)

- **Kind**: internal
- **Source**: 4020:153:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(address,address)`

```solidity
function assertEq(address left, address right) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right);
    }
}
```

## External Calls

- **Vm::prank(address)**
- **SuperGovernor::changePrimaryManager(address,address,address)**
- **ISuperVaultAggregator::getMainManager(address)**

## State Variable Reads

- **sGovernor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **strategy1** (`address`)
- **newManager** (`address`)
- **superVaultAggregator** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_ManagerTakeover_ChangeManager() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 1)
  │   💬 Args: [0x2C, "FeeRecipient"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address) (NodeID: 2)
      💬 Args: [ISuperVaultAggregator(superVaultAggregator).getMainManager(strategy1), newManager]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests changing a manager for a strategy
