# Function: test_ManageYieldSource_RevertsOnNonPrimaryManager()

**Contract**: [test/unit/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_ManageYieldSource_RevertsOnNonPrimaryManager()`
- **Visibility**: public
- **Source Range**: 112543:363:660

## Implementation

```solidity
/// @notice Tests manageYieldSource (singular) reverts when caller is not primary manager
///  @dev Covers SuperVaultStrategy.sol:462 (_isPrimaryManager check)
function test_ManageYieldSource_RevertsOnNonPrimaryManager() public {
    address notManager = _deployAccount(0xBAD, "NotManager");
    vm.prank(notManager);
    vm.expectRevert(ISuperVaultStrategy.MANAGER_NOT_AUTHORIZED.selector);
    strategy.manageYieldSource(address(0x1234), address(0x5678), ISuperVaultStrategy.YieldSourceAction.Add);
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
- **SuperVaultStrategy::manageYieldSource(address,address,enum ISuperVaultStrategy.YieldSourceAction)**

## State Variable Reads

- **strategy** (`contract SuperVaultStrategy`) [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_ManageYieldSource_RevertsOnNonPrimaryManager() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 1)
      💬 Args: [0xBAD, "NotManager"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests manageYieldSource (singular) reverts when caller is not primary manager
 @dev Covers SuperVaultStrategy.sol:462 (_isPrimaryManager check)
