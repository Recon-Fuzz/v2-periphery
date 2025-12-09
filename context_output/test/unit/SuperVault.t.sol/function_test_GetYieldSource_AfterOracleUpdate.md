# Function: test_GetYieldSource_AfterOracleUpdate()

**Contract**: [test/unit/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_GetYieldSource_AfterOracleUpdate()`
- **Visibility**: public
- **Source Range**: 152554:1389:660

## Implementation

```solidity
/// @notice Tests getYieldSource after oracle update
///  @dev Verifies oracle change is reflected
function test_GetYieldSource_AfterOracleUpdate() public {
    address yieldSourceAddr = address(0x1234);
    address originalOracle = address(0x5678);
    address newOracle = address(0xABCD);
    address[] memory sources = new address[](1);
    address[] memory oracles = new address[](1);
    ISuperVaultStrategy.YieldSourceAction[] memory actionTypes = new ISuperVaultStrategy.YieldSourceAction[](1);
    sources[0] = yieldSourceAddr;
    oracles[0] = originalOracle;
    actionTypes[0] = ISuperVaultStrategy.YieldSourceAction.Add;
    vm.prank(manager);
    strategy.manageYieldSources(sources, oracles, actionTypes);
    ISuperVaultStrategy.YieldSource memory ys1 = strategy.getYieldSource(yieldSourceAddr);
    assertEq(ys1.oracle, originalOracle, "Original oracle should match");
    oracles[0] = newOracle;
    actionTypes[0] = ISuperVaultStrategy.YieldSourceAction.UpdateOracle;
    vm.prank(manager);
    strategy.manageYieldSources(sources, oracles, actionTypes);
    ISuperVaultStrategy.YieldSource memory ys2 = strategy.getYieldSource(yieldSourceAddr);
    assertEq(ys2.oracle, newOracle, "Oracle should be updated");
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
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_GetYieldSource_AfterOracleUpdate() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 1)
  │   💬 Args: [ys1.oracle, originalOracle, "Original oracle should match"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 2)
      💬 Args: [ys2.oracle, newOracle, "Oracle should be updated"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests getYieldSource after oracle update
 @dev Verifies oracle change is reflected
