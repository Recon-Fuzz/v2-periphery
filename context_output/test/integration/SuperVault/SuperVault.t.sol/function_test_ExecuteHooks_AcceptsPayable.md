# Function: test_ExecuteHooks_AcceptsPayable()

**Contract**: [test/integration/SuperVault/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_ExecuteHooks_AcceptsPayable()`
- **Visibility**: public
- **Source Range**: 410214:1563:580

## Implementation

```solidity
function test_ExecuteHooks_AcceptsPayable() public {
    uint256 ethAmount = 1 ether;
    vm.deal(MANAGER, ethAmount);
    uint256 strategyETHBefore = address(strategy).balance;
    vm.startPrank(MANAGER);
    (bool success, ) = address(strategy).call{value: ethAmount}("");
    vm.stopPrank();
    assertTrue(success, "ETH transfer should succeed");
    assertEq(address(strategy).balance, strategyETHBefore + ethAmount, "Strategy should have received ETH");
    ISuperVaultStrategy.ExecuteArgs memory args = ISuperVaultStrategy.ExecuteArgs({hooks: new address[](0), hookCalldata: new bytes[](0), expectedAssetsOrSharesOut: new uint256[](0), globalProofs: new bytes32[][](0), strategyProofs: new bytes32[][](0)});
    vm.deal(MANAGER, ethAmount);
    vm.startPrank(MANAGER);
    vm.expectRevert(ISuperVaultStrategy.ZERO_LENGTH.selector);
    strategy.executeHooks{value: ethAmount}(args);
    vm.stopPrank();
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
- **Vm::expectRevert(bytes4)**

## State Variable Reads

- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_ExecuteHooks_AcceptsPayable() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 1)
  │   💬 Args: [success, "ETH transfer should succeed"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
      💬 Args: [address(strategy).balance, strategyETHBefore + ethAmount, "Strategy should have received ETH"]
      👁️  Def: internal
```
