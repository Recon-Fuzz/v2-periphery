# Function: test_ValidateHooks_GlobalRootVetoed()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_ValidateHooks_GlobalRootVetoed()`
- **Visibility**: public
- **Source Range**: 64983:1569:661

## Implementation

```solidity
/// @notice Tests validateHooks returns all false when global hooks root is vetoed
function test_ValidateHooks_GlobalRootVetoed() public {
    vm.prank(address(superGovernor));
    superVaultAggregator.setGlobalHooksRootVetoStatus(true);
    ISuperVaultAggregator.ValidateHookArgs[] memory argsArray = new ISuperVaultAggregator.ValidateHookArgs[](3);
    argsArray[0] = ISuperVaultAggregator.ValidateHookArgs({hookAddress: address(0x1), hookArgs: bytes(""), globalProof: new bytes32[](0), strategyProof: new bytes32[](0)});
    argsArray[1] = ISuperVaultAggregator.ValidateHookArgs({hookAddress: address(0x2), hookArgs: bytes(""), globalProof: new bytes32[](0), strategyProof: new bytes32[](0)});
    argsArray[2] = ISuperVaultAggregator.ValidateHookArgs({hookAddress: address(0x3), hookArgs: bytes(""), globalProof: new bytes32[](0), strategyProof: new bytes32[](0)});
    bool[] memory results = superVaultAggregator.validateHooks(strategy, argsArray);
    assertEq(results.length, 3, "Should return 3 results");
    assertFalse(results[0], "First hook should be false when global root vetoed");
    assertFalse(results[1], "Second hook should be false when global root vetoed");
    assertFalse(results[2], "Third hook should be false when global root vetoed");
}
```

## Related Implementations

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
- **SuperVaultAggregator::setGlobalHooksRootVetoStatus(bool)**
- **SuperVaultAggregator::validateHooks(address,struct ISuperVaultAggregator.ValidateHookArgs[])**

## State Variable Reads

- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_ValidateHooks_GlobalRootVetoed() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [results.length, 3, "Should return 3 results"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 2)
  │   💬 Args: [results[0], "First hook should be false when global root vetoed"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 3)
  │   💬 Args: [results[1], "Second hook should be false when global root vetoed"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 4)
      💬 Args: [results[2], "Third hook should be false when global root vetoed"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests validateHooks returns all false when global hooks root is vetoed
