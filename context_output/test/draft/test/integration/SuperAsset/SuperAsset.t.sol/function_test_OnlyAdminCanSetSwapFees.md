# Function: test_OnlyAdminCanSetSwapFees()

**Contract**: [test/draft/test/integration/SuperAsset/SuperAsset.t.sol/contract_SuperAssetTest.md]

## Metadata

- **Contract**: SuperAssetTest
- **Signature**: `test_OnlyAdminCanSetSwapFees()`
- **Visibility**: public
- **Source Range**: 19975:489:565

## Implementation

```solidity
function test_OnlyAdminCanSetSwapFees() public {
    uint256 newFee = 500;
    vm.startPrank(user);
    vm.expectRevert(ISuperAsset.UNAUTHORIZED.selector);
    superAsset.setSwapFeeInPercentage(newFee);
    vm.stopPrank();
    vm.startPrank(admin);
    superAsset.setSwapFeeInPercentage(newFee);
    vm.stopPrank();
    assertEq(superAsset.swapFeeInPercentage(), newFee);
}
```

## Related Implementations

### assertEq(uint256,uint256)

- **Kind**: internal
- **Source**: 2664:153:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256)`

```solidity
function assertEq(uint256 left, uint256 right) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right);
    }
}
```

## External Calls

- **Vm::startPrank(address)**
- **Vm::expectRevert(bytes4)**
- **SuperAsset::setSwapFeeInPercentage(uint256)**
- **Vm::stopPrank()**
- **SuperAsset::swapFeeInPercentage()**

## State Variable Reads

- **user** (`address`)
- **superAsset** (`contract SuperAsset`) [test/draft/src/SuperAsset/SuperAsset.sol/contract_SuperAsset.md]
- **admin** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperAssetTest.test_OnlyAdminCanSetSwapFees() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 1)
      💬 Args: [superAsset.swapFeeInPercentage(), newFee]
      👁️  Def: internal
```
