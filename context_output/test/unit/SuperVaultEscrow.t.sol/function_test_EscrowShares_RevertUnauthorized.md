# Function: test_EscrowShares_RevertUnauthorized()

**Contract**: [test/unit/SuperVaultEscrow.t.sol/contract_SuperVaultEscrowTest.md]

## Metadata

- **Contract**: SuperVaultEscrowTest
- **Signature**: `test_EscrowShares_RevertUnauthorized()`
- **Visibility**: public
- **Source Range**: 2662:315:662

## Implementation

```solidity
/// @notice Tests that escrowShares reverts when caller is not vault
function test_EscrowShares_RevertUnauthorized() public {
    escrow.initialize(vault);
    vm.prank(user);
    vm.expectRevert(ISuperVaultEscrow.UNAUTHORIZED.selector);
    escrow.escrowShares(user, 100);
}
```

## External Calls

- **SuperVaultEscrow::initialize(address)**
- **Vm::prank(address)**
- **Vm::expectRevert(bytes4)**
- **SuperVaultEscrow::escrowShares(address,uint256)**

## State Variable Reads

- **escrow** (`contract SuperVaultEscrow`) [src/SuperVault/SuperVaultEscrow.sol/contract_SuperVaultEscrow.md]
- **vault** (`address`)
- **user** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultEscrowTest.test_EscrowShares_RevertUnauthorized() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests that escrowShares reverts when caller is not vault
