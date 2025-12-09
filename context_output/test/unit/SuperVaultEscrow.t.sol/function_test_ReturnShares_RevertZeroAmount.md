# Function: test_ReturnShares_RevertZeroAmount()

**Contract**: [test/unit/SuperVaultEscrow.t.sol/contract_SuperVaultEscrowTest.md]

## Metadata

- **Contract**: SuperVaultEscrowTest
- **Signature**: `test_ReturnShares_RevertZeroAmount()`
- **Visibility**: public
- **Source Range**: 3991:289:662

## Implementation

```solidity
/// @notice Tests that returnShares reverts when amount is zero
function test_ReturnShares_RevertZeroAmount() public {
    escrow.initialize(vault);
    vm.prank(vault);
    vm.expectRevert(ISuperVaultEscrow.ZERO_AMOUNT.selector);
    escrow.returnShares(user, 0);
}
```

## External Calls

- **SuperVaultEscrow::initialize(address)**
- **Vm::prank(address)**
- **Vm::expectRevert(bytes4)**
- **SuperVaultEscrow::returnShares(address,uint256)**

## State Variable Reads

- **escrow** (`contract SuperVaultEscrow`) [src/SuperVault/SuperVaultEscrow.sol/contract_SuperVaultEscrow.md]
- **vault** (`address`)
- **user** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultEscrowTest.test_ReturnShares_RevertZeroAmount() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests that returnShares reverts when amount is zero
