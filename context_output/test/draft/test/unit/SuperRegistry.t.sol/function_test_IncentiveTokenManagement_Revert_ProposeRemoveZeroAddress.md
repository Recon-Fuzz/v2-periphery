# Function: test_IncentiveTokenManagement_Revert_ProposeRemoveZeroAddress()

**Contract**: [test/draft/test/unit/SuperRegistry.t.sol/contract_SuperRegistryTest.md]

## Metadata

- **Contract**: SuperRegistryTest
- **Signature**: `test_IncentiveTokenManagement_Revert_ProposeRemoveZeroAddress()`
- **Visibility**: public
- **Source Range**: 11648:331:568

## Implementation

```solidity
/// @notice Tests reverting when proposing to remove incentive tokens with zero address
function test_IncentiveTokenManagement_Revert_ProposeRemoveZeroAddress() public {
    address[] memory tokens = new address[](1);
    tokens[0] = address(0);
    vm.prank(registryAdmin);
    vm.expectRevert(ISuperRegistry.INVALID_ADDRESS.selector);
    superRegistry.proposeRemoveIncentiveTokens(tokens);
}
```

## External Calls

- **Vm::prank(address)**
- **Vm::expectRevert(bytes4)**
- **SuperRegistry::proposeRemoveIncentiveTokens(address[])**

## State Variable Reads

- **registryAdmin** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperRegistryTest.test_IncentiveTokenManagement_Revert_ProposeRemoveZeroAddress() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests reverting when proposing to remove incentive tokens with zero address
