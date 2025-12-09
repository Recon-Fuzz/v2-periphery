# Function: test_IsGlobalHooksRootActive()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_IsGlobalHooksRootActive()`
- **Visibility**: public
- **Source Range**: 70155:1046:661

## Implementation

```solidity
/// @notice Tests isGlobalHooksRootActive returns correct status
function test_IsGlobalHooksRootActive() public {
    bool isActive = superVaultAggregator.isGlobalHooksRootActive();
    assertFalse(isActive, "Should be inactive when root is zero");
    bytes32 newRoot = keccak256("activeRoot");
    vm.prank(address(superGovernor));
    superVaultAggregator.proposeGlobalHooksRoot(newRoot);
    isActive = superVaultAggregator.isGlobalHooksRootActive();
    assertFalse(isActive, "Should be inactive before execution");
    uint256 timelock = superVaultAggregator.getHooksRootUpdateTimelock();
    vm.warp(block.timestamp + timelock);
    superVaultAggregator.executeGlobalHooksRootUpdate();
    isActive = superVaultAggregator.isGlobalHooksRootActive();
    assertTrue(isActive, "Should be active after execution with non-zero root");
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

- **SuperVaultAggregator::isGlobalHooksRootActive()**
- **Vm::prank(address)**
- **SuperVaultAggregator::proposeGlobalHooksRoot(bytes32)**
- **SuperVaultAggregator::getHooksRootUpdateTimelock()**
- **Vm::warp(uint256)**
- **SuperVaultAggregator::executeGlobalHooksRootUpdate()**

## State Variable Reads

- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_IsGlobalHooksRootActive() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 1)
  │   💬 Args: [isActive, "Should be inactive when root is zero"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 2)
  │   💬 Args: [isActive, "Should be inactive before execution"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 3)
      💬 Args: [isActive, "Should be active after execution with non-zero root"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests isGlobalHooksRootActive returns correct status
