# Function: test_claimRewards_FailedCall()

**Contract**: [test/draft/test/unit/VaultBank.t.sol/contract_VaultBankTest.md]

## Metadata

- **Contract**: VaultBankTest
- **Signature**: `test_claimRewards_FailedCall()`
- **Visibility**: public
- **Source Range**: 59394:533:570

## Implementation

```solidity
function test_claimRewards_FailedCall() public {
    MockHookTarget mockTarget = new MockHookTarget();
    mockTarget.setShouldFailExecution(true);
    uint256 gasLimit = 100_000;
    uint256 value = 0;
    uint16 maxReturnDataCopy = 256;
    bytes memory data = abi.encodeWithSignature("execute()");
    vm.expectRevert(IVaultBankSource.CLAIM_FAILED.selector);
    vm.prank(address(this));
    vaultBank.exposed_claimRewards(address(mockTarget), gasLimit, value, maxReturnDataCopy, data);
}
```

## External Calls

- **MockHookTarget::setShouldFailExecution(bool)**
- **Vm::expectRevert(bytes4)**
- **Vm::prank(address)**
- **TestVaultBank::exposed_claimRewards(address,uint256,uint256,uint16,bytes)**

## State Variable Reads

- **vaultBank** (`contract TestVaultBank`) [test/draft/test/unit/VaultBank.t.sol/contract_TestVaultBank.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: VaultBankTest.test_claimRewards_FailedCall() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
