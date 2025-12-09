# Function: test_IncentiveTokenManagement_Revert_ProposeAddZeroAddress()

**Contract**: [test/draft/test/unit/SuperRegistry.t.sol/contract_SuperRegistryTest.md]

## Metadata

- **Contract**: SuperRegistryTest
- **Signature**: `test_IncentiveTokenManagement_Revert_ProposeAddZeroAddress()`
- **Visibility**: public
- **Source Range**: 7706:325:568

## Implementation

```solidity
/// @notice Tests reverting when proposing to add incentive tokens with zero address
function test_IncentiveTokenManagement_Revert_ProposeAddZeroAddress() public {
    address[] memory tokens = new address[](1);
    tokens[0] = address(0);
    vm.prank(registryAdmin);
    vm.expectRevert(ISuperRegistry.INVALID_ADDRESS.selector);
    superRegistry.proposeAddIncentiveTokens(tokens);
}
```

## External Calls

- **Vm::prank(address)**
- **Vm::expectRevert(bytes4)**
- **SuperRegistry::proposeAddIncentiveTokens(address[])**

## State Variable Reads

- **registryAdmin** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperRegistryTest.test_IncentiveTokenManagement_Revert_ProposeAddZeroAddress() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests reverting when proposing to add incentive tokens with zero address
