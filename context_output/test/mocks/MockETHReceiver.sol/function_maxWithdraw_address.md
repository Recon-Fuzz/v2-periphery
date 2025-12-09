# Function: maxWithdraw(address)

**Contract**: [test/mocks/MockETHReceiver.sol/contract_MockETHReceiver.md]

## Metadata

- **Contract**: MockETHReceiver
- **Signature**: `maxWithdraw(address)`
- **Visibility**: external
- **Source Range**: 2185:117:590

## Implementation

```solidity
function maxWithdraw(address owner) override external view returns (uint256) {
    return balanceOf(owner);
}
```

## Related Implementations

### balanceOf(address)

- **Kind**: internal
- **Source**: 2933:116:48
- **Link**: `lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol:ERC20:balanceOf(address)`

```solidity
/// @inheritdoc IERC20
function balanceOf(address account) virtual public view returns (uint256) {
    return _balances[account];
}
```

## State Variable Reads

- **_balances** (`mapping(address => uint256)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockETHReceiver.maxWithdraw(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: ERC20.balanceOf(address) (NodeID: 1)
      💬 Args: [owner]
      👁️  Def: public
```

## Documentation

### Interface Documentation

 @dev Returns the maximum amount of the underlying asset that can be withdrawn from the owner balance in the
 Vault, through a withdraw call.
 - MUST return a limited value if owner is subject to some withdrawal limit or timelock.
 - MUST NOT revert.
