# Function: superVaultAggregator_changePrimaryManager(address,address,address)

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `superVaultAggregator_changePrimaryManager(address,address,address)`
- **Visibility**: public
- **Source Range**: 2845:296:646
- **Inherited From**: AdminTargets

## Implementation

```solidity
/// @dev removed because we're bypassing hook validation
function superVaultAggregator_changePrimaryManager(address strategy, address newManager, address feeRecipient) public asAdmin() {
    superVaultAggregator.changePrimaryManager(strategy, newManager, feeRecipient);
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

- **UnsafeSuperVaultAggregator::changePrimaryManager(address,address,address)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: AdminTargets.superVaultAggregator_changePrimaryManager(address,address,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 1)
      💬 Args: [no args]
```

## Documentation

### Function Documentation

@dev removed because we're bypassing hook validation
