# Function: getLoanTokenBalance(address,bytes)

**Contract**: [lib/v2-core/src/hooks/loan/morpho/MorphoRepayAndWithdrawHook.sol/contract_MorphoRepayAndWithdrawHook.md]

## Metadata

- **Contract**: MorphoRepayAndWithdrawHook
- **Signature**: `getLoanTokenBalance(address,bytes)`
- **Visibility**: public
- **Source Range**: 2238:212:375
- **Inherited From**: BaseLoanHook

## Implementation

```solidity
/// @inheritdoc ISuperHookLoans
function getLoanTokenBalance(address account, bytes memory data) public view returns (uint256) {
    address loanToken = BytesLib.toAddress(data, 0);
    return IERC20(loanToken).balanceOf(account);
}
```

## Related Implementations

### toAddress(bytes,uint256)

- **Kind**: internal
- **Source**: 12130:354:441
- **Link**: `lib/v2-core/src/vendor/BytesLib.sol:BytesLib:toAddress(bytes,uint256)`

```solidity
function toAddress(bytes memory _bytes, uint256 _start) internal pure returns (address) {
    require(_bytes.length >= (_start + 20), "toAddress_outOfBounds");
    address tempAddress;
    assembly {
        tempAddress := div(mload(add(add(_bytes, 0x20), _start)), 0x1000000000000000000000000)
    }
    return tempAddress;
}
```

## External Calls

- **IERC20::balanceOf(address)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BaseLoanHook.getLoanTokenBalance(address,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 1)
      💬 Args: [data, 0]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc ISuperHookLoans

### Interface Documentation

@notice Gets the current loan token balance for an account
 @dev Used to track outstanding loan amounts
 @param account The account to check the loan balance for
 @param data The hook-specific data containing loan parameters
 @return The amount of tokens currently borrowed
