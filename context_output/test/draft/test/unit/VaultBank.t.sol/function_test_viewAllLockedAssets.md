# Function: test_viewAllLockedAssets()

**Contract**: [test/draft/test/unit/VaultBank.t.sol/contract_VaultBankTest.md]

## Metadata

- **Contract**: VaultBankTest
- **Signature**: `test_viewAllLockedAssets()`
- **Visibility**: public
- **Source Range**: 54543:1814:570

## Implementation

```solidity
function test_viewAllLockedAssets() public {
    uint256 lockAmount = 100 ether;
    token.mint(user, lockAmount);
    vm.startPrank(user);
    token.approve(address(vaultBank), lockAmount);
    vm.stopPrank();
    address[] memory initialAssets = vaultBank.viewAllLockedAssets();
    assertEq(initialAssets.length, 0, "Initial locked assets array should be empty");
    vaultBank.lockAsset(yieldSourceOracleId, user, address(token), address(mockHook), lockAmount, DST_CHAIN_ID);
    address[] memory assets = vaultBank.viewAllLockedAssets();
    assertEq(assets.length, 1, "Locked assets array should have one entry");
    assertEq(assets[0], address(token), "Locked asset should match the token address");
    MockERC20 token2 = new MockERC20("Token2", "TKN2", 18);
    token2.mint(user, lockAmount);
    vm.startPrank(user);
    token2.approve(address(vaultBank), lockAmount);
    vm.stopPrank();
    vaultBank.lockAsset(yieldSourceOracleId, user, address(token2), address(mockHook), lockAmount, DST_CHAIN_ID);
    address[] memory assetsAfterSecondLock = vaultBank.viewAllLockedAssets();
    assertEq(assetsAfterSecondLock.length, 2, "Locked assets array should have two entries");
    bool foundToken1 = false;
    bool foundToken2 = false;
    for (uint256 i = 0; i < assetsAfterSecondLock.length; i++) {
        if (assetsAfterSecondLock[i] == address(token)) {
            foundToken1 = true;
        } else if (assetsAfterSecondLock[i] == address(token2)) {
            foundToken2 = true;
        }
    }
    assertTrue(foundToken1, "First token should be in the locked assets array");
    assertTrue(foundToken2, "Second token should be in the locked assets array");
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

### assertEq(address,address,string)

- **Kind**: internal
- **Source**: 4179:177:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(address,address,string)`

```solidity
function assertEq(address left, address right, string memory err) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right, err);
    }
}
```

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

- **MockERC20::mint(address,uint256)**
- **Vm::startPrank(address)**
- **MockERC20::approve(address,uint256)**
- **Vm::stopPrank()**
- **TestVaultBank::viewAllLockedAssets()**
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
┌─ [0] ⚙️ FUNCTION: VaultBankTest.test_viewAllLockedAssets() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [initialAssets.length, 0, "Initial locked assets array should be empty"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
  │   💬 Args: [assets.length, 1, "Locked assets array should have one entry"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 3)
  │   💬 Args: [assets[0], address(token), "Locked asset should match the token address"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 4)
  │   💬 Args: [assetsAfterSecondLock.length, 2, "Locked assets array should have two entries"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 5)
  │   💬 Args: [foundToken1, "First token should be in the locked assets array"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 6)
      💬 Args: [foundToken2, "Second token should be in the locked assets array"]
      👁️  Def: internal
```
