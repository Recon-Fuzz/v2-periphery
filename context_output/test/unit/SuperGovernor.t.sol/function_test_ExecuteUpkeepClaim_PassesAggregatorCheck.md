# Function: test_ExecuteUpkeepClaim_PassesAggregatorCheck()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_ExecuteUpkeepClaim_PassesAggregatorCheck()`
- **Visibility**: public
- **Source Range**: 45480:836:659

## Implementation

```solidity
/// @notice Tests executeUpkeepClaim passes aggregator check when set
///  @dev Covers SuperGovernor.sol:513 - aggregator check passes when aggregator is set
///  Note: May fail with INSUFFICIENT_UPKEEP if no upkeep balance exists, but that validates
///  the aggregator check passed (since CONTRACT_NOT_FOUND would occur first)
function test_ExecuteUpkeepClaim_PassesAggregatorCheck() public {
    uint256 claimAmount = 1000;
    vm.prank(governor);
    try superGovernor.executeUpkeepClaim(claimAmount) {} catch (bytes memory reason) {
        bytes4 selector = bytes4(reason);
        bytes4 contractNotFound = ISuperGovernor.CONTRACT_NOT_FOUND.selector;
        assertTrue(selector != contractNotFound, "Should not revert with CONTRACT_NOT_FOUND");
    }
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

## External Calls

- **Vm::prank(address)**
- **SuperGovernor::executeUpkeepClaim(uint256)**

## State Variable Reads

- **governor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_ExecuteUpkeepClaim_PassesAggregatorCheck() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 1)
      💬 Args: [selector != contractNotFound, "Should not revert with CONTRACT_NOT_FOUND"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests executeUpkeepClaim passes aggregator check when set
 @dev Covers SuperGovernor.sol:513 - aggregator check passes when aggregator is set
 Note: May fail with INSUFFICIENT_UPKEEP if no upkeep balance exists, but that validates
 the aggregator check passed (since CONTRACT_NOT_FOUND would occur first)
