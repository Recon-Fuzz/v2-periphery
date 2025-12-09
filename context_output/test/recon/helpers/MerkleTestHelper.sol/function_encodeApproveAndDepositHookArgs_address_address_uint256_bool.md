# Function: encodeApproveAndDepositHookArgs(address,address,uint256,bool)

**Contract**: [test/recon/helpers/MerkleTestHelper.sol/contract_MerkleTestHelper.md]

## Metadata

- **Contract**: MerkleTestHelper
- **Signature**: `encodeApproveAndDepositHookArgs(address,address,uint256,bool)`
- **Visibility**: public
- **Source Range**: 4927:458:633

## Implementation

```solidity
/// @notice Generate encoded hook arguments for ApproveAndDeposit4626VaultHook
///  @param yieldSource Address of the yield source vault
///  @param token Address of the token to approve and deposit
///  @param amount Amount to deposit
///  @param usePrevHookAmount Whether to use previous hook amount
///  @return Encoded hook arguments
function encodeApproveAndDepositHookArgs(address yieldSource, address token, uint256 amount, bool usePrevHookAmount) public pure returns (bytes memory) {
    return abi.encodePacked(bytes32(0), yieldSource, token, amount, usePrevHookAmount);
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MerkleTestHelper.encodeApproveAndDepositHookArgs(address,address,uint256,bool) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Generate encoded hook arguments for ApproveAndDeposit4626VaultHook
 @param yieldSource Address of the yield source vault
 @param token Address of the token to approve and deposit
 @param amount Amount to deposit
 @param usePrevHookAmount Whether to use previous hook amount
 @return Encoded hook arguments
