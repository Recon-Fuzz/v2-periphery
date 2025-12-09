# Function: test_GetUpkeepCostPerSingleUpdate_SuperOracleNotFound()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_GetUpkeepCostPerSingleUpdate_SuperOracleNotFound()`
- **Visibility**: public
- **Source Range**: 132756:321:659

## Implementation

```solidity
/// @notice Tests getUpkeepCostPerSingleUpdate reverts when SUPER_ORACLE not found
///  @dev Covers SuperGovernor.sol:863 - if (oracle == address(0)) revert SUPER_ORACLE_NOT_FOUND()
function test_GetUpkeepCostPerSingleUpdate_SuperOracleNotFound() public {
    address testOracle = makeAddr("testOracle");
    vm.expectRevert(ISuperGovernor.SUPER_ORACLE_NOT_FOUND.selector);
    superGovernor.getUpkeepCostPerSingleUpdate(testOracle);
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

- **Vm::expectRevert(bytes4)**
- **SuperGovernor::getUpkeepCostPerSingleUpdate(address)**

## State Variable Reads

- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_GetUpkeepCostPerSingleUpdate_SuperOracleNotFound() (NodeID: 0)
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

@notice Tests getUpkeepCostPerSingleUpdate reverts when SUPER_ORACLE not found
 @dev Covers SuperGovernor.sol:863 - if (oracle == address(0)) revert SUPER_ORACLE_NOT_FOUND()
