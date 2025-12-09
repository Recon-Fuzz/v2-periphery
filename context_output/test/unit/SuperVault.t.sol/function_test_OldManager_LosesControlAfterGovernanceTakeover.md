# Function: test_OldManager_LosesControlAfterGovernanceTakeover()

**Contract**: [test/unit/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_OldManager_LosesControlAfterGovernanceTakeover()`
- **Visibility**: public
- **Source Range**: 224999:612:660

## Implementation

```solidity
/// @notice Tests that old manager loses control after governance takeover
function test_OldManager_LosesControlAfterGovernanceTakeover() public {
    address newManager = _deployAccount(0x111, "NewManager");
    address newFeeRecipient = _deployAccount(0x222, "NewFeeRecipient");
    vm.prank(sGovernor);
    superGovernor.changePrimaryManager(address(strategy), newManager, newFeeRecipient);
    vm.prank(manager);
    vm.expectRevert(ISuperVaultAggregator.UNAUTHORIZED_UPDATE_AUTHORITY.selector);
    superVaultAggregator.pauseStrategy(address(strategy));
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
- **SuperGovernor::changePrimaryManager(address,address,address)**
- **Vm::expectRevert(bytes4)**
- **SuperVaultAggregator::pauseStrategy(address)**

## State Variable Reads

- **sGovernor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **strategy** (`contract SuperVaultStrategy`) [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]
- **manager** (`address`)
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_OldManager_LosesControlAfterGovernanceTakeover() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 1)
  │   💬 Args: [0x111, "NewManager"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 2)
      💬 Args: [0x222, "NewFeeRecipient"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests that old manager loses control after governance takeover
