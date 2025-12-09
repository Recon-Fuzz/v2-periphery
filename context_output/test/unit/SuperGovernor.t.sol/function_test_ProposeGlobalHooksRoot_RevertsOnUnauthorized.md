# Function: test_ProposeGlobalHooksRoot_RevertsOnUnauthorized()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_ProposeGlobalHooksRoot_RevertsOnUnauthorized()`
- **Visibility**: public
- **Source Range**: 39619:731:659

## Implementation

```solidity
/// @notice Tests proposeGlobalHooksRoot reverts when called by unauthorized user
///  @dev Covers SuperGovernor.sol:220 - onlyRole(_GOVERNOR_ROLE) modifier
function test_ProposeGlobalHooksRoot_RevertsOnUnauthorized() public {
    bytes32 newRoot = keccak256("new global hooks root");
    vm.prank(user);
    vm.expectRevert(abi.encodeWithSelector(IAccessControl.AccessControlUnauthorizedAccount.selector, user, GOVERNOR_ROLE));
    superGovernor.proposeGlobalHooksRoot(newRoot);
    vm.prank(sGovernor);
    vm.expectRevert(abi.encodeWithSelector(IAccessControl.AccessControlUnauthorizedAccount.selector, sGovernor, GOVERNOR_ROLE));
    superGovernor.proposeGlobalHooksRoot(newRoot);
}
```

## External Calls

- **Vm::prank(address)**
- **Vm::expectRevert(bytes)**
- **SuperGovernor::proposeGlobalHooksRoot(bytes32)**

## State Variable Reads

- **user** (`address`)
- **GOVERNOR_ROLE** (`bytes32`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **sGovernor** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_ProposeGlobalHooksRoot_RevertsOnUnauthorized() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests proposeGlobalHooksRoot reverts when called by unauthorized user
 @dev Covers SuperGovernor.sol:220 - onlyRole(_GOVERNOR_ROLE) modifier
