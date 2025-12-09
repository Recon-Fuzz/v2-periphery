# Function: test_ChangeGlobalLeavesStatus_StrategyIndependence()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_ChangeGlobalLeavesStatus_StrategyIndependence()`
- **Visibility**: public
- **Source Range**: 169074:2440:661

## Implementation

```solidity
/// @notice Tests that different strategies have independent banned leaves
function test_ChangeGlobalLeavesStatus_StrategyIndependence() public {
    vm.prank(manager);
    (, address strategy2, ) = superVaultAggregator.createVault(ISuperVaultAggregator.VaultCreationParams({asset: address(asset), mainManager: manager, secondaryManagers: new address[](0), name: "Test Vault 2", symbol: "TV2", minUpdateInterval: 5, maxStaleness: 300, feeConfig: ISuperVaultStrategy.FeeConfig({performanceFeeBps: 1000, managementFeeBps: 0, recipient: manager})}));
    address hookAddress = address(0x123);
    bytes memory hookArgs = "test_args";
    bytes32 leaf = keccak256(bytes.concat(keccak256(abi.encode(hookAddress, hookArgs))));
    vm.prank(address(superGovernor));
    superVaultAggregator.proposeGlobalHooksRoot(leaf);
    vm.warp((block.timestamp + superVaultAggregator.getHooksRootUpdateTimelock()) + 1);
    superVaultAggregator.executeGlobalHooksRootUpdate();
    bytes32[] memory leaves = new bytes32[](1);
    leaves[0] = leaf;
    bool[] memory statuses = new bool[](1);
    statuses[0] = true;
    vm.prank(manager);
    superVaultAggregator.changeGlobalLeavesStatus(leaves, statuses, strategy);
    bytes32[] memory globalProof = new bytes32[](0);
    bytes32[] memory strategyProof = new bytes32[](0);
    bool isValid1 = superVaultAggregator.validateHook(strategy, ISuperVaultAggregator.ValidateHookArgs({hookAddress: hookAddress, hookArgs: hookArgs, globalProof: globalProof, strategyProof: strategyProof}));
    assertFalse(isValid1, "Hook should be invalid for strategy1");
    bool isValid2 = superVaultAggregator.validateHook(strategy2, ISuperVaultAggregator.ValidateHookArgs({hookAddress: hookAddress, hookArgs: hookArgs, globalProof: globalProof, strategyProof: strategyProof}));
    assertTrue(isValid2, "Hook should be valid for strategy2");
}
```

## Related Implementations

### assertFalse(bool,string)

- **Kind**: internal
- **Source**: 2179:149:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertFalse(bool,string)`

```solidity
function assertFalse(bool data, string memory err) virtual internal pure {
    if (data) {
        vm.assertFalse(data, err);
    }
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

## External Calls

- **Vm::prank(address)**
- **SuperVaultAggregator::createVault(struct ISuperVaultAggregator.VaultCreationParams)**
- **SuperVaultAggregator::proposeGlobalHooksRoot(bytes32)**
- **Vm::warp(uint256)**
- **SuperVaultAggregator::getHooksRootUpdateTimelock()**
- **SuperVaultAggregator::executeGlobalHooksRootUpdate()**
- **SuperVaultAggregator::changeGlobalLeavesStatus(bytes32[],bool[],address)**
- **SuperVaultAggregator::validateHook(address,struct ISuperVaultAggregator.ValidateHookArgs)**

## State Variable Reads

- **manager** (`address`)
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **asset** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **strategy** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_ChangeGlobalLeavesStatus_StrategyIndependence() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 1)
  │   💬 Args: [isValid1, "Hook should be invalid for strategy1"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 2)
      💬 Args: [isValid2, "Hook should be valid for strategy2"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests that different strategies have independent banned leaves
