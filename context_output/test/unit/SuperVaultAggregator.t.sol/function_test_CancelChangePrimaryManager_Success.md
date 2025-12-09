# Function: test_CancelChangePrimaryManager_Success()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_CancelChangePrimaryManager_Success()`
- **Visibility**: public
- **Source Range**: 89840:984:661

## Implementation

```solidity
/// @notice Tests that mainManager can cancel a pending manager change proposal
function test_CancelChangePrimaryManager_Success() public {
    address newManager = _deployAccount(0xBB, "NewManager");
    vm.prank(secondaryManager);
    superVaultAggregator.proposeChangePrimaryManager(strategy, newManager, treasury);
    (address proposedManager, ) = superVaultAggregator.getPendingManagerChange(strategy);
    assertEq(proposedManager, newManager, "Proposal should exist");
    vm.expectEmit(true, true, false, false);
    emit ISuperVaultAggregator.PrimaryManagerChangeCancelled(strategy, newManager);
    vm.prank(manager);
    superVaultAggregator.cancelChangePrimaryManager(strategy);
    (proposedManager, ) = superVaultAggregator.getPendingManagerChange(strategy);
    assertEq(proposedManager, address(0), "Proposal should be cleared");
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
- **SuperVaultAggregator::getPendingManagerChange(address)**
- **Vm::expectEmit(bool,bool,bool,bool)**
- **SuperVaultAggregator::cancelChangePrimaryManager(address)**

## State Variable Reads

- **secondaryManager** (`address`)
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`address`)
- **treasury** (`address`)
- **manager** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_CancelChangePrimaryManager_Success() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 1)
  │   💬 Args: [0xBB, "NewManager"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 2)
  │   💬 Args: [proposedManager, newManager, "Proposal should exist"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 3)
      💬 Args: [proposedManager, address(0), "Proposal should be cleared"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests that mainManager can cancel a pending manager change proposal
