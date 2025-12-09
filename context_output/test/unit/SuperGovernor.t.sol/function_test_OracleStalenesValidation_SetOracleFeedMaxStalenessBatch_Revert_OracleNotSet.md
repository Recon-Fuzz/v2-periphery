# Function: test_OracleStalenesValidation_SetOracleFeedMaxStalenessBatch_Revert_OracleNotSet()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_OracleStalenesValidation_SetOracleFeedMaxStalenessBatch_Revert_OracleNotSet()`
- **Visibility**: public
- **Source Range**: 106810:536:659

## Implementation

```solidity
/// @notice Tests setOracleFeedMaxStalenessBatch reverts when oracle is not set in registry
///  @dev Covers SuperGovernor.sol:278 - if (oracle == address(0)) revert CONTRACT_NOT_FOUND()
function test_OracleStalenesValidation_SetOracleFeedMaxStalenessBatch_Revert_OracleNotSet() public {
    address[] memory feeds = new address[](2);
    feeds[0] = makeAddr("feed1");
    feeds[1] = makeAddr("feed2");
    uint256[] memory stalenessList = new uint256[](2);
    stalenessList[0] = 400;
    stalenessList[1] = 500;
    vm.prank(oracleManager);
    vm.expectRevert(ISuperGovernor.CONTRACT_NOT_FOUND.selector);
    superGovernor.setOracleFeedMaxStalenessBatch(feeds, stalenessList);
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
- **SuperGovernor::setOracleFeedMaxStalenessBatch(address[],uint256[])**

## State Variable Reads

- **oracleManager** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_OracleStalenesValidation_SetOracleFeedMaxStalenessBatch_Revert_OracleNotSet() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdCheatsSafe.makeAddr(string) (NodeID: 1)
  │   💬 Args: ["feed1"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdCheatsSafe.makeAddrAndKey(string) (NodeID: 2)
  │     💬 Args: [name]
  │     👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdCheatsSafe.makeAddr(string) (NodeID: 3)
      💬 Args: ["feed2"]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: StdCheatsSafe.makeAddrAndKey(string) (NodeID: 4)
        💬 Args: [name]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests setOracleFeedMaxStalenessBatch reverts when oracle is not set in registry
 @dev Covers SuperGovernor.sol:278 - if (oracle == address(0)) revert CONTRACT_NOT_FOUND()
