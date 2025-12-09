# Function: test_ExecuteUpkeepClaim_Success()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_ExecuteUpkeepClaim_Success()`
- **Visibility**: public
- **Source Range**: 48594:747:659

## Implementation

```solidity
/// @notice Tests executeUpkeepClaim successfully delegates to aggregator
///  @dev Covers SuperGovernor.sol:511-516 success path with aggregator delegation
function test_ExecuteUpkeepClaim_Success() public {
    MockSuperVaultAggregator mockAggregator = new MockSuperVaultAggregator();
    bytes32 aggregatorKey = superGovernor.SUPER_VAULT_AGGREGATOR();
    vm.prank(sGovernor);
    superGovernor.setAddress(aggregatorKey, address(mockAggregator));
    uint256 claimAmount = 1000;
    vm.prank(governor);
    superGovernor.executeUpkeepClaim(claimAmount);
    assertTrue(mockAggregator.claimUpkeepCalled(), "Aggregator should have received the claim call");
    assertEq(mockAggregator.lastClaimAmount(), claimAmount, "Claim amount should match");
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
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_ExecuteUpkeepClaim_Success() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 1)
  │   💬 Args: [mockAggregator.claimUpkeepCalled(), "Aggregator should have received the claim call"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
      💬 Args: [mockAggregator.lastClaimAmount(), claimAmount, "Claim amount should match"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests executeUpkeepClaim successfully delegates to aggregator
 @dev Covers SuperGovernor.sol:511-516 success path with aggregator delegation
