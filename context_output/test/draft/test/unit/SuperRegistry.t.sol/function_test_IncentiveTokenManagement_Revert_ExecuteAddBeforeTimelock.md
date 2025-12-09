# Function: test_IncentiveTokenManagement_Revert_ExecuteAddBeforeTimelock()

**Contract**: [test/draft/test/unit/SuperRegistry.t.sol/contract_SuperRegistryTest.md]

## Metadata

- **Contract**: SuperRegistryTest
- **Signature**: `test_IncentiveTokenManagement_Revert_ExecuteAddBeforeTimelock()`
- **Visibility**: public
- **Source Range**: 9403:469:568

## Implementation

```solidity
/// @notice Tests reverting when executing add before timelock expiry
function test_IncentiveTokenManagement_Revert_ExecuteAddBeforeTimelock() public {
    address[] memory tokens = new address[](1);
    tokens[0] = address(0x111);
    vm.prank(registryAdmin);
    superRegistry.proposeAddIncentiveTokens(tokens);
    vm.expectRevert(ISuperRegistry.TIMELOCK_NOT_EXPIRED.selector);
    superRegistry.executeAddIncentiveTokens();
}
```

## External Calls

- **Vm::prank(address)**
- **SuperRegistry::proposeAddIncentiveTokens(address[])**
- **Vm::expectRevert(bytes4)**
- **SuperRegistry::executeAddIncentiveTokens()**

## State Variable Reads

- **registryAdmin** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperRegistryTest.test_IncentiveTokenManagement_Revert_ExecuteAddBeforeTimelock() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests reverting when executing add before timelock expiry
