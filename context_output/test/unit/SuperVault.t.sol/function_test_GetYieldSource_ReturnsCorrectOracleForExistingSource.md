# Function: test_GetYieldSource_ReturnsCorrectOracleForExistingSource()

**Contract**: [test/unit/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_GetYieldSource_ReturnsCorrectOracleForExistingSource()`
- **Visibility**: public
- **Source Range**: 149444:901:660

## Implementation

```solidity
/// @notice Tests getYieldSource returns correct oracle for existing yield source
///  @dev Covers SuperVaultStrategy.sol:581
function test_GetYieldSource_ReturnsCorrectOracleForExistingSource() public {
    address yieldSourceAddr = address(0x1234);
    address oracleAddr = address(0x5678);
    address[] memory sources = new address[](1);
    address[] memory oracles = new address[](1);
    ISuperVaultStrategy.YieldSourceAction[] memory actionTypes = new ISuperVaultStrategy.YieldSourceAction[](1);
    sources[0] = yieldSourceAddr;
    oracles[0] = oracleAddr;
    actionTypes[0] = ISuperVaultStrategy.YieldSourceAction.Add;
    vm.prank(manager);
    strategy.manageYieldSources(sources, oracles, actionTypes);
    ISuperVaultStrategy.YieldSource memory yieldSource = strategy.getYieldSource(yieldSourceAddr);
    assertEq(yieldSource.oracle, oracleAddr, "Oracle address should match");
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

- **Vm::prank(address)**
- **SuperVaultStrategy::manageYieldSources(address[],address[],enum ISuperVaultStrategy.YieldSourceAction[])**
- **SuperVaultStrategy::getYieldSource(address)**

## State Variable Reads

- **manager** (`address`)
- **strategy** (`contract SuperVaultStrategy`) [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_GetYieldSource_ReturnsCorrectOracleForExistingSource() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 1)
      💬 Args: [yieldSource.oracle, oracleAddr, "Oracle address should match"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests getYieldSource returns correct oracle for existing yield source
 @dev Covers SuperVaultStrategy.sol:581
