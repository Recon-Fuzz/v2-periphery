# Function: test_FixedPriceOracle_GetRoundData()

**Contract**: [test/oracles/FixedPriceOracle.t.sol/contract_FixedPriceOracleTest.md]

## Metadata

- **Contract**: FixedPriceOracleTest
- **Signature**: `test_FixedPriceOracle_GetRoundData()`
- **Visibility**: public
- **Source Range**: 4026:473:623

## Implementation

```solidity
/// @notice Test getRoundData returns same as latestRoundData
function test_FixedPriceOracle_GetRoundData() public view {
    (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound) = fixedPriceOracle.getRoundData(42);
    assertEq(roundId, 42);
    assertEq(answer, INITIAL_UP_PRICE);
    assertEq(startedAt, block.timestamp);
    assertEq(updatedAt, block.timestamp);
    assertEq(answeredInRound, 42);
}
```

## Related Implementations

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

### assertEq(int256,int256)

- **Kind**: internal
- **Source**: 3346:151:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(int256,int256)`

```solidity
function assertEq(int256 left, int256 right) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right);
    }
}
```

## External Calls

- **FixedPriceOracle::getRoundData(uint80)**

## State Variable Reads

- **fixedPriceOracle** (`contract FixedPriceOracle`) [src/oracles/FixedPriceOracle.sol/contract_FixedPriceOracle.md]
- **INITIAL_UP_PRICE** (`int256`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: FixedPriceOracleTest.test_FixedPriceOracle_GetRoundData() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 1)
  │   💬 Args: [roundId, 42]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(int256,int256) (NodeID: 2)
  │   💬 Args: [answer, INITIAL_UP_PRICE]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 3)
  │   💬 Args: [startedAt, block.timestamp]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 4)
  │   💬 Args: [updatedAt, block.timestamp]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 5)
      💬 Args: [answeredInRound, 42]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Test getRoundData returns same as latestRoundData
