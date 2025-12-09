# Function: test_DeployVault()

**Contract**: [test/integration/SuperVault/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_DeployVault()`
- **Visibility**: public
- **Source Range**: 131509:1628:580

## Implementation

```solidity
function test_DeployVault() public {
    (address vaultAddr, address strategyAddr, address escrowAddr) = _deployVault(address(asset), "SV");
    assertTrue(vaultAddr != address(0), "Vault address should not be zero");
    assertTrue(strategyAddr != address(0), "Strategy address should not be zero");
    assertTrue(escrowAddr != address(0), "Escrow address should not be zero");
    SuperVault vaultContract = SuperVault(vaultAddr);
    ISuperVaultStrategy strategyContract = ISuperVaultStrategy(strategyAddr);
    SuperVaultEscrow escrowContract = SuperVaultEscrow(escrowAddr);
    assertEq(vaultContract.name(), "SuperVault", "Wrong vault name");
    assertEq(vaultContract.symbol(), "SV", "Wrong vault symbol");
    assertEq(vaultContract.asset(), address(asset), "Wrong asset");
    assertEq(address(vaultContract.strategy()), strategyAddr, "Wrong strategy");
    assertEq(vaultContract.decimals(), 6, "Wrong decimals");
    (address _vaultAddr, address _asset, uint8 _decimals) = strategyContract.getVaultInfo();
    assertEq(_vaultAddr, vaultAddr, "Wrong vault in strategy");
    assertEq(_asset, address(asset), "Wrong asset in strategy");
    assertEq(_decimals, 6, "Wrong decimals in strategy");
    assertTrue(escrowContract.initialized(), "Escrow not initialized");
    assertEq(escrowContract.vault(), vaultAddr, "Wrong vault in escrow");
}
```

## Related Implementations

### _deployVault(address,string)

- **Kind**: internal
- **Source**: 13311:1259:576
- **Link**: `test/integration/SuperVault/BaseSuperVaultTest.t.sol:BaseSuperVaultTest:_deployVault(address,string)`

```solidity
///  @notice Deploys a new SuperVault with default configuration
///  @return vaultAddr The address of the deployed SuperVault
///  @return strategyAddr The address of the deployed SuperVaultStrategy
///  @return escrowAddr The address of the deployed SuperVaultEscrow
function _deployVault(address _asset, string memory _superVaultSymbol) internal returns (address vaultAddr, address strategyAddr, address escrowAddr) {
    vm.startPrank(SV_MANAGER);
    (vaultAddr, strategyAddr, escrowAddr) = aggregator.createVault(ISuperVaultAggregator.VaultCreationParams({asset: _asset, name: "SuperVault", symbol: _superVaultSymbol, mainManager: MANAGER, secondaryManagers: new address[](0), minUpdateInterval: 5, maxStaleness: 1 weeks, feeConfig: ISuperVaultStrategy.FeeConfig({performanceFeeBps: 1000, managementFeeBps: 0, recipient: address(this)})}));
    vm.label(vaultAddr, string.concat("SuperVault ", _superVaultSymbol));
    vm.label(strategyAddr, string.concat("SuperVaultStrategy ", _superVaultSymbol));
    vm.label(escrowAddr, string.concat("SuperVaultEscrow ", _superVaultSymbol));
    vm.stopPrank();
    return (vaultAddr, strategyAddr, escrowAddr);
}
```

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

### assertEq(string,string,string)

- **Kind**: internal
- **Source**: 5178:146:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(string,string,string)`

```solidity
function assertEq(string memory left, string memory right, string memory err) virtual internal pure {
    vm.assertEq(left, right, err);
}
```

### assertEq(address,address,string)

- **Kind**: internal
- **Source**: 4179:177:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(address,address,string)`

```solidity
function assertEq(address left, address right, string memory err) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right, err);
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

- **SuperVault::name()**
- **SuperVault::symbol()**
- **SuperVault::asset()**
- **SuperVault::strategy()**
- **SuperVault::decimals()**
- **ISuperVaultStrategy::getVaultInfo()**
- **SuperVaultEscrow::initialized()**
- **SuperVaultEscrow::vault()**

## State Variable Reads

- **aggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_DeployVault() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: BaseSuperVaultTest._deployVault(address,string) (NodeID: 1)
  │   💬 Args: [address(asset), "SV"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 2)
  │   💬 Args: [vaultAddr != address(0), "Vault address should not be zero"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 3)
  │   💬 Args: [strategyAddr != address(0), "Strategy address should not be zero"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 4)
  │   💬 Args: [escrowAddr != address(0), "Escrow address should not be zero"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(string,string,string) (NodeID: 5)
  │   💬 Args: [vaultContract.name(), "SuperVault", "Wrong vault name"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(string,string,string) (NodeID: 6)
  │   💬 Args: [vaultContract.symbol(), "SV", "Wrong vault symbol"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 7)
  │   💬 Args: [vaultContract.asset(), address(asset), "Wrong asset"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 8)
  │   💬 Args: [address(vaultContract.strategy()), strategyAddr, "Wrong strategy"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 9)
  │   💬 Args: [vaultContract.decimals(), 6, "Wrong decimals"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 10)
  │   💬 Args: [_vaultAddr, vaultAddr, "Wrong vault in strategy"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 11)
  │   💬 Args: [_asset, address(asset), "Wrong asset in strategy"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 12)
  │   💬 Args: [_decimals, 6, "Wrong decimals in strategy"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 13)
  │   💬 Args: [escrowContract.initialized(), "Escrow not initialized"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 14)
      💬 Args: [escrowContract.vault(), vaultAddr, "Wrong vault in escrow"]
      👁️  Def: internal
```
