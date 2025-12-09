# Function: test_MinimalAmountOperations()

**Contract**: [test/draft/test/integration/SuperAsset/SuperAsset.t.sol/contract_SuperAssetTest.md]

## Metadata

- **Contract**: SuperAssetTest
- **Signature**: `test_MinimalAmountOperations()`
- **Visibility**: public
- **Source Range**: 67445:949:565

## Implementation

```solidity
function test_MinimalAmountOperations() public {
    uint256 minAmount = 1;
    vm.startPrank(user);
    tokenIn.approve(address(superAsset), minAmount);
    ISuperAsset.DepositArgs memory depositArgs = ISuperAsset.DepositArgs({receiver: user, tokenIn: address(tokenIn), amountTokenToDeposit: minAmount, minSharesOut: 0});
    try superAsset.deposit(depositArgs) returns (ISuperAsset.DepositReturnVars memory ret) {
        assertGe(ret.amountSharesMinted, 0, "Shares minted should be non-negative");
    } catch {
        assertTrue(true, "Minimal amount operations may revert");
    }
    vm.stopPrank();
}
```

## Related Implementations

### assertGe(uint256,uint256,string)

- **Kind**: internal
- **Source**: 17502:176:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertGe(uint256,uint256,string)`

```solidity
function assertGe(uint256 left, uint256 right, string memory err) virtual internal pure {
    if (left < right) {
        vm.assertGe(left, right, err);
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
- **Mock4626Vault::approve(address,uint256)**
- **SuperAsset::deposit(struct ISuperAsset.DepositArgs)**
- **Vm::stopPrank()**

## State Variable Reads

- **user** (`address`)
- **tokenIn** (`contract Mock4626Vault`) [test/mocks/Mock4626Vault.sol/contract_Mock4626Vault.md]
- **superAsset** (`contract SuperAsset`) [test/draft/src/SuperAsset/SuperAsset.sol/contract_SuperAsset.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperAssetTest.test_MinimalAmountOperations() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGe(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [ret.amountSharesMinted, 0, "Shares minted should be non-negative"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 2)
      💬 Args: [true, "Minimal amount operations may revert"]
      👁️  Def: internal
```
