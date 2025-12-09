# Function: test_ResetHighWaterMark_RevertInvalidStrategy()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_ResetHighWaterMark_RevertInvalidStrategy()`
- **Visibility**: public
- **Source Range**: 43259:328:661

## Implementation

```solidity
/// @notice Tests that resetHighWaterMark reverts when strategy is invalid address
function test_ResetHighWaterMark_RevertInvalidStrategy() public {
    address invalidStrategy = _deployAccount(0x27, "InvalidStrategy");
    vm.prank(address(superGovernor));
    vm.expectRevert(ISuperVaultAggregator.UNKNOWN_STRATEGY.selector);
    superVaultAggregator.resetHighWaterMark(invalidStrategy);
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

- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_ResetHighWaterMark_RevertInvalidStrategy() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 1)
      💬 Args: [0x27, "InvalidStrategy"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests that resetHighWaterMark reverts when strategy is invalid address
