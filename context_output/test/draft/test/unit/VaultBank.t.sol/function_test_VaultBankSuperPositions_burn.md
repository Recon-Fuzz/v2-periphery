# Function: test_VaultBankSuperPositions_burn()

**Contract**: [test/draft/test/unit/VaultBank.t.sol/contract_VaultBankTest.md]

## Metadata

- **Contract**: VaultBankTest
- **Signature**: `test_VaultBankSuperPositions_burn()`
- **Visibility**: public
- **Source Range**: 64040:222:570

## Implementation

```solidity
function test_VaultBankSuperPositions_burn() public {
    vaultBankSp.mint(address(this), 100 ether);
    vaultBankSp.burn(address(this), 100 ether);
    assertEq(vaultBankSp.balanceOf(address(this)), 0);
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

- **VaultBankSuperPosition::mint(address,uint256)**
- **VaultBankSuperPosition::burn(address,uint256)**
- **VaultBankSuperPosition::balanceOf(address)**

## State Variable Reads

- **vaultBankSp** (`contract VaultBankSuperPosition`) [test/draft/src/VaultBank/VaultBankSuperPosition.sol/contract_VaultBankSuperPosition.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: VaultBankTest.test_VaultBankSuperPositions_burn() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 1)
      💬 Args: [vaultBankSp.balanceOf(address(this)), 0]
      👁️  Def: internal
```
