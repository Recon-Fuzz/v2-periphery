# Function: test_GetSuperVaultEscrowsCount()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_GetSuperVaultEscrowsCount()`
- **Visibility**: public
- **Source Range**: 63566:1324:661

## Implementation

```solidity
/// @notice Tests getSuperVaultEscrowsCount returns the correct count
function test_GetSuperVaultEscrowsCount() public {
    uint256 count = superVaultAggregator.getSuperVaultEscrowsCount();
    assertEq(count, 1, "Should have 1 escrow from setUp");
    address[] memory escrows = superVaultAggregator.getAllSuperVaultEscrows();
    assertEq(count, escrows.length, "Count should match getAllSuperVaultEscrows length");
    vm.prank(manager);
    superVaultAggregator.createVault(ISuperVaultAggregator.VaultCreationParams({asset: address(asset), name: "Test Vault 2", symbol: "TV2", mainManager: manager, secondaryManagers: new address[](0), minUpdateInterval: 5, maxStaleness: 300, feeConfig: ISuperVaultStrategy.FeeConfig({performanceFeeBps: 1000, managementFeeBps: 0, recipient: manager})}));
    uint256 newCount = superVaultAggregator.getSuperVaultEscrowsCount();
    assertEq(newCount, 2, "Should have 2 escrows after creating another vault");
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

- **SuperVaultAggregator::getSuperVaultEscrowsCount()**
- **SuperVaultAggregator::getAllSuperVaultEscrows()**
- **Vm::prank(address)**
- **SuperVaultAggregator::createVault(struct ISuperVaultAggregator.VaultCreationParams)**

## State Variable Reads

- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **manager** (`address`)
- **asset** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_GetSuperVaultEscrowsCount() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [count, 1, "Should have 1 escrow from setUp"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
  │   💬 Args: [count, escrows.length, "Count should match getAllSuperVaultEscrows length"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 3)
      💬 Args: [newCount, 2, "Should have 2 escrows after creating another vault"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests getSuperVaultEscrowsCount returns the correct count
