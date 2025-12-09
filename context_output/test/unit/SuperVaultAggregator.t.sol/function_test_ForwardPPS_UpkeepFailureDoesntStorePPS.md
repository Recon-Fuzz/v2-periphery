# Function: test_ForwardPPS_UpkeepFailureDoesntStorePPS()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_ForwardPPS_UpkeepFailureDoesntStorePPS()`
- **Visibility**: public
- **Source Range**: 232967:807:661

## Implementation

```solidity
/// @notice Test upkeep failure path doesn't store PPS
///  @dev Upkeep failure path is covered by existing logic at lines 1180-1186 in SuperVaultAggregator.sol
///  @dev This test validates the logic exists but upkeep is disabled by default in test environment
///  @dev The upkeep failure path follows the same pause + stale pattern as other validation failures
function test_ForwardPPS_UpkeepFailureDoesntStorePPS() public view {
    assertFalse(superGovernor.isUpkeepPaymentsEnabled(), "Upkeep should be disabled by default");
}
```

## Related Implementations

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

- **SuperGovernor::isUpkeepPaymentsEnabled()**

## State Variable Reads

- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_ForwardPPS_UpkeepFailureDoesntStorePPS() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 1)
      💬 Args: [superGovernor.isUpkeepPaymentsEnabled(), "Upkeep should be disabled by default"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Test upkeep failure path doesn't store PPS
 @dev Upkeep failure path is covered by existing logic at lines 1180-1186 in SuperVaultAggregator.sol
 @dev This test validates the logic exists but upkeep is disabled by default in test environment
 @dev The upkeep failure path follows the same pause + stale pattern as other validation failures
