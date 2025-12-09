# Function: test_SkimFeeFlow_ZeroTotalSupply_HandledCorrectly()

**Contract**: [test/integration/SuperVault/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_SkimFeeFlow_ZeroTotalSupply_HandledCorrectly()`
- **Visibility**: public
- **Source Range**: 464641:575:580

## Implementation

```solidity
/// @notice Test 3.3: Zero total supply edge case
function test_SkimFeeFlow_ZeroTotalSupply_HandledCorrectly() public {
    assertEq(vault.totalSupply(), 0, "Should start with zero supply");
    uint256 hwmPpsBefore = strategy.vaultHwmPps();
    vm.startPrank(MANAGER);
    strategy.skimPerformanceFee();
    vm.stopPrank();
    assertEq(strategy.vaultHwmPps(), hwmPpsBefore, "HWM PPS should remain unchanged");
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

## External Calls

- **SuperVault::totalSupply()**
- **SuperVaultStrategy::vaultHwmPps()**
- **Vm::startPrank(address)**
- **SuperVaultStrategy::skimPerformanceFee()**
- **Vm::stopPrank()**

## State Variable Reads

- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_SkimFeeFlow_ZeroTotalSupply_HandledCorrectly() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [vault.totalSupply(), 0, "Should start with zero supply"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
      💬 Args: [strategy.vaultHwmPps(), hwmPpsBefore, "HWM PPS should remain unchanged"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Test 3.3: Zero total supply edge case
