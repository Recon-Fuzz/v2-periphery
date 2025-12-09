# Function: test_UpkeepPayments_GetProposedStatus_InitialState()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_UpkeepPayments_GetProposedStatus_InitialState()`
- **Visibility**: public
- **Source Range**: 81489:321:659

## Implementation

```solidity
/// @notice Tests getProposedUpkeepPaymentsStatus returns initial state
///  @dev Verifies default values before any proposal is made
function test_UpkeepPayments_GetProposedStatus_InitialState() public view {
    (bool enabled, uint256 effectiveTime) = superGovernor.getProposedUpkeepPaymentsStatus();
    assertEq(enabled, false, "Initial enabled should be false");
    assertEq(effectiveTime, 0, "Initial effective time should be 0");
}
```

## Related Implementations

### assertEq(bool,bool,string)

- **Kind**: internal
- **Source**: 2487:171:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(bool,bool,string)`

```solidity
function assertEq(bool left, bool right, string memory err) virtual internal pure {
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

- **SuperGovernor::getProposedUpkeepPaymentsStatus()**

## State Variable Reads

- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_UpkeepPayments_GetProposedStatus_InitialState() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(bool,bool,string) (NodeID: 1)
  │   💬 Args: [enabled, false, "Initial enabled should be false"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
      💬 Args: [effectiveTime, 0, "Initial effective time should be 0"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests getProposedUpkeepPaymentsStatus returns initial state
 @dev Verifies default values before any proposal is made
