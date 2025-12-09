# Function: test_ChangePrimaryManager_ThenResetHighWaterMark()

**Contract**: [test/unit/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_ChangePrimaryManager_ThenResetHighWaterMark()`
- **Visibility**: public
- **Source Range**: 214344:1145:660

## Implementation

```solidity
/// @notice Tests the complete flow of changePrimaryManager + resetHighWaterMark
///  @dev This is the recommended pattern when replacing a manager with PPS < HWM
function test_ChangePrimaryManager_ThenResetHighWaterMark() public {
    address newManager = _deployAccount(0x111, "NewManager");
    address newFeeRecipient = _deployAccount(0x222, "NewFeeRecipient");
    address initialManager = superVaultAggregator.getMainManager(address(strategy));
    assertEq(initialManager, manager, "Initial manager should be set");
    vm.prank(sGovernor);
    superGovernor.changePrimaryManager(address(strategy), newManager, newFeeRecipient);
    assertEq(superVaultAggregator.getMainManager(address(strategy)), newManager, "Manager should be updated");
    vm.prank(sGovernor);
    superGovernor.resetHighWaterMark(address(strategy));
    uint256 currentPPS = strategy.getStoredPPS();
    uint256 newHwm = strategy.vaultHwmPps();
    assertEq(newHwm, currentPPS, "HWM should be reset to current PPS after manager change");
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

### assertEq(address,address,string)

- **Kind**: internal
- **Source**: 4179:177:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(address,address,string)`

```solidity
function assertEq(address left, address right, string memory err) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right, err);
    }
}
```

### assertEq(uint256,uint256,string)

- **Kind**: internal
- **Source**: 2823:177:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256,string)`

```solidity
function assertEq(uint256 left, uint256 right, string memory err) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right, err);
    }
}
```

## External Calls

- **SuperVaultAggregator::getMainManager(address)**
- **Vm::prank(address)**
- **SuperGovernor::changePrimaryManager(address,address,address)**
- **SuperGovernor::resetHighWaterMark(address)**
- **SuperVaultStrategy::getStoredPPS()**
- **SuperVaultStrategy::vaultHwmPps()**

## State Variable Reads

- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`contract SuperVaultStrategy`) [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]
- **manager** (`address`)
- **sGovernor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_ChangePrimaryManager_ThenResetHighWaterMark() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 1)
  │   💬 Args: [0x111, "NewManager"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 2)
  │   💬 Args: [0x222, "NewFeeRecipient"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 3)
  │   💬 Args: [initialManager, manager, "Initial manager should be set"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 4)
  │   💬 Args: [superVaultAggregator.getMainManager(address(strategy)), newManager, "Manager should be updated"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 5)
      💬 Args: [newHwm, currentPPS, "HWM should be reset to current PPS after manager change"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests the complete flow of changePrimaryManager + resetHighWaterMark
 @dev This is the recommended pattern when replacing a manager with PPS < HWM
