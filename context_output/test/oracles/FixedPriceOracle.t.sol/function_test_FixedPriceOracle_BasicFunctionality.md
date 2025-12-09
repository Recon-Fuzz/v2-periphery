# Function: test_FixedPriceOracle_BasicFunctionality()

**Contract**: [test/oracles/FixedPriceOracle.t.sol/contract_FixedPriceOracleTest.md]

## Metadata

- **Contract**: FixedPriceOracleTest
- **Signature**: `test_FixedPriceOracle_BasicFunctionality()`
- **Visibility**: public
- **Source Range**: 1146:732:623

## Implementation

```solidity
/// @notice Test basic FixedPriceOracle functionality
function test_FixedPriceOracle_BasicFunctionality() public view {
    assertEq(fixedPriceOracle.decimals(), UP_DECIMALS);
    (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound) = fixedPriceOracle.latestRoundData();
    assertEq(roundId, 1);
    assertEq(answer, INITIAL_UP_PRICE);
    assertEq(startedAt, block.timestamp);
    assertEq(updatedAt, block.timestamp);
    assertEq(answeredInRound, 1);
    assertEq(fixedPriceOracle.latestAnswer(), uint256(INITIAL_UP_PRICE));
    assertEq(fixedPriceOracle.owner(), owner);
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

- **FixedPriceOracle::decimals()**
- **FixedPriceOracle::latestRoundData()**
- **FixedPriceOracle::latestAnswer()**
- **FixedPriceOracle::owner()**

## State Variable Reads

- **fixedPriceOracle** (`contract FixedPriceOracle`) [src/oracles/FixedPriceOracle.sol/contract_FixedPriceOracle.md]
- **UP_DECIMALS** (`uint8`)
- **INITIAL_UP_PRICE** (`int256`)
- **owner** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: FixedPriceOracleTest.test_FixedPriceOracle_BasicFunctionality() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 1)
  │   💬 Args: [fixedPriceOracle.decimals(), UP_DECIMALS]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 2)
  │   💬 Args: [roundId, 1]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(int256,int256) (NodeID: 3)
  │   💬 Args: [answer, INITIAL_UP_PRICE]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 4)
  │   💬 Args: [startedAt, block.timestamp]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 5)
  │   💬 Args: [updatedAt, block.timestamp]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 6)
  │   💬 Args: [answeredInRound, 1]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 7)
  │   💬 Args: [fixedPriceOracle.latestAnswer(), uint256(INITIAL_UP_PRICE)]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address) (NodeID: 8)
      💬 Args: [fixedPriceOracle.owner(), owner]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Test basic FixedPriceOracle functionality
