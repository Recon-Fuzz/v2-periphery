# Function: test_OracleUpdateManagement_QueueOracleUpdate_Revert_OracleNotSet()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_OracleUpdateManagement_QueueOracleUpdate_Revert_OracleNotSet()`
- **Visibility**: public
- **Source Range**: 109248:633:659

## Implementation

```solidity
/// @notice Tests queueOracleUpdate reverts when oracle is not set in registry
function test_OracleUpdateManagement_QueueOracleUpdate_Revert_OracleNotSet() public {
    address[] memory bases = new address[](1);
    bases[0] = address(0x111);
    address[] memory quotes = new address[](1);
    quotes[0] = address(0x333);
    bytes32[] memory providers = new bytes32[](1);
    providers[0] = keccak256("PROVIDER1");
    address[] memory feeds = new address[](1);
    feeds[0] = address(0x555);
    vm.prank(oracleManager);
    vm.expectRevert(ISuperGovernor.CONTRACT_NOT_FOUND.selector);
    superGovernor.queueOracleUpdate(bases, quotes, providers, feeds);
}
```

## External Calls

- **Vm::prank(address)**
- **Vm::expectRevert(bytes4)**
- **SuperGovernor::queueOracleUpdate(address[],address[],bytes32[],address[])**

## State Variable Reads

- **oracleManager** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_OracleUpdateManagement_QueueOracleUpdate_Revert_OracleNotSet() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests queueOracleUpdate reverts when oracle is not set in registry
