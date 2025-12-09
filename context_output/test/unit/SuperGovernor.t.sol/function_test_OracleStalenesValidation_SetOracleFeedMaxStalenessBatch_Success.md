# Function: test_OracleStalenesValidation_SetOracleFeedMaxStalenessBatch_Success()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_OracleStalenesValidation_SetOracleFeedMaxStalenessBatch_Success()`
- **Visibility**: public
- **Source Range**: 100967:852:659

## Implementation

```solidity
/// @notice Tests setOracleFeedMaxStalenessBatch with all valid staleness values
function test_OracleStalenesValidation_SetOracleFeedMaxStalenessBatch_Success() public {
    MockSuperOracleForStaleness mockOracle = new MockSuperOracleForStaleness();
    bytes32 oracleKey = superGovernor.SUPER_ORACLE();
    vm.prank(sGovernor);
    superGovernor.setAddress(oracleKey, address(mockOracle));
    address[] memory feeds = new address[](3);
    feeds[0] = address(0x123);
    feeds[1] = address(0x456);
    feeds[2] = address(0x789);
    uint256[] memory stalenessList = new uint256[](3);
    stalenessList[0] = 400;
    stalenessList[1] = 500;
    stalenessList[2] = 600;
    vm.prank(oracleManager);
    superGovernor.setOracleFeedMaxStalenessBatch(feeds, stalenessList);
    assertTrue(mockOracle.batchCalled(), "Oracle batch function should have been called");
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
- **SuperGovernor::setOracleFeedMaxStalenessBatch(address[],uint256[])**
- **MockSuperOracleForStaleness::batchCalled()**

## State Variable Reads

- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **sGovernor** (`address`)
- **oracleManager** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_OracleStalenesValidation_SetOracleFeedMaxStalenessBatch_Success() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 1)
      💬 Args: [mockOracle.batchCalled(), "Oracle batch function should have been called"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests setOracleFeedMaxStalenessBatch with all valid staleness values
