# Function: test_OracleStalenesValidation_AfterMinStalenesChange()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_OracleStalenesValidation_AfterMinStalenesChange()`
- **Visibility**: public
- **Source Range**: 102872:1226:659

## Implementation

```solidity
/// @notice Tests oracle staleness validation after changing minimum staleness
function test_OracleStalenesValidation_AfterMinStalenesChange() public {
    MockSuperOracleForStaleness mockOracle = new MockSuperOracleForStaleness();
    bytes32 oracleKey = superGovernor.SUPER_ORACLE();
    vm.prank(sGovernor);
    superGovernor.setAddress(oracleKey, address(mockOracle));
    uint256 newMinStaleness = 800;
    vm.prank(sGovernor);
    superGovernor.proposeMinStaleness(newMinStaleness);
    vm.warp((block.timestamp + TIMELOCK) + 1);
    superGovernor.executeMinStalenessChange();
    uint256 previouslyValidStaleness = 600;
    vm.prank(oracleManager);
    vm.expectRevert(ISuperGovernor.MAX_STALENESS_TOO_LOW.selector);
    superGovernor.setOracleMaxStaleness(previouslyValidStaleness);
    uint256 nowValidStaleness = 900;
    vm.prank(oracleManager);
    superGovernor.setOracleMaxStaleness(nowValidStaleness);
    assertEq(mockOracle.lastMaxStaleness(), nowValidStaleness, "Oracle should accept valid staleness");
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
- **SuperGovernor::proposeMinStaleness(uint256)**
- **Vm::warp(uint256)**
- **SuperGovernor::executeMinStalenessChange()**
- **Vm::expectRevert(bytes4)**
- **SuperGovernor::setOracleMaxStaleness(uint256)**
- **MockSuperOracleForStaleness::lastMaxStaleness()**

## State Variable Reads

- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **sGovernor** (`address`)
- **TIMELOCK** (`uint256`)
- **oracleManager** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_OracleStalenesValidation_AfterMinStalenesChange() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
      💬 Args: [mockOracle.lastMaxStaleness(), nowValidStaleness, "Oracle should accept valid staleness"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests oracle staleness validation after changing minimum staleness
