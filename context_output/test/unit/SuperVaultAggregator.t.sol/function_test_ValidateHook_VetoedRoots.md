# Function: test_ValidateHook_VetoedRoots()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_ValidateHook_VetoedRoots()`
- **Visibility**: public
- **Source Range**: 149594:1735:661

## Implementation

```solidity
/// @notice Tests hook validation with vetoed roots
function test_ValidateHook_VetoedRoots() public {
    bytes memory hookArgs = abi.encode("test_hook_call", 101_112);
    address mockHookAddress = address(0x1234567890123456789012345678901234567890);
    bytes32 leaf = keccak256(bytes.concat(keccak256(abi.encode(mockHookAddress, hookArgs))));
    vm.prank(address(superGovernor));
    superVaultAggregator.proposeGlobalHooksRoot(leaf);
    vm.warp((block.timestamp + 24 hours) + 1);
    superVaultAggregator.executeGlobalHooksRootUpdate();
    vm.prank(manager);
    superVaultAggregator.proposeStrategyHooksRoot(strategy, leaf);
    vm.warp((block.timestamp + 24 hours) + 1);
    superVaultAggregator.executeStrategyHooksRootUpdate(strategy);
    vm.prank(address(superGovernor));
    superVaultAggregator.setGlobalHooksRootVetoStatus(true);
    vm.prank(address(superGovernor));
    superVaultAggregator.setStrategyHooksRootVetoStatus(strategy, true);
    bytes32[] memory emptyGlobalProof = new bytes32[](0);
    bytes32[] memory emptyStrategyProof = new bytes32[](0);
    bool isValid = superVaultAggregator.validateHook(strategy, ISuperVaultAggregator.ValidateHookArgs({hookAddress: mockHookAddress, hookArgs: hookArgs, globalProof: emptyGlobalProof, strategyProof: emptyStrategyProof}));
    assertFalse(isValid, "Hook should be invalid when both roots are vetoed");
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

## External Calls

- **Vm::prank(address)**
- **SuperVaultAggregator::proposeGlobalHooksRoot(bytes32)**
- **Vm::warp(uint256)**
- **SuperVaultAggregator::executeGlobalHooksRootUpdate()**
- **SuperVaultAggregator::proposeStrategyHooksRoot(address,bytes32)**
- **SuperVaultAggregator::executeStrategyHooksRootUpdate(address)**
- **SuperVaultAggregator::setGlobalHooksRootVetoStatus(bool)**
- **SuperVaultAggregator::setStrategyHooksRootVetoStatus(address,bool)**
- **SuperVaultAggregator::validateHook(address,struct ISuperVaultAggregator.ValidateHookArgs)**

## State Variable Reads

- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **manager** (`address`)
- **strategy** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_ValidateHook_VetoedRoots() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 1)
      💬 Args: [isValid, "Hook should be invalid when both roots are vetoed"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests hook validation with vetoed roots
