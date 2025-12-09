# Function: test_CreateVaultWithSecondaryManagers()

**Contract**: [test/integration/SuperVault/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_CreateVaultWithSecondaryManagers()`
- **Visibility**: public
- **Source Range**: 134806:854:580

## Implementation

```solidity
function test_CreateVaultWithSecondaryManagers() public {
    address[] memory secondaryManagers = new address[](2);
    secondaryManagers[0] = address(0x1);
    secondaryManagers[1] = address(0x2);
    (, address strategyAddr, ) = _createVaultWithSecondaryManagers(VaultCreationParams({asset: address(asset), manager: address(this), minUpdateInterval: 1000, maxStaleness: 10_000, performanceFeeBps: 1000, symbol: "TV"}), secondaryManagers);
    address[] memory retrievedManagers = aggregator.getSecondaryManagers(strategyAddr);
    assertEq(retrievedManagers.length, 2);
    assertEq(retrievedManagers[0], address(0x1));
    assertEq(retrievedManagers[1], address(0x2));
}
```

## Related Implementations

### _createVaultWithSecondaryManagers(struct SuperVaultTest.VaultCreationParams,address[])

- **Kind**: internal
- **Source**: 136711:908:580
- **Link**: `test/integration/SuperVault/SuperVault.t.sol:SuperVaultTest:_createVaultWithSecondaryManagers(struct SuperVaultTest.VaultCreationParams,address[])`

```solidity
function _createVaultWithSecondaryManagers(VaultCreationParams memory params, address[] memory secondaryManagers) internal returns (address vaultAddr, address strategyAddr, address escrowAddr) {
    (vaultAddr, strategyAddr, escrowAddr) = aggregator.createVault(ISuperVaultAggregator.VaultCreationParams({asset: params.asset, name: "SuperVault", symbol: params.symbol, mainManager: params.manager, secondaryManagers: secondaryManagers, minUpdateInterval: params.minUpdateInterval, maxStaleness: params.maxStaleness, feeConfig: ISuperVaultStrategy.FeeConfig({performanceFeeBps: params.performanceFeeBps, managementFeeBps: 0, recipient: address(this)})}));
}
```

### assertEq(uint256,uint256)

- **Kind**: internal
- **Source**: 2664:153:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256)`

```solidity
function assertEq(uint256 left, uint256 right) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right);
    }
}
```

### assertEq(address,address)

- **Kind**: internal
- **Source**: 4020:153:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(address,address)`

```solidity
function assertEq(address left, address right) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right);
    }
}
```

## External Calls

- **SuperVaultAggregator::getSecondaryManagers(address)**

## State Variable Reads

- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_CreateVaultWithSecondaryManagers() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: SuperVaultTest._createVaultWithSecondaryManagers(struct SuperVaultTest.VaultCreationParams,address[]) (NodeID: 1)
  │   💬 Args: [VaultCreationParams({asset: address(asset), manager: address(this), minUpdateInterval: 1000, maxStaleness: 10_000, performanceFeeBps: 1000, symbol: "TV"}), secondaryManagers]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 2)
  │   💬 Args: [retrievedManagers.length, 2]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address) (NodeID: 3)
  │   💬 Args: [retrievedManagers[0], address(0x1)]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address) (NodeID: 4)
      💬 Args: [retrievedManagers[1], address(0x2)]
      👁️  Def: internal
```
