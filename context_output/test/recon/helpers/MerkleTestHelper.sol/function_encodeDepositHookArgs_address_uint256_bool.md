# Function: encodeDepositHookArgs(address,uint256,bool)

**Contract**: [test/recon/helpers/MerkleTestHelper.sol/contract_MerkleTestHelper.md]

## Metadata

- **Contract**: MerkleTestHelper
- **Signature**: `encodeDepositHookArgs(address,uint256,bool)`
- **Visibility**: public
- **Source Range**: 3409:370:633

## Implementation

```solidity
/// @notice Generate encoded hook arguments for Deposit4626VaultHook
///  @param yieldSource Address of the yield source vault
///  @param amount Amount to deposit
///  @param usePrevHookAmount Whether to use previous hook amount
///  @return Encoded hook arguments
function encodeDepositHookArgs(address yieldSource, uint256 amount, bool usePrevHookAmount) public pure returns (bytes memory) {
    return abi.encodePacked(bytes32(0), yieldSource, amount, usePrevHookAmount);
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MerkleTestHelper.encodeDepositHookArgs(address,uint256,bool) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Generate encoded hook arguments for Deposit4626VaultHook
 @param yieldSource Address of the yield source vault
 @param amount Amount to deposit
 @param usePrevHookAmount Whether to use previous hook amount
 @return Encoded hook arguments
