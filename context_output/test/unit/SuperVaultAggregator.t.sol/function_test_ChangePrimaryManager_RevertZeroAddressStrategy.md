# Function: test_ChangePrimaryManager_RevertZeroAddressStrategy()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_ChangePrimaryManager_RevertZeroAddressStrategy()`
- **Visibility**: public
- **Source Range**: 38141:509:661

## Implementation

```solidity
/// @notice Tests that changePrimaryManager reverts when strategy is zero address (caught by validStrategy modifier)
function test_ChangePrimaryManager_RevertZeroAddressStrategy() public {
    address newManager = _deployAccount(0x23, "NewManager");
    address feeRecipient = _deployAccount(0x24, "FeeRecipient");
    vm.prank(address(superGovernor));
    vm.expectRevert(ISuperVaultAggregator.UNKNOWN_STRATEGY.selector);
    superVaultAggregator.changePrimaryManager(address(0), newManager, feeRecipient);
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
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_ChangePrimaryManager_RevertZeroAddressStrategy() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 1)
  │   💬 Args: [0x23, "NewManager"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 2)
      💬 Args: [0x24, "FeeRecipient"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests that changePrimaryManager reverts when strategy is zero address (caught by validStrategy modifier)
