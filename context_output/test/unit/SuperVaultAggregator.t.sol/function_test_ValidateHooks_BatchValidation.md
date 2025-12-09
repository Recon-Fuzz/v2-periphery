# Function: test_ValidateHooks_BatchValidation()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_ValidateHooks_BatchValidation()`
- **Visibility**: public
- **Source Range**: 152890:2804:661

## Implementation

```solidity
/// @notice Tests batch hook validation with mixed single-leaf and multi-leaf scenarios
function test_ValidateHooks_BatchValidation() public {
    address mockHookAddress1 = address(0x1234567890123456789012345678901234567890);
    address mockHookAddress2 = address(0x2345678901234567890123456789012345678901);
    bytes memory hookArgs1 = abi.encode("hook1", 1);
    bytes memory hookArgs2 = abi.encode("hook2", 2);
    bytes32 leaf1 = keccak256(bytes.concat(keccak256(abi.encode(mockHookAddress1, hookArgs1))));
    bytes32 leaf2 = keccak256(bytes.concat(keccak256(abi.encode(mockHookAddress2, hookArgs2))));
    vm.prank(address(superGovernor));
    superVaultAggregator.proposeGlobalHooksRoot(leaf1);
    vm.warp((block.timestamp + 24 hours) + 1);
    superVaultAggregator.executeGlobalHooksRootUpdate();
    vm.prank(manager);
    superVaultAggregator.proposeStrategyHooksRoot(strategy, leaf2);
    vm.warp((block.timestamp + 24 hours) + 1);
    superVaultAggregator.executeStrategyHooksRootUpdate(strategy);
    address[] memory hookAddresses = new address[](2);
    hookAddresses[0] = mockHookAddress1;
    hookAddresses[1] = mockHookAddress2;
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
    assertTrue(validHooks[0], "First hook should be valid against global root");
    assertTrue(validHooks[1], "Second hook should be valid against strategy root");
}
```

## Related Implementations

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
- **SuperVaultAggregator::executeGlobalHooksRootUpdate()**
- **SuperVaultAggregator::proposeStrategyHooksRoot(address,bytes32)**
- **SuperVaultAggregator::executeStrategyHooksRootUpdate(address)**
- **SuperVaultAggregator::validateHooks(address,struct ISuperVaultAggregator.ValidateHookArgs[])**

## State Variable Reads

- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **manager** (`address`)
- **strategy** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_ValidateHooks_BatchValidation() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 1)
  │   💬 Args: [validHooks[0], "First hook should be valid against global root"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 2)
      💬 Args: [validHooks[1], "Second hook should be valid against strategy root"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests batch hook validation with mixed single-leaf and multi-leaf scenarios
