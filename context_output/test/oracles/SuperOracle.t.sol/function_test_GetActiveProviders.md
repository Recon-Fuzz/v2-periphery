# Function: test_GetActiveProviders()

**Contract**: [test/oracles/SuperOracle.t.sol/contract_SuperOracleTest.md]

## Metadata

- **Contract**: SuperOracleTest
- **Signature**: `test_GetActiveProviders()`
- **Visibility**: public
- **Source Range**: 10062:868:624

## Implementation

```solidity
function test_GetActiveProviders() public view {
    bytes32[] memory activeProviders = superOracle.getActiveProviders();
    assertEq(activeProviders.length, 3, "Should have 3 active providers");
    bool foundProvider1 = false;
    bool foundProvider2 = false;
    bool foundProvider3 = false;
    for (uint256 i = 0; i < activeProviders.length; i++) {
        if (activeProviders[i] == PROVIDER_1) foundProvider1 = true;
        if (activeProviders[i] == PROVIDER_2) foundProvider2 = true;
        if (activeProviders[i] == PROVIDER_3) foundProvider3 = true;
    }
    assertTrue(foundProvider1, "Provider 1 should be active");
    assertTrue(foundProvider2, "Provider 2 should be active");
    assertTrue(foundProvider3, "Provider 3 should be active");
}
```

## Related Implementations

### assertEq(uint256,uint256,string)

- **Kind**: internal
- **Source**: 2823:177:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256,string)`

```solidity
function assertEq(uint256 left, uint256 right, string memory err) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right, err);
    }
}
```

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

- **SuperOracle::getActiveProviders()**

## State Variable Reads

- **superOracle** (`contract SuperOracle`) [src/oracles/SuperOracle.sol/contract_SuperOracle.md]
- **PROVIDER_1** (`bytes32`)
- **PROVIDER_2** (`bytes32`)
- **PROVIDER_3** (`bytes32`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleTest.test_GetActiveProviders() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [activeProviders.length, 3, "Should have 3 active providers"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 2)
  │   💬 Args: [foundProvider1, "Provider 1 should be active"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 3)
  │   💬 Args: [foundProvider2, "Provider 2 should be active"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 4)
      💬 Args: [foundProvider3, "Provider 3 should be active"]
      👁️  Def: internal
```
