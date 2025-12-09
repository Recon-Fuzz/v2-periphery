# Function: f()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `f()`
- **Visibility**: public
- **Source Range**: 104172:1535:659

## Implementation

```solidity
/// @notice Tests access control for oracle staleness functions
function f() public {
    MockSuperOracleForStaleness mockOracle = new MockSuperOracleForStaleness();
    bytes32 oracleKey = superGovernor.SUPER_ORACLE();
    vm.prank(sGovernor);
    superGovernor.setAddress(oracleKey, address(mockOracle));
    uint256 validStaleness = 400;
    address feed = address(0x123);
    vm.prank(user);
    vm.expectRevert(abi.encodeWithSelector(IAccessControl.AccessControlUnauthorizedAccount.selector, user, ORACLE_MANAGER_ROLE));
    superGovernor.setOracleMaxStaleness(validStaleness);
    vm.prank(user);
    vm.expectRevert(abi.encodeWithSelector(IAccessControl.AccessControlUnauthorizedAccount.selector, user, ORACLE_MANAGER_ROLE));
    superGovernor.setOracleFeedMaxStaleness(feed, validStaleness);
    vm.prank(sGovernor);
    vm.expectRevert(abi.encodeWithSelector(IAccessControl.AccessControlUnauthorizedAccount.selector, sGovernor, ORACLE_MANAGER_ROLE));
    superGovernor.setOracleMaxStaleness(validStaleness);
    vm.prank(oracleManager);
    superGovernor.setOracleMaxStaleness(validStaleness);
    assertEq(mockOracle.lastMaxStaleness(), validStaleness, "OracleManager should be able to set staleness");
}
```

## Related Implementations

### assertEq(uint256,uint256,string)

- **Kind**: internal
- **Source**: 2823:177:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256,string)`

```solidity
function assertEq(uint256 left, uint256 right, string memory err) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right, err);
    }
}
```

## External Calls

- **SuperGovernor::SUPER_ORACLE()**
- **Vm::prank(address)**
- **SuperGovernor::setAddress(bytes32,address)**
- **Vm::expectRevert(bytes)**
- **SuperGovernor::setOracleMaxStaleness(uint256)**
- **SuperGovernor::setOracleFeedMaxStaleness(address,uint256)**
- **MockSuperOracleForStaleness::lastMaxStaleness()**

## State Variable Reads

- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **sGovernor** (`address`)
- **user** (`address`)
- **ORACLE_MANAGER_ROLE** (`bytes32`)
- **oracleManager** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.f() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
      💬 Args: [mockOracle.lastMaxStaleness(), validStaleness, "OracleManager should be able to set staleness"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests access control for oracle staleness functions
