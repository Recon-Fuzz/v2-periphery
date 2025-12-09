# Function: test_CancelOracleProviderRemoval_Revert_ContractNotFound()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_CancelOracleProviderRemoval_Revert_ContractNotFound()`
- **Visibility**: public
- **Source Range**: 120114:237:659

## Implementation

```solidity
function test_CancelOracleProviderRemoval_Revert_ContractNotFound() public {
    vm.prank(oracleManager);
    vm.expectRevert(ISuperGovernor.CONTRACT_NOT_FOUND.selector);
    superGovernor.cancelOracleProviderRemoval();
}
```

## External Calls

- **Vm::prank(address)**
- **Vm::expectRevert(bytes4)**
- **SuperGovernor::cancelOracleProviderRemoval()**

## State Variable Reads

- **oracleManager** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_CancelOracleProviderRemoval_Revert_ContractNotFound() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
