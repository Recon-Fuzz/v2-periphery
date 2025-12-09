# Function: superGovernor_proposeMinStaleness(uint256)

**Contract**: [test/recon/trophies/TrophiesToFoundry.sol/contract_TrophiesToFoundry.md]

## Metadata

- **Contract**: TrophiesToFoundry
- **Signature**: `superGovernor_proposeMinStaleness(uint256)`
- **Visibility**: public
- **Source Range**: 785:164:650
- **Inherited From**: SuperGovernorTargets

## Implementation

```solidity
function superGovernor_proposeMinStaleness(uint256 newMinStaleness) public asAdmin() {
    superGovernor.proposeMinStaleness(newMinStaleness);
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

- **SuperGovernor::proposeMinStaleness(uint256)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTargets.superGovernor_proposeMinStaleness(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 1)
      💬 Args: [no args]
```
