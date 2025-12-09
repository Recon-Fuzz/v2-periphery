# Function: test_ValidateHook_UnbannedGlobalLeaf()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_ValidateHook_UnbannedGlobalLeaf()`
- **Visibility**: public
- **Source Range**: 161170:1971:661

## Implementation

```solidity
/// @notice Tests hook validation with unbanned global leaves
function test_ValidateHook_UnbannedGlobalLeaf() public {
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
    bool isValid = superVaultAggregator.validateHook(strategy, ISuperVaultAggregator.ValidateHookArgs({hookAddress: hookAddress, hookArgs: hookArgs, globalProof: globalProof, strategyProof: strategyProof}));
    assertFalse(isValid, "Hook should be invalid when banned");
    statuses[0] = false;
    vm.prank(manager);
    superVaultAggregator.changeGlobalLeavesStatus(leaves, statuses, strategy);
    isValid = superVaultAggregator.validateHook(strategy, ISuperVaultAggregator.ValidateHookArgs({hookAddress: hookAddress, hookArgs: hookArgs, globalProof: globalProof, strategyProof: strategyProof}));
    assertTrue(isValid, "Hook should be valid after unbanning");
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
- **SuperVaultAggregator::proposeGlobalHooksRoot(bytes32)**
- **Vm::warp(uint256)**
- **SuperVaultAggregator::getHooksRootUpdateTimelock()**
- **SuperVaultAggregator::executeGlobalHooksRootUpdate()**
- **SuperVaultAggregator::changeGlobalLeavesStatus(bytes32[],bool[],address)**
- **SuperVaultAggregator::validateHook(address,struct ISuperVaultAggregator.ValidateHookArgs)**

## State Variable Reads

- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **manager** (`address`)
- **strategy** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_ValidateHook_UnbannedGlobalLeaf() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 1)
  │   💬 Args: [isValid, "Hook should be invalid when banned"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 2)
      💬 Args: [isValid, "Hook should be valid after unbanning"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests hook validation with unbanned global leaves
