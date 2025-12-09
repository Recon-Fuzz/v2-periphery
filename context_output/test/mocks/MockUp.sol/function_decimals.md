# Function: decimals()

**Contract**: [test/mocks/MockUp.sol/contract_MockUp.md]

## Metadata

- **Contract**: MockUp
- **Signature**: `decimals()`
- **Visibility**: public
- **Source Range**: 2688:82:267
- **Inherited From**: ERC20

## Implementation

```solidity
///  @dev Returns the number of decimals used to get its user representation.
///  For example, if `decimals` equals `2`, a balance of `505` tokens should
///  be displayed to a user as `5.05` (`505 / 10 ** 2`).
///  Tokens usually opt for a value of 18, imitating the relationship between
///  Ether and Wei. This is the default value returned by this function, unless
///  it's overridden.
///  NOTE: This information is only used for _display_ purposes: it in
///  no way affects any of the arithmetic of the contract, including
///  {IERC20-balanceOf} and {IERC20-transfer}.
function decimals() virtual public view returns (uint8) {
    return 18;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC20.decimals() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

 @dev Returns the number of decimals used to get its user representation.
 For example, if `decimals` equals `2`, a balance of `505` tokens should
 be displayed to a user as `5.05` (`505 / 10 ** 2`).
 Tokens usually opt for a value of 18, imitating the relationship between
 Ether and Wei. This is the default value returned by this function, unless
 it's overridden.
 NOTE: This information is only used for _display_ purposes: it in
 no way affects any of the arithmetic of the contract, including
 {IERC20-balanceOf} and {IERC20-transfer}.

### Interface Documentation

 @dev Returns the decimals places of the token.
