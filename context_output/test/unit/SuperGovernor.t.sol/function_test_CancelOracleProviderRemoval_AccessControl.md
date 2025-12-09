# Function: test_CancelOracleProviderRemoval_AccessControl()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_CancelOracleProviderRemoval_AccessControl()`
- **Visibility**: public
- **Source Range**: 119488:620:659

## Implementation

```solidity
function test_CancelOracleProviderRemoval_AccessControl() public {
    MockSuperOracleForStaleness mockOracle = new MockSuperOracleForStaleness();
    bytes32 oracleKey = superGovernor.SUPER_ORACLE();
    vm.prank(sGovernor);
    superGovernor.setAddress(oracleKey, address(mockOracle));
    vm.expectRevert(abi.encodeWithSelector(IAccessControl.AccessControlUnauthorizedAccount.selector, address(this), ORACLE_MANAGER_ROLE));
    superGovernor.cancelOracleProviderRemoval();
}
```

## External Calls

- **SuperGovernor::SUPER_ORACLE()**
- **Vm::prank(address)**
- **SuperGovernor::setAddress(bytes32,address)**
- **Vm::expectRevert(bytes)**
- **SuperGovernor::cancelOracleProviderRemoval()**

## State Variable Reads

- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **sGovernor** (`address`)
- **ORACLE_MANAGER_ROLE** (`bytes32`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_CancelOracleProviderRemoval_AccessControl() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
