# Function: previewRedeem(address,uint256)

**Contract**: [test/recon/mocks/MockERC5115Tester.sol/contract_MockERC5115Tester.md]

## Metadata

- **Contract**: MockERC5115Tester
- **Signature**: `previewRedeem(address,uint256)`
- **Visibility**: public
- **Source Range**: 2347:458:639
- **Inherited From**: ERC5115

## Implementation

```solidity
function previewRedeem(address tokenOut, uint256 amountSharesToRedeem) virtual public view returns (uint256 amountTokenOut) {
    require(tokenOut == address(yieldToken), "Invalid token");
    uint256 supply = totalSupply;
    if (supply == 0) {
        return amountSharesToRedeem;
    }
    return (amountSharesToRedeem * yieldToken.balanceOf(address(this))) / supply;
}
```

## External Calls

- **MockERC20::balanceOf(address)**

## State Variable Reads

- **yieldToken** (`contract MockERC20`) [lib/setup-helpers/src/MockERC20.sol/contract_MockERC20.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC5115.previewRedeem(address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
