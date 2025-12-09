# Function: test_CancelChangePrimaryManager_CanRepropose()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_CancelChangePrimaryManager_CanRepropose()`
- **Visibility**: public
- **Source Range**: 94839:814:661

## Implementation

```solidity
/// @notice Tests that cancelled proposal can be re-proposed
function test_CancelChangePrimaryManager_CanRepropose() public {
    address newManager = _deployAccount(0xC0, "NewManager");
    vm.prank(secondaryManager);
    superVaultAggregator.proposeChangePrimaryManager(strategy, newManager, treasury);
    vm.prank(manager);
    superVaultAggregator.cancelChangePrimaryManager(strategy);
    vm.prank(secondaryManager);
    superVaultAggregator.proposeChangePrimaryManager(strategy, newManager, treasury);
    (address proposedManager, ) = superVaultAggregator.getPendingManagerChange(strategy);
    assertEq(proposedManager, newManager, "New proposal should exist");
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

## External Calls

- **Vm::prank(address)**
- **SuperVaultAggregator::proposeChangePrimaryManager(address,address,address)**
- **SuperVaultAggregator::cancelChangePrimaryManager(address)**
- **SuperVaultAggregator::getPendingManagerChange(address)**

## State Variable Reads

- **secondaryManager** (`address`)
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`address`)
- **treasury** (`address`)
- **manager** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_CancelChangePrimaryManager_CanRepropose() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 1)
  │   💬 Args: [0xC0, "NewManager"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 2)
      💬 Args: [proposedManager, newManager, "New proposal should exist"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests that cancelled proposal can be re-proposed
