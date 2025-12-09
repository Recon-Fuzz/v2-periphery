# Function: test_Initialize_RevertIfAlreadyInitialized()

**Contract**: [test/draft/test/integration/SuperAsset/SuperAsset.t.sol/contract_SuperAssetTest.md]

## Metadata

- **Contract**: SuperAssetTest
- **Signature**: `test_Initialize_RevertIfAlreadyInitialized()`
- **Visibility**: public
- **Source Range**: 18848:430:565

## Implementation

```solidity
function test_Initialize_RevertIfAlreadyInitialized() public {
    vm.expectRevert(ISuperAsset.ALREADY_INITIALIZED.selector);
    superAsset.initialize("SuperAsset", "SA", address(underlyingToken1), address(superGovernor), address(superRegistry), 100, 100);
}
```

## External Calls

- **Vm::expectRevert(bytes4)**
- **SuperAsset::initialize(string,string,address,address,address,uint256,uint256)**

## State Variable Reads

- **superAsset** (`contract SuperAsset`) [test/draft/src/SuperAsset/SuperAsset.sol/contract_SuperAsset.md]
- **underlyingToken1** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperAssetTest.test_Initialize_RevertIfAlreadyInitialized() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
