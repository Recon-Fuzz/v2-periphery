# Function: setUp()

**Contract**: [test/oracles/SuperOracle.t.sol/contract_SuperOracleTest.md]

## Metadata

- **Contract**: SuperOracleTest
- **Signature**: `setUp()`
- **Visibility**: public
- **Source Range**: 1212:1767:624

## Implementation

```solidity
function setUp() public {
    mockETH = new MockERC20("Mock ETH", "ETH", 18);
    mockUSD = new MockERC20("Mock USD", "USD", 6);
    mockBTC = new MockERC20("Mock BTC", "BTC", 8);
    mockFeed1 = new MockAggregator(1.1e8, 8);
    mockFeed2 = new MockAggregator(1e8, 8);
    mockFeed3 = new MockAggregator(0.9e8, 8);
    mockFeed4 = new MockAggregator(2e8, 8);
    address[] memory bases = new address[](3);
    bases[0] = address(mockETH);
    bases[1] = address(mockETH);
    bases[2] = address(mockETH);
    address[] memory quotes = new address[](3);
    quotes[0] = address(mockUSD);
    quotes[1] = address(mockUSD);
    quotes[2] = address(mockUSD);
    bytes32[] memory providers = new bytes32[](3);
    providers[0] = PROVIDER_1;
    providers[1] = PROVIDER_2;
    providers[2] = PROVIDER_3;
    address[] memory feeds = new address[](3);
    feeds[0] = address(mockFeed1);
    feeds[1] = address(mockFeed2);
    feeds[2] = address(mockFeed3);
    superOracle = SuperOracle(payable(VmContractHelper622(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/oracles/SuperOracle.sol:SuperOracle", _args: encodeArgs447(DeployHelper447.FoundryPpConstructorArgs(address(this), bases, quotes, providers, feeds))})));
    superOracle.setDefaultStaleness(2 weeks);
}
```

## External Calls

- **VmContractHelper622::deployCode(string,bytes)**
- **SuperOracle::setDefaultStaleness(uint256)**

## State Variable Reads

- **mockETH** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **mockUSD** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **PROVIDER_1** (`bytes32`)
- **PROVIDER_2** (`bytes32`)
- **PROVIDER_3** (`bytes32`)
- **mockFeed1** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **mockFeed2** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **mockFeed3** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **superOracle** (`contract SuperOracle`) [src/oracles/SuperOracle.sol/contract_SuperOracle.md]

## State Variable Writes

- **mockETH** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **mockUSD** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **mockBTC** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **mockFeed1** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **mockFeed2** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **mockFeed3** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **mockFeed4** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **superOracle** (`contract SuperOracle`) [src/oracles/SuperOracle.sol/contract_SuperOracle.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleTest.setUp() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
