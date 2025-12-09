# Function: test_ExecuteUpkeepClaim_RevertsOnUnauthorized()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_ExecuteUpkeepClaim_RevertsOnUnauthorized()`
- **Visibility**: public
- **Source Range**: 47553:568:659

## Implementation

```solidity
/// @notice Tests executeUpkeepClaim reverts when called by unauthorized user
///  @dev Covers SuperGovernor.sol:511 - onlyRole(_GOVERNOR_ROLE) modifier
function test_ExecuteUpkeepClaim_RevertsOnUnauthorized() public {
    uint256 claimAmount = 1000;
    vm.prank(user);
    vm.expectRevert(abi.encodeWithSelector(IAccessControl.AccessControlUnauthorizedAccount.selector, user, GOVERNOR_ROLE));
    superGovernor.executeUpkeepClaim(claimAmount);
}
```

## External Calls

- **Vm::prank(address)**
- **Vm::expectRevert(bytes)**
- **SuperGovernor::executeUpkeepClaim(uint256)**

## State Variable Reads

- **user** (`address`)
- **GOVERNOR_ROLE** (`bytes32`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_ExecuteUpkeepClaim_RevertsOnUnauthorized() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests executeUpkeepClaim reverts when called by unauthorized user
 @dev Covers SuperGovernor.sol:511 - onlyRole(_GOVERNOR_ROLE) modifier
