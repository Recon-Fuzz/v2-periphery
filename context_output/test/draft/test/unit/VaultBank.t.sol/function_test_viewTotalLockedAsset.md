# Function: test_viewTotalLockedAsset()

**Contract**: [test/draft/test/unit/VaultBank.t.sol/contract_VaultBankTest.md]

## Metadata

- **Contract**: VaultBankTest
- **Signature**: `test_viewTotalLockedAsset()`
- **Visibility**: public
- **Source Range**: 53817:720:570

## Implementation

```solidity
function test_viewTotalLockedAsset() public {
    uint256 lockAmount1 = 100 ether;
    uint256 lockAmount2 = 50 ether;
    token.mint(user, lockAmount1 + lockAmount2);
    vm.startPrank(user);
    token.approve(address(vaultBank), lockAmount1 + lockAmount2);
    vm.stopPrank();
    assertEq(vaultBank.viewTotalLockedAsset(address(token)), 0, "Initial total locked amount should be 0");
    vaultBank.lockAsset(yieldSourceOracleId, user, address(token), address(mockHook), lockAmount1, DST_CHAIN_ID);
    assertEq(vaultBank.viewTotalLockedAsset(address(token)), lockAmount1, "Total locked amount should match sum of all locks");
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

- **MockERC20::mint(address,uint256)**
- **Vm::startPrank(address)**
- **MockERC20::approve(address,uint256)**
- **Vm::stopPrank()**
- **TestVaultBank::viewTotalLockedAsset(address)**
- **TestVaultBank::lockAsset(bytes32,address,address,address,uint256,uint64)**

## State Variable Reads

- **token** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **user** (`address`)
- **vaultBank** (`contract TestVaultBank`) [test/draft/test/unit/VaultBank.t.sol/contract_TestVaultBank.md]
- **yieldSourceOracleId** (`bytes32`)
- **mockHook** (`contract MockHook`) [test/mocks/MockHook.sol/contract_MockHook.md]
- **DST_CHAIN_ID** (`uint64`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: VaultBankTest.test_viewTotalLockedAsset() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [vaultBank.viewTotalLockedAsset(address(token)), 0, "Initial total locked amount should be 0"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
      💬 Args: [vaultBank.viewTotalLockedAsset(address(token)), lockAmount1, "Total locked amount should match sum of all locks"]
      👁️  Def: internal
```
