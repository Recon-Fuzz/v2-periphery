# Function: decreaseYield(uint256)

**Contract**: [test/recon/mocks/MockERC5115Tester.sol/contract_MockERC5115Tester.md]

## Metadata

- **Contract**: MockERC5115Tester
- **Signature**: `decreaseYield(uint256)`
- **Visibility**: public
- **Source Range**: 6002:333:639

## Implementation

```solidity
function decreaseYield(uint256 decreasePercentageFP4) public {
    require(decreasePercentageFP4 <= 10_000, "Invalid percentage");
    uint256 amount = (yieldToken.balanceOf(address(this)) * decreasePercentageFP4) / 10_000;
    MockERC20(yieldToken).transfer(address(0xbeef), amount);
    totalLosses += amount;
}
```

## External Calls

- **MockERC20::balanceOf(address)**
- **MockERC20::transfer(address,uint256)**

## Native Transfers

- **unknown** (computed)

## State Variable Writes

- **totalLosses** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockERC5115Tester.decreaseYield(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
