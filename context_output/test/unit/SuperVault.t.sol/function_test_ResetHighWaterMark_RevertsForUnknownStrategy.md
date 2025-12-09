# Function: test_ResetHighWaterMark_RevertsForUnknownStrategy()

**Contract**: [test/unit/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_ResetHighWaterMark_RevertsForUnknownStrategy()`
- **Visibility**: public
- **Source Range**: 223618:306:660

## Implementation

```solidity
/// @notice Tests that resetHighWaterMark reverts for non-existent strategy
function test_ResetHighWaterMark_RevertsForUnknownStrategy() public {
    address fakeStrategy = _deployAccount(0xFAFE, "FakeStrategy");
    vm.prank(sGovernor);
    vm.expectRevert(ISuperVaultAggregator.UNKNOWN_STRATEGY.selector);
    superGovernor.resetHighWaterMark(fakeStrategy);
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
- **SuperGovernor::resetHighWaterMark(address)**

## State Variable Reads

- **sGovernor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_ResetHighWaterMark_RevertsForUnknownStrategy() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 1)
      💬 Args: [0xFAFE, "FakeStrategy"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests that resetHighWaterMark reverts for non-existent strategy
