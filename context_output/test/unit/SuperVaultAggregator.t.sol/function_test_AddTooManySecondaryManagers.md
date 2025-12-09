# Function: test_AddTooManySecondaryManagers()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_AddTooManySecondaryManagers()`
- **Visibility**: public
- **Source Range**: 76665:733:661

## Implementation

```solidity
/// @notice Tests emergency replacement clears all secondary managers
function test_AddTooManySecondaryManagers() public {
    uint256 len = 6;
    address[] memory secondaryManagers = new address[](len);
    for (uint256 i = 0; i < (len - 1); ++i) {
        secondaryManagers[i] = _deployAccount(10 + i, "SecondaryManager");
    }
    vm.startPrank(manager);
    for (uint256 i = 0; i < (len - 2); ++i) {
        superVaultAggregator.addSecondaryManager(strategy, secondaryManagers[i]);
    }
    address lastSecondaryManager = _deployAccount(20, "SecondaryManager");
    vm.expectRevert(ISuperVaultAggregator.TOO_MANY_SECONDARY_MANAGERS.selector);
    superVaultAggregator.addSecondaryManager(strategy, lastSecondaryManager);
    vm.stopPrank();
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

- **Vm::startPrank(address)**
- **SuperVaultAggregator::addSecondaryManager(address,address)**
- **Vm::expectRevert(bytes4)**
- **Vm::stopPrank()**

## State Variable Reads

- **manager** (`address`)
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_AddTooManySecondaryManagers() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 1)
  │   💬 Args: [10 + i, "SecondaryManager"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 2)
      💬 Args: [20, "SecondaryManager"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests emergency replacement clears all secondary managers
