# Function: test_IncentiveTokenManagement_Revert_ExecuteRemoveBeforeTimelock()

**Contract**: [test/draft/test/unit/SuperRegistry.t.sol/contract_SuperRegistryTest.md]

## Metadata

- **Contract**: SuperRegistryTest
- **Signature**: `test_IncentiveTokenManagement_Revert_ExecuteRemoveBeforeTimelock()`
- **Visibility**: public
- **Source Range**: 13627:768:568

## Implementation

```solidity
/// @notice Tests reverting when executing remove before timelock expiry
function test_IncentiveTokenManagement_Revert_ExecuteRemoveBeforeTimelock() public {
    address token1 = address(0x111);
    address[] memory tokens = new address[](1);
    tokens[0] = token1;
    vm.prank(registryAdmin);
    superRegistry.proposeAddIncentiveTokens(tokens);
    vm.warp((block.timestamp + TIMELOCK) + 1);
    superRegistry.executeAddIncentiveTokens();
    vm.warp(block.timestamp + 1);
    vm.prank(registryAdmin);
    superRegistry.proposeRemoveIncentiveTokens(tokens);
    vm.expectRevert(ISuperRegistry.TIMELOCK_NOT_EXPIRED.selector);
    superRegistry.executeRemoveIncentiveTokens();
}
```

## External Calls

- **Vm::prank(address)**
- **SuperRegistry::proposeAddIncentiveTokens(address[])**
- **Vm::warp(uint256)**
- **SuperRegistry::executeAddIncentiveTokens()**
- **SuperRegistry::proposeRemoveIncentiveTokens(address[])**
- **Vm::expectRevert(bytes4)**
- **SuperRegistry::executeRemoveIncentiveTokens()**

## State Variable Reads

- **registryAdmin** (`address`)
- **TIMELOCK** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperRegistryTest.test_IncentiveTokenManagement_Revert_ExecuteRemoveBeforeTimelock() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests reverting when executing remove before timelock expiry
