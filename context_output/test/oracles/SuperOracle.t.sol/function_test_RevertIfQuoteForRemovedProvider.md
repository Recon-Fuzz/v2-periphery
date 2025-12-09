# Function: test_RevertIfQuoteForRemovedProvider()

**Contract**: [test/oracles/SuperOracle.t.sol/contract_SuperOracleTest.md]

## Metadata

- **Contract**: SuperOracleTest
- **Signature**: `test_RevertIfQuoteForRemovedProvider()`
- **Visibility**: public
- **Source Range**: 44467:973:624

## Implementation

```solidity
function test_RevertIfQuoteForRemovedProvider() public {
    bytes32[] memory providersToRemove = new bytes32[](1);
    providersToRemove[0] = PROVIDER_1;
    superOracle.queueProviderRemoval(providersToRemove);
    vm.warp((block.timestamp + 1 hours) + 1 seconds);
    superOracle.executeProviderRemoval();
    vm.expectRevert(ISuperOracle.INVALID_ORACLE_PROVIDER.selector);
    superOracle.getOracleAddress(address(mockETH), address(mockUSD), PROVIDER_1);
    vm.expectRevert(ISuperOracle.ORACLE_UNTRUSTED_DATA.selector);
    superOracle.getQuoteFromProvider(1e18, address(mockETH), address(mockUSD), PROVIDER_1);
}
```

## External Calls

- **SuperOracle::queueProviderRemoval(bytes32[])**
- **Vm::warp(uint256)**
- **SuperOracle::executeProviderRemoval()**
- **Vm::expectRevert(bytes4)**
- **SuperOracle::getOracleAddress(address,address,bytes32)**
- **SuperOracle::getQuoteFromProvider(uint256,address,address,bytes32)**

## State Variable Reads

- **PROVIDER_1** (`bytes32`)
- **superOracle** (`contract SuperOracle`) [src/oracles/SuperOracle.sol/contract_SuperOracle.md]
- **mockETH** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **mockUSD** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleTest.test_RevertIfQuoteForRemovedProvider() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
