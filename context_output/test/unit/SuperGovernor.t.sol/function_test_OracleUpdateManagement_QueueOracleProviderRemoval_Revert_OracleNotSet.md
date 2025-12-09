# Function: test_OracleUpdateManagement_QueueOracleProviderRemoval_Revert_OracleNotSet()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_OracleUpdateManagement_QueueOracleProviderRemoval_Revert_OracleNotSet()`
- **Visibility**: public
- **Source Range**: 115872:366:659

## Implementation

```solidity
/// @notice Tests queueOracleProviderRemoval reverts when oracle is not set in registry
///  @dev Covers SuperGovernor.sol:310 - if (oracle == address(0)) revert CONTRACT_NOT_FOUND()
function test_OracleUpdateManagement_QueueOracleProviderRemoval_Revert_OracleNotSet() public {
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
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_OracleUpdateManagement_QueueOracleProviderRemoval_Revert_OracleNotSet() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests queueOracleProviderRemoval reverts when oracle is not set in registry
 @dev Covers SuperGovernor.sol:310 - if (oracle == address(0)) revert CONTRACT_NOT_FOUND()
