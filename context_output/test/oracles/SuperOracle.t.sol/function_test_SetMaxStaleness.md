# Function: test_SetMaxStaleness()

**Contract**: [test/oracles/SuperOracle.t.sol/contract_SuperOracleTest.md]

## Metadata

- **Contract**: SuperOracleTest
- **Signature**: `test_SetMaxStaleness()`
- **Visibility**: public
- **Source Range**: 14829:325:624

## Implementation

```solidity
function test_SetMaxStaleness() public {
    uint256 newMaxStaleness = 12 hours;
    superOracle.setDefaultStaleness(newMaxStaleness);
    assertEq(superOracle.defaultStaleness(), newMaxStaleness, "Max staleness should be updated");
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

## External Calls

- **SuperOracle::setDefaultStaleness(uint256)**
- **SuperOracle::defaultStaleness()**

## State Variable Reads

- **superOracle** (`contract SuperOracle`) [src/oracles/SuperOracle.sol/contract_SuperOracle.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleTest.test_SetMaxStaleness() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
      💬 Args: [superOracle.defaultStaleness(), newMaxStaleness, "Max staleness should be updated"]
      👁️  Def: internal
```
