# Function: test_GetOracleAddress_ReturnsUpdatedOracleAfterUpdate()

**Contract**: [test/oracles/SuperOracle.t.sol/contract_SuperOracleTest.md]

## Metadata

- **Contract**: SuperOracleTest
- **Signature**: `test_GetOracleAddress_ReturnsUpdatedOracleAfterUpdate()`
- **Visibility**: public
- **Source Range**: 71738:1279:624

## Implementation

```solidity
/// @notice Tests getOracleAddress after updating existing provider's oracle
///  @dev Verifies oracle address changes after update
function test_GetOracleAddress_ReturnsUpdatedOracleAfterUpdate() public {
    address oracleBefore = superOracle.getOracleAddress(address(mockETH), address(mockUSD), PROVIDER_1);
    assertEq(oracleBefore, address(mockFeed1), "Initial oracle should be mockFeed1");
    address[] memory bases = new address[](1);
    bases[0] = address(mockETH);
    address[] memory quotes = new address[](1);
    quotes[0] = address(mockUSD);
    bytes32[] memory providers = new bytes32[](1);
    providers[0] = PROVIDER_1;
    address[] memory feeds = new address[](1);
    feeds[0] = address(mockFeed4);
    superOracle.queueOracleUpdate(bases, quotes, providers, feeds);
    vm.warp((block.timestamp + 1 weeks) + 1 seconds);
    mockFeed4.setUpdatedAt(block.timestamp);
    superOracle.executeOracleUpdate();
    address oracleAfter = superOracle.getOracleAddress(address(mockETH), address(mockUSD), PROVIDER_1);
    assertEq(oracleAfter, address(mockFeed4), "Oracle should be updated to mockFeed4");
    assertFalse(oracleAfter == oracleBefore, "Oracle address should have changed");
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

### assertFalse(bool,string)

- **Kind**: internal
- **Source**: 2179:149:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertFalse(bool,string)`

```solidity
function assertFalse(bool data, string memory err) virtual internal pure {
    if (data) {
        vm.assertFalse(data, err);
    }
}
```

## External Calls

- **SuperOracle::getOracleAddress(address,address,bytes32)**
- **SuperOracle::queueOracleUpdate(address[],address[],bytes32[],address[])**
- **Vm::warp(uint256)**
- **MockAggregator::setUpdatedAt(uint256)**
- **SuperOracle::executeOracleUpdate()**

## State Variable Reads

- **superOracle** (`contract SuperOracle`) [src/oracles/SuperOracle.sol/contract_SuperOracle.md]
- **mockETH** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **mockUSD** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **PROVIDER_1** (`bytes32`)
- **mockFeed1** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **mockFeed4** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleTest.test_GetOracleAddress_ReturnsUpdatedOracleAfterUpdate() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 1)
  │   💬 Args: [oracleBefore, address(mockFeed1), "Initial oracle should be mockFeed1"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 2)
  │   💬 Args: [oracleAfter, address(mockFeed4), "Oracle should be updated to mockFeed4"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 3)
      💬 Args: [oracleAfter == oracleBefore, "Oracle address should have changed"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests getOracleAddress after updating existing provider's oracle
 @dev Verifies oracle address changes after update
