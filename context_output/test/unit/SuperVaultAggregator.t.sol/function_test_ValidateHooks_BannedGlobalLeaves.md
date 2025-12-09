# Function: test_ValidateHooks_BannedGlobalLeaves()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_ValidateHooks_BannedGlobalLeaves()`
- **Visibility**: public
- **Source Range**: 163217:2988:661

## Implementation

```solidity
/// @notice Tests batch hook validation with banned global leaves
function test_ValidateHooks_BannedGlobalLeaves() public {
    address hookAddress1 = address(0x123);
    address hookAddress2 = address(0x456);
    bytes memory hookArgs1 = "args1";
    bytes memory hookArgs2 = "args2";
    bytes32 leaf1 = keccak256(bytes.concat(keccak256(abi.encode(hookAddress1, hookArgs1))));
    bytes32 leaf2 = keccak256(bytes.concat(keccak256(abi.encode(hookAddress2, hookArgs2))));
    vm.prank(address(superGovernor));
    superVaultAggregator.proposeGlobalHooksRoot(leaf1);
    vm.warp((block.timestamp + superVaultAggregator.getHooksRootUpdateTimelock()) + 1);
    superVaultAggregator.executeGlobalHooksRootUpdate();
    vm.prank(manager);
    superVaultAggregator.proposeStrategyHooksRoot(strategy, leaf2);
    vm.warp((block.timestamp + superVaultAggregator.getHooksRootUpdateTimelock()) + 1);
    superVaultAggregator.executeStrategyHooksRootUpdate(strategy);
    bytes32[] memory leaves = new bytes32[](1);
    leaves[0] = leaf1;
    bool[] memory statuses = new bool[](1);
    statuses[0] = true;
    vm.prank(manager);
    superVaultAggregator.changeGlobalLeavesStatus(leaves, statuses, strategy);
    address[] memory hookAddresses = new address[](2);
    hookAddresses[0] = hookAddress1;
    hookAddresses[1] = hookAddress2;
    bytes[] memory hooksArgs = new bytes[](2);
    hooksArgs[0] = hookArgs1;
    hooksArgs[1] = hookArgs2;
    bytes32[][] memory globalProofs = new bytes32[][](2);
    globalProofs[0] = new bytes32[](0);
    globalProofs[1] = new bytes32[](0);
    bytes32[][] memory strategyProofs = new bytes32[][](2);
    strategyProofs[0] = new bytes32[](0);
    strategyProofs[1] = new bytes32[](0);
    ISuperVaultAggregator.ValidateHookArgs[] memory argsArray = new ISuperVaultAggregator.ValidateHookArgs[](2);
    argsArray[0] = ISuperVaultAggregator.ValidateHookArgs({hookAddress: hookAddresses[0], hookArgs: hooksArgs[0], globalProof: globalProofs[0], strategyProof: strategyProofs[0]});
    argsArray[1] = ISuperVaultAggregator.ValidateHookArgs({hookAddress: hookAddresses[1], hookArgs: hooksArgs[1], globalProof: globalProofs[1], strategyProof: strategyProofs[1]});
    bool[] memory validHooks = superVaultAggregator.validateHooks(strategy, argsArray);
    assertFalse(validHooks[0], "First hook should be invalid (banned global leaf)");
    assertTrue(validHooks[1], "Second hook should be valid (strategy leaf not banned)");
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
- **SuperVaultAggregator::proposeStrategyHooksRoot(address,bytes32)**
- **SuperVaultAggregator::executeStrategyHooksRootUpdate(address)**
- **SuperVaultAggregator::changeGlobalLeavesStatus(bytes32[],bool[],address)**
- **SuperVaultAggregator::validateHooks(address,struct ISuperVaultAggregator.ValidateHookArgs[])**

## State Variable Reads

- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **manager** (`address`)
- **strategy** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_ValidateHooks_BannedGlobalLeaves() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 1)
  │   💬 Args: [validHooks[0], "First hook should be invalid (banned global leaf)"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 2)
      💬 Args: [validHooks[1], "Second hook should be valid (strategy leaf not banned)"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests batch hook validation with banned global leaves
