# Function: test_OracleUpdateManagement_BatchSetOracleUptimeFeed_AccessControl()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_OracleUpdateManagement_BatchSetOracleUptimeFeed_AccessControl()`
- **Visibility**: public
- **Source Range**: 124368:1265:659

## Implementation

```solidity
/// @notice Tests batchSetOracleUptimeFeed access control
///  @dev Covers SuperGovernor.sol:322 - onlyRole(_ORACLE_MANAGER_ROLE) modifier
function test_OracleUpdateManagement_BatchSetOracleUptimeFeed_AccessControl() public {
    MockSuperOracleL2 mockOracleL2 = new MockSuperOracleL2();
    bytes32 oracleKey = superGovernor.SUPER_ORACLE();
    vm.prank(sGovernor);
    superGovernor.setAddress(oracleKey, address(mockOracleL2));
    address[] memory dataOracles = new address[](1);
    dataOracles[0] = makeAddr("dataOracle");
    address[] memory uptimeOracles = new address[](1);
    uptimeOracles[0] = makeAddr("uptimeOracle");
    uint256[] memory gracePeriods = new uint256[](1);
    gracePeriods[0] = 3600;
    vm.prank(user);
    vm.expectRevert(abi.encodeWithSelector(IAccessControl.AccessControlUnauthorizedAccount.selector, user, ORACLE_MANAGER_ROLE));
    superGovernor.batchSetOracleUptimeFeed(dataOracles, uptimeOracles, gracePeriods);
    vm.prank(oracleManager);
    superGovernor.batchSetOracleUptimeFeed(dataOracles, uptimeOracles, gracePeriods);
    assertTrue(mockOracleL2.batchSetUptimeFeedCalled(), "OracleManager should be able to call");
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

### assertTrue(bool,string)

- **Kind**: internal
- **Source**: 1894:148:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertTrue(bool,string)`

```solidity
function assertTrue(bool data, string memory err) virtual internal pure {
    if (!data) {
        vm.assertTrue(data, err);
    }
}
```

## External Calls

- **SuperGovernor::SUPER_ORACLE()**
- **Vm::prank(address)**
- **SuperGovernor::setAddress(bytes32,address)**
- **Vm::expectRevert(bytes)**
- **SuperGovernor::batchSetOracleUptimeFeed(address[],address[],uint256[])**
- **MockSuperOracleL2::batchSetUptimeFeedCalled()**

## State Variable Reads

- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **sGovernor** (`address`)
- **user** (`address`)
- **ORACLE_MANAGER_ROLE** (`bytes32`)
- **oracleManager** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_OracleUpdateManagement_BatchSetOracleUptimeFeed_AccessControl() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdCheatsSafe.makeAddr(string) (NodeID: 1)
  │   💬 Args: ["dataOracle"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdCheatsSafe.makeAddrAndKey(string) (NodeID: 2)
  │     💬 Args: [name]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdCheatsSafe.makeAddr(string) (NodeID: 3)
  │   💬 Args: ["uptimeOracle"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdCheatsSafe.makeAddrAndKey(string) (NodeID: 4)
  │     💬 Args: [name]
  │     👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 5)
      💬 Args: [mockOracleL2.batchSetUptimeFeedCalled(), "OracleManager should be able to call"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests batchSetOracleUptimeFeed access control
 @dev Covers SuperGovernor.sol:322 - onlyRole(_ORACLE_MANAGER_ROLE) modifier
