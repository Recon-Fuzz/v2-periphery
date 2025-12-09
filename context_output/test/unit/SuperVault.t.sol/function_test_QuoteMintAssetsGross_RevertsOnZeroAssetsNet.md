# Function: test_QuoteMintAssetsGross_RevertsOnZeroAssetsNet()

**Contract**: [test/unit/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_QuoteMintAssetsGross_RevertsOnZeroAssetsNet()`
- **Visibility**: public
- **Source Range**: 78047:1166:660

## Implementation

```solidity
/// @notice Tests quoteMintAssetsGross reverts when assetsNet rounds to 0
///  @dev Covers SuperVaultStrategy.sol:239
function test_QuoteMintAssetsGross_RevertsOnZeroAssetsNet() public {
    bytes32 strategyDataSlot = bytes32(uint256(1));
    bytes32 ppsStorageSlot = keccak256(abi.encode(address(strategy), strategyDataSlot));
    vm.store(address(superVaultAggregator), ppsStorageSlot, bytes32(uint256(1)));
    assertEq(strategy.getStoredPPS(), 1, "PPS should be 1");
    vm.expectRevert(ISuperVaultStrategy.INVALID_AMOUNT.selector);
    strategy.quoteMintAssetsGross(0);
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

- **Vm::store(address,bytes32,bytes32)**
- **SuperVaultStrategy::getStoredPPS()**
- **Vm::expectRevert(bytes4)**
- **SuperVaultStrategy::quoteMintAssetsGross(uint256)**

## State Variable Reads

- **strategy** (`contract SuperVaultStrategy`) [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_QuoteMintAssetsGross_RevertsOnZeroAssetsNet() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
      💬 Args: [strategy.getStoredPPS(), 1, "PPS should be 1"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests quoteMintAssetsGross reverts when assetsNet rounds to 0
 @dev Covers SuperVaultStrategy.sol:239
