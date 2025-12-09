# Function: test_GetCurrentNonce()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_GetCurrentNonce()`
- **Visibility**: public
- **Source Range**: 54974:1127:661

## Implementation

```solidity
/// @notice Tests that getCurrentNonce returns the correct vault creation nonce
function test_GetCurrentNonce() public {
    uint256 initialNonce = superVaultAggregator.getCurrentNonce();
    assertEq(initialNonce, 1, "Initial nonce should be 1 after one vault creation");
    vm.prank(manager);
    superVaultAggregator.createVault(ISuperVaultAggregator.VaultCreationParams({asset: address(asset), name: "Test Vault 2", symbol: "TV2", mainManager: manager, secondaryManagers: new address[](0), minUpdateInterval: 5, maxStaleness: 300, feeConfig: ISuperVaultStrategy.FeeConfig({performanceFeeBps: 1000, managementFeeBps: 0, recipient: manager})}));
    uint256 newNonce = superVaultAggregator.getCurrentNonce();
    assertEq(newNonce, 2, "Nonce should increment to 2 after second vault creation");
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

- **SuperVaultAggregator::getCurrentNonce()**
- **Vm::prank(address)**
- **SuperVaultAggregator::createVault(struct ISuperVaultAggregator.VaultCreationParams)**

## State Variable Reads

- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **manager** (`address`)
- **asset** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_GetCurrentNonce() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [initialNonce, 1, "Initial nonce should be 1 after one vault creation"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
      💬 Args: [newNonce, 2, "Nonce should increment to 2 after second vault creation"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests that getCurrentNonce returns the correct vault creation nonce
