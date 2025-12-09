# Function: test_UpdatePPSAfterSkim_RevertZeroPPS()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_UpdatePPSAfterSkim_RevertZeroPPS()`
- **Visibility**: public
- **Source Range**: 21965:558:661

## Implementation

```solidity
/// @notice Tests that updatePPSAfterSkim reverts when newPPS is zero
function test_UpdatePPSAfterSkim_RevertZeroPPS() public {
    uint256 currentPPS = superVaultAggregator.getPPS(strategy);
    assertTrue(currentPPS > 0, "Initial PPS should be positive");
    vm.prank(strategy);
    vm.expectRevert(ISuperVaultAggregator.INVALID_ASSET.selector);
    superVaultAggregator.updatePPSAfterSkim(0, 100e18);
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

- **SuperVaultAggregator::getPPS(address)**
- **Vm::prank(address)**
- **Vm::expectRevert(bytes4)**
- **SuperVaultAggregator::updatePPSAfterSkim(uint256,uint256)**

## State Variable Reads

- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_UpdatePPSAfterSkim_RevertZeroPPS() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 1)
      💬 Args: [currentPPS > 0, "Initial PPS should be positive"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests that updatePPSAfterSkim reverts when newPPS is zero
