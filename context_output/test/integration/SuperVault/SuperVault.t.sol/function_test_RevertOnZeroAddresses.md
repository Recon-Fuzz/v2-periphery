# Function: test_RevertOnZeroAddresses()

**Contract**: [test/integration/SuperVault/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_RevertOnZeroAddresses()`
- **Visibility**: public
- **Source Range**: 133868:932:580

## Implementation

```solidity
function test_RevertOnZeroAddresses() public {
    vm.expectRevert(ISuperVaultAggregator.ZERO_ADDRESS.selector);
    _createVault(VaultCreationParams({asset: address(0), manager: MANAGER, minUpdateInterval: 1000, maxStaleness: 10_000, performanceFeeBps: 1000, symbol: "TV"}));
    vm.expectRevert(ISuperVaultAggregator.ZERO_ADDRESS.selector);
    _createVault(VaultCreationParams({asset: address(asset), manager: address(0), minUpdateInterval: 1000, maxStaleness: 10_000, performanceFeeBps: 1000, symbol: "TV"}));
}
```

## Related Implementations

### _createVault(struct SuperVaultTest.VaultCreationParams)

- **Kind**: internal
- **Source**: 135877:828:580
- **Link**: `test/integration/SuperVault/SuperVault.t.sol:SuperVaultTest:_createVault(struct SuperVaultTest.VaultCreationParams)`

```solidity
function _createVault(VaultCreationParams memory params) internal returns (address vaultAddr, address strategyAddr, address escrowAddr) {
    (vaultAddr, strategyAddr, escrowAddr) = aggregator.createVault(ISuperVaultAggregator.VaultCreationParams({asset: params.asset, name: "SuperVault", symbol: params.symbol, mainManager: params.manager, secondaryManagers: new address[](0), minUpdateInterval: params.minUpdateInterval, maxStaleness: params.maxStaleness, feeConfig: ISuperVaultStrategy.FeeConfig({performanceFeeBps: params.performanceFeeBps, managementFeeBps: 0, recipient: address(this)})}));
}
```

## External Calls

- **Vm::expectRevert(bytes4)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_RevertOnZeroAddresses() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: SuperVaultTest._createVault(struct SuperVaultTest.VaultCreationParams) (NodeID: 1)
  │   💬 Args: [VaultCreationParams({asset: address(0), manager: MANAGER, minUpdateInterval: 1000, maxStaleness: 10_000, performanceFeeBps: 1000, symbol: "TV"})]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: SuperVaultTest._createVault(struct SuperVaultTest.VaultCreationParams) (NodeID: 2)
      💬 Args: [VaultCreationParams({asset: address(asset), manager: address(0), minUpdateInterval: 1000, maxStaleness: 10_000, performanceFeeBps: 1000, symbol: "TV"})]
      👁️  Def: internal
```
