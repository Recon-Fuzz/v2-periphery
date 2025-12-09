# Function: test_ResetHighWaterMark_AggregatorRevertsForNonGovernor()

**Contract**: [test/unit/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_ResetHighWaterMark_AggregatorRevertsForNonGovernor()`
- **Visibility**: public
- **Source Range**: 222567:649:660

## Implementation

```solidity
/// @notice Tests that resetHighWaterMark cannot be called directly on aggregator by non-governor
function test_ResetHighWaterMark_AggregatorRevertsForNonGovernor() public {
    vm.prank(manager);
    vm.expectRevert(ISuperVaultAggregator.UNAUTHORIZED_UPDATE_AUTHORITY.selector);
    superVaultAggregator.resetHighWaterMark(address(strategy));
    address randomUser = _deployAccount(0x999, "RandomUser");
    vm.prank(randomUser);
    vm.expectRevert(ISuperVaultAggregator.UNAUTHORIZED_UPDATE_AUTHORITY.selector);
    superVaultAggregator.resetHighWaterMark(address(strategy));
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
- **SuperVaultAggregator::resetHighWaterMark(address)**

## State Variable Reads

- **manager** (`address`)
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`contract SuperVaultStrategy`) [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_ResetHighWaterMark_AggregatorRevertsForNonGovernor() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 1)
      💬 Args: [0x999, "RandomUser"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests that resetHighWaterMark cannot be called directly on aggregator by non-governor
