# Function: test_lockAsset_Amount0()

**Contract**: [test/draft/test/unit/VaultBank.t.sol/contract_VaultBankTest.md]

## Metadata

- **Contract**: VaultBankTest
- **Signature**: `test_lockAsset_Amount0()`
- **Visibility**: public
- **Source Range**: 6587:358:570

## Implementation

```solidity
function test_lockAsset_Amount0() public {
    token.mint(user, 100 ether);
    vm.startPrank(user);
    token.approve(address(vaultBank), 100 ether);
    vm.stopPrank();
    vm.expectRevert(IVaultBankSource.INVALID_AMOUNT.selector);
    vaultBank.lockAsset(yieldSourceOracleId, user, address(token), address(mockHook), 0, 1);
}
```

## External Calls

- **MockERC20::mint(address,uint256)**
- **Vm::startPrank(address)**
- **MockERC20::approve(address,uint256)**
- **Vm::stopPrank()**
- **Vm::expectRevert(bytes4)**
- **TestVaultBank::lockAsset(bytes32,address,address,address,uint256,uint64)**

## State Variable Reads

- **token** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **user** (`address`)
- **vaultBank** (`contract TestVaultBank`) [test/draft/test/unit/VaultBank.t.sol/contract_TestVaultBank.md]
- **yieldSourceOracleId** (`bytes32`)
- **mockHook** (`contract MockHook`) [test/mocks/MockHook.sol/contract_MockHook.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: VaultBankTest.test_lockAsset_Amount0() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
