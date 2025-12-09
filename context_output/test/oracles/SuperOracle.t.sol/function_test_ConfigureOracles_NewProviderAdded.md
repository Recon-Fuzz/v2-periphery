# Function: test_ConfigureOracles_NewProviderAdded()

**Contract**: [test/oracles/SuperOracle.t.sol/contract_SuperOracleTest.md]

## Metadata

- **Contract**: SuperOracleTest
- **Signature**: `test_ConfigureOracles_NewProviderAdded()`
- **Visibility**: public
- **Source Range**: 54302:801:624

## Implementation

```solidity
/// @notice Tests _configureOracles with new provider addition
///  @dev Covers SuperOracleBase.sol:595 - if (!providerExists)
function test_ConfigureOracles_NewProviderAdded() public {
    bytes32 newProv = keccak256("BrandNewProvider");
    address[] memory bases = new address[](1);
    bases[0] = address(mockBTC);
    address[] memory quotes = new address[](1);
    quotes[0] = address(mockUSD);
    bytes32[] memory providers = new bytes32[](1);
    providers[0] = newProv;
    address[] memory feeds = new address[](1);
    feeds[0] = address(mockFeed4);
    assertFalse(superOracle.isProviderSet(newProv));
    superOracle.queueOracleUpdate(bases, quotes, providers, feeds);
    vm.warp(block.timestamp + 1 weeks);
    mockFeed4.setUpdatedAt(block.timestamp);
    superOracle.executeOracleUpdate();
    assertTrue(superOracle.isProviderSet(newProv));
}
```

## Related Implementations

### assertFalse(bool)

- **Kind**: internal
- **Source**: 2048:125:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertFalse(bool)`

```solidity
function assertFalse(bool data) virtual internal pure {
    if (data) {
        vm.assertFalse(data);
    }
}
```

### assertTrue(bool)

- **Kind**: internal
- **Source**: 1764:124:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertTrue(bool)`

```solidity
function assertTrue(bool data) virtual internal pure {
    if (!data) {
        vm.assertTrue(data);
    }
}
```

## External Calls

- **SuperOracle::isProviderSet(bytes32)**
- **SuperOracle::queueOracleUpdate(address[],address[],bytes32[],address[])**
- **Vm::warp(uint256)**
- **MockAggregator::setUpdatedAt(uint256)**
- **SuperOracle::executeOracleUpdate()**

## State Variable Reads

- **mockBTC** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **mockUSD** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **mockFeed4** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **superOracle** (`contract SuperOracle`) [src/oracles/SuperOracle.sol/contract_SuperOracle.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleTest.test_ConfigureOracles_NewProviderAdded() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool) (NodeID: 1)
  │   💬 Args: [superOracle.isProviderSet(newProv)]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool) (NodeID: 2)
      💬 Args: [superOracle.isProviderSet(newProv)]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests _configureOracles with new provider addition
 @dev Covers SuperOracleBase.sol:595 - if (!providerExists)
