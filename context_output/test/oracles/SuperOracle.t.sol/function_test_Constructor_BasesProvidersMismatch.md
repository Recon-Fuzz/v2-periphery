# Function: test_Constructor_BasesProvidersMismatch()

**Contract**: [test/oracles/SuperOracle.t.sol/contract_SuperOracleTest.md]

## Metadata

- **Contract**: SuperOracleTest
- **Signature**: `test_Constructor_BasesProvidersMismatch()`
- **Visibility**: public
- **Source Range**: 52065:882:624

## Implementation

```solidity
/// @notice Tests constructor array validation - bases/providers mismatch
///  @dev Covers SuperOracleBase.sol:82-84 - array length validation
function test_Constructor_BasesProvidersMismatch() public {
    address[] memory bases = new address[](2);
    bases[0] = address(mockETH);
    bases[1] = address(mockBTC);
    address[] memory quotes = new address[](2);
    quotes[0] = address(mockUSD);
    quotes[1] = address(mockUSD);
    bytes32[] memory providers = new bytes32[](1);
    providers[0] = PROVIDER_1;
    address[] memory feeds = new address[](2);
    feeds[0] = address(mockFeed1);
    feeds[1] = address(mockFeed2);
    vm.expectRevert(ISuperOracle.ARRAY_LENGTH_MISMATCH.selector);
    SuperOracle(payable(VmContractHelper622(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/oracles/SuperOracle.sol:SuperOracle", _args: encodeArgs447(DeployHelper447.FoundryPpConstructorArgs(address(this), bases, quotes, providers, feeds))})));
}
```

## External Calls

- **Vm::expectRevert(bytes4)**
- **VmContractHelper622::deployCode(string,bytes)**

## State Variable Reads

- **mockETH** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **mockBTC** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **mockUSD** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **PROVIDER_1** (`bytes32`)
- **mockFeed1** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **mockFeed2** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleTest.test_Constructor_BasesProvidersMismatch() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests constructor array validation - bases/providers mismatch
 @dev Covers SuperOracleBase.sol:82-84 - array length validation
