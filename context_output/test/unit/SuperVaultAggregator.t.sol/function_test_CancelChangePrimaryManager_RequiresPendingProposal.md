# Function: test_CancelChangePrimaryManager_RequiresPendingProposal()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_CancelChangePrimaryManager_RequiresPendingProposal()`
- **Visibility**: public
- **Source Range**: 91967:965:661

## Implementation

```solidity
/// @notice Tests that canceling requires a pending proposal
function test_CancelChangePrimaryManager_RequiresPendingProposal() public {
    vm.prank(manager);
    vm.expectRevert(ISuperVaultAggregator.NO_PENDING_MANAGER_CHANGE.selector);
    superVaultAggregator.cancelChangePrimaryManager(strategy);
    address newManager = _deployAccount(0xBE, "NewManager");
    vm.prank(secondaryManager);
    superVaultAggregator.proposeChangePrimaryManager(strategy, newManager, treasury);
    vm.warp((block.timestamp + 7 days) + 1);
    vm.prank(secondaryManager);
    superVaultAggregator.executeChangePrimaryManager(strategy);
    vm.prank(newManager);
    vm.expectRevert(ISuperVaultAggregator.NO_PENDING_MANAGER_CHANGE.selector);
    superVaultAggregator.cancelChangePrimaryManager(strategy);
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

## External Calls

- **Vm::prank(address)**
- **Vm::expectRevert(bytes4)**
- **SuperVaultAggregator::cancelChangePrimaryManager(address)**
- **SuperVaultAggregator::proposeChangePrimaryManager(address,address,address)**
- **Vm::warp(uint256)**
- **SuperVaultAggregator::executeChangePrimaryManager(address)**

## State Variable Reads

- **manager** (`address`)
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`address`)
- **secondaryManager** (`address`)
- **treasury** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_CancelChangePrimaryManager_RequiresPendingProposal() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 1)
      💬 Args: [0xBE, "NewManager"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests that canceling requires a pending proposal
