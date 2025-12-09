# Function: test_OracleUpdateManagement_ExecuteOracleProviderRemoval_AccessControl()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_OracleUpdateManagement_ExecuteOracleProviderRemoval_AccessControl()`
- **Visibility**: public
- **Source Range**: 120498:1601:659

## Implementation

```solidity
/// @notice Tests executeOracleProviderRemoval access control
///  @dev Covers SuperGovernor.sol:468 - onlyRole(_ORACLE_MANAGER_ROLE)
function test_OracleUpdateManagement_ExecuteOracleProviderRemoval_AccessControl() public {
    MockSuperOracleForStaleness mockOracle = new MockSuperOracleForStaleness();
    bytes32 oracleKey = superGovernor.SUPER_ORACLE();
    vm.prank(sGovernor);
    superGovernor.setAddress(oracleKey, address(mockOracle));
    address unauthorized = makeAddr("unauthorized");
    vm.prank(unauthorized);
    vm.expectRevert(abi.encodeWithSelector(IAccessControl.AccessControlUnauthorizedAccount.selector, unauthorized, ORACLE_MANAGER_ROLE));
    superGovernor.executeOracleProviderRemoval();
    vm.prank(governor);
    vm.expectRevert(abi.encodeWithSelector(IAccessControl.AccessControlUnauthorizedAccount.selector, governor, ORACLE_MANAGER_ROLE));
    superGovernor.executeOracleProviderRemoval();
    assertFalse(mockOracle.providerRemovalExecuted(), "Oracle should not have been called by unauthorized users");
    vm.prank(oracleManager);
    superGovernor.executeOracleProviderRemoval();
    assertTrue(mockOracle.providerRemovalExecuted(), "Oracle should have been called by authorized user");
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

### assertFalse(bool,string)

- **Kind**: internal
- **Source**: 2179:149:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertFalse(bool,string)`

```solidity
function assertFalse(bool data, string memory err) virtual internal pure {
    if (data) {
        vm.assertFalse(data, err);
    }
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
- **SuperGovernor::executeOracleProviderRemoval()**
- **MockSuperOracleForStaleness::providerRemovalExecuted()**

## State Variable Reads

- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **sGovernor** (`address`)
- **ORACLE_MANAGER_ROLE** (`bytes32`)
- **governor** (`address`)
- **oracleManager** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_OracleUpdateManagement_ExecuteOracleProviderRemoval_AccessControl() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdCheatsSafe.makeAddr(string) (NodeID: 1)
  │   💬 Args: ["unauthorized"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdCheatsSafe.makeAddrAndKey(string) (NodeID: 2)
  │     💬 Args: [name]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 3)
  │   💬 Args: [mockOracle.providerRemovalExecuted(), "Oracle should not have been called by unauthorized users"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 4)
      💬 Args: [mockOracle.providerRemovalExecuted(), "Oracle should have been called by authorized user"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests executeOracleProviderRemoval access control
 @dev Covers SuperGovernor.sol:468 - onlyRole(_ORACLE_MANAGER_ROLE)
