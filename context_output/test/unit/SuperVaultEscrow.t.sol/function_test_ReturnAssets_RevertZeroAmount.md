# Function: test_ReturnAssets_RevertZeroAmount()

**Contract**: [test/unit/SuperVaultEscrow.t.sol/contract_SuperVaultEscrowTest.md]

## Metadata

- **Contract**: SuperVaultEscrowTest
- **Signature**: `test_ReturnAssets_RevertZeroAmount()`
- **Visibility**: public
- **Source Range**: 4931:289:662

## Implementation

```solidity
/// @notice Tests that returnAssets reverts when amount is zero
function test_ReturnAssets_RevertZeroAmount() public {
    escrow.initialize(vault);
    vm.prank(vault);
    vm.expectRevert(ISuperVaultEscrow.ZERO_AMOUNT.selector);
    escrow.returnAssets(user, 0);
}
```

## External Calls

- **SuperVaultEscrow::initialize(address)**
- **Vm::prank(address)**
- **Vm::expectRevert(bytes4)**
- **SuperVaultEscrow::returnAssets(address,uint256)**

## State Variable Reads

- **escrow** (`contract SuperVaultEscrow`) [src/SuperVault/SuperVaultEscrow.sol/contract_SuperVaultEscrow.md]
- **vault** (`address`)
- **user** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultEscrowTest.test_ReturnAssets_RevertZeroAmount() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests that returnAssets reverts when amount is zero
