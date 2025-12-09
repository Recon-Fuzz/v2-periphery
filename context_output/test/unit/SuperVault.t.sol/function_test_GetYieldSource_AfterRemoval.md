# Function: test_GetYieldSource_AfterRemoval()

**Contract**: [test/unit/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_GetYieldSource_AfterRemoval()`
- **Visibility**: public
- **Source Range**: 154077:1324:660

## Implementation

```solidity
/// @notice Tests getYieldSource after removal returns zero address
///  @dev Verifies removal clears the oracle mapping
function test_GetYieldSource_AfterRemoval() public {
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
    ISuperVaultStrategy.YieldSource memory ys1 = strategy.getYieldSource(yieldSourceAddr);
    assertEq(ys1.oracle, oracleAddr, "Oracle should exist before removal");
    actionTypes[0] = ISuperVaultStrategy.YieldSourceAction.Remove;
    vm.prank(manager);
    strategy.manageYieldSources(sources, oracles, actionTypes);
    ISuperVaultStrategy.YieldSource memory ys2 = strategy.getYieldSource(yieldSourceAddr);
    assertEq(ys2.oracle, address(0), "Oracle should be zero after removal");
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
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_GetYieldSource_AfterRemoval() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 1)
  │   💬 Args: [ys1.oracle, oracleAddr, "Oracle should exist before removal"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 2)
      💬 Args: [ys2.oracle, address(0), "Oracle should be zero after removal"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests getYieldSource after removal returns zero address
 @dev Verifies removal clears the oracle mapping
