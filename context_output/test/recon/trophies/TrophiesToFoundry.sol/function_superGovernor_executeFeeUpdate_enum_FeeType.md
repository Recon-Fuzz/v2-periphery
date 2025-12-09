# Function: superGovernor_executeFeeUpdate(enum FeeType)

**Contract**: [test/recon/trophies/TrophiesToFoundry.sol/contract_TrophiesToFoundry.md]

## Metadata

- **Contract**: TrophiesToFoundry
- **Signature**: `superGovernor_executeFeeUpdate(enum FeeType)`
- **Visibility**: public
- **Source Range**: 651:128:650
- **Inherited From**: SuperGovernorTargets

## Implementation

```solidity
function superGovernor_executeFeeUpdate(FeeType feeType) public asAdmin() {
    superGovernor.executeFeeUpdate(feeType);
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

- **SuperGovernor::executeFeeUpdate(enum FeeType)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTargets.superGovernor_executeFeeUpdate(enum FeeType) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 1)
      💬 Args: [no args]
```
