# Function: superGovernor_proposeGlobalHooksRoot(bytes32)

**Contract**: [test/recon/trophies/TrophiesToFoundry.sol/contract_TrophiesToFoundry.md]

## Metadata

- **Contract**: TrophiesToFoundry
- **Signature**: `superGovernor_proposeGlobalHooksRoot(bytes32)`
- **Visibility**: public
- **Source Range**: 1522:154:650
- **Inherited From**: SuperGovernorTargets

## Implementation

```solidity
function superGovernor_proposeGlobalHooksRoot(bytes32 newRoot) public asAdmin() {
    superGovernor.proposeGlobalHooksRoot(newRoot);
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

- **SuperGovernor::proposeGlobalHooksRoot(bytes32)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTargets.superGovernor_proposeGlobalHooksRoot(bytes32) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 1)
      💬 Args: [no args]
```
