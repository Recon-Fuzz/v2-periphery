# Function: test_AutoPurgeWithZeroBalance()

**Contract**: [test/draft/test/integration/SuperAsset/SuperAsset.t.sol/contract_SuperAssetTest.md]

## Metadata

- **Contract**: SuperAssetTest
- **Signature**: `test_AutoPurgeWithZeroBalance()`
- **Visibility**: public
- **Source Range**: 51543:1658:565

## Implementation

```solidity
function test_AutoPurgeWithZeroBalance() public {
    MockERC20 testToken = new MockERC20("Test Token", "TEST", 18);
    vm.startPrank(admin);
    superAsset.whitelistERC20(address(testToken));
    vm.stopPrank();
    testToken.mint(address(superAsset), 100e18);
    assertEq(testToken.balanceOf(address(superAsset)), 100e18, "SuperAsset should have token balance");
    vm.startPrank(admin);
    superAsset.removeERC20(address(testToken));
    ISuperAsset.TokenData memory tokenData = superAsset.getTokenData(address(testToken));
    assertFalse(tokenData.isActive, "Token should be inactive after deactivation");
    assertTrue(tokenData.isSupportedERC20, "Token should still be supported when it has balance");
    vm.stopPrank();
    vm.prank(address(superAsset));
    testToken.transfer(address(this), 100e18);
    assertEq(testToken.balanceOf(address(superAsset)), 0, "SuperAsset should have no token balance");
    vm.startPrank(admin);
    superAsset.removeERC20(address(testToken));
    tokenData = superAsset.getTokenData(address(testToken));
    assertFalse(tokenData.isActive, "Token should be inactive after purge");
    assertFalse(tokenData.isSupportedERC20, "Token should be completely removed when it has no balance");
    vm.stopPrank();
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

### assertFalse(bool,string)

- **Kind**: internal
- **Source**: 2179:149:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertFalse(bool,string)`

```solidity
function assertFalse(bool data, string memory err) virtual internal pure {
    if (data) {
        vm.assertFalse(data, err);
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

- **Vm::startPrank(address)**
- **SuperAsset::whitelistERC20(address)**
- **Vm::stopPrank()**
- **MockERC20::mint(address,uint256)**
- **MockERC20::balanceOf(address)**
- **SuperAsset::removeERC20(address)**
- **SuperAsset::getTokenData(address)**
- **Vm::prank(address)**
- **MockERC20::transfer(address,uint256)**

## Native Transfers

- **testToken** (computed)

## State Variable Reads

- **admin** (`address`)
- **superAsset** (`contract SuperAsset`) [test/draft/src/SuperAsset/SuperAsset.sol/contract_SuperAsset.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperAssetTest.test_AutoPurgeWithZeroBalance() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [testToken.balanceOf(address(superAsset)), 100e18, "SuperAsset should have token balance"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 2)
  │   💬 Args: [tokenData.isActive, "Token should be inactive after deactivation"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 3)
  │   💬 Args: [tokenData.isSupportedERC20, "Token should still be supported when it has balance"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 4)
  │   💬 Args: [testToken.balanceOf(address(superAsset)), 0, "SuperAsset should have no token balance"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 5)
  │   💬 Args: [tokenData.isActive, "Token should be inactive after purge"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 6)
      💬 Args: [tokenData.isSupportedERC20, "Token should be completely removed when it has no balance"]
      👁️  Def: internal
```
