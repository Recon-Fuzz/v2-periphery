# Function: test_GetSuperVaultsCount()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_GetSuperVaultsCount()`
- **Visibility**: public
- **Source Range**: 60800:1246:661

## Implementation

```solidity
/// @notice Tests getSuperVaultsCount returns the correct count
function test_GetSuperVaultsCount() public {
    uint256 count = superVaultAggregator.getSuperVaultsCount();
    assertEq(count, 1, "Should have 1 vault from setUp");
    address[] memory vaults = superVaultAggregator.getAllSuperVaults();
    assertEq(count, vaults.length, "Count should match getAllSuperVaults length");
    vm.prank(manager);
    superVaultAggregator.createVault(ISuperVaultAggregator.VaultCreationParams({asset: address(asset), name: "Test Vault 2", symbol: "TV2", mainManager: manager, secondaryManagers: new address[](0), minUpdateInterval: 5, maxStaleness: 300, feeConfig: ISuperVaultStrategy.FeeConfig({performanceFeeBps: 1000, managementFeeBps: 0, recipient: manager})}));
    uint256 newCount = superVaultAggregator.getSuperVaultsCount();
    assertEq(newCount, 2, "Should have 2 vaults after creating another");
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

- **SuperVaultAggregator::getSuperVaultsCount()**
- **SuperVaultAggregator::getAllSuperVaults()**
- **Vm::prank(address)**
- **SuperVaultAggregator::createVault(struct ISuperVaultAggregator.VaultCreationParams)**

## State Variable Reads

- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **manager** (`address`)
- **asset** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_GetSuperVaultsCount() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [count, 1, "Should have 1 vault from setUp"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
  │   💬 Args: [count, vaults.length, "Count should match getAllSuperVaults length"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 3)
      💬 Args: [newCount, 2, "Should have 2 vaults after creating another"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests getSuperVaultsCount returns the correct count
