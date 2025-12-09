# Function: test_TargetAllocationManagement()

**Contract**: [test/draft/test/integration/SuperAsset/SuperAsset.t.sol/contract_SuperAssetTest.md]

## Metadata

- **Contract**: SuperAssetTest
- **Signature**: `test_TargetAllocationManagement()`
- **Visibility**: public
- **Source Range**: 58464:1133:565

## Implementation

```solidity
function test_TargetAllocationManagement() public {
    vm.startPrank(admin);
    address[] memory tokens = new address[](3);
    tokens[0] = address(tokenIn);
    tokens[1] = address(tokenOut);
    tokens[2] = address(underlyingToken1);
    uint256[] memory allocations = new uint256[](3);
    allocations[0] = 50e18;
    allocations[1] = 30e18;
    allocations[2] = 20e18;
    superAsset.setTargetAllocations(tokens, allocations);
    ISuperAsset.TokenData memory tokenData = superAsset.getTokenData(address(tokenIn));
    assertEq(tokenData.targetAllocations, 50e18, "TokenIn allocation should be 50%");
    tokenData = superAsset.getTokenData(address(tokenOut));
    assertEq(tokenData.targetAllocations, 30e18, "TokenOut allocation should be 30%");
    tokenData = superAsset.getTokenData(address(underlyingToken1));
    assertEq(tokenData.targetAllocations, 20e18, "underlyingToken1 allocation should be 20%");
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
- **SuperAsset::setTargetAllocations(address[],uint256[])**
- **SuperAsset::getTokenData(address)**
- **Vm::stopPrank()**

## State Variable Reads

- **admin** (`address`)
- **tokenIn** (`contract Mock4626Vault`) [test/mocks/Mock4626Vault.sol/contract_Mock4626Vault.md]
- **tokenOut** (`contract Mock4626Vault`) [test/mocks/Mock4626Vault.sol/contract_Mock4626Vault.md]
- **underlyingToken1** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **superAsset** (`contract SuperAsset`) [test/draft/src/SuperAsset/SuperAsset.sol/contract_SuperAsset.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperAssetTest.test_TargetAllocationManagement() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [tokenData.targetAllocations, 50e18, "TokenIn allocation should be 50%"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
  │   💬 Args: [tokenData.targetAllocations, 30e18, "TokenOut allocation should be 30%"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 3)
      💬 Args: [tokenData.targetAllocations, 20e18, "underlyingToken1 allocation should be 20%"]
      👁️  Def: internal
```
