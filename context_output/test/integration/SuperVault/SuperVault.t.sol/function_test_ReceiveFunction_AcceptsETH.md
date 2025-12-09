# Function: test_ReceiveFunction_AcceptsETH()

**Contract**: [test/integration/SuperVault/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_ReceiveFunction_AcceptsETH()`
- **Visibility**: public
- **Source Range**: 411783:569:580

## Implementation

```solidity
function test_ReceiveFunction_AcceptsETH() public {
    uint256 ethAmount = 1 ether;
    vm.deal(address(this), ethAmount);
    uint256 strategyBalanceBefore = address(strategy).balance;
    (bool success, ) = payable(address(strategy)).call{value: ethAmount}("");
    assertTrue(success, "ETH transfer should succeed");
    assertEq(address(strategy).balance, strategyBalanceBefore + ethAmount, "Strategy should receive ETH");
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
- **unknown::unknown**

## State Variable Reads

- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_ReceiveFunction_AcceptsETH() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 1)
  │   💬 Args: [success, "ETH transfer should succeed"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
      💬 Args: [address(strategy).balance, strategyBalanceBefore + ethAmount, "Strategy should receive ETH"]
      👁️  Def: internal
```
