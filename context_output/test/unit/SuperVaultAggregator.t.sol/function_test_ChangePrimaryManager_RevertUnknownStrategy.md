# Function: test_ChangePrimaryManager_RevertUnknownStrategy()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_ChangePrimaryManager_RevertUnknownStrategy()`
- **Visibility**: public
- **Source Range**: 100083:493:661

## Implementation

```solidity
/// @notice Tests emergency replacement with unknown strategy reverts
function test_ChangePrimaryManager_RevertUnknownStrategy() public {
    address unknownStrategy = _deployAccount(0x17, "UnknownStrategy");
    address newManager = _deployAccount(0x18, "NewManager");
    address feeRecipient = _deployAccount(0x2E, "FeeRecipient");
    vm.prank(address(superGovernor));
    vm.expectRevert(ISuperVaultAggregator.UNKNOWN_STRATEGY.selector);
    superVaultAggregator.changePrimaryManager(unknownStrategy, newManager, feeRecipient);
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
- **SuperVaultAggregator::changePrimaryManager(address,address,address)**

## State Variable Reads

- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_ChangePrimaryManager_RevertUnknownStrategy() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 1)
  │   💬 Args: [0x17, "UnknownStrategy"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 2)
  │   💬 Args: [0x18, "NewManager"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 3)
      💬 Args: [0x2E, "FeeRecipient"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests emergency replacement with unknown strategy reverts
