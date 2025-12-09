# Function: test_IncentiveTokenManagement_ExecuteAddIncentiveTokens()

**Contract**: [test/draft/test/unit/SuperRegistry.t.sol/contract_SuperRegistryTest.md]

## Metadata

- **Contract**: SuperRegistryTest
- **Signature**: `test_IncentiveTokenManagement_ExecuteAddIncentiveTokens()`
- **Visibility**: public
- **Source Range**: 8113:931:568

## Implementation

```solidity
/// @notice Tests executing addition of incentive tokens after timelock
function test_IncentiveTokenManagement_ExecuteAddIncentiveTokens() public {
    address token1 = address(0x111);
    address token2 = address(0x222);
    address[] memory tokens = new address[](2);
    tokens[0] = token1;
    tokens[1] = token2;
    vm.prank(registryAdmin);
    superRegistry.proposeAddIncentiveTokens(tokens);
    vm.warp((block.timestamp + TIMELOCK) + 1);
    vm.expectEmit(true, false, false, false);
    emit ISuperRegistry.WhitelistedIncentiveTokensAdded(tokens);
    superRegistry.executeAddIncentiveTokens();
    assertTrue(superRegistry.isWhitelistedIncentiveToken(token1), "Token1 should be whitelisted");
    assertTrue(superRegistry.isWhitelistedIncentiveToken(token2), "Token2 should be whitelisted");
}
```

## Related Implementations

### assertTrue(bool,string)

- **Kind**: internal
- **Source**: 1894:148:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertTrue(bool,string)`

```solidity
function assertTrue(bool data, string memory err) virtual internal pure {
    if (!data) {
        vm.assertTrue(data, err);
    }
}
```

## External Calls

- **Vm::prank(address)**
- **SuperRegistry::proposeAddIncentiveTokens(address[])**
- **Vm::warp(uint256)**
- **Vm::expectEmit(bool,bool,bool,bool)**
- **SuperRegistry::executeAddIncentiveTokens()**
- **SuperRegistry::isWhitelistedIncentiveToken(address)**

## State Variable Reads

- **registryAdmin** (`address`)
- **TIMELOCK** (`uint256`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperRegistryTest.test_IncentiveTokenManagement_ExecuteAddIncentiveTokens() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 1)
  │   💬 Args: [superRegistry.isWhitelistedIncentiveToken(token1), "Token1 should be whitelisted"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 2)
      💬 Args: [superRegistry.isWhitelistedIncentiveToken(token2), "Token2 should be whitelisted"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests executing addition of incentive tokens after timelock
