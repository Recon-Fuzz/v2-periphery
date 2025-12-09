# Function: test_OracleUpdateManagement_QueueOracleUpdate_AccessControl()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_OracleUpdateManagement_QueueOracleUpdate_AccessControl()`
- **Visibility**: public
- **Source Range**: 109978:1662:659

## Implementation

```solidity
/// @notice Tests queueOracleUpdate access control - only ORACLE_MANAGER_ROLE can call
function test_OracleUpdateManagement_QueueOracleUpdate_AccessControl() public {
    MockSuperOracleForStaleness mockOracle = new MockSuperOracleForStaleness();
    bytes32 oracleKey = superGovernor.SUPER_ORACLE();
    vm.prank(sGovernor);
    superGovernor.setAddress(oracleKey, address(mockOracle));
    address[] memory bases = new address[](1);
    bases[0] = address(0x111);
    address[] memory quotes = new address[](1);
    quotes[0] = address(0x333);
    bytes32[] memory providers = new bytes32[](1);
    providers[0] = keccak256("PROVIDER1");
    address[] memory feeds = new address[](1);
    feeds[0] = address(0x555);
    vm.prank(user);
    vm.expectRevert(abi.encodeWithSelector(IAccessControl.AccessControlUnauthorizedAccount.selector, user, ORACLE_MANAGER_ROLE));
    superGovernor.queueOracleUpdate(bases, quotes, providers, feeds);
    vm.prank(sGovernor);
    vm.expectRevert(abi.encodeWithSelector(IAccessControl.AccessControlUnauthorizedAccount.selector, sGovernor, ORACLE_MANAGER_ROLE));
    superGovernor.queueOracleUpdate(bases, quotes, providers, feeds);
    vm.prank(oracleManager);
    superGovernor.queueOracleUpdate(bases, quotes, providers, feeds);
    assertTrue(mockOracle.oracleUpdateQueued(), "OracleManager should be able to queue oracle update");
}
```

## Related Implementations

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
- **SuperGovernor::queueOracleUpdate(address[],address[],bytes32[],address[])**
- **MockSuperOracleForStaleness::oracleUpdateQueued()**

## State Variable Reads

- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **sGovernor** (`address`)
- **user** (`address`)
- **ORACLE_MANAGER_ROLE** (`bytes32`)
- **oracleManager** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_OracleUpdateManagement_QueueOracleUpdate_AccessControl() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 1)
      💬 Args: [mockOracle.oracleUpdateQueued(), "OracleManager should be able to queue oracle update"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests queueOracleUpdate access control - only ORACLE_MANAGER_ROLE can call
