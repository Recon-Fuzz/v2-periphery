# Function: test_CircuitBreaker_DispersionDetection2()

**Contract**: [test/draft/test/integration/SuperAsset/SuperAsset.t.sol/contract_SuperAssetTest.md]

## Metadata

- **Contract**: SuperAssetTest
- **Signature**: `test_CircuitBreaker_DispersionDetection2()`
- **Visibility**: public
- **Source Range**: 65455:872:565

## Implementation

```solidity
function test_CircuitBreaker_DispersionDetection2() public {
    vm.startPrank(user);
    tokenIn.approve(address(superAsset), 100e18);
    (, int256 basePrice, , , ) = mockFeed1.latestRoundData();
    mockFeed2.setAnswer((basePrice * 120) / 100);
    mockFeed3.setAnswer((basePrice * 80) / 100);
    ISuperAsset.DepositArgs memory depositArgs = ISuperAsset.DepositArgs({receiver: user, tokenIn: address(tokenIn), amountTokenToDeposit: 100e18, minSharesOut: 0});
    vm.expectRevert(abi.encodeWithSelector(ISuperAsset.SUPPORTED_ASSET_PRICE_DISPERSION.selector, address(tokenIn)));
    superAsset.deposit(depositArgs);
    vm.stopPrank();
}
```

## External Calls

- **Vm::startPrank(address)**
- **Mock4626Vault::approve(address,uint256)**
- **MockAggregator::latestRoundData()**
- **MockAggregator::setAnswer(int256)**
- **Vm::expectRevert(bytes)**
- **SuperAsset::deposit(struct ISuperAsset.DepositArgs)**
- **Vm::stopPrank()**

## State Variable Reads

- **user** (`address`)
- **tokenIn** (`contract Mock4626Vault`) [test/mocks/Mock4626Vault.sol/contract_Mock4626Vault.md]
- **superAsset** (`contract SuperAsset`) [test/draft/src/SuperAsset/SuperAsset.sol/contract_SuperAsset.md]
- **mockFeed1** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **mockFeed2** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **mockFeed3** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperAssetTest.test_CircuitBreaker_DispersionDetection2() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
