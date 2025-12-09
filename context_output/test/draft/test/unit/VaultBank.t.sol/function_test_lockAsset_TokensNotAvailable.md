# Function: test_lockAsset_TokensNotAvailable()

**Contract**: [test/draft/test/unit/VaultBank.t.sol/contract_VaultBankTest.md]

## Metadata

- **Contract**: VaultBankTest
- **Signature**: `test_lockAsset_TokensNotAvailable()`
- **Visibility**: public
- **Source Range**: 7602:299:570

## Implementation

```solidity
function test_lockAsset_TokensNotAvailable() public {
    token.mint(address(this), 50 ether);
    token.approve(address(vaultBank), 50 ether);
    vm.expectRevert();
    vaultBank.lockAsset(yieldSourceOracleId, address(this), address(token), address(mockHook), 100 ether, 1);
}
```

## External Calls

- **MockERC20::mint(address,uint256)**
- **MockERC20::approve(address,uint256)**
- **Vm::expectRevert()**
- **TestVaultBank::lockAsset(bytes32,address,address,address,uint256,uint64)**

## State Variable Reads

- **token** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **vaultBank** (`contract TestVaultBank`) [test/draft/test/unit/VaultBank.t.sol/contract_TestVaultBank.md]
- **yieldSourceOracleId** (`bytes32`)
- **mockHook** (`contract MockHook`) [test/mocks/MockHook.sol/contract_MockHook.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: VaultBankTest.test_lockAsset_TokensNotAvailable() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
