# Function: superGovernor_executeMinStalenessChange()

**Contract**: [test/recon/CryticTester.sol/contract_CryticTester.md]

## Metadata

- **Contract**: CryticTester
- **Signature**: `superGovernor_executeMinStalenessChange()`
- **Visibility**: public
- **Source Range**: 955:124:650
- **Inherited From**: SuperGovernorTargets

## Implementation

```solidity
function superGovernor_executeMinStalenessChange() public asAdmin() {
    superGovernor.executeMinStalenessChange();
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

- **SuperGovernor::executeMinStalenessChange()**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTargets.superGovernor_executeMinStalenessChange() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 1)
      💬 Args: [no args]
```
