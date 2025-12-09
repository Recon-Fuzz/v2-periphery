# Function: test_ValidateHook_OneRootVetoed()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_ValidateHook_OneRootVetoed()`
- **Visibility**: public
- **Source Range**: 151420:1372:661

## Implementation

```solidity
/// @notice Tests hook validation when one root is vetoed but the other is valid
function test_ValidateHook_OneRootVetoed() public {
    bytes memory hookArgs = abi.encode("test_hook_call", 131_415);
    address mockHookAddress = address(0x1234567890123456789012345678901234567890);
    bytes32 leaf = keccak256(bytes.concat(keccak256(abi.encode(mockHookAddress, hookArgs))));
    vm.prank(manager);
    superVaultAggregator.proposeStrategyHooksRoot(strategy, leaf);
    vm.warp((block.timestamp + 24 hours) + 1);
    superVaultAggregator.executeStrategyHooksRootUpdate(strategy);
    vm.prank(address(superGovernor));
    superVaultAggregator.setGlobalHooksRootVetoStatus(true);
    bytes32[] memory emptyGlobalProof = new bytes32[](0);
    bytes32[] memory emptyStrategyProof = new bytes32[](0);
    bool isValid = superVaultAggregator.validateHook(strategy, ISuperVaultAggregator.ValidateHookArgs({hookAddress: mockHookAddress, hookArgs: hookArgs, globalProof: emptyGlobalProof, strategyProof: emptyStrategyProof}));
    assertFalse(isValid, "Hook should be invalid when global root is vetoed");
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
- **SuperVaultAggregator::proposeStrategyHooksRoot(address,bytes32)**
- **Vm::warp(uint256)**
- **SuperVaultAggregator::executeStrategyHooksRootUpdate(address)**
- **SuperVaultAggregator::setGlobalHooksRootVetoStatus(bool)**
- **SuperVaultAggregator::validateHook(address,struct ISuperVaultAggregator.ValidateHookArgs)**

## State Variable Reads

- **manager** (`address`)
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_ValidateHook_OneRootVetoed() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 1)
      💬 Args: [isValid, "Hook should be invalid when global root is vetoed"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests hook validation when one root is vetoed but the other is valid
