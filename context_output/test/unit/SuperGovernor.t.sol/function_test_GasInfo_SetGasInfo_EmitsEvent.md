# Function: test_GasInfo_SetGasInfo_EmitsEvent()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_GasInfo_SetGasInfo_EmitsEvent()`
- **Visibility**: public
- **Source Range**: 75476:362:659

## Implementation

```solidity
/// @notice Tests setGasInfo emits correct event
///  @dev Covers SuperGovernor.sol:527 - emit GasInfoSet(oracle, gasIncreasePerEntryBatch)
function test_GasInfo_SetGasInfo_EmitsEvent() public {
    address oracle = makeAddr("testOracle");
    uint256 gasIncreasePerBatch = 1000;
    vm.prank(governor);
    vm.expectEmit(true, true, false, true);
    emit ISuperGovernor.GasInfoSet(oracle, gasIncreasePerBatch);
    superGovernor.setGasInfo(oracle, gasIncreasePerBatch);
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

## External Calls

- **Vm::prank(address)**
- **Vm::expectEmit(bool,bool,bool,bool)**
- **SuperGovernor::setGasInfo(address,uint256)**

## State Variable Reads

- **governor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_GasInfo_SetGasInfo_EmitsEvent() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdCheatsSafe.makeAddr(string) (NodeID: 1)
      💬 Args: ["testOracle"]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: StdCheatsSafe.makeAddrAndKey(string) (NodeID: 2)
        💬 Args: [name]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests setGasInfo emits correct event
 @dev Covers SuperGovernor.sol:527 - emit GasInfoSet(oracle, gasIncreasePerEntryBatch)
