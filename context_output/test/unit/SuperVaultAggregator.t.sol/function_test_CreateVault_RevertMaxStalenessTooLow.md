# Function: test_CreateVault_RevertMaxStalenessTooLow()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_CreateVault_RevertMaxStalenessTooLow()`
- **Visibility**: public
- **Source Range**: 15852:971:661

## Implementation

```solidity
/// @notice Tests that createVault reverts when maxStaleness is below minimum required staleness
function test_CreateVault_RevertMaxStalenessTooLow() public {
    uint256 minStaleness = superGovernor.getMinStaleness();
    assertEq(minStaleness, 300, "Min staleness should be 300 seconds");
    vm.prank(manager);
    vm.expectRevert(ISuperVaultAggregator.MAX_STALENESS_TOO_LOW.selector);
    superVaultAggregator.createVault(ISuperVaultAggregator.VaultCreationParams({asset: address(asset), name: "Test Vault", symbol: "TEST", mainManager: manager, secondaryManagers: new address[](0), minUpdateInterval: 5, maxStaleness: 299, feeConfig: ISuperVaultStrategy.FeeConfig({performanceFeeBps: 1000, managementFeeBps: 0, recipient: manager})}));
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

- **SuperGovernor::getMinStaleness()**
- **Vm::prank(address)**
- **Vm::expectRevert(bytes4)**
- **SuperVaultAggregator::createVault(struct ISuperVaultAggregator.VaultCreationParams)**

## State Variable Reads

- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **manager** (`address`)
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **asset** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_CreateVault_RevertMaxStalenessTooLow() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
      💬 Args: [minStaleness, 300, "Min staleness should be 300 seconds"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests that createVault reverts when maxStaleness is below minimum required staleness
