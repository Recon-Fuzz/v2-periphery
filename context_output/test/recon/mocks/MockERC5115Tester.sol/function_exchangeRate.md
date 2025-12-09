# Function: exchangeRate()

**Contract**: [test/recon/mocks/MockERC5115Tester.sol/contract_MockERC5115Tester.md]

## Metadata

- **Contract**: MockERC5115Tester
- **Signature**: `exchangeRate()`
- **Visibility**: public
- **Source Range**: 1444:215:639
- **Inherited From**: ERC5115

## Implementation

```solidity
function exchangeRate() virtual public view returns (uint256) {
    uint256 supply = totalSupply;
    if (supply == 0) return 1e18;
    return (yieldToken.balanceOf(address(this)) * 1e18) / supply;
}
```

## External Calls

- **MockERC20::balanceOf(address)**

## State Variable Reads

- **yieldToken** (`contract MockERC20`) [lib/setup-helpers/src/MockERC20.sol/contract_MockERC20.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC5115.exchangeRate() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
