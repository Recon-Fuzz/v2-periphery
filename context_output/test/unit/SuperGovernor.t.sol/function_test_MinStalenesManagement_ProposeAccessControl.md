# Function: test_MinStalenesManagement_ProposeAccessControl()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_MinStalenesManagement_ProposeAccessControl()`
- **Visibility**: public
- **Source Range**: 92705:882:659

## Implementation

```solidity
/// @notice Tests access control for proposeMinStaleness (only SUPER_GOVERNOR_ROLE)
function test_MinStalenesManagement_ProposeAccessControl() public {
    uint256 newMinStaleness = 600;
    vm.prank(governor);
    vm.expectRevert(abi.encodeWithSelector(IAccessControl.AccessControlUnauthorizedAccount.selector, governor, SUPER_GOVERNOR_ROLE));
    superGovernor.proposeMinStaleness(newMinStaleness);
    vm.prank(user);
    vm.expectRevert(abi.encodeWithSelector(IAccessControl.AccessControlUnauthorizedAccount.selector, user, SUPER_GOVERNOR_ROLE));
    superGovernor.proposeMinStaleness(newMinStaleness);
    vm.prank(sGovernor);
    superGovernor.proposeMinStaleness(newMinStaleness);
}
```

## External Calls

- **Vm::prank(address)**
- **Vm::expectRevert(bytes)**
- **SuperGovernor::proposeMinStaleness(uint256)**

## State Variable Reads

- **governor** (`address`)
- **SUPER_GOVERNOR_ROLE** (`bytes32`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **user** (`address`)
- **sGovernor** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_MinStalenesManagement_ProposeAccessControl() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests access control for proposeMinStaleness (only SUPER_GOVERNOR_ROLE)
