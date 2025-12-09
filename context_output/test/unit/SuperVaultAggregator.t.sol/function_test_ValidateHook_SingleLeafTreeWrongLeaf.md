# Function: test_ValidateHook_SingleLeafTreeWrongLeaf()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_ValidateHook_SingleLeafTreeWrongLeaf()`
- **Visibility**: public
- **Source Range**: 147935:1597:661

## Implementation

```solidity
/// @notice Tests hook validation fails when leaf doesn't match single-leaf tree root
function test_ValidateHook_SingleLeafTreeWrongLeaf() public {
    address mockHookAddress = address(0x1234567890123456789012345678901234567890);
    address differentHookAddress = address(0x2345678901234567890123456789012345678901);
    bytes memory hookArgs = abi.encode("test_hook_call", 789);
    bytes memory differentHookArgs = abi.encode("different_hook_call", 999);
    bytes32 correctLeaf = keccak256(bytes.concat(keccak256(abi.encode(differentHookAddress, differentHookArgs))));
    vm.prank(address(superGovernor));
    superVaultAggregator.proposeGlobalHooksRoot(correctLeaf);
    vm.warp((block.timestamp + 24 hours) + 1);
    superVaultAggregator.executeGlobalHooksRootUpdate();
    bytes32[] memory emptyGlobalProof = new bytes32[](0);
    bytes32[] memory emptyStrategyProof = new bytes32[](0);
    bool isValid = superVaultAggregator.validateHook(strategy, ISuperVaultAggregator.ValidateHookArgs({hookAddress: mockHookAddress, hookArgs: hookArgs, globalProof: emptyGlobalProof, strategyProof: emptyStrategyProof}));
    assertFalse(isValid, "Hook should be invalid when leaf doesn't match single-leaf tree root");
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
- **SuperVaultAggregator::validateHook(address,struct ISuperVaultAggregator.ValidateHookArgs)**

## State Variable Reads

- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_ValidateHook_SingleLeafTreeWrongLeaf() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 1)
      💬 Args: [isValid, "Hook should be invalid when leaf doesn't match single-leaf tree root"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests hook validation fails when leaf doesn't match single-leaf tree root
