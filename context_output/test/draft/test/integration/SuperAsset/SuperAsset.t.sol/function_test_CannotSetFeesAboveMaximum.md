# Function: test_CannotSetFeesAboveMaximum()

**Contract**: [test/draft/test/integration/SuperAsset/SuperAsset.t.sol/contract_SuperAssetTest.md]

## Metadata

- **Contract**: SuperAssetTest
- **Signature**: `test_CannotSetFeesAboveMaximum()`
- **Visibility**: public
- **Source Range**: 20470:306:565

## Implementation

```solidity
function test_CannotSetFeesAboveMaximum() public {
    uint256 tooHighFee = superAsset.MAX_SWAP_FEE_PERC() + 1;
    vm.startPrank(admin);
    vm.expectRevert(ISuperAsset.INVALID_SWAP_FEE_PERCENTAGE.selector);
    superAsset.setSwapFeeInPercentage(tooHighFee);
    vm.stopPrank();
}
```

## External Calls

- **SuperAsset::MAX_SWAP_FEE_PERC()**
- **Vm::startPrank(address)**
- **Vm::expectRevert(bytes4)**
- **SuperAsset::setSwapFeeInPercentage(uint256)**
- **Vm::stopPrank()**

## State Variable Reads

- **superAsset** (`contract SuperAsset`) [test/draft/src/SuperAsset/SuperAsset.sol/contract_SuperAsset.md]
- **admin** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperAssetTest.test_CannotSetFeesAboveMaximum() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
