# Function: increaseYield(uint256)

**Contract**: [test/recon/mocks/MockERC7540Tester.sol/contract_MockERC7540Tester.md]

## Metadata

- **Contract**: MockERC7540Tester
- **Signature**: `increaseYield(uint256)`
- **Visibility**: external
- **Source Range**: 11706:220:641

## Implementation

```solidity
function increaseYield(uint256 increasePercentageFP4) external {
    uint256 amount = (totalAssets() * increasePercentageFP4) / MAX_BPS;
    MockERC20(asset).transferFrom(msg.sender, address(this), amount);
}
```

## Related Implementations

### totalAssets()

- **Kind**: internal
- **Source**: 788:115:641
- **Link**: `test/recon/mocks/MockERC7540Tester.sol:ERC7575:totalAssets()`

```solidity
function totalAssets() virtual public view returns (uint256) {
    return asset.balanceOf(address(this));
}
```

## External Calls

- **MockERC20::transferFrom(address,address,uint256)**

## State Variable Reads

- **MAX_BPS** (`uint256`)
- **asset** (`contract MockERC20`) [lib/setup-helpers/src/MockERC20.sol/contract_MockERC20.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockERC7540Tester.increaseYield(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: ERC7575.totalAssets() (NodeID: 1)
      💬 Args: [no args]
      👁️  Def: public
```
