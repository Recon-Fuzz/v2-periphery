# Function: test_ChangePrimaryManager_ClearsPendingHookProposals()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_ChangePrimaryManager_ClearsPendingHookProposals()`
- **Visibility**: public
- **Source Range**: 78980:1242:661

## Implementation

```solidity
/// @notice Tests emergency replacement clears pending hook root proposals
function test_ChangePrimaryManager_ClearsPendingHookProposals() public {
    bytes32 newHookRoot = keccak256("new_hook_root");
    vm.prank(manager);
    superVaultAggregator.proposeStrategyHooksRoot(strategy, newHookRoot);
    (bytes32 proposedRoot, uint256 effectiveTime) = superVaultAggregator.getProposedStrategyHooksRoot(strategy);
    assertEq(proposedRoot, newHookRoot, "Hook proposal should exist");
    assertTrue(effectiveTime > 0, "Hook effective time should be set");
    address emergencyManager = _deployAccount(0x11, "EmergencyManager");
    address feeRecipient = _deployAccount(0x2A, "FeeRecipient");
    vm.prank(address(superGovernor));
    superVaultAggregator.changePrimaryManager(strategy, emergencyManager, feeRecipient);
    (proposedRoot, effectiveTime) = superVaultAggregator.getProposedStrategyHooksRoot(strategy);
    assertEq(proposedRoot, bytes32(0), "Hook proposal should be cleared");
    assertEq(effectiveTime, 0, "Hook effective time should be cleared");
}
```

## Related Implementations

### assertEq(bytes32,bytes32,string)

- **Kind**: internal
- **Source**: 4521:177:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(bytes32,bytes32,string)`

```solidity
function assertEq(bytes32 left, bytes32 right, string memory err) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right, err);
    }
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

- **Vm::prank(address)**
- **SuperVaultAggregator::proposeStrategyHooksRoot(address,bytes32)**
- **SuperVaultAggregator::getProposedStrategyHooksRoot(address)**
- **SuperVaultAggregator::changePrimaryManager(address,address,address)**

## State Variable Reads

- **manager** (`address`)
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_ChangePrimaryManager_ClearsPendingHookProposals() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(bytes32,bytes32,string) (NodeID: 1)
  │   💬 Args: [proposedRoot, newHookRoot, "Hook proposal should exist"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 2)
  │   💬 Args: [effectiveTime > 0, "Hook effective time should be set"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 3)
  │   💬 Args: [0x11, "EmergencyManager"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 4)
  │   💬 Args: [0x2A, "FeeRecipient"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(bytes32,bytes32,string) (NodeID: 5)
  │   💬 Args: [proposedRoot, bytes32(0), "Hook proposal should be cleared"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 6)
      💬 Args: [effectiveTime, 0, "Hook effective time should be cleared"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests emergency replacement clears pending hook root proposals
