# Function: test_OracleUpdateManagement_BatchSetOracleUptimeFeed_Revert_OracleNotSet()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_OracleUpdateManagement_BatchSetOracleUptimeFeed_Revert_OracleNotSet()`
- **Visibility**: public
- **Source Range**: 122295:601:659

## Implementation

```solidity
/// @notice Tests batchSetOracleUptimeFeed reverts when oracle is not set in registry
///  @dev Covers SuperGovernor.sol:325 - if (oracleL2 == address(0)) revert CONTRACT_NOT_FOUND()
function test_OracleUpdateManagement_BatchSetOracleUptimeFeed_Revert_OracleNotSet() public {
    address[] memory dataOracles = new address[](1);
    dataOracles[0] = makeAddr("dataOracle");
    address[] memory uptimeOracles = new address[](1);
    uptimeOracles[0] = makeAddr("uptimeOracle");
    uint256[] memory gracePeriods = new uint256[](1);
    gracePeriods[0] = 3600;
    vm.prank(oracleManager);
    vm.expectRevert(ISuperGovernor.CONTRACT_NOT_FOUND.selector);
    superGovernor.batchSetOracleUptimeFeed(dataOracles, uptimeOracles, gracePeriods);
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
- **SuperGovernor::batchSetOracleUptimeFeed(address[],address[],uint256[])**

## State Variable Reads

- **oracleManager** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_OracleUpdateManagement_BatchSetOracleUptimeFeed_Revert_OracleNotSet() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdCheatsSafe.makeAddr(string) (NodeID: 1)
  │   💬 Args: ["dataOracle"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdCheatsSafe.makeAddrAndKey(string) (NodeID: 2)
  │     💬 Args: [name]
  │     👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdCheatsSafe.makeAddr(string) (NodeID: 3)
      💬 Args: ["uptimeOracle"]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: StdCheatsSafe.makeAddrAndKey(string) (NodeID: 4)
        💬 Args: [name]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests batchSetOracleUptimeFeed reverts when oracle is not set in registry
 @dev Covers SuperGovernor.sol:325 - if (oracleL2 == address(0)) revert CONTRACT_NOT_FOUND()
