# Function: test_VaultBankSuperPositions_constructor()

**Contract**: [test/draft/test/unit/VaultBank.t.sol/contract_VaultBankTest.md]

## Metadata

- **Contract**: VaultBankTest
- **Signature**: `test_VaultBankSuperPositions_constructor()`
- **Visibility**: public
- **Source Range**: 63679:171:570

## Implementation

```solidity
function test_VaultBankSuperPositions_constructor() public view {
    assertEq(vaultBankSp.decimals(), 18);
    assertEq(vaultBankSp.owner(), address(this));
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

### assertEq(address,address)

- **Kind**: internal
- **Source**: 4020:153:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(address,address)`

```solidity
function assertEq(address left, address right) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right);
    }
}
```

## External Calls

- **VaultBankSuperPosition::decimals()**
- **VaultBankSuperPosition::owner()**

## State Variable Reads

- **vaultBankSp** (`contract VaultBankSuperPosition`) [test/draft/src/VaultBank/VaultBankSuperPosition.sol/contract_VaultBankSuperPosition.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: VaultBankTest.test_VaultBankSuperPositions_constructor() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 1)
  │   💬 Args: [vaultBankSp.decimals(), 18]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address) (NodeID: 2)
      💬 Args: [vaultBankSp.owner(), address(this)]
      👁️  Def: internal
```
