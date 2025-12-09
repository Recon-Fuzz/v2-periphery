# Function: test_OracleStalenesValidation_SetOracleFeedMaxStaleness_Revert_OracleNotSet()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_OracleStalenesValidation_SetOracleFeedMaxStaleness_Revert_OracleNotSet()`
- **Visibility**: public
- **Source Range**: 106252:358:659

## Implementation

```solidity
/// @notice Tests setOracleFeedMaxStaleness reverts when oracle is not set in registry
///  @dev Covers SuperGovernor.sol:259 - if (oracle == address(0)) revert CONTRACT_NOT_FOUND()
function test_OracleStalenesValidation_SetOracleFeedMaxStaleness_Revert_OracleNotSet() public {
    address feed = makeAddr("testFeed");
    uint256 validStaleness = 400;
    vm.prank(oracleManager);
    vm.expectRevert(ISuperGovernor.CONTRACT_NOT_FOUND.selector);
    superGovernor.setOracleFeedMaxStaleness(feed, validStaleness);
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
- **SuperGovernor::setOracleFeedMaxStaleness(address,uint256)**

## State Variable Reads

- **oracleManager** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_OracleStalenesValidation_SetOracleFeedMaxStaleness_Revert_OracleNotSet() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdCheatsSafe.makeAddr(string) (NodeID: 1)
      💬 Args: ["testFeed"]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: StdCheatsSafe.makeAddrAndKey(string) (NodeID: 2)
        💬 Args: [name]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests setOracleFeedMaxStaleness reverts when oracle is not set in registry
 @dev Covers SuperGovernor.sol:259 - if (oracle == address(0)) revert CONTRACT_NOT_FOUND()
