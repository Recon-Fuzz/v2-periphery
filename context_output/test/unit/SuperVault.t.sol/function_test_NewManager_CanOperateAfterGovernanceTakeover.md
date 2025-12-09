# Function: test_NewManager_CanOperateAfterGovernanceTakeover()

**Contract**: [test/unit/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_NewManager_CanOperateAfterGovernanceTakeover()`
- **Visibility**: public
- **Source Range**: 224007:907:660

## Implementation

```solidity
/// @notice Tests that new manager can operate after governance takeover
function test_NewManager_CanOperateAfterGovernanceTakeover() public {
    address newManager = _deployAccount(0x111, "NewManager");
    address newFeeRecipient = _deployAccount(0x222, "NewFeeRecipient");
    vm.prank(sGovernor);
    superGovernor.changePrimaryManager(address(strategy), newManager, newFeeRecipient);
    vm.prank(newManager);
    superVaultAggregator.pauseStrategy(address(strategy));
    assertTrue(superVaultAggregator.isStrategyPaused(address(strategy)), "New manager should be able to pause");
    vm.prank(newManager);
    superVaultAggregator.unpauseStrategy(address(strategy));
    assertFalse(superVaultAggregator.isStrategyPaused(address(strategy)), "New manager should be able to unpause");
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

### assertTrue(bool,string)

- **Kind**: internal
- **Source**: 1894:148:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertTrue(bool,string)`

```solidity
function assertTrue(bool data, string memory err) virtual internal pure {
    if (!data) {
        vm.assertTrue(data, err);
    }
}
```

### assertFalse(bool,string)

- **Kind**: internal
- **Source**: 2179:149:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertFalse(bool,string)`

```solidity
function assertFalse(bool data, string memory err) virtual internal pure {
    if (data) {
        vm.assertFalse(data, err);
    }
}
```

## External Calls

- **Vm::prank(address)**
- **SuperGovernor::changePrimaryManager(address,address,address)**
- **SuperVaultAggregator::pauseStrategy(address)**
- **SuperVaultAggregator::isStrategyPaused(address)**
- **SuperVaultAggregator::unpauseStrategy(address)**

## State Variable Reads

- **sGovernor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **strategy** (`contract SuperVaultStrategy`) [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_NewManager_CanOperateAfterGovernanceTakeover() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 1)
  │   💬 Args: [0x111, "NewManager"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 2)
  │   💬 Args: [0x222, "NewFeeRecipient"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 3)
  │   💬 Args: [superVaultAggregator.isStrategyPaused(address(strategy)), "New manager should be able to pause"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 4)
      💬 Args: [superVaultAggregator.isStrategyPaused(address(strategy)), "New manager should be able to unpause"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests that new manager can operate after governance takeover
