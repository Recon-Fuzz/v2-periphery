# Function: decreaseYield(uint256)

**Contract**: [test/recon/mocks/MockERC7540Tester.sol/contract_MockERC7540Tester.md]

## Metadata

- **Contract**: MockERC7540Tester
- **Signature**: `decreaseYield(uint256)`
- **Visibility**: external
- **Source Range**: 11932:206:641

## Implementation

```solidity
function decreaseYield(uint256 decreasePercentageFP4) external {
    uint256 amount = (totalAssets() * decreasePercentageFP4) / MAX_BPS;
    MockERC20(asset).transfer(address(0xbeef), amount);
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

- **MockERC20::transfer(address,uint256)**

## Native Transfers

- **unknown** (computed)

## State Variable Reads

- **MAX_BPS** (`uint256`)
- **asset** (`contract MockERC20`) [lib/setup-helpers/src/MockERC20.sol/contract_MockERC20.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockERC7540Tester.decreaseYield(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: ERC7575.totalAssets() (NodeID: 1)
      💬 Args: [no args]
      👁️  Def: public
```
