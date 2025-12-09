# Function: test_OracleStalenesValidation_SetOracleMaxStaleness_Success()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_OracleStalenesValidation_SetOracleMaxStaleness_Success()`
- **Visibility**: public
- **Source Range**: 97122:823:659

## Implementation

```solidity
/// @notice Tests setOracleMaxStaleness with valid staleness value
function test_OracleStalenesValidation_SetOracleMaxStaleness_Success() public {
    MockSuperOracleForStaleness mockOracle = new MockSuperOracleForStaleness();
    bytes32 oracleKey = superGovernor.SUPER_ORACLE();
    vm.prank(sGovernor);
    superGovernor.setAddress(oracleKey, address(mockOracle));
    uint256 validStaleness = 400;
    vm.prank(oracleManager);
    superGovernor.setOracleMaxStaleness(validStaleness);
    assertEq(mockOracle.lastMaxStaleness(), validStaleness, "Oracle should have received the staleness value");
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
- **SuperGovernor::setOracleMaxStaleness(uint256)**
- **MockSuperOracleForStaleness::lastMaxStaleness()**

## State Variable Reads

- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **sGovernor** (`address`)
- **oracleManager** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_OracleStalenesValidation_SetOracleMaxStaleness_Success() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
      💬 Args: [mockOracle.lastMaxStaleness(), validStaleness, "Oracle should have received the staleness value"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests setOracleMaxStaleness with valid staleness value
