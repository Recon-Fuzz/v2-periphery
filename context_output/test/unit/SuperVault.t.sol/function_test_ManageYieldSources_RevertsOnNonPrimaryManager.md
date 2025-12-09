# Function: test_ManageYieldSources_RevertsOnNonPrimaryManager()

**Contract**: [test/unit/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_ManageYieldSources_RevertsOnNonPrimaryManager()`
- **Visibility**: public
- **Source Range**: 111683:687:660

## Implementation

```solidity
/// @notice Tests manageYieldSources reverts when caller is not primary manager
///  @dev Covers SuperVaultStrategy.sol:474 (_isPrimaryManager check)
function test_ManageYieldSources_RevertsOnNonPrimaryManager() public {
    address notManager = _deployAccount(0xBAD, "NotManager");
    address[] memory sources = new address[](1);
    sources[0] = address(0x1234);
    address[] memory oracles = new address[](1);
    oracles[0] = address(0x5678);
    ISuperVaultStrategy.YieldSourceAction[] memory actionTypes = new ISuperVaultStrategy.YieldSourceAction[](1);
    actionTypes[0] = ISuperVaultStrategy.YieldSourceAction.Add;
    vm.prank(notManager);
    vm.expectRevert(ISuperVaultStrategy.MANAGER_NOT_AUTHORIZED.selector);
    strategy.manageYieldSources(sources, oracles, actionTypes);
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
- **SuperVaultStrategy::manageYieldSources(address[],address[],enum ISuperVaultStrategy.YieldSourceAction[])**

## State Variable Reads

- **strategy** (`contract SuperVaultStrategy`) [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_ManageYieldSources_RevertsOnNonPrimaryManager() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 1)
      💬 Args: [0xBAD, "NotManager"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests manageYieldSources reverts when caller is not primary manager
 @dev Covers SuperVaultStrategy.sol:474 (_isPrimaryManager check)
