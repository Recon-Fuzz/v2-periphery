# Function: test_ExecuteChangePrimaryManager_ClearsPendingMinUpdateIntervalProposal()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_ExecuteChangePrimaryManager_ClearsPendingMinUpdateIntervalProposal()`
- **Visibility**: public
- **Source Range**: 85648:1524:661

## Implementation

```solidity
/// @notice Tests that executeChangePrimaryManager clears pending minUpdateInterval proposal
///  @dev This prevents stale proposals from being executed after manager handover
function test_ExecuteChangePrimaryManager_ClearsPendingMinUpdateIntervalProposal() public {
    uint256 newMinUpdateInterval = 100;
    vm.prank(manager);
    superVaultAggregator.proposeMinUpdateIntervalChange(strategy, newMinUpdateInterval);
    (uint256 proposedInterval, uint256 effectiveTime) = superVaultAggregator.getProposedMinUpdateInterval(strategy);
    assertEq(proposedInterval, newMinUpdateInterval, "MinUpdateInterval proposal should exist");
    assertTrue(effectiveTime > 0, "MinUpdateInterval effective time should be set");
    address newPrimaryManager = _deployAccount(0x21, "NewPrimaryManager");
    vm.prank(secondaryManager);
    superVaultAggregator.proposeChangePrimaryManager(strategy, newPrimaryManager, treasury);
    vm.warp((block.timestamp + 7 days) + 1);
    superVaultAggregator.executeChangePrimaryManager(strategy);
    (proposedInterval, effectiveTime) = superVaultAggregator.getProposedMinUpdateInterval(strategy);
    assertEq(proposedInterval, 0, "MinUpdateInterval proposal should be cleared after manager change");
    assertEq(effectiveTime, 0, "MinUpdateInterval effective time should be cleared after manager change");
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

## External Calls

- **Vm::prank(address)**
- **SuperVaultAggregator::proposeMinUpdateIntervalChange(address,uint256)**
- **SuperVaultAggregator::getProposedMinUpdateInterval(address)**
- **SuperVaultAggregator::proposeChangePrimaryManager(address,address,address)**
- **Vm::warp(uint256)**
- **SuperVaultAggregator::executeChangePrimaryManager(address)**

## State Variable Reads

- **manager** (`address`)
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`address`)
- **secondaryManager** (`address`)
- **treasury** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_ExecuteChangePrimaryManager_ClearsPendingMinUpdateIntervalProposal() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [proposedInterval, newMinUpdateInterval, "MinUpdateInterval proposal should exist"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 2)
  │   💬 Args: [effectiveTime > 0, "MinUpdateInterval effective time should be set"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 3)
  │   💬 Args: [0x21, "NewPrimaryManager"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 4)
  │   💬 Args: [proposedInterval, 0, "MinUpdateInterval proposal should be cleared after manager change"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 5)
      💬 Args: [effectiveTime, 0, "MinUpdateInterval effective time should be cleared after manager change"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests that executeChangePrimaryManager clears pending minUpdateInterval proposal
 @dev This prevents stale proposals from being executed after manager handover
