# Interface: IAccountExecute

## Metadata

- **Name**: IAccountExecute
- **Type**: Interface
- **Path**: lib/v2-core/lib/modulekit/src/accounts/kernel/interfaces/IAccountExecute.sol

## Public/External Functions

### executeUserOp(struct PackedUserOperation,bytes32)

- **Signature**: `executeUserOp(struct PackedUserOperation,bytes32)`
- **Visibility**: external
- **Source Range**: 695:135:158

**Signature:**
```solidity
///  Account may implement this execute method.
///  passing this methodSig at the beginning of callData will cause the entryPoint to pass the
///  full UserOp (and hash)
///  to the account.
///  The account should skip the methodSig, and use the callData (and optionally, other UserOp
///  fields)
///  @param userOp              - The operation that was just validated.
///  @param userOpHash          - Hash of the user's request data.
function executeUserOp(PackedUserOperation calldata userOp, bytes32 userOpHash) external payable;;
```
