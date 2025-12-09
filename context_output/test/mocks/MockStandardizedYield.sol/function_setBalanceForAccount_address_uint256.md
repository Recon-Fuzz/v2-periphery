# Function: setBalanceForAccount(address,uint256)

**Contract**: [test/mocks/MockStandardizedYield.sol/contract_MockStandardizedYield.md]

## Metadata

- **Contract**: MockStandardizedYield
- **Signature**: `setBalanceForAccount(address,uint256)`
- **Visibility**: external
- **Source Range**: 2175:138:603

## Implementation

```solidity
function setBalanceForAccount(address acc, uint256 amount) external {
    balanceOf[acc] = amount;
    totalSupply = amount;
}
```

## State Variable Writes

- **balanceOf** (`mapping(address => uint256)`)
- **totalSupply** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockStandardizedYield.setBalanceForAccount(address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
