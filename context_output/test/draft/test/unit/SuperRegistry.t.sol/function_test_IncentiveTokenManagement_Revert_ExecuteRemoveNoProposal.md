# Function: test_IncentiveTokenManagement_Revert_ExecuteRemoveNoProposal()

**Contract**: [test/draft/test/unit/SuperRegistry.t.sol/contract_SuperRegistryTest.md]

## Metadata

- **Contract**: SuperRegistryTest
- **Signature**: `test_IncentiveTokenManagement_Revert_ExecuteRemoveNoProposal()`
- **Visibility**: public
- **Source Range**: 13333:211:568

## Implementation

```solidity
/// @notice Tests reverting when executing remove without proposal
function test_IncentiveTokenManagement_Revert_ExecuteRemoveNoProposal() public {
    vm.expectRevert(ISuperRegistry.TIMELOCK_NOT_EXPIRED.selector);
    superRegistry.executeRemoveIncentiveTokens();
}
```

## External Calls

- **Vm::expectRevert(bytes4)**
- **SuperRegistry::executeRemoveIncentiveTokens()**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperRegistryTest.test_IncentiveTokenManagement_Revert_ExecuteRemoveNoProposal() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests reverting when executing remove without proposal
