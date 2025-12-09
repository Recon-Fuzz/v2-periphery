# Function: test_IncentiveTokenManagement_ProposeRemoveIncentiveTokens()

**Contract**: [test/draft/test/unit/SuperRegistry.t.sol/contract_SuperRegistryTest.md]

## Metadata

- **Contract**: SuperRegistryTest
- **Signature**: `test_IncentiveTokenManagement_ProposeRemoveIncentiveTokens()`
- **Visibility**: public
- **Source Range**: 9937:1173:568

## Implementation

```solidity
/// @notice Tests proposing to remove incentive tokens
function test_IncentiveTokenManagement_ProposeRemoveIncentiveTokens() public {
    address token1 = address(0x111);
    address token2 = address(0x222);
    address[] memory tokens = new address[](2);
    tokens[0] = token1;
    tokens[1] = token2;
    vm.prank(registryAdmin);
    superRegistry.proposeAddIncentiveTokens(tokens);
    vm.warp((block.timestamp + TIMELOCK) + 1);
    superRegistry.executeAddIncentiveTokens();
    vm.warp(block.timestamp + 1);
    uint256 expectedTime = block.timestamp + TIMELOCK;
    vm.prank(registryAdmin);
    vm.expectEmit(true, true, false, false);
    emit ISuperRegistry.WhitelistedIncentiveTokensProposed(tokens, expectedTime);
    superRegistry.proposeRemoveIncentiveTokens(tokens);
    assertTrue(superRegistry.isWhitelistedIncentiveToken(token1), "Token1 should still be whitelisted");
    assertTrue(superRegistry.isWhitelistedIncentiveToken(token2), "Token2 should still be whitelisted");
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
- **SuperRegistry::executeAddIncentiveTokens()**
- **Vm::expectEmit(bool,bool,bool,bool)**
- **SuperRegistry::proposeRemoveIncentiveTokens(address[])**
- **SuperRegistry::isWhitelistedIncentiveToken(address)**

## State Variable Reads

- **registryAdmin** (`address`)
- **TIMELOCK** (`uint256`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperRegistryTest.test_IncentiveTokenManagement_ProposeRemoveIncentiveTokens() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 1)
  │   💬 Args: [superRegistry.isWhitelistedIncentiveToken(token1), "Token1 should still be whitelisted"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 2)
      💬 Args: [superRegistry.isWhitelistedIncentiveToken(token2), "Token2 should still be whitelisted"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests proposing to remove incentive tokens
