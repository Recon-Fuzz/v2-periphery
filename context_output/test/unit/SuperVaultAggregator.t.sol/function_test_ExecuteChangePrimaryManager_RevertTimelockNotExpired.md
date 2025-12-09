# Function: test_ExecuteChangePrimaryManager_RevertTimelockNotExpired()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_ExecuteChangePrimaryManager_RevertTimelockNotExpired()`
- **Visibility**: public
- **Source Range**: 40462:837:661

## Implementation

```solidity
/// @notice Tests that executeChangePrimaryManager reverts when timelock hasn't expired
function test_ExecuteChangePrimaryManager_RevertTimelockNotExpired() public {
    address newManager = _deployAccount(0x24, "NewManager");
    vm.prank(secondaryManager);
    superVaultAggregator.proposeChangePrimaryManager(strategy, newManager, treasury);
    vm.expectRevert(ISuperVaultAggregator.TIMELOCK_NOT_EXPIRED.selector);
    superVaultAggregator.executeChangePrimaryManager(strategy);
    vm.warp((block.timestamp + 7 days) - 1);
    vm.expectRevert(ISuperVaultAggregator.TIMELOCK_NOT_EXPIRED.selector);
    superVaultAggregator.executeChangePrimaryManager(strategy);
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
- **SuperVaultAggregator::executeChangePrimaryManager(address)**
- **Vm::warp(uint256)**

## State Variable Reads

- **secondaryManager** (`address`)
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`address`)
- **treasury** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_ExecuteChangePrimaryManager_RevertTimelockNotExpired() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 1)
      💬 Args: [0x24, "NewManager"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests that executeChangePrimaryManager reverts when timelock hasn't expired
