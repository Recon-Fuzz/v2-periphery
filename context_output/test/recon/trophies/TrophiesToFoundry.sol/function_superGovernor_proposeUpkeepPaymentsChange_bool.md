# Function: superGovernor_proposeUpkeepPaymentsChange(bool)

**Contract**: [test/recon/trophies/TrophiesToFoundry.sol/contract_TrophiesToFoundry.md]

## Metadata

- **Contract**: TrophiesToFoundry
- **Signature**: `superGovernor_proposeUpkeepPaymentsChange(bool)`
- **Visibility**: public
- **Source Range**: 1221:161:650
- **Inherited From**: SuperGovernorTargets

## Implementation

```solidity
function superGovernor_proposeUpkeepPaymentsChange(bool enabled) public asAdmin() {
    superGovernor.proposeUpkeepPaymentsChange(enabled);
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

- **SuperGovernor::proposeUpkeepPaymentsChange(bool)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTargets.superGovernor_proposeUpkeepPaymentsChange(bool) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 1)
      💬 Args: [no args]
```
