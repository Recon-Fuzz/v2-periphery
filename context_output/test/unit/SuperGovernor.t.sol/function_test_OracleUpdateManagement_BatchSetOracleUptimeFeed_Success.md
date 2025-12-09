# Function: test_OracleUpdateManagement_BatchSetOracleUptimeFeed_Success()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_OracleUpdateManagement_BatchSetOracleUptimeFeed_Success()`
- **Visibility**: public
- **Source Range**: 123022:1194:659

## Implementation

```solidity
/// @notice Tests batchSetOracleUptimeFeed success path
///  @dev Covers SuperGovernor.sol:316-328 complete flow
function test_OracleUpdateManagement_BatchSetOracleUptimeFeed_Success() public {
    MockSuperOracleL2 mockOracleL2 = new MockSuperOracleL2();
    bytes32 oracleKey = superGovernor.SUPER_ORACLE();
    vm.prank(sGovernor);
    superGovernor.setAddress(oracleKey, address(mockOracleL2));
    address[] memory dataOracles = new address[](2);
    dataOracles[0] = makeAddr("dataOracle1");
    dataOracles[1] = makeAddr("dataOracle2");
    address[] memory uptimeOracles = new address[](2);
    uptimeOracles[0] = makeAddr("uptimeOracle1");
    uptimeOracles[1] = makeAddr("uptimeOracle2");
    uint256[] memory gracePeriods = new uint256[](2);
    gracePeriods[0] = 3600;
    gracePeriods[1] = 7200;
    vm.prank(oracleManager);
    superGovernor.batchSetOracleUptimeFeed(dataOracles, uptimeOracles, gracePeriods);
    assertTrue(mockOracleL2.batchSetUptimeFeedCalled(), "Oracle should have received the call");
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
- **SuperGovernor::batchSetOracleUptimeFeed(address[],address[],uint256[])**
- **MockSuperOracleL2::batchSetUptimeFeedCalled()**

## State Variable Reads

- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **sGovernor** (`address`)
- **oracleManager** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_OracleUpdateManagement_BatchSetOracleUptimeFeed_Success() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdCheatsSafe.makeAddr(string) (NodeID: 1)
  │   💬 Args: ["dataOracle1"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdCheatsSafe.makeAddrAndKey(string) (NodeID: 2)
  │     💬 Args: [name]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdCheatsSafe.makeAddr(string) (NodeID: 3)
  │   💬 Args: ["dataOracle2"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdCheatsSafe.makeAddrAndKey(string) (NodeID: 4)
  │     💬 Args: [name]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdCheatsSafe.makeAddr(string) (NodeID: 5)
  │   💬 Args: ["uptimeOracle1"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdCheatsSafe.makeAddrAndKey(string) (NodeID: 6)
  │     💬 Args: [name]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdCheatsSafe.makeAddr(string) (NodeID: 7)
  │   💬 Args: ["uptimeOracle2"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdCheatsSafe.makeAddrAndKey(string) (NodeID: 8)
  │     💬 Args: [name]
  │     👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 9)
      💬 Args: [mockOracleL2.batchSetUptimeFeedCalled(), "Oracle should have received the call"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests batchSetOracleUptimeFeed success path
 @dev Covers SuperGovernor.sol:316-328 complete flow
