# Function: superGovernor_executeUpkeepClaim(uint256)

**Contract**: [test/recon/trophies/TrophiesToFoundry.sol/contract_TrophiesToFoundry.md]

## Metadata

- **Contract**: TrophiesToFoundry
- **Signature**: `superGovernor_executeUpkeepClaim(uint256)`
- **Visibility**: public
- **Source Range**: 1085:130:650
- **Inherited From**: SuperGovernorTargets

## Implementation

```solidity
function superGovernor_executeUpkeepClaim(uint256 amount) public asAdmin() {
    superGovernor.executeUpkeepClaim(amount);
}
```

## Related Implementations

### asAdmin()

- **Kind**: modifier
- **Source**: 5816:70:631
- **Link**: `test/recon/Setup.sol:Setup:asAdmin()`

```solidity
/// === MODIFIERS === ///
///  Prank admin and actor
modifier asAdmin() {
    vm.prank(address(this));
    _;
}
```

## External Calls

- **SuperGovernor::executeUpkeepClaim(uint256)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTargets.superGovernor_executeUpkeepClaim(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 1)
      💬 Args: [no args]
```
