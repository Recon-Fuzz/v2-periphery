# Function: test_GasInfo_SetGasInfo_RevertsOnZeroGas()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_GasInfo_SetGasInfo_RevertsOnZeroGas()`
- **Visibility**: public
- **Source Range**: 73730:256:659

## Implementation

```solidity
/// @notice Tests reverting when setting gas info with zero gas increase
///  @dev Covers SuperGovernor.sol:524 - if (gasIncreasePerEntryBatch == 0) revert INVALID_GAS_INFO()
function test_GasInfo_SetGasInfo_RevertsOnZeroGas() public {
    address oracle = makeAddr("testOracle");
    vm.prank(governor);
    vm.expectRevert(ISuperGovernor.INVALID_GAS_INFO.selector);
    superGovernor.setGasInfo(oracle, 0);
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
- **Vm::expectRevert(bytes4)**
- **SuperGovernor::setGasInfo(address,uint256)**

## State Variable Reads

- **governor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_GasInfo_SetGasInfo_RevertsOnZeroGas() (NodeID: 0)
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

@notice Tests reverting when setting gas info with zero gas increase
 @dev Covers SuperGovernor.sol:524 - if (gasIncreasePerEntryBatch == 0) revert INVALID_GAS_INFO()
