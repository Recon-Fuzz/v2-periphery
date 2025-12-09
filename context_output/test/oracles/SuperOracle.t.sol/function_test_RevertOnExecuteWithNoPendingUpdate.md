# Function: test_RevertOnExecuteWithNoPendingUpdate()

**Contract**: [test/oracles/SuperOracle.t.sol/contract_SuperOracleTest.md]

## Metadata

- **Contract**: SuperOracleTest
- **Signature**: `test_RevertOnExecuteWithNoPendingUpdate()`
- **Visibility**: public
- **Source Range**: 38555:425:624

## Implementation

```solidity
function test_RevertOnExecuteWithNoPendingUpdate() public {
    vm.expectRevert(ISuperOracle.NO_PENDING_UPDATE.selector);
    superOracle.executeOracleUpdate();
    vm.expectRevert(ISuperOracle.NO_PENDING_UPDATE.selector);
    superOracle.executeProviderRemoval();
}
```

## External Calls

- **Vm::expectRevert(bytes4)**
- **SuperOracle::executeOracleUpdate()**
- **SuperOracle::executeProviderRemoval()**

## State Variable Reads

- **superOracle** (`contract SuperOracle`) [src/oracles/SuperOracle.sol/contract_SuperOracle.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleTest.test_RevertOnExecuteWithNoPendingUpdate() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
