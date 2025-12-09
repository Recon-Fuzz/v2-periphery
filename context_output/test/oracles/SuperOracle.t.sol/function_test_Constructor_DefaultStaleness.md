# Function: test_Constructor_DefaultStaleness()

**Contract**: [test/oracles/SuperOracle.t.sol/contract_SuperOracleTest.md]

## Metadata

- **Contract**: SuperOracleTest
- **Signature**: `test_Constructor_DefaultStaleness()`
- **Visibility**: public
- **Source Range**: 65644:834:624

## Implementation

```solidity
/// @notice Tests constructor sets default staleness correctly
///  @dev Verifies line 79 - defaultStaleness = 1 days
function test_Constructor_DefaultStaleness() public {
    address[] memory bases = new address[](1);
    bases[0] = address(mockETH);
    address[] memory quotes = new address[](1);
    quotes[0] = address(mockUSD);
    bytes32[] memory providers = new bytes32[](1);
    providers[0] = PROVIDER_1;
    address[] memory feeds = new address[](1);
    feeds[0] = address(mockFeed1);
    SuperOracle newOracle = SuperOracle(payable(VmContractHelper622(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/oracles/SuperOracle.sol:SuperOracle", _args: encodeArgs447(DeployHelper447.FoundryPpConstructorArgs(address(this), bases, quotes, providers, feeds))})));
    assertEq(newOracle.defaultStaleness(), 1 days);
    assertEq(newOracle.SUPER_GOVERNOR(), address(this));
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

### assertEq(address,address)

- **Kind**: internal
- **Source**: 4020:153:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(address,address)`

```solidity
function assertEq(address left, address right) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right);
    }
}
```

## External Calls

- **VmContractHelper622::deployCode(string,bytes)**
- **SuperOracle::defaultStaleness()**
- **SuperOracle::SUPER_GOVERNOR()**

## State Variable Reads

- **mockETH** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **mockUSD** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **PROVIDER_1** (`bytes32`)
- **mockFeed1** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleTest.test_Constructor_DefaultStaleness() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 1)
  │   💬 Args: [newOracle.defaultStaleness(), 1 days]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address) (NodeID: 2)
      💬 Args: [newOracle.SUPER_GOVERNOR(), address(this)]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests constructor sets default staleness correctly
 @dev Verifies line 79 - defaultStaleness = 1 days
