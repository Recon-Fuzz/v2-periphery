# Function: test_CancelProviderRemoval_Revert_NoPendingUpdate()

**Contract**: [test/oracles/SuperOracle.t.sol/contract_SuperOracleTest.md]

## Metadata

- **Contract**: SuperOracleTest
- **Signature**: `test_CancelProviderRemoval_Revert_NoPendingUpdate()`
- **Visibility**: public
- **Source Range**: 31548:243:624

## Implementation

```solidity
function test_CancelProviderRemoval_Revert_NoPendingUpdate() public {
    vm.expectRevert(ISuperOracle.NO_PENDING_UPDATE.selector);
    superOracle.cancelProviderRemoval();
}
```

## External Calls

- **Vm::expectRevert(bytes4)**
- **SuperOracle::cancelProviderRemoval()**

## State Variable Reads

- **superOracle** (`contract SuperOracle`) [src/oracles/SuperOracle.sol/contract_SuperOracle.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleTest.test_CancelProviderRemoval_Revert_NoPendingUpdate() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
