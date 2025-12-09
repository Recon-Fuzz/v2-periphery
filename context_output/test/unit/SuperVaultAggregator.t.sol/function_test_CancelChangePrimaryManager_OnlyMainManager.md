# Function: test_CancelChangePrimaryManager_OnlyMainManager()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_CancelChangePrimaryManager_OnlyMainManager()`
- **Visibility**: public
- **Source Range**: 90897:999:661

## Implementation

```solidity
/// @notice Tests that only the current mainManager can cancel
function test_CancelChangePrimaryManager_OnlyMainManager() public {
    address newManager = _deployAccount(0xBC, "NewManager");
    vm.prank(secondaryManager);
    superVaultAggregator.proposeChangePrimaryManager(strategy, newManager, treasury);
    vm.prank(secondaryManager);
    vm.expectRevert(ISuperVaultAggregator.UNAUTHORIZED_UPDATE_AUTHORITY.selector);
    superVaultAggregator.cancelChangePrimaryManager(strategy);
    address randomUser = _deployAccount(0xBD, "RandomUser");
    vm.prank(randomUser);
    vm.expectRevert(ISuperVaultAggregator.UNAUTHORIZED_UPDATE_AUTHORITY.selector);
    superVaultAggregator.cancelChangePrimaryManager(strategy);
    vm.prank(manager);
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
- **SuperVaultAggregator::proposeChangePrimaryManager(address,address,address)**
- **Vm::expectRevert(bytes4)**
- **SuperVaultAggregator::cancelChangePrimaryManager(address)**

## State Variable Reads

- **secondaryManager** (`address`)
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`address`)
- **treasury** (`address`)
- **manager** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_CancelChangePrimaryManager_OnlyMainManager() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 1)
  │   💬 Args: [0xBC, "NewManager"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 2)
      💬 Args: [0xBD, "RandomUser"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests that only the current mainManager can cancel
