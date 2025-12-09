# Function: superGovernor_executeUpkeepPaymentsChange()

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `superGovernor_executeUpkeepPaymentsChange()`
- **Visibility**: public
- **Source Range**: 1388:128:650
- **Inherited From**: SuperGovernorTargets

## Implementation

```solidity
function superGovernor_executeUpkeepPaymentsChange() public asAdmin() {
    superGovernor.executeUpkeepPaymentsChange();
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

- **SuperGovernor::executeUpkeepPaymentsChange()**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTargets.superGovernor_executeUpkeepPaymentsChange() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 1)
      💬 Args: [no args]
```
