# Function: test_GetOracleAddress_RevertsOnAverageProvider()

**Contract**: [test/oracles/SuperOracle.t.sol/contract_SuperOracleTest.md]

## Metadata

- **Contract**: SuperOracleTest
- **Signature**: `test_GetOracleAddress_RevertsOnAverageProvider()`
- **Visibility**: public
- **Source Range**: 70121:303:624

## Implementation

```solidity
/// @notice Tests getOracleAddress with AVERAGE_PROVIDER (should revert as it's not a real provider)
///  @dev AVERAGE_PROVIDER is a special constant for averaging, not an actual provider
function test_GetOracleAddress_RevertsOnAverageProvider() public {
    vm.expectRevert(ISuperOracle.INVALID_ORACLE_PROVIDER.selector);
    superOracle.getOracleAddress(address(mockETH), address(mockUSD), AVERAGE_PROVIDER);
}
```

## External Calls

- **Vm::expectRevert(bytes4)**
- **SuperOracle::getOracleAddress(address,address,bytes32)**

## State Variable Reads

- **superOracle** (`contract SuperOracle`) [src/oracles/SuperOracle.sol/contract_SuperOracle.md]
- **mockETH** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **mockUSD** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **AVERAGE_PROVIDER** (`bytes32`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleTest.test_GetOracleAddress_RevertsOnAverageProvider() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests getOracleAddress with AVERAGE_PROVIDER (should revert as it's not a real provider)
 @dev AVERAGE_PROVIDER is a special constant for averaging, not an actual provider
