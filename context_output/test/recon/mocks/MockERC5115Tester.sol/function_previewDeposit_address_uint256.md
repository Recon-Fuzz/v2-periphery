# Function: previewDeposit(address,uint256)

**Contract**: [test/recon/mocks/MockERC5115Tester.sol/contract_MockERC5115Tester.md]

## Metadata

- **Contract**: MockERC5115Tester
- **Signature**: `previewDeposit(address,uint256)`
- **Visibility**: public
- **Source Range**: 1883:458:639
- **Inherited From**: ERC5115

## Implementation

```solidity
function previewDeposit(address tokenIn, uint256 amountTokenToDeposit) virtual public view returns (uint256 amountSharesOut) {
    require(tokenIn == address(yieldToken), "Invalid token");
    uint256 supply = totalSupply;
    if (supply == 0) {
        return amountTokenToDeposit;
    }
    return (amountTokenToDeposit * supply) / yieldToken.balanceOf(address(this));
}
```

## External Calls

- **MockERC20::balanceOf(address)**

## State Variable Reads

- **yieldToken** (`contract MockERC20`) [lib/setup-helpers/src/MockERC20.sol/contract_MockERC20.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC5115.previewDeposit(address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
