# Function: test_receive()

**Contract**: [test/draft/test/unit/VaultBank.t.sol/contract_VaultBankTest.md]

## Metadata

- **Contract**: VaultBankTest
- **Signature**: `test_receive()`
- **Visibility**: public
- **Source Range**: 56363:502:570

## Implementation

```solidity
function test_receive() public {
    uint256 initialBalance = address(vaultBank).balance;
    uint256 amount = 1 ether;
    vm.deal(user, amount);
    vm.startPrank(user);
    (bool success, ) = address(vaultBank).call{value: amount}("");
    vm.stopPrank();
    assertTrue(success, "VaultBank should receive ETH");
    assertEq(address(vaultBank).balance, initialBalance + amount, "VaultBank balance should increase by the sent amount");
}
```

## Related Implementations

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

- **Vm::deal(address,uint256)**
- **Vm::startPrank(address)**
- **unknown::unknown**
- **Vm::stopPrank()**

## State Variable Reads

- **vaultBank** (`contract TestVaultBank`) [test/draft/test/unit/VaultBank.t.sol/contract_TestVaultBank.md]
- **user** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: VaultBankTest.test_receive() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 1)
  │   💬 Args: [success, "VaultBank should receive ETH"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
      💬 Args: [address(vaultBank).balance, initialBalance + amount, "VaultBank balance should increase by the sent amount"]
      👁️  Def: internal
```
