# Function: test_WeightManagement()

**Contract**: [test/draft/test/integration/SuperAsset/SuperAsset.t.sol/contract_SuperAssetTest.md]

## Metadata

- **Contract**: SuperAssetTest
- **Signature**: `test_WeightManagement()`
- **Visibility**: public
- **Source Range**: 59603:820:565

## Implementation

```solidity
function test_WeightManagement() public {
    vm.startPrank(admin);
    superAsset.setWeight(address(tokenIn), 100);
    superAsset.setWeight(address(tokenOut), 200);
    superAsset.setWeight(address(underlyingToken1), 50);
    ISuperAsset.TokenData memory tokenData = superAsset.getTokenData(address(tokenIn));
    assertEq(tokenData.weights, 100, "TokenIn weight should be 100");
    tokenData = superAsset.getTokenData(address(tokenOut));
    assertEq(tokenData.weights, 200, "TokenOut weight should be 200");
    tokenData = superAsset.getTokenData(address(underlyingToken1));
    assertEq(tokenData.weights, 50, "underlyingToken1 weight should be 50");
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

## External Calls

- **Vm::startPrank(address)**
- **SuperAsset::setWeight(address,uint256)**
- **SuperAsset::getTokenData(address)**
- **Vm::stopPrank()**

## State Variable Reads

- **admin** (`address`)
- **superAsset** (`contract SuperAsset`) [test/draft/src/SuperAsset/SuperAsset.sol/contract_SuperAsset.md]
- **tokenIn** (`contract Mock4626Vault`) [test/mocks/Mock4626Vault.sol/contract_Mock4626Vault.md]
- **tokenOut** (`contract Mock4626Vault`) [test/mocks/Mock4626Vault.sol/contract_Mock4626Vault.md]
- **underlyingToken1** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperAssetTest.test_WeightManagement() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [tokenData.weights, 100, "TokenIn weight should be 100"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
  │   💬 Args: [tokenData.weights, 200, "TokenOut weight should be 200"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 3)
      💬 Args: [tokenData.weights, 50, "underlyingToken1 weight should be 50"]
      👁️  Def: internal
```
