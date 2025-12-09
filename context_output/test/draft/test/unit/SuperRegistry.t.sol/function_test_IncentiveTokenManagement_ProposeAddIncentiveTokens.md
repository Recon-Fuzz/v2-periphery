# Function: test_IncentiveTokenManagement_ProposeAddIncentiveTokens()

**Contract**: [test/draft/test/unit/SuperRegistry.t.sol/contract_SuperRegistryTest.md]

## Metadata

- **Contract**: SuperRegistryTest
- **Signature**: `test_IncentiveTokenManagement_ProposeAddIncentiveTokens()`
- **Visibility**: public
- **Source Range**: 6756:855:568

## Implementation

```solidity
/// @notice Tests proposing to add incentive tokens
function test_IncentiveTokenManagement_ProposeAddIncentiveTokens() public {
    address token1 = address(0x111);
    address token2 = address(0x222);
    address[] memory tokens = new address[](2);
    tokens[0] = token1;
    tokens[1] = token2;
    uint256 expectedTime = block.timestamp + TIMELOCK;
    vm.prank(registryAdmin);
    vm.expectEmit(true, true, false, false);
    emit ISuperRegistry.WhitelistedIncentiveTokensProposed(tokens, expectedTime);
    superRegistry.proposeAddIncentiveTokens(tokens);
    assertFalse(superRegistry.isWhitelistedIncentiveToken(token1), "Token1 should not be whitelisted yet");
    assertFalse(superRegistry.isWhitelistedIncentiveToken(token2), "Token2 should not be whitelisted yet");
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
- **Vm::expectEmit(bool,bool,bool,bool)**
- **SuperRegistry::proposeAddIncentiveTokens(address[])**
- **SuperRegistry::isWhitelistedIncentiveToken(address)**

## State Variable Reads

- **TIMELOCK** (`uint256`)
- **registryAdmin** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperRegistryTest.test_IncentiveTokenManagement_ProposeAddIncentiveTokens() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 1)
  │   💬 Args: [superRegistry.isWhitelistedIncentiveToken(token1), "Token1 should not be whitelisted yet"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 2)
      💬 Args: [superRegistry.isWhitelistedIncentiveToken(token2), "Token2 should not be whitelisted yet"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests proposing to add incentive tokens
