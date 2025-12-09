# Function: test_CalculateStdDev_MeanBranches()

**Contract**: [test/oracles/SuperOracle.t.sol/contract_SuperOracleTest.md]

## Metadata

- **Contract**: SuperOracleTest
- **Signature**: `test_CalculateStdDev_MeanBranches()`
- **Visibility**: public
- **Source Range**: 58832:478:624

## Implementation

```solidity
/// @notice Tests _calculateStdDev with values >= mean branch
///  @dev Covers SuperOracleBase.sol:537-540 - if (values[i] >= mean)
function test_CalculateStdDev_MeanBranches() public view {
    (, uint256 deviation, , ) = superOracle.getQuoteFromProvider(1e18, address(mockETH), address(mockUSD), AVERAGE_PROVIDER);
    assertGt(deviation, 0);
}
```

## Related Implementations

### assertGt(uint256,uint256)

- **Kind**: internal
- **Source**: 14636:153:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertGt(uint256,uint256)`

```solidity
function assertGt(uint256 left, uint256 right) virtual internal pure {
    if (left <= right) {
        vm.assertGt(left, right);
    }
}
```

## External Calls

- **SuperOracle::getQuoteFromProvider(uint256,address,address,bytes32)**

## State Variable Reads

- **superOracle** (`contract SuperOracle`) [src/oracles/SuperOracle.sol/contract_SuperOracle.md]
- **mockETH** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **mockUSD** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **AVERAGE_PROVIDER** (`bytes32`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleTest.test_CalculateStdDev_MeanBranches() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 1)
      💬 Args: [deviation, 0]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests _calculateStdDev with values >= mean branch
 @dev Covers SuperOracleBase.sol:537-540 - if (values[i] >= mean)
