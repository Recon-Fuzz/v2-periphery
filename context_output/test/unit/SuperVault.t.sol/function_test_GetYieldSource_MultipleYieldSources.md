# Function: test_GetYieldSource_MultipleYieldSources()

**Contract**: [test/unit/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_GetYieldSource_MultipleYieldSources()`
- **Visibility**: public
- **Source Range**: 151034:1408:660

## Implementation

```solidity
/// @notice Tests getYieldSource with multiple yield sources
///  @dev Verifies correct oracle returned for each source
function test_GetYieldSource_MultipleYieldSources() public {
    address[] memory sources = new address[](3);
    address[] memory oracles = new address[](3);
    ISuperVaultStrategy.YieldSourceAction[] memory actionTypes = new ISuperVaultStrategy.YieldSourceAction[](3);
    sources[0] = address(0x1111);
    sources[1] = address(0x2222);
    sources[2] = address(0x3333);
    oracles[0] = address(0xAAAA);
    oracles[1] = address(0xBBBB);
    oracles[2] = address(0xCCCC);
    actionTypes[0] = ISuperVaultStrategy.YieldSourceAction.Add;
    actionTypes[1] = ISuperVaultStrategy.YieldSourceAction.Add;
    actionTypes[2] = ISuperVaultStrategy.YieldSourceAction.Add;
    vm.prank(manager);
    strategy.manageYieldSources(sources, oracles, actionTypes);
    ISuperVaultStrategy.YieldSource memory ys1 = strategy.getYieldSource(sources[0]);
    ISuperVaultStrategy.YieldSource memory ys2 = strategy.getYieldSource(sources[1]);
    ISuperVaultStrategy.YieldSource memory ys3 = strategy.getYieldSource(sources[2]);
    assertEq(ys1.oracle, oracles[0], "First oracle should match");
    assertEq(ys2.oracle, oracles[1], "Second oracle should match");
    assertEq(ys3.oracle, oracles[2], "Third oracle should match");
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
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_GetYieldSource_MultipleYieldSources() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 1)
  │   💬 Args: [ys1.oracle, oracles[0], "First oracle should match"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 2)
  │   💬 Args: [ys2.oracle, oracles[1], "Second oracle should match"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 3)
      💬 Args: [ys3.oracle, oracles[2], "Third oracle should match"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests getYieldSource with multiple yield sources
 @dev Verifies correct oracle returned for each source
