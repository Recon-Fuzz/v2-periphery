# Function: test_Sqrt_ZeroInput()

**Contract**: [test/oracles/SuperOracle.t.sol/contract_SuperOracleTest.md]

## Metadata

- **Contract**: SuperOracleTest
- **Signature**: `test_Sqrt_ZeroInput()`
- **Visibility**: public
- **Source Range**: 59427:691:624

## Implementation

```solidity
/// @notice Tests _sqrt with zero input
///  @dev Covers SuperOracleBase.sol:556 - if (x == 0) return 0
function test_Sqrt_ZeroInput() public {
    bytes32[] memory toRemove = new bytes32[](2);
    toRemove[0] = PROVIDER_1;
    toRemove[1] = PROVIDER_2;
    superOracle.queueProviderRemoval(toRemove);
    vm.warp(block.timestamp + 1 hours);
    mockFeed3.setUpdatedAt(block.timestamp);
    superOracle.executeProviderRemoval();
    (, uint256 dev, , ) = superOracle.getQuoteFromProvider(1e18, address(mockETH), address(mockUSD), AVERAGE_PROVIDER);
    assertEq(dev, 0);
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

- **SuperOracle::queueProviderRemoval(bytes32[])**
- **Vm::warp(uint256)**
- **MockAggregator::setUpdatedAt(uint256)**
- **SuperOracle::executeProviderRemoval()**
- **SuperOracle::getQuoteFromProvider(uint256,address,address,bytes32)**

## State Variable Reads

- **PROVIDER_1** (`bytes32`)
- **PROVIDER_2** (`bytes32`)
- **superOracle** (`contract SuperOracle`) [src/oracles/SuperOracle.sol/contract_SuperOracle.md]
- **mockFeed3** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **mockETH** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **mockUSD** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **AVERAGE_PROVIDER** (`bytes32`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleTest.test_Sqrt_ZeroInput() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 1)
      💬 Args: [dev, 0]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests _sqrt with zero input
 @dev Covers SuperOracleBase.sol:556 - if (x == 0) return 0
