# Function: test_RevertWhen_AuthorizingOperatorWithInvalidSignature()

**Contract**: [test/integration/SuperVault/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_RevertWhen_AuthorizingOperatorWithInvalidSignature()`
- **Visibility**: public
- **Source Range**: 41810:1033:580

## Implementation

```solidity
function test_RevertWhen_AuthorizingOperatorWithInvalidSignature() public {
    bool approved = true;
    bytes32 nonce = keccak256("test_nonce");
    uint256 deadline = block.timestamp + 1 hours;
    bytes32 domainSeparator = vault.DOMAIN_SEPARATOR();
    bytes32 digest = keccak256(abi.encodePacked("\u0019\u0001", domainSeparator, keccak256(abi.encode(vault.AUTHORIZE_OPERATOR_TYPEHASH(), userAddress, operator, approved, nonce, deadline))));
    uint256 wrongPrivateKey = 0x789;
    (uint8 v, bytes32 r, bytes32 s) = vm.sign(wrongPrivateKey, digest);
    bytes memory signature = abi.encodePacked(r, s, v);
    vm.prank(operator);
    vm.expectRevert(ISuperVault.INVALID_SIGNATURE.selector);
    vault.authorizeOperator(userAddress, operator, approved, nonce, deadline, signature);
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

- **userAddress** (`address`)
- **operator** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_RevertWhen_AuthorizingOperatorWithInvalidSignature() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
