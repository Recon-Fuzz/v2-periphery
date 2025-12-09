# Function: test_InvalidateNonce()

**Contract**: [test/integration/SuperVault/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_InvalidateNonce()`
- **Visibility**: public
- **Source Range**: 44922:1143:580

## Implementation

```solidity
function test_InvalidateNonce() public {
    bytes32 nonce = keccak256("test_nonce");
    vm.prank(userAddress);
    vault.invalidateNonce(nonce);
    vm.prank(userAddress);
    vm.expectRevert(ISuperVault.INVALID_NONCE.selector);
    vault.invalidateNonce(nonce);
    bool approved = true;
    uint256 deadline = block.timestamp + 1 hours;
    bytes32 domainSeparator = vault.DOMAIN_SEPARATOR();
    bytes32 digest = keccak256(abi.encodePacked("\u0019\u0001", domainSeparator, keccak256(abi.encode(vault.AUTHORIZE_OPERATOR_TYPEHASH(), userAddress, operator, approved, nonce, deadline))));
    (uint8 v, bytes32 r, bytes32 s) = vm.sign(userPrivateKey, digest);
    bytes memory signature = abi.encodePacked(r, s, v);
    vm.prank(operator);
    vm.expectRevert(ISuperVault.UNAUTHORIZED.selector);
    vault.authorizeOperator(userAddress, operator, approved, nonce, deadline, signature);
}
```

## External Calls

- **Vm::prank(address)**
- **SuperVault::invalidateNonce(bytes32)**
- **Vm::expectRevert(bytes4)**
- **SuperVault::DOMAIN_SEPARATOR()**
- **SuperVault::AUTHORIZE_OPERATOR_TYPEHASH()**
- **Vm::sign(uint256,bytes32)**
- **SuperVault::authorizeOperator(address,address,bool,bytes32,uint256,bytes)**

## State Variable Reads

- **userAddress** (`address`)
- **operator** (`address`)
- **userPrivateKey** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_InvalidateNonce() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
