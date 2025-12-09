# Function: allowance(address,address)

**Contract**: [lib/v2-core/lib/modulekit/src/mocks/MockERC20.sol/contract_MockERC20.md]

## Metadata

- **Contract**: MockERC20
- **Signature**: `allowance(address,address)`
- **Visibility**: external
- **Source Range**: 1568:142:196

## Implementation

```solidity
function allowance(address owner, address spender) override external view returns (uint256) {
    return _allowance[owner][spender];
}
```

## State Variable Reads

- **_allowance** (`mapping(address => mapping(address => uint256))`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockERC20.allowance(address,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Returns the remaining number of tokens that `spender` is allowed
 to spend on behalf of `owner`
