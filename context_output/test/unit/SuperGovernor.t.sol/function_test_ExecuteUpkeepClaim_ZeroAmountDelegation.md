# Function: test_ExecuteUpkeepClaim_ZeroAmountDelegation()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_ExecuteUpkeepClaim_ZeroAmountDelegation()`
- **Visibility**: public
- **Source Range**: 49492:740:659

## Implementation

```solidity
/// @notice Tests executeUpkeepClaim with zero amount delegates correctly
///  @dev Verifies zero amount is properly passed to aggregator
function test_ExecuteUpkeepClaim_ZeroAmountDelegation() public {
    MockSuperVaultAggregator mockAggregator = new MockSuperVaultAggregator();
    bytes32 aggregatorKey = superGovernor.SUPER_VAULT_AGGREGATOR();
    vm.prank(sGovernor);
    superGovernor.setAddress(aggregatorKey, address(mockAggregator));
    vm.prank(governor);
    superGovernor.executeUpkeepClaim(0);
    assertTrue(mockAggregator.claimUpkeepCalled(), "Aggregator should have received the claim call");
    assertEq(mockAggregator.lastClaimAmount(), 0, "Claim amount should be zero");
}
```

## Related Implementations

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

- **SuperGovernor::SUPER_VAULT_AGGREGATOR()**
- **Vm::prank(address)**
- **SuperGovernor::setAddress(bytes32,address)**
- **SuperGovernor::executeUpkeepClaim(uint256)**
- **MockSuperVaultAggregator::claimUpkeepCalled()**
- **MockSuperVaultAggregator::lastClaimAmount()**

## State Variable Reads

- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **sGovernor** (`address`)
- **governor** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_ExecuteUpkeepClaim_ZeroAmountDelegation() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 1)
  │   💬 Args: [mockAggregator.claimUpkeepCalled(), "Aggregator should have received the claim call"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
      💬 Args: [mockAggregator.lastClaimAmount(), 0, "Claim amount should be zero"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests executeUpkeepClaim with zero amount delegates correctly
 @dev Verifies zero amount is properly passed to aggregator
