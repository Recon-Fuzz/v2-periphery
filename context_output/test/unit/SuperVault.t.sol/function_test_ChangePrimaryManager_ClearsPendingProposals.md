# Function: test_ChangePrimaryManager_ClearsPendingProposals()

**Contract**: [test/unit/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_ChangePrimaryManager_ClearsPendingProposals()`
- **Visibility**: public
- **Source Range**: 218971:1596:660

## Implementation

```solidity
/// @notice Tests that changePrimaryManager clears all pending proposals
function test_ChangePrimaryManager_ClearsPendingProposals() public {
    address newManager = _deployAccount(0x111, "NewManager");
    address newFeeRecipient = _deployAccount(0x222, "NewFeeRecipient");
    address secondaryManager = _deployAccount(0x333, "SecondaryManager");
    vm.prank(manager);
    superVaultAggregator.addSecondaryManager(address(strategy), secondaryManager);
    address proposedManager = _deployAccount(0x444, "ProposedManager");
    address proposedFeeRecipient = _deployAccount(0x555, "ProposedFeeRecipient");
    vm.prank(secondaryManager);
    superVaultAggregator.proposeChangePrimaryManager(address(strategy), proposedManager, proposedFeeRecipient);
    (address pending, ) = superVaultAggregator.getPendingManagerChange(address(strategy));
    assertEq(pending, proposedManager, "Proposal should exist");
    vm.prank(sGovernor);
    superGovernor.changePrimaryManager(address(strategy), newManager, newFeeRecipient);
    (address clearedPending, ) = superVaultAggregator.getPendingManagerChange(address(strategy));
    assertEq(clearedPending, address(0), "Proposal should be cleared after governance override");
    assertEq(superVaultAggregator.getMainManager(address(strategy)), newManager, "New manager should be set");
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
- **SuperVaultAggregator::addSecondaryManager(address,address)**
- **SuperVaultAggregator::proposeChangePrimaryManager(address,address,address)**
- **SuperVaultAggregator::getPendingManagerChange(address)**
- **SuperGovernor::changePrimaryManager(address,address,address)**
- **SuperVaultAggregator::getMainManager(address)**

## State Variable Reads

- **manager** (`address`)
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`contract SuperVaultStrategy`) [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]
- **sGovernor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_ChangePrimaryManager_ClearsPendingProposals() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 1)
  │   💬 Args: [0x111, "NewManager"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 2)
  │   💬 Args: [0x222, "NewFeeRecipient"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 3)
  │   💬 Args: [0x333, "SecondaryManager"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 4)
  │   💬 Args: [0x444, "ProposedManager"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 5)
  │   💬 Args: [0x555, "ProposedFeeRecipient"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 6)
  │   💬 Args: [pending, proposedManager, "Proposal should exist"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 7)
  │   💬 Args: [clearedPending, address(0), "Proposal should be cleared after governance override"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 8)
      💬 Args: [superVaultAggregator.getMainManager(address(strategy)), newManager, "New manager should be set"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests that changePrimaryManager clears all pending proposals
