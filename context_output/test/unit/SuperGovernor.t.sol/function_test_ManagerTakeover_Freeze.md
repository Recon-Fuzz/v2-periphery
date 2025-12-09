# Function: test_ManagerTakeover_Freeze()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_ManagerTakeover_Freeze()`
- **Visibility**: public
- **Source Range**: 21809:333:659

## Implementation

```solidity
/// @notice Tests freezing manager takeovers
function test_ManagerTakeover_Freeze() public {
    vm.prank(sGovernor);
    vm.expectEmit(true, false, false, false);
    emit ISuperGovernor.ManagerTakeoversFrozen();
    superGovernor.freezeManagerTakeover();
    assertTrue(superGovernor.isManagerTakeoverFrozen(), "Manager takeovers should be frozen");
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
- **Vm::expectEmit(bool,bool,bool,bool)**
- **SuperGovernor::freezeManagerTakeover()**
- **SuperGovernor::isManagerTakeoverFrozen()**

## State Variable Reads

- **sGovernor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_ManagerTakeover_Freeze() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 1)
      💬 Args: [superGovernor.isManagerTakeoverFrozen(), "Manager takeovers should be frozen"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests freezing manager takeovers
