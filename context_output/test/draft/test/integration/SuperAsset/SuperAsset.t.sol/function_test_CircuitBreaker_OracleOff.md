# Function: test_CircuitBreaker_OracleOff()

**Contract**: [test/draft/test/integration/SuperAsset/SuperAsset.t.sol/contract_SuperAssetTest.md]

## Metadata

- **Contract**: SuperAssetTest
- **Signature**: `test_CircuitBreaker_OracleOff()`
- **Visibility**: public
- **Source Range**: 57723:735:565

## Implementation

```solidity
function test_CircuitBreaker_OracleOff() public {
    vm.startPrank(user);
    tokenIn.approve(address(superAsset), 100e18);
    mockFeed1.setAnswer(0);
    mockFeed2.setAnswer(0);
    mockFeed3.setAnswer(0);
    ISuperAsset.DepositArgs memory depositArgs = ISuperAsset.DepositArgs({receiver: user, tokenIn: address(tokenIn), amountTokenToDeposit: 100e18, minSharesOut: 0});
    vm.expectRevert(ISuperOracle.NO_VALID_REPORTED_PRICES.selector);
    superAsset.deposit(depositArgs);
    vm.stopPrank();
}
```

## External Calls

- **Vm::startPrank(address)**
- **Mock4626Vault::approve(address,uint256)**
- **MockAggregator::setAnswer(int256)**
- **Vm::expectRevert(bytes4)**
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
┌─ [0] ⚙️ FUNCTION: SuperAssetTest.test_CircuitBreaker_OracleOff() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
