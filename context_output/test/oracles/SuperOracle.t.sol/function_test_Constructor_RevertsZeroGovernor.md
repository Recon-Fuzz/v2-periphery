# Function: test_Constructor_RevertsZeroGovernor()

**Contract**: [test/oracles/SuperOracle.t.sol/contract_SuperOracleTest.md]

## Metadata

- **Contract**: SuperOracleTest
- **Signature**: `test_Constructor_RevertsZeroGovernor()`
- **Visibility**: public
- **Source Range**: 50127:753:624

## Implementation

```solidity
/// @notice Tests constructor reverts with zero governor address
///  @dev Covers SuperOracleBase.sol:77 - if (superGovernor_ == address(0))
function test_Constructor_RevertsZeroGovernor() public {
    address[] memory bases = new address[](1);
    bases[0] = address(mockETH);
    address[] memory quotes = new address[](1);
    quotes[0] = address(mockUSD);
    bytes32[] memory providers = new bytes32[](1);
    providers[0] = PROVIDER_1;
    address[] memory feeds = new address[](1);
    feeds[0] = address(mockFeed1);
    vm.expectRevert(ISuperOracle.ZERO_ADDRESS.selector);
    SuperOracle(payable(VmContractHelper622(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/oracles/SuperOracle.sol:SuperOracle", _args: encodeArgs447(DeployHelper447.FoundryPpConstructorArgs(address(0), bases, quotes, providers, feeds))})));
}
```

## External Calls

- **Vm::expectRevert(bytes4)**
- **VmContractHelper622::deployCode(string,bytes)**

## State Variable Reads

- **mockETH** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **mockUSD** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **PROVIDER_1** (`bytes32`)
- **mockFeed1** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleTest.test_Constructor_RevertsZeroGovernor() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests constructor reverts with zero governor address
 @dev Covers SuperOracleBase.sol:77 - if (superGovernor_ == address(0))
