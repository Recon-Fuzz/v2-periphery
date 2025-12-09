# Function: test_FixedPriceOracle_NeverStale()

**Contract**: [test/oracles/FixedPriceOracle.t.sol/contract_FixedPriceOracleTest.md]

## Metadata

- **Contract**: FixedPriceOracleTest
- **Signature**: `test_FixedPriceOracle_NeverStale()`
- **Visibility**: public
- **Source Range**: 3138:816:623

## Implementation

```solidity
/// @notice Test staleness - FixedPriceOracle should never be stale
function test_FixedPriceOracle_NeverStale() public {
    uint256 initialTimestamp = block.timestamp;
    vm.warp(initialTimestamp + 365 days);
    (, int256 answer, uint256 startedAt, uint256 updatedAt, ) = fixedPriceOracle.latestRoundData();
    assertEq(answer, INITIAL_UP_PRICE, "Price should remain the same");
    assertEq(startedAt, block.timestamp, "startedAt should be current timestamp");
    assertEq(updatedAt, block.timestamp, "updatedAt should be current timestamp (never stale)");
    assertEq(fixedPriceOracle.getTimestamp(1), block.timestamp);
}
```

## Related Implementations

### assertEq(int256,int256,string)

- **Kind**: internal
- **Source**: 3503:175:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(int256,int256,string)`

```solidity
function assertEq(int256 left, int256 right, string memory err) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right, err);
    }
}
```

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

## External Calls

- **Vm::warp(uint256)**
- **FixedPriceOracle::latestRoundData()**
- **FixedPriceOracle::getTimestamp(uint256)**

## State Variable Reads

- **fixedPriceOracle** (`contract FixedPriceOracle`) [src/oracles/FixedPriceOracle.sol/contract_FixedPriceOracle.md]
- **INITIAL_UP_PRICE** (`int256`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: FixedPriceOracleTest.test_FixedPriceOracle_NeverStale() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(int256,int256,string) (NodeID: 1)
  │   💬 Args: [answer, INITIAL_UP_PRICE, "Price should remain the same"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
  │   💬 Args: [startedAt, block.timestamp, "startedAt should be current timestamp"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 3)
  │   💬 Args: [updatedAt, block.timestamp, "updatedAt should be current timestamp (never stale)"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 4)
      💬 Args: [fixedPriceOracle.getTimestamp(1), block.timestamp]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Test staleness - FixedPriceOracle should never be stale
