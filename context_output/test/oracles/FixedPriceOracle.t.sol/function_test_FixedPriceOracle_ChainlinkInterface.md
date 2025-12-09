# Function: test_FixedPriceOracle_ChainlinkInterface()

**Contract**: [test/oracles/FixedPriceOracle.t.sol/contract_FixedPriceOracleTest.md]

## Metadata

- **Contract**: FixedPriceOracleTest
- **Signature**: `test_FixedPriceOracle_ChainlinkInterface()`
- **Visibility**: public
- **Source Range**: 4562:392:623

## Implementation

```solidity
/// @notice Test other Chainlink interface functions
function test_FixedPriceOracle_ChainlinkInterface() public view {
    assertEq(fixedPriceOracle.description(), "Fixed Price Oracle");
    assertEq(fixedPriceOracle.version(), 1);
    assertEq(fixedPriceOracle.phaseId(), 1);
    assertEq(fixedPriceOracle.phaseAggregators(1), address(fixedPriceOracle));
    assertEq(fixedPriceOracle.phaseAggregators(2), address(0));
}
```

## Related Implementations

### assertEq(string,string)

- **Kind**: internal
- **Source**: 5050:122:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(string,string)`

```solidity
function assertEq(string memory left, string memory right) virtual internal pure {
    vm.assertEq(left, right);
}
```

### assertEq(uint256,uint256)

- **Kind**: internal
- **Source**: 2664:153:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256)`

```solidity
function assertEq(uint256 left, uint256 right) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right);
    }
}
```

### assertEq(address,address)

- **Kind**: internal
- **Source**: 4020:153:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(address,address)`

```solidity
function assertEq(address left, address right) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right);
    }
}
```

## External Calls

- **FixedPriceOracle::description()**
- **FixedPriceOracle::version()**
- **FixedPriceOracle::phaseId()**
- **FixedPriceOracle::phaseAggregators(uint16)**

## State Variable Reads

- **fixedPriceOracle** (`contract FixedPriceOracle`) [src/oracles/FixedPriceOracle.sol/contract_FixedPriceOracle.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: FixedPriceOracleTest.test_FixedPriceOracle_ChainlinkInterface() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(string,string) (NodeID: 1)
  │   💬 Args: [fixedPriceOracle.description(), "Fixed Price Oracle"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 2)
  │   💬 Args: [fixedPriceOracle.version(), 1]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 3)
  │   💬 Args: [fixedPriceOracle.phaseId(), 1]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address) (NodeID: 4)
  │   💬 Args: [fixedPriceOracle.phaseAggregators(1), address(fixedPriceOracle)]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address) (NodeID: 5)
      💬 Args: [fixedPriceOracle.phaseAggregators(2), address(0)]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Test other Chainlink interface functions
