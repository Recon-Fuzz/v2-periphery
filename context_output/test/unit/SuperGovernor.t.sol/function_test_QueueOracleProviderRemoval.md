# Function: test_QueueOracleProviderRemoval()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_QueueOracleProviderRemoval()`
- **Visibility**: public
- **Source Range**: 131100:354:659

## Implementation

```solidity
function test_QueueOracleProviderRemoval() public {
    bytes32[] memory providers = new bytes32[](1);
    providers[0] = keccak256("PROVIDER1");
    vm.prank(oracleManager);
    vm.expectRevert(ISuperGovernor.CONTRACT_NOT_FOUND.selector);
    superGovernor.queueOracleProviderRemoval(providers);
}
```

## External Calls

- **Vm::prank(address)**
- **Vm::expectRevert(bytes4)**
- **SuperGovernor::queueOracleProviderRemoval(bytes32[])**

## State Variable Reads

- **oracleManager** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_QueueOracleProviderRemoval() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
