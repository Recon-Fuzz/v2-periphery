# Function: test_ChangeGlobalLeavesStatus_Revert_UnknownStrategy()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_ChangeGlobalLeavesStatus_Revert_UnknownStrategy()`
- **Visibility**: public
- **Source Range**: 158265:519:661

## Implementation

```solidity
/// @notice Tests that unknown strategy reverts
function test_ChangeGlobalLeavesStatus_Revert_UnknownStrategy() public {
    address unknownStrategy = _deployAccount(0x99, "UnknownStrategy");
    bytes32[] memory leaves = new bytes32[](1);
    leaves[0] = keccak256("test_leaf");
    bool[] memory statuses = new bool[](1);
    statuses[0] = true;
    vm.prank(manager);
    vm.expectRevert(ISuperVaultAggregator.UNKNOWN_STRATEGY.selector);
    superVaultAggregator.changeGlobalLeavesStatus(leaves, statuses, unknownStrategy);
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
- **SuperVaultAggregator::changeGlobalLeavesStatus(bytes32[],bool[],address)**

## State Variable Reads

- **manager** (`address`)
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_ChangeGlobalLeavesStatus_Revert_UnknownStrategy() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 1)
      💬 Args: [0x99, "UnknownStrategy"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests that unknown strategy reverts
