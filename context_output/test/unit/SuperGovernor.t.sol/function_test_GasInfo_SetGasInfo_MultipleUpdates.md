# Function: test_GasInfo_SetGasInfo_MultipleUpdates()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_GasInfo_SetGasInfo_MultipleUpdates()`
- **Visibility**: public
- **Source Range**: 76001:880:659

## Implementation

```solidity
/// @notice Tests updating gas info multiple times for the same oracle
///  @dev Verifies that gas info can be updated and the latest value is stored
function test_GasInfo_SetGasInfo_MultipleUpdates() public {
    address oracle = makeAddr("testOracle");
    uint256 firstGasValue = 1000;
    uint256 secondGasValue = 2000;
    uint256 thirdGasValue = 5000;
    vm.prank(governor);
    superGovernor.setGasInfo(oracle, firstGasValue);
    assertEq(superGovernor.getGasInfo(oracle), firstGasValue, "First gas value should be set");
    vm.prank(governor);
    superGovernor.setGasInfo(oracle, secondGasValue);
    assertEq(superGovernor.getGasInfo(oracle), secondGasValue, "Second gas value should override first");
    vm.prank(governor);
    superGovernor.setGasInfo(oracle, thirdGasValue);
    assertEq(superGovernor.getGasInfo(oracle), thirdGasValue, "Third gas value should override second");
}
```

## Related Implementations

### makeAddr(string)

- **Kind**: internal
- **Source**: 20760:125:14
- **Link**: `lib/forge-std/src/StdCheats.sol:StdCheatsSafe:makeAddr(string)`

```solidity
function makeAddr(string memory name) virtual internal returns (address addr) {
    (addr, ) = makeAddrAndKey(name);
}
```

### makeAddrAndKey(string)

- **Kind**: internal
- **Source**: 20479:242:14
- **Link**: `lib/forge-std/src/StdCheats.sol:StdCheatsSafe:makeAddrAndKey(string)`

```solidity
function makeAddrAndKey(string memory name) virtual internal returns (address addr, uint256 privateKey) {
    privateKey = uint256(keccak256(abi.encodePacked(name)));
    addr = vm.addr(privateKey);
    vm.label(addr, name);
}
```

### assertEq(uint256,uint256,string)

- **Kind**: internal
- **Source**: 2823:177:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256,string)`

```solidity
function assertEq(uint256 left, uint256 right, string memory err) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right, err);
    }
}
```

## External Calls

- **Vm::prank(address)**
- **SuperGovernor::setGasInfo(address,uint256)**
- **SuperGovernor::getGasInfo(address)**

## State Variable Reads

- **governor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_GasInfo_SetGasInfo_MultipleUpdates() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdCheatsSafe.makeAddr(string) (NodeID: 1)
  │   💬 Args: ["testOracle"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdCheatsSafe.makeAddrAndKey(string) (NodeID: 2)
  │     💬 Args: [name]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 3)
  │   💬 Args: [superGovernor.getGasInfo(oracle), firstGasValue, "First gas value should be set"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 4)
  │   💬 Args: [superGovernor.getGasInfo(oracle), secondGasValue, "Second gas value should override first"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 5)
      💬 Args: [superGovernor.getGasInfo(oracle), thirdGasValue, "Third gas value should override second"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests updating gas info multiple times for the same oracle
 @dev Verifies that gas info can be updated and the latest value is stored
