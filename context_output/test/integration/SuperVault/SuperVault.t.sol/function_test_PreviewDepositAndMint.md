# Function: test_PreviewDepositAndMint()

**Contract**: [test/integration/SuperVault/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_PreviewDepositAndMint()`
- **Visibility**: public
- **Source Range**: 54594:637:580

## Implementation

```solidity
function test_PreviewDepositAndMint() public view {
    uint256 amount = 1000e6;
    uint256 expectedShares = vault.convertToShares(amount);
    uint256 previewShares = vault.previewDeposit(amount);
    assertEq(previewShares, expectedShares, "previewDeposit should match convertToShares");
    uint256 expectedAssets = vault.convertToAssets(amount);
    uint256 previewAssets = vault.previewMint(amount);
    assertEq(previewAssets, expectedAssets, "previewMint should match convertToAssets");
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

- **SuperVault::convertToShares(uint256)**
- **SuperVault::previewDeposit(uint256)**
- **SuperVault::convertToAssets(uint256)**
- **SuperVault::previewMint(uint256)**

## State Variable Reads

- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_PreviewDepositAndMint() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [previewShares, expectedShares, "previewDeposit should match convertToShares"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
      💬 Args: [previewAssets, expectedAssets, "previewMint should match convertToAssets"]
      👁️  Def: internal
```
