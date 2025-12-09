# Function: test_MinStalenessManagement_InitialValue()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_MinStalenessManagement_InitialValue()`
- **Visibility**: public
- **Source Range**: 95527:253:659

## Implementation

```solidity
/// @notice Tests the initial minimum staleness value
function test_MinStalenessManagement_InitialValue() public view {
    assertEq(superGovernor.getMinStaleness(), 300, "Initial minimum staleness should be 300 seconds");
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

## External Calls

- **SuperGovernor::getMinStaleness()**

## State Variable Reads

- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_MinStalenessManagement_InitialValue() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
      💬 Args: [superGovernor.getMinStaleness(), 300, "Initial minimum staleness should be 300 seconds"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests the initial minimum staleness value
