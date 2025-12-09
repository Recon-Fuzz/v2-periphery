# Function: test_ChangePrimaryManager_RevertZeroAddressNewManager()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_ChangePrimaryManager_RevertZeroAddressNewManager()`
- **Visibility**: public
- **Source Range**: 38744:347:661

## Implementation

```solidity
/// @notice Tests that changePrimaryManager reverts when newManager is zero address
function test_ChangePrimaryManager_RevertZeroAddressNewManager() public {
    address feeRecipient = _deployAccount(0x25, "FeeRecipient");
    vm.prank(address(superGovernor));
    vm.expectRevert(ISuperVaultAggregator.ZERO_ADDRESS.selector);
    superVaultAggregator.changePrimaryManager(strategy, address(0), feeRecipient);
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
- **strategy** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_ChangePrimaryManager_RevertZeroAddressNewManager() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 1)
      💬 Args: [0x25, "FeeRecipient"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests that changePrimaryManager reverts when newManager is zero address
