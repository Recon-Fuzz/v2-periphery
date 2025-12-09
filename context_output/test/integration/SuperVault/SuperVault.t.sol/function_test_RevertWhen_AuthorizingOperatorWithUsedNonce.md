# Function: test_RevertWhen_AuthorizingOperatorWithUsedNonce()

**Contract**: [test/integration/SuperVault/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_RevertWhen_AuthorizingOperatorWithUsedNonce()`
- **Visibility**: public
- **Source Range**: 40705:1099:580

## Implementation

```solidity
function test_RevertWhen_AuthorizingOperatorWithUsedNonce() public {
    bool approved = true;
    bytes32 nonce = keccak256("test_nonce");
    uint256 deadline = block.timestamp + 1 hours;
    bytes32 domainSeparator = vault.DOMAIN_SEPARATOR();
    bytes32 digest = keccak256(abi.encodePacked("\u0019\u0001", domainSeparator, keccak256(abi.encode(vault.AUTHORIZE_OPERATOR_TYPEHASH(), userAddress, operator, approved, nonce, deadline))));
    vm.startPrank(userAddress);
    (uint8 v, bytes32 r, bytes32 s) = vm.sign(userPrivateKey, digest);
    bytes memory signature = abi.encodePacked(r, s, v);
    vault.authorizeOperator(userAddress, operator, approved, nonce, deadline, signature);
    vm.expectRevert(ISuperVault.UNAUTHORIZED.selector);
    vault.authorizeOperator(userAddress, operator, approved, nonce, deadline, signature);
    vm.stopPrank();
}
```

## External Calls

- **SuperVault::DOMAIN_SEPARATOR()**
- **SuperVault::AUTHORIZE_OPERATOR_TYPEHASH()**
- **Vm::startPrank(address)**
- **Vm::sign(uint256,bytes32)**
- **SuperVault::authorizeOperator(address,address,bool,bytes32,uint256,bytes)**
- **Vm::expectRevert(bytes4)**
- **Vm::stopPrank()**

## State Variable Reads

- **userAddress** (`address`)
- **operator** (`address`)
- **userPrivateKey** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_RevertWhen_AuthorizingOperatorWithUsedNonce() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
