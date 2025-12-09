# Function: test_GasInfo_SetGasInfo_AccessControl()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_GasInfo_SetGasInfo_AccessControl()`
- **Visibility**: public
- **Source Range**: 74112:1211:659

## Implementation

```solidity
/// @notice Tests setGasInfo access control
///  @dev Covers SuperGovernor.sol:522 - onlyRole(_GAS_MANAGER_ROLE)
function test_GasInfo_SetGasInfo_AccessControl() public {
    address oracle = makeAddr("testOracle");
    uint256 gasIncreasePerBatch = 1000;
    bytes32 gasManagerRole = superGovernor.GAS_MANAGER_ROLE();
    address unauthorized = makeAddr("unauthorized");
    vm.prank(unauthorized);
    vm.expectRevert(abi.encodeWithSelector(IAccessControl.AccessControlUnauthorizedAccount.selector, unauthorized, gasManagerRole));
    superGovernor.setGasInfo(oracle, gasIncreasePerBatch);
    vm.prank(sGovernor);
    vm.expectRevert(abi.encodeWithSelector(IAccessControl.AccessControlUnauthorizedAccount.selector, sGovernor, gasManagerRole));
    superGovernor.setGasInfo(oracle, gasIncreasePerBatch);
    vm.prank(governor);
    superGovernor.setGasInfo(oracle, gasIncreasePerBatch);
    assertEq(superGovernor.getGasInfo(oracle), gasIncreasePerBatch, "Gas info should be set");
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

- **SuperGovernor::GAS_MANAGER_ROLE()**
- **Vm::prank(address)**
- **Vm::expectRevert(bytes)**
- **SuperGovernor::setGasInfo(address,uint256)**
- **SuperGovernor::getGasInfo(address)**

## State Variable Reads

- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **sGovernor** (`address`)
- **governor** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_GasInfo_SetGasInfo_AccessControl() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdCheatsSafe.makeAddr(string) (NodeID: 1)
  │   💬 Args: ["testOracle"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdCheatsSafe.makeAddrAndKey(string) (NodeID: 2)
  │     💬 Args: [name]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdCheatsSafe.makeAddr(string) (NodeID: 3)
  │   💬 Args: ["unauthorized"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdCheatsSafe.makeAddrAndKey(string) (NodeID: 4)
  │     💬 Args: [name]
  │     👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 5)
      💬 Args: [superGovernor.getGasInfo(oracle), gasIncreasePerBatch, "Gas info should be set"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests setGasInfo access control
 @dev Covers SuperGovernor.sol:522 - onlyRole(_GAS_MANAGER_ROLE)
