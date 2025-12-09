# Function: test_GetQuoteFromProvider_RevertsOnNoOracleConfiguredForPair()

**Contract**: [test/oracles/SuperOracle.t.sol/contract_SuperOracleTest.md]

## Metadata

- **Contract**: SuperOracleTest
- **Signature**: `test_GetQuoteFromProvider_RevertsOnNoOracleConfiguredForPair()`
- **Visibility**: public
- **Source Range**: 9309:558:624

## Implementation

```solidity
/// @notice Tests getQuoteFromProvider reverts when provider is registered but has no oracle for the requested pair
///  @dev Covers SuperOracleBase.sol:287 - if (_oracle == address(0)) revert NO_ORACLES_CONFIGURED()
function test_GetQuoteFromProvider_RevertsOnNoOracleConfiguredForPair() public {
    uint256 baseAmount = 1e8;
    vm.expectRevert(ISuperOracle.NO_ORACLES_CONFIGURED.selector);
    superOracle.getQuoteFromProvider(baseAmount, address(mockBTC), address(mockUSD), PROVIDER_1);
}
```

## External Calls

- **Vm::expectRevert(bytes4)**
- **SuperOracle::getQuoteFromProvider(uint256,address,address,bytes32)**

## State Variable Reads

- **superOracle** (`contract SuperOracle`) [src/oracles/SuperOracle.sol/contract_SuperOracle.md]
- **mockBTC** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **mockUSD** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **PROVIDER_1** (`bytes32`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleTest.test_GetQuoteFromProvider_RevertsOnNoOracleConfiguredForPair() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests getQuoteFromProvider reverts when provider is registered but has no oracle for the requested pair
 @dev Covers SuperOracleBase.sol:287 - if (_oracle == address(0)) revert NO_ORACLES_CONFIGURED()
