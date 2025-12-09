# Function: test_BasicRedeemWithCircuitBreaker()

**Contract**: [test/draft/test/integration/SuperAsset/SuperAsset.t.sol/contract_SuperAssetTest.md]

## Metadata

- **Contract**: SuperAssetTest
- **Signature**: `test_BasicRedeemWithCircuitBreaker()`
- **Visibility**: public
- **Source Range**: 37816:1945:565

## Implementation

```solidity
function test_BasicRedeemWithCircuitBreaker() public {
    uint256 depositAmount = 100e18;
    underlyingToken1.mint(user, depositAmount);
    vm.startPrank(user);
    underlyingToken1.approve(address(superAsset), depositAmount);
    ISuperAsset.DepositArgs memory depositArgs = ISuperAsset.DepositArgs({receiver: user, tokenIn: address(underlyingToken1), amountTokenToDeposit: depositAmount, minSharesOut: 0});
    ISuperAsset.DepositReturnVars memory retDeposit = superAsset.deposit(depositArgs);
    uint256 sharesBalance = retDeposit.amountSharesMinted;
    assertGt(sharesBalance, 0, "User should have shares after deposit");
    (, int256 currentPrice, , , ) = mockFeed1.latestRoundData();
    mockFeed1.setAnswer((currentPrice * 95) / 100);
    _updateAllFeedTimestamps();
    ISuperAsset.RedeemArgs memory redeemArgs = ISuperAsset.RedeemArgs({receiver: user, amountSharesToRedeem: sharesBalance, tokenOut: address(underlyingToken1), minTokenOut: 0});
    ISuperAsset.RedeemReturnVars memory retRedeem = superAsset.redeem(redeemArgs);
    assertGt(retRedeem.amountTokenOutAfterFees, 0, "User should receive some tokens out");
    assertEq(superAsset.balanceOf(user), 0, "User should have no shares left after full redeem");
    vm.stopPrank();
}
```

## Related Implementations

### assertGt(uint256,uint256,string)

- **Kind**: internal
- **Source**: 14795:177:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertGt(uint256,uint256,string)`

```solidity
function assertGt(uint256 left, uint256 right, string memory err) virtual internal pure {
    if (left <= right) {
        vm.assertGt(left, right, err);
    }
}
```

### _updateAllFeedTimestamps()

- **Kind**: internal
- **Source**: 4273:618:565
- **Link**: `test/draft/test/integration/SuperAsset/SuperAsset.t.sol:SuperAssetTest:_updateAllFeedTimestamps()`

```solidity
function _updateAllFeedTimestamps() internal {
    mockFeedSuperAssetShares1.setUpdatedAt(block.timestamp);
    mockFeedPrimaryAsset.setUpdatedAt(block.timestamp);
    mockFeed1.setUpdatedAt(block.timestamp);
    mockFeed2.setUpdatedAt(block.timestamp);
    mockFeed3.setUpdatedAt(block.timestamp);
    mockFeed4.setUpdatedAt(block.timestamp);
    mockFeed5.setUpdatedAt(block.timestamp);
    mockFeed6.setUpdatedAt(block.timestamp);
    mockFeed7.setUpdatedAt(block.timestamp);
    mockFeed8.setUpdatedAt(block.timestamp);
    mockFeed9.setUpdatedAt(block.timestamp);
}
```

### assertEq(uint256,uint256,string)

- **Kind**: internal
- **Source**: 2823:177:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256,string)`

```solidity
function assertEq(uint256 left, uint256 right, string memory err) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right, err);
    }
}
```

## External Calls

- **MockERC20::mint(address,uint256)**
- **Vm::startPrank(address)**
- **MockERC20::approve(address,uint256)**
- **SuperAsset::deposit(struct ISuperAsset.DepositArgs)**
- **MockAggregator::latestRoundData()**
- **MockAggregator::setAnswer(int256)**
- **SuperAsset::redeem(struct ISuperAsset.RedeemArgs)**
- **SuperAsset::balanceOf(address)**
- **Vm::stopPrank()**

## State Variable Reads

- **underlyingToken1** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **user** (`address`)
- **superAsset** (`contract SuperAsset`) [test/draft/src/SuperAsset/SuperAsset.sol/contract_SuperAsset.md]
- **mockFeed1** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]
- **mockFeedSuperAssetShares1** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **mockFeedPrimaryAsset** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **mockFeed2** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **mockFeed3** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **mockFeed4** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **mockFeed5** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **mockFeed6** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **mockFeed7** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **mockFeed8** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **mockFeed9** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperAssetTest.test_BasicRedeemWithCircuitBreaker() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [sharesBalance, 0, "User should have shares after deposit"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: SuperAssetTest._updateAllFeedTimestamps() (NodeID: 2)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 3)
  │   💬 Args: [retRedeem.amountTokenOutAfterFees, 0, "User should receive some tokens out"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 4)
      💬 Args: [superAsset.balanceOf(user), 0, "User should have no shares left after full redeem"]
      👁️  Def: internal
```
