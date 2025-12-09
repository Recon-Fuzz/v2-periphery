# Function: test_IncentiveTokenManagement_Revert_ProposeRemoveNotWhitelisted()

**Contract**: [test/draft/test/unit/SuperRegistry.t.sol/contract_SuperRegistryTest.md]

## Metadata

- **Contract**: SuperRegistryTest
- **Signature**: `test_IncentiveTokenManagement_Revert_ProposeRemoveNotWhitelisted()`
- **Visibility**: public
- **Source Range**: 11196:354:568

## Implementation

```solidity
/// @notice Tests reverting when proposing to remove non-whitelisted tokens
function test_IncentiveTokenManagement_Revert_ProposeRemoveNotWhitelisted() public {
    address[] memory tokens = new address[](1);
    tokens[0] = address(0x111);
    vm.prank(registryAdmin);
    vm.expectRevert(ISuperRegistry.NOT_WHITELISTED_INCENTIVE_TOKEN.selector);
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
┌─ [0] ⚙️ FUNCTION: SuperRegistryTest.test_IncentiveTokenManagement_Revert_ProposeRemoveNotWhitelisted() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests reverting when proposing to remove non-whitelisted tokens
