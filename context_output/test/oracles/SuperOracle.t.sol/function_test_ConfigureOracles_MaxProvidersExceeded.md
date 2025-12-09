# Function: test_ConfigureOracles_MaxProvidersExceeded()

**Contract**: [test/oracles/SuperOracle.t.sol/contract_SuperOracleTest.md]

## Metadata

- **Contract**: SuperOracleTest
- **Signature**: `test_ConfigureOracles_MaxProvidersExceeded()`
- **Visibility**: public
- **Source Range**: 55287:1073:624

## Implementation

```solidity
/// @notice Tests _configureOracles reverts when max providers exceeded
///  @dev Covers SuperOracleBase.sol:596-598 - if (activeProviders.length >= MAX_SAMPLE_PROVIDERS)
function test_ConfigureOracles_MaxProvidersExceeded() public {
    address[] memory bases = new address[](8);
    address[] memory quotes = new address[](8);
    bytes32[] memory providers = new bytes32[](8);
    address[] memory feeds = new address[](8);
    for (uint256 i = 0; i < 8; i++) {
        bases[i] = address(mockETH);
        quotes[i] = address(mockUSD);
        providers[i] = keccak256(abi.encodePacked("ExtraProvider", i));
        MockAggregator feed = new MockAggregator(1e8, 8);
        feed.setUpdatedAt(block.timestamp);
        feeds[i] = address(feed);
    }
    superOracle.queueOracleUpdate(bases, quotes, providers, feeds);
    vm.warp(block.timestamp + 1 weeks);
    vm.expectRevert(ISuperOracle.TOO_MANY_PROVIDERS.selector);
    superOracle.executeOracleUpdate();
}
```

## External Calls

- **MockAggregator::setUpdatedAt(uint256)**
- **SuperOracle::queueOracleUpdate(address[],address[],bytes32[],address[])**
- **Vm::warp(uint256)**
- **Vm::expectRevert(bytes4)**
- **SuperOracle::executeOracleUpdate()**

## State Variable Reads

- **mockETH** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **mockUSD** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **superOracle** (`contract SuperOracle`) [src/oracles/SuperOracle.sol/contract_SuperOracle.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleTest.test_ConfigureOracles_MaxProvidersExceeded() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests _configureOracles reverts when max providers exceeded
 @dev Covers SuperOracleBase.sol:596-598 - if (activeProviders.length >= MAX_SAMPLE_PROVIDERS)
