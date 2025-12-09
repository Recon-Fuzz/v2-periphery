# Function: test_SuperBank_receive()

**Contract**: [test/unit/SuperBank.t.sol/contract_SuperBankTest.md]

## Metadata

- **Contract**: SuperBankTest
- **Signature**: `test_SuperBank_receive()`
- **Visibility**: public
- **Source Range**: 5592:463:658

## Implementation

```solidity
function test_SuperBank_receive() public {
    uint256 initialBalance = address(superBank).balance;
    uint256 amountToSend = 1 ether;
    vm.deal(user, amountToSend);
    vm.prank(user);
    (bool success, ) = address(superBank).call{value: amountToSend}("");
    assertTrue(success, "ETH transfer failed");
    assertEq(address(superBank).balance, initialBalance + amountToSend, "SuperBank did not receive ETH correctly");
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
- **Vm::prank(address)**
- **unknown::unknown**

## State Variable Reads

- **superBank** (`contract SuperBank`) [src/SuperBank.sol/contract_SuperBank.md]
- **user** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperBankTest.test_SuperBank_receive() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 1)
  │   💬 Args: [success, "ETH transfer failed"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
      💬 Args: [address(superBank).balance, initialBalance + amountToSend, "SuperBank did not receive ETH correctly"]
      👁️  Def: internal
```
