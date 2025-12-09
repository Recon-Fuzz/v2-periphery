# Function: test_OnlyOwnerCanPerformAdminActions()

**Contract**: [test/oracles/SuperOracle.t.sol/contract_SuperOracleTest.md]

## Metadata

- **Contract**: SuperOracleTest
- **Signature**: `test_OnlyOwnerCanPerformAdminActions()`
- **Visibility**: public
- **Source Range**: 39913:1583:624

## Implementation

```solidity
function test_OnlyOwnerCanPerformAdminActions() public {
    address nonOwner = address(0x1234);
    vm.startPrank(nonOwner);
    vm.expectRevert();
    superOracle.setDefaultStaleness(1 days);
    vm.expectRevert();
    superOracle.setFeedMaxStaleness(address(mockFeed1), 12 hours);
    address[] memory feeds = new address[](1);
    feeds[0] = address(mockFeed1);
    uint256[] memory values = new uint256[](1);
    values[0] = 12 hours;
    vm.expectRevert();
    superOracle.setFeedMaxStalenessBatch(feeds, values);
    address[] memory bases = new address[](1);
    bases[0] = address(mockETH);
    address[] memory quotes = new address[](1);
    quotes[0] = address(mockUSD);
    bytes32[] memory providers = new bytes32[](1);
    providers[0] = NEW_PROVIDER;
    address[] memory oracles = new address[](1);
    oracles[0] = address(mockFeed4);
    vm.expectRevert();
    superOracle.queueOracleUpdate(bases, quotes, providers, oracles);
    bytes32[] memory providersToRemove = new bytes32[](1);
    providersToRemove[0] = PROVIDER_1;
    vm.expectRevert();
    superOracle.queueProviderRemoval(providersToRemove);
    vm.stopPrank();
}
```

## External Calls

- **Vm::startPrank(address)**
- **Vm::expectRevert()**
- **SuperOracle::setDefaultStaleness(uint256)**
- **SuperOracle::setFeedMaxStaleness(address,uint256)**
- **SuperOracle::setFeedMaxStalenessBatch(address[],uint256[])**
- **SuperOracle::queueOracleUpdate(address[],address[],bytes32[],address[])**
- **SuperOracle::queueProviderRemoval(bytes32[])**
- **Vm::stopPrank()**

## State Variable Reads

- **superOracle** (`contract SuperOracle`) [src/oracles/SuperOracle.sol/contract_SuperOracle.md]
- **mockFeed1** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **mockETH** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **mockUSD** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **NEW_PROVIDER** (`bytes32`)
- **mockFeed4** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **PROVIDER_1** (`bytes32`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleTest.test_OnlyOwnerCanPerformAdminActions() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
