# Function: test_GetOracleAddress_RevertsOnNoOracleConfiguredForPair()

**Contract**: [test/oracles/SuperOracle.t.sol/contract_SuperOracleTest.md]

## Metadata

- **Contract**: SuperOracleTest
- **Signature**: `test_GetOracleAddress_RevertsOnNoOracleConfiguredForPair()`
- **Visibility**: public
- **Source Range**: 68417:378:624

## Implementation

```solidity
/// @notice Tests getOracleAddress reverts when provider is set but oracle for base/quote is not configured
///  @dev Covers SuperOracleBase.sol:189 - NO_ORACLES_CONFIGURED when oracle == address(0)
function test_GetOracleAddress_RevertsOnNoOracleConfiguredForPair() public {
    vm.expectRevert(ISuperOracle.NO_ORACLES_CONFIGURED.selector);
    superOracle.getOracleAddress(address(mockBTC), address(mockUSD), PROVIDER_1);
}
```

## External Calls

- **Vm::expectRevert(bytes4)**
- **SuperOracle::getOracleAddress(address,address,bytes32)**

## State Variable Reads

- **superOracle** (`contract SuperOracle`) [src/oracles/SuperOracle.sol/contract_SuperOracle.md]
- **mockBTC** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **mockUSD** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **PROVIDER_1** (`bytes32`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleTest.test_GetOracleAddress_RevertsOnNoOracleConfiguredForPair() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests getOracleAddress reverts when provider is set but oracle for base/quote is not configured
 @dev Covers SuperOracleBase.sol:189 - NO_ORACLES_CONFIGURED when oracle == address(0)
