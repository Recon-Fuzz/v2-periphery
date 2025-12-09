# Function: test_SuperVault_Initializer()

**Contract**: [test/integration/SuperVault/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_SuperVault_Initializer()`
- **Visibility**: public
- **Source Range**: 7450:1733:580

## Implementation

```solidity
function test_SuperVault_Initializer() public {
    ISuperVaultAggregator.VaultCreationParams memory params = ISuperVaultAggregator.VaultCreationParams({asset: address(asset), name: "SuperVault", symbol: "SV_USDC", mainManager: MANAGER, secondaryManagers: new address[](0), minUpdateInterval: 0, maxStaleness: 300, feeConfig: ISuperVaultStrategy.FeeConfig({performanceFeeBps: 0, managementFeeBps: 0, recipient: MANAGER})});
    aggregator.createVault(params);
    uint256 NOT_ENTERED = 1;
    bytes32 slot = 0x9b779b17422d0df92223018b32b4d1fa46e071723d6817e2486d003becc55f00;
    uint256 storedValue = uint256(vm.load(address(vault), slot));
    assertEq(storedValue, NOT_ENTERED, "ReentrancyGuard not initialized properly");
    MockAssetNoDecimals mockAsset = new MockAssetNoDecimals("NoDecimals", "NODEC");
    ISuperVaultAggregator.VaultCreationParams memory params1 = ISuperVaultAggregator.VaultCreationParams({asset: address(mockAsset), name: "SuperVault", symbol: "SV_USDC", mainManager: MANAGER, secondaryManagers: new address[](0), minUpdateInterval: 0, maxStaleness: 300, feeConfig: ISuperVaultStrategy.FeeConfig({performanceFeeBps: 0, managementFeeBps: 0, recipient: MANAGER})});
    vm.expectRevert(ISuperVault.INVALID_ASSET.selector);
    aggregator.createVault(params1);
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

- **SuperVaultAggregator::createVault(struct ISuperVaultAggregator.VaultCreationParams)**
- **Vm::load(address,bytes32)**
- **Vm::expectRevert(bytes4)**

## State Variable Reads

- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_SuperVault_Initializer() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
      💬 Args: [storedValue, NOT_ENTERED, "ReentrancyGuard not initialized properly"]
      👁️  Def: internal
```
