# Function: test_GetQuoteFromProvider_SingleProviderPath()

**Contract**: [test/oracles/SuperOracle.t.sol/contract_SuperOracleTest.md]

## Metadata

- **Contract**: SuperOracleTest
- **Signature**: `test_GetQuoteFromProvider_SingleProviderPath()`
- **Visibility**: public
- **Source Range**: 56528:359:624

## Implementation

```solidity
/// @notice Tests getQuoteFromProvider for single provider (non-average)
///  @dev Covers SuperOracleBase.sol:284-292 - else branch (not AVERAGE_PROVIDER)
function test_GetQuoteFromProvider_SingleProviderPath() public view {
    (uint256 quote, uint256 dev, uint256 total, uint256 avail) = superOracle.getQuoteFromProvider(1e18, address(mockETH), address(mockUSD), PROVIDER_1);
    assertEq(quote, 1.1e6);
    assertEq(dev, 0);
    assertEq(total, 1);
    assertEq(avail, 1);
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

## External Calls

- **SuperOracle::getQuoteFromProvider(uint256,address,address,bytes32)**

## State Variable Reads

- **superOracle** (`contract SuperOracle`) [src/oracles/SuperOracle.sol/contract_SuperOracle.md]
- **mockETH** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **mockUSD** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **PROVIDER_1** (`bytes32`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleTest.test_GetQuoteFromProvider_SingleProviderPath() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 1)
  │   💬 Args: [quote, 1.1e6]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 2)
  │   💬 Args: [dev, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 3)
  │   💬 Args: [total, 1]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 4)
      💬 Args: [avail, 1]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests getQuoteFromProvider for single provider (non-average)
 @dev Covers SuperOracleBase.sol:284-292 - else branch (not AVERAGE_PROVIDER)
