# Function: increaseYield(uint256)

**Contract**: [test/recon/mocks/MockERC5115Tester.sol/contract_MockERC5115Tester.md]

## Metadata

- **Contract**: MockERC5115Tester
- **Signature**: `increaseYield(uint256)`
- **Visibility**: public
- **Source Range**: 5680:316:639

## Implementation

```solidity
function increaseYield(uint256 increasePercentageFP4) public {
    require(increasePercentageFP4 <= 10_000, "Invalid percentage");
    uint256 amount = (yieldToken.balanceOf(address(this)) * increasePercentageFP4) / 10_000;
    MockERC20(yieldToken).transferFrom(msg.sender, address(this), amount);
}
```

## External Calls

- **MockERC20::balanceOf(address)**
- **MockERC20::transferFrom(address,address,uint256)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockERC5115Tester.increaseYield(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
