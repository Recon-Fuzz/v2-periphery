# Function: test_IncentiveTokenManagement_PublicExecution()

**Contract**: [test/draft/test/unit/SuperRegistry.t.sol/contract_SuperRegistryTest.md]

## Metadata

- **Contract**: SuperRegistryTest
- **Signature**: `test_IncentiveTokenManagement_PublicExecution()`
- **Visibility**: public
- **Source Range**: 16042:992:568

## Implementation

```solidity
/// @notice Tests that execution functions are public (can be called by anyone)
function test_IncentiveTokenManagement_PublicExecution() public {
    address token1 = address(0x111);
    address[] memory tokens = new address[](1);
    tokens[0] = token1;
    vm.prank(registryAdmin);
    superRegistry.proposeAddIncentiveTokens(tokens);
    vm.warp((block.timestamp + TIMELOCK) + 1);
    vm.prank(user);
    superRegistry.executeAddIncentiveTokens();
    assertTrue(superRegistry.isWhitelistedIncentiveToken(token1), "Token should be whitelisted");
    vm.warp(block.timestamp + 1);
    vm.prank(registryAdmin);
    superRegistry.proposeRemoveIncentiveTokens(tokens);
    vm.warp((block.timestamp + TIMELOCK) + 1);
    vm.prank(user);
    superRegistry.executeRemoveIncentiveTokens();
    assertFalse(superRegistry.isWhitelistedIncentiveToken(token1), "Token should not be whitelisted");
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
- **SuperRegistry::isWhitelistedIncentiveToken(address)**
- **SuperRegistry::proposeRemoveIncentiveTokens(address[])**
- **SuperRegistry::executeRemoveIncentiveTokens()**

## State Variable Reads

- **registryAdmin** (`address`)
- **TIMELOCK** (`uint256`)
- **user** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperRegistryTest.test_IncentiveTokenManagement_PublicExecution() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 1)
  │   💬 Args: [superRegistry.isWhitelistedIncentiveToken(token1), "Token should be whitelisted"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 2)
      💬 Args: [superRegistry.isWhitelistedIncentiveToken(token1), "Token should not be whitelisted"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests that execution functions are public (can be called by anyone)
