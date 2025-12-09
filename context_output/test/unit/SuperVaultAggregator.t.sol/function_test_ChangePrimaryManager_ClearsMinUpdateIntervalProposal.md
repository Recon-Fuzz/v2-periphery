# Function: test_ChangePrimaryManager_ClearsMinUpdateIntervalProposal()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_ChangePrimaryManager_ClearsMinUpdateIntervalProposal()`
- **Visibility**: public
- **Source Range**: 208009:1230:661

## Implementation

```solidity
/// @notice Test 12: Manager replacement clears proposal
function test_ChangePrimaryManager_ClearsMinUpdateIntervalProposal() public {
    vm.prank(manager);
    superVaultAggregator.proposeMinUpdateIntervalChange(strategy, 10);
    (uint256 proposedInterval, uint256 effectiveTime) = superVaultAggregator.getProposedMinUpdateInterval(strategy);
    assertGt(proposedInterval, 0, "Proposal should exist");
    assertGt(effectiveTime, 0, "Effective time should exist");
    address newManager = address(0x999);
    vm.prank(sGovernor);
    superGovernor.changePrimaryManager(strategy, newManager, treasury);
    (proposedInterval, effectiveTime) = superVaultAggregator.getProposedMinUpdateInterval(strategy);
    assertEq(proposedInterval, 0, "Proposal should be cleared");
    assertEq(effectiveTime, 0, "Effective time should be cleared");
    vm.warp((block.timestamp + 3 days) + 1);
    vm.expectRevert(ISuperVaultAggregator.NO_PENDING_MIN_UPDATE_INTERVAL_CHANGE.selector);
    superVaultAggregator.executeMinUpdateIntervalChange(strategy);
}
```

## Related Implementations

### assertGt(uint256,uint256,string)

- **Kind**: internal
- **Source**: 14795:177:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertGt(uint256,uint256,string)`

```solidity
function assertGt(uint256 left, uint256 right, string memory err) virtual internal pure {
    if (left <= right) {
        vm.assertGt(left, right, err);
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

- **Vm::prank(address)**
- **SuperVaultAggregator::proposeMinUpdateIntervalChange(address,uint256)**
- **SuperVaultAggregator::getProposedMinUpdateInterval(address)**
- **SuperGovernor::changePrimaryManager(address,address,address)**
- **Vm::warp(uint256)**
- **Vm::expectRevert(bytes4)**
- **SuperVaultAggregator::executeMinUpdateIntervalChange(address)**

## State Variable Reads

- **manager** (`address`)
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`address`)
- **sGovernor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **treasury** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_ChangePrimaryManager_ClearsMinUpdateIntervalProposal() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [proposedInterval, 0, "Proposal should exist"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 2)
  │   💬 Args: [effectiveTime, 0, "Effective time should exist"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 3)
  │   💬 Args: [proposedInterval, 0, "Proposal should be cleared"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 4)
      💬 Args: [effectiveTime, 0, "Effective time should be cleared"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Test 12: Manager replacement clears proposal
