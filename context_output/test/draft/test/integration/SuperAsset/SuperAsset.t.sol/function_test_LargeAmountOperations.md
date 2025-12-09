# Function: test_LargeAmountOperations()

**Contract**: [test/draft/test/integration/SuperAsset/SuperAsset.t.sol/contract_SuperAssetTest.md]

## Metadata

- **Contract**: SuperAssetTest
- **Signature**: `test_LargeAmountOperations()`
- **Visibility**: public
- **Source Range**: 66333:1106:565

## Implementation

```solidity
function test_LargeAmountOperations() public {
    address liquidityProvider = user11;
    uint256 largeAmount = type(uint128).max;
    underlyingToken1.mint(liquidityProvider, largeAmount);
    vm.startPrank(liquidityProvider);
    underlyingToken1.approve(address(tokenIn), largeAmount);
    tokenIn.deposit(largeAmount / 2, liquidityProvider);
    tokenIn.approve(address(superAsset), largeAmount / 2);
    ISuperAsset.DepositArgs memory depositArgs = ISuperAsset.DepositArgs({receiver: liquidityProvider, tokenIn: address(tokenIn), amountTokenToDeposit: largeAmount / 4, minSharesOut: 0});
    ISuperAsset.DepositReturnVars memory ret = superAsset.deposit(depositArgs);
    assertGt(ret.amountSharesMinted, 0, "Should mint shares even with large amounts");
    vm.stopPrank();
}
```

## Related Implementations

### assertGt(uint256,uint256,string)

- **Kind**: internal
- **Source**: 14795:177:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertGt(uint256,uint256,string)`

```solidity
function assertGt(uint256 left, uint256 right, string memory err) virtual internal pure {
    if (left <= right) {
        vm.assertGt(left, right, err);
    }
}
```

## External Calls

- **MockERC20::mint(address,uint256)**
- **Vm::startPrank(address)**
- **MockERC20::approve(address,uint256)**
- **Mock4626Vault::deposit(uint256,address)**
- **Mock4626Vault::approve(address,uint256)**
- **SuperAsset::deposit(struct ISuperAsset.DepositArgs)**
- **Vm::stopPrank()**

## State Variable Reads

- **user11** (`address`)
- **underlyingToken1** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **tokenIn** (`contract Mock4626Vault`) [test/mocks/Mock4626Vault.sol/contract_Mock4626Vault.md]
- **superAsset** (`contract SuperAsset`) [test/draft/src/SuperAsset/SuperAsset.sol/contract_SuperAsset.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperAssetTest.test_LargeAmountOperations() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 1)
      💬 Args: [ret.amountSharesMinted, 0, "Should mint shares even with large amounts"]
      👁️  Def: internal
```
