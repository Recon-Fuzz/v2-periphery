# Function: test_claimRewards_InvalidTarget()

**Contract**: [test/draft/test/unit/VaultBank.t.sol/contract_VaultBankTest.md]

## Metadata

- **Contract**: VaultBankTest
- **Signature**: `test_claimRewards_InvalidTarget()`
- **Visibility**: public
- **Source Range**: 58745:643:570

## Implementation

```solidity
function test_claimRewards_InvalidTarget() public {
    address mockTarget = address(0);
    uint256 gasLimit = 100_000;
    uint256 value = 0;
    uint16 maxReturnDataCopy = 256;
    bytes memory data = "";
    vm.expectRevert(IVaultBankSource.INVALID_CLAIM_TARGET.selector);
    vm.prank(address(this));
    vaultBank.exposed_claimRewards(mockTarget, gasLimit, value, maxReturnDataCopy, data);
    vm.expectRevert(IVaultBankSource.INVALID_CLAIM_TARGET.selector);
    vm.prank(address(this));
    vaultBank.exposed_claimRewards(address(vaultBank), gasLimit, value, maxReturnDataCopy, data);
}
```

## External Calls

- **Vm::expectRevert(bytes4)**
- **Vm::prank(address)**
- **TestVaultBank::exposed_claimRewards(address,uint256,uint256,uint16,bytes)**

## State Variable Reads

- **vaultBank** (`contract TestVaultBank`) [test/draft/test/unit/VaultBank.t.sol/contract_TestVaultBank.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: VaultBankTest.test_claimRewards_InvalidTarget() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
