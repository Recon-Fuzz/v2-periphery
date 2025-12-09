# Function: test_HookManagement_Revert_ZeroAddress()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_HookManagement_Revert_ZeroAddress()`
- **Visibility**: public
- **Source Range**: 30879:206:659

## Implementation

```solidity
/// @notice Tests reverting when registering a hook with zero address
function test_HookManagement_Revert_ZeroAddress() public {
    vm.prank(governor);
    vm.expectRevert(ISuperGovernor.INVALID_ADDRESS.selector);
    superGovernor.registerHook(address(0));
}
```

## External Calls

- **Vm::prank(address)**
- **Vm::expectRevert(bytes4)**
- **SuperGovernor::registerHook(address)**

## State Variable Reads

- **governor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_HookManagement_Revert_ZeroAddress() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests reverting when registering a hook with zero address
