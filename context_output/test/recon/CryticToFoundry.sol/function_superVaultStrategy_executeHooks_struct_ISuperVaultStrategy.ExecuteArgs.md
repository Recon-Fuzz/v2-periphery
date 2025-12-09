# Function: superVaultStrategy_executeHooks(struct ISuperVaultStrategy.ExecuteArgs)

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `superVaultStrategy_executeHooks(struct ISuperVaultStrategy.ExecuteArgs)`
- **Visibility**: public
- **Source Range**: 1234:232:646
- **Inherited From**: AdminTargets

## Implementation

```solidity
/// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///
function superVaultStrategy_executeHooks(ISuperVaultStrategy.ExecuteArgs memory args) public payable asAdmin() {
    superVaultStrategy.executeHooks{value: msg.value}(args);
    executeHooksSuccess = true;
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

- **unknown::unknown**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: AdminTargets.superVaultStrategy_executeHooks(struct ISuperVaultStrategy.ExecuteArgs) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 1)
      💬 Args: [no args]
```

## Documentation

### Function Documentation

AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///
