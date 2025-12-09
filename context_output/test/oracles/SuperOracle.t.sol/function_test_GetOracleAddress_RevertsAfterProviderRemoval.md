# Function: test_GetOracleAddress_RevertsAfterProviderRemoval()

**Contract**: [test/oracles/SuperOracle.t.sol/contract_SuperOracleTest.md]

## Metadata

- **Contract**: SuperOracleTest
- **Signature**: `test_GetOracleAddress_RevertsAfterProviderRemoval()`
- **Visibility**: public
- **Source Range**: 68967:953:624

## Implementation

```solidity
/// @notice Tests getOracleAddress reverts when provider was removed
///  @dev Covers SuperOracleBase.sol:187 - INVALID_ORACLE_PROVIDER after provider removal
function test_GetOracleAddress_RevertsAfterProviderRemoval() public {
    address oracleBefore = superOracle.getOracleAddress(address(mockETH), address(mockUSD), PROVIDER_1);
    assertEq(oracleBefore, address(mockFeed1), "Oracle should exist before removal");
    bytes32[] memory toRemove = new bytes32[](1);
    toRemove[0] = PROVIDER_1;
    superOracle.queueProviderRemoval(toRemove);
    vm.warp((block.timestamp + 1 hours) + 1 seconds);
    mockFeed2.setUpdatedAt(block.timestamp);
    mockFeed3.setUpdatedAt(block.timestamp);
    superOracle.executeProviderRemoval();
    vm.expectRevert(ISuperOracle.INVALID_ORACLE_PROVIDER.selector);
    superOracle.getOracleAddress(address(mockETH), address(mockUSD), PROVIDER_1);
}
```

## Related Implementations

### assertEq(address,address,string)

- **Kind**: internal
- **Source**: 4179:177:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(address,address,string)`

```solidity
function assertEq(address left, address right, string memory err) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right, err);
    }
}
```

## External Calls

- **SuperOracle::getOracleAddress(address,address,bytes32)**
- **SuperOracle::queueProviderRemoval(bytes32[])**
- **Vm::warp(uint256)**
- **MockAggregator::setUpdatedAt(uint256)**
- **SuperOracle::executeProviderRemoval()**
- **Vm::expectRevert(bytes4)**

## State Variable Reads

- **superOracle** (`contract SuperOracle`) [src/oracles/SuperOracle.sol/contract_SuperOracle.md]
- **mockETH** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **mockUSD** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **PROVIDER_1** (`bytes32`)
- **mockFeed1** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **mockFeed2** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **mockFeed3** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleTest.test_GetOracleAddress_RevertsAfterProviderRemoval() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 1)
      💬 Args: [oracleBefore, address(mockFeed1), "Oracle should exist before removal"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests getOracleAddress reverts when provider was removed
 @dev Covers SuperOracleBase.sol:187 - INVALID_ORACLE_PROVIDER after provider removal
