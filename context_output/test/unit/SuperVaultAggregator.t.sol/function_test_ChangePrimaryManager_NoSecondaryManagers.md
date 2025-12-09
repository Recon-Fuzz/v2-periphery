# Function: test_ChangePrimaryManager_NoSecondaryManagers()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_ChangePrimaryManager_NoSecondaryManagers()`
- **Visibility**: public
- **Source Range**: 101364:1000:661

## Implementation

```solidity
/// @notice Tests emergency replacement works when no secondary managers exist
function test_ChangePrimaryManager_NoSecondaryManagers() public {
    vm.prank(manager);
    superVaultAggregator.removeSecondaryManager(strategy, secondaryManager);
    address[] memory secondaryManagers = superVaultAggregator.getSecondaryManagers(strategy);
    assertEq(secondaryManagers.length, 0, "No secondary managers should exist");
    address emergencyManager = _deployAccount(0x1A, "EmergencyManager");
    address feeRecipient = _deployAccount(0x30, "FeeRecipient");
    vm.prank(address(superGovernor));
    superVaultAggregator.changePrimaryManager(strategy, emergencyManager, feeRecipient);
    address currentManager = superVaultAggregator.getMainManager(strategy);
    assertEq(currentManager, emergencyManager, "Emergency manager should be set");
}
```

## Related Implementations

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

## External Calls

- **Vm::prank(address)**
- **SuperVaultAggregator::removeSecondaryManager(address,address)**
- **SuperVaultAggregator::getSecondaryManagers(address)**
- **SuperVaultAggregator::changePrimaryManager(address,address,address)**
- **SuperVaultAggregator::getMainManager(address)**

## State Variable Reads

- **manager** (`address`)
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`address`)
- **secondaryManager** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_ChangePrimaryManager_NoSecondaryManagers() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [secondaryManagers.length, 0, "No secondary managers should exist"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 2)
  │   💬 Args: [0x1A, "EmergencyManager"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 3)
  │   💬 Args: [0x30, "FeeRecipient"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 4)
      💬 Args: [currentManager, emergencyManager, "Emergency manager should be set"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests emergency replacement works when no secondary managers exist
