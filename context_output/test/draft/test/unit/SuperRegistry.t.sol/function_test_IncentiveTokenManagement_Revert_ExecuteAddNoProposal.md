# Function: test_IncentiveTokenManagement_Revert_ExecuteAddNoProposal()

**Contract**: [test/draft/test/unit/SuperRegistry.t.sol/contract_SuperRegistryTest.md]

## Metadata

- **Contract**: SuperRegistryTest
- **Signature**: `test_IncentiveTokenManagement_Revert_ExecuteAddNoProposal()`
- **Visibility**: public
- **Source Range**: 9118:205:568

## Implementation

```solidity
/// @notice Tests reverting when executing add without proposal
function test_IncentiveTokenManagement_Revert_ExecuteAddNoProposal() public {
    vm.expectRevert(ISuperRegistry.TIMELOCK_NOT_EXPIRED.selector);
    superRegistry.executeAddIncentiveTokens();
}
```

## External Calls

- **Vm::expectRevert(bytes4)**
- **SuperRegistry::executeAddIncentiveTokens()**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperRegistryTest.test_IncentiveTokenManagement_Revert_ExecuteAddNoProposal() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests reverting when executing add without proposal
