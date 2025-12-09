# Function: encodeRedeemHookArgs(address,address,uint256,bool)

**Contract**: [test/recon/helpers/MerkleTestHelper.sol/contract_MerkleTestHelper.md]

## Metadata

- **Contract**: MerkleTestHelper
- **Signature**: `encodeRedeemHookArgs(address,address,uint256,bool)`
- **Visibility**: public
- **Source Range**: 4117:447:633

## Implementation

```solidity
/// @notice Generate encoded hook arguments for Redeem4626VaultHook
///  @param yieldSource Address of the yield source vault
///  @param owner Address of the owner
///  @param shares Number of shares to redeem
///  @param usePrevHookAmount Whether to use previous hook amount
///  @return Encoded hook arguments
function encodeRedeemHookArgs(address yieldSource, address owner, uint256 shares, bool usePrevHookAmount) public pure returns (bytes memory) {
    return abi.encodePacked(bytes32(0), yieldSource, owner, shares, usePrevHookAmount);
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MerkleTestHelper.encodeRedeemHookArgs(address,address,uint256,bool) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Generate encoded hook arguments for Redeem4626VaultHook
 @param yieldSource Address of the yield source vault
 @param owner Address of the owner
 @param shares Number of shares to redeem
 @param usePrevHookAmount Whether to use previous hook amount
 @return Encoded hook arguments
