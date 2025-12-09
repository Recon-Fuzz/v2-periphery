# Function: test_ReturnShares_RevertUnauthorized()

**Contract**: [test/unit/SuperVaultEscrow.t.sol/contract_SuperVaultEscrowTest.md]

## Metadata

- **Contract**: SuperVaultEscrowTest
- **Signature**: `test_ReturnShares_RevertUnauthorized()`
- **Visibility**: public
- **Source Range**: 3602:315:662

## Implementation

```solidity
/// @notice Tests that returnShares reverts when caller is not vault
function test_ReturnShares_RevertUnauthorized() public {
    escrow.initialize(vault);
    vm.prank(user);
    vm.expectRevert(ISuperVaultEscrow.UNAUTHORIZED.selector);
    escrow.returnShares(user, 100);
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
┌─ [0] ⚙️ FUNCTION: SuperVaultEscrowTest.test_ReturnShares_RevertUnauthorized() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests that returnShares reverts when caller is not vault
