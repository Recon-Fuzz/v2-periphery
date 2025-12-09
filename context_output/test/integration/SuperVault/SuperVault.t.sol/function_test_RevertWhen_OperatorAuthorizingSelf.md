# Function: test_RevertWhen_OperatorAuthorizingSelf()

**Contract**: [test/integration/SuperVault/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_RevertWhen_OperatorAuthorizingSelf()`
- **Visibility**: public
- **Source Range**: 42849:916:580

## Implementation

```solidity
function test_RevertWhen_OperatorAuthorizingSelf() public {
    bool approved = true;
    bytes32 nonce = keccak256("test_nonce");
    uint256 deadline = block.timestamp + 1 hours;
    bytes32 digest = keccak256(abi.encodePacked("\u0019\u0001", vault.DOMAIN_SEPARATOR(), keccak256(abi.encode(vault.AUTHORIZE_OPERATOR_TYPEHASH(), operator, operator, approved, nonce, deadline))));
    (uint8 v, bytes32 r, bytes32 s) = vm.sign(userPrivateKey, digest);
    bytes memory signature = abi.encodePacked(r, s, v);
    vm.prank(operator);
    vm.expectRevert(ISuperVault.UNAUTHORIZED.selector);
    vault.authorizeOperator(operator, operator, approved, nonce, deadline, signature);
}
```

## External Calls

- **SuperVault::DOMAIN_SEPARATOR()**
- **SuperVault::AUTHORIZE_OPERATOR_TYPEHASH()**
- **Vm::sign(uint256,bytes32)**
- **Vm::prank(address)**
- **Vm::expectRevert(bytes4)**
- **SuperVault::authorizeOperator(address,address,bool,bytes32,uint256,bytes)**

## State Variable Reads

- **operator** (`address`)
- **userPrivateKey** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_RevertWhen_OperatorAuthorizingSelf() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
