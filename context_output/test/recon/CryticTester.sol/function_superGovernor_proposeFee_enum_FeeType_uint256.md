# Function: superGovernor_proposeFee(enum FeeType,uint256)

**Contract**: [test/recon/CryticTester.sol/contract_CryticTester.md]

## Metadata

- **Contract**: CryticTester
- **Signature**: `superGovernor_proposeFee(enum FeeType,uint256)`
- **Visibility**: public
- **Source Range**: 485:160:650
- **Inherited From**: SuperGovernorTargets

## Implementation

```solidity
/// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///
function superGovernor_proposeFee(FeeType feeType, uint256 value) public asAdmin() {
    superGovernor.proposeFee(feeType, value);
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

- **SuperGovernor::proposeFee(enum FeeType,uint256)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTargets.superGovernor_proposeFee(enum FeeType,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 1)
      💬 Args: [no args]
```

## Documentation

### Function Documentation

AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///
