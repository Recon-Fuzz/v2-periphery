# Function: test_Initialize1()

**Contract**: [test/draft/test/integration/SuperAsset/SuperAsset.t.sol/contract_SuperAssetTest.md]

## Metadata

- **Contract**: SuperAssetTest
- **Signature**: `test_Initialize1()`
- **Visibility**: public
- **Source Range**: 18584:258:565

## Implementation

```solidity
function test_Initialize1() public view {
    assertEq(superAsset.name(), "SuperAsset");
    assertEq(superAsset.symbol(), "SA");
    assertEq(superAsset.swapFeeInPercentage(), 100);
    assertEq(superAsset.swapFeeOutPercentage(), 100);
}
```

## Related Implementations

### assertEq(string,string)

- **Kind**: internal
- **Source**: 5050:122:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(string,string)`

```solidity
function assertEq(string memory left, string memory right) virtual internal pure {
    vm.assertEq(left, right);
}
```

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

- **SuperAsset::name()**
- **SuperAsset::symbol()**
- **SuperAsset::swapFeeInPercentage()**
- **SuperAsset::swapFeeOutPercentage()**

## State Variable Reads

- **superAsset** (`contract SuperAsset`) [test/draft/src/SuperAsset/SuperAsset.sol/contract_SuperAsset.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperAssetTest.test_Initialize1() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(string,string) (NodeID: 1)
  │   💬 Args: [superAsset.name(), "SuperAsset"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(string,string) (NodeID: 2)
  │   💬 Args: [superAsset.symbol(), "SA"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 3)
  │   💬 Args: [superAsset.swapFeeInPercentage(), 100]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 4)
      💬 Args: [superAsset.swapFeeOutPercentage(), 100]
      👁️  Def: internal
```
