# Function: test_IncentiveTokenManagement_ExecuteRemoveIncentiveTokens()

**Contract**: [test/draft/test/unit/SuperRegistry.t.sol/contract_SuperRegistryTest.md]

## Metadata

- **Contract**: SuperRegistryTest
- **Signature**: `test_IncentiveTokenManagement_ExecuteRemoveIncentiveTokens()`
- **Visibility**: public
- **Source Range**: 12060:1196:568

## Implementation

```solidity
/// @notice Tests executing removal of incentive tokens after timelock
function test_IncentiveTokenManagement_ExecuteRemoveIncentiveTokens() public {
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
    vm.prank(registryAdmin);
    superRegistry.proposeRemoveIncentiveTokens(tokens);
    vm.warp((block.timestamp + TIMELOCK) + 1);
    vm.expectEmit(true, false, false, false);
    emit ISuperRegistry.WhitelistedIncentiveTokensRemoved(tokens);
    superRegistry.executeRemoveIncentiveTokens();
    assertFalse(superRegistry.isWhitelistedIncentiveToken(token1), "Token1 should not be whitelisted");
    assertFalse(superRegistry.isWhitelistedIncentiveToken(token2), "Token2 should not be whitelisted");
}
```

## Related Implementations

### assertFalse(bool,string)

- **Kind**: internal
- **Source**: 2179:149:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertFalse(bool,string)`

```solidity
function assertFalse(bool data, string memory err) virtual internal pure {
    if (data) {
        vm.assertFalse(data, err);
    }
}
```

## External Calls

- **Vm::prank(address)**
- **SuperRegistry::proposeAddIncentiveTokens(address[])**
- **Vm::warp(uint256)**
- **SuperRegistry::executeAddIncentiveTokens()**
- **SuperRegistry::proposeRemoveIncentiveTokens(address[])**
- **Vm::expectEmit(bool,bool,bool,bool)**
- **SuperRegistry::executeRemoveIncentiveTokens()**
- **SuperRegistry::isWhitelistedIncentiveToken(address)**

## State Variable Reads

- **registryAdmin** (`address`)
- **TIMELOCK** (`uint256`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperRegistryTest.test_IncentiveTokenManagement_ExecuteRemoveIncentiveTokens() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 1)
  │   💬 Args: [superRegistry.isWhitelistedIncentiveToken(token1), "Token1 should not be whitelisted"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 2)
      💬 Args: [superRegistry.isWhitelistedIncentiveToken(token2), "Token2 should not be whitelisted"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests executing removal of incentive tokens after timelock
