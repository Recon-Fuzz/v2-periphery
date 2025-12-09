# Function: test_GasInfo_SetGasInfo_MultipleOracles()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_GasInfo_SetGasInfo_MultipleOracles()`
- **Visibility**: public
- **Source Range**: 77516:914:659

## Implementation

```solidity
/// @notice Tests setGasInfo with multiple different oracles
///  @dev Verifies that gas info is stored independently for each oracle
function test_GasInfo_SetGasInfo_MultipleOracles() public {
    address oracle1 = makeAddr("oracle1");
    address oracle2 = makeAddr("oracle2");
    address oracle3 = makeAddr("oracle3");
    uint256 gasValue1 = 1000;
    uint256 gasValue2 = 2000;
    uint256 gasValue3 = 3000;
    vm.startPrank(governor);
    superGovernor.setGasInfo(oracle1, gasValue1);
    superGovernor.setGasInfo(oracle2, gasValue2);
    superGovernor.setGasInfo(oracle3, gasValue3);
    vm.stopPrank();
    assertEq(superGovernor.getGasInfo(oracle1), gasValue1, "Oracle1 gas value should match");
    assertEq(superGovernor.getGasInfo(oracle2), gasValue2, "Oracle2 gas value should match");
    assertEq(superGovernor.getGasInfo(oracle3), gasValue3, "Oracle3 gas value should match");
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

- **Vm::startPrank(address)**
- **SuperGovernor::setGasInfo(address,uint256)**
- **Vm::stopPrank()**
- **SuperGovernor::getGasInfo(address)**

## State Variable Reads

- **governor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_GasInfo_SetGasInfo_MultipleOracles() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdCheatsSafe.makeAddr(string) (NodeID: 1)
  │   💬 Args: ["oracle1"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdCheatsSafe.makeAddrAndKey(string) (NodeID: 2)
  │     💬 Args: [name]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdCheatsSafe.makeAddr(string) (NodeID: 3)
  │   💬 Args: ["oracle2"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdCheatsSafe.makeAddrAndKey(string) (NodeID: 4)
  │     💬 Args: [name]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdCheatsSafe.makeAddr(string) (NodeID: 5)
  │   💬 Args: ["oracle3"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdCheatsSafe.makeAddrAndKey(string) (NodeID: 6)
  │     💬 Args: [name]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 7)
  │   💬 Args: [superGovernor.getGasInfo(oracle1), gasValue1, "Oracle1 gas value should match"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 8)
  │   💬 Args: [superGovernor.getGasInfo(oracle2), gasValue2, "Oracle2 gas value should match"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 9)
      💬 Args: [superGovernor.getGasInfo(oracle3), gasValue3, "Oracle3 gas value should match"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests setGasInfo with multiple different oracles
 @dev Verifies that gas info is stored independently for each oracle
