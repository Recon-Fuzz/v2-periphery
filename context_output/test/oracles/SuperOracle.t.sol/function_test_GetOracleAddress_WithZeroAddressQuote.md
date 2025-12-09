# Function: test_GetOracleAddress_WithZeroAddressQuote()

**Contract**: [test/oracles/SuperOracle.t.sol/contract_SuperOracleTest.md]

## Metadata

- **Contract**: SuperOracleTest
- **Signature**: `test_GetOracleAddress_WithZeroAddressQuote()`
- **Visibility**: public
- **Source Range**: 75267:308:624

## Implementation

```solidity
/// @notice Tests getOracleAddress with zero address for quote token
///  @dev Verifies behavior with zero address quote
function test_GetOracleAddress_WithZeroAddressQuote() public {
    vm.expectRevert(ISuperOracle.NO_ORACLES_CONFIGURED.selector);
    superOracle.getOracleAddress(address(mockETH), address(0), PROVIDER_1);
}
```

## External Calls

- **Vm::expectRevert(bytes4)**
- **SuperOracle::getOracleAddress(address,address,bytes32)**

## State Variable Reads

- **superOracle** (`contract SuperOracle`) [src/oracles/SuperOracle.sol/contract_SuperOracle.md]
- **mockETH** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **PROVIDER_1** (`bytes32`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleTest.test_GetOracleAddress_WithZeroAddressQuote() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests getOracleAddress with zero address for quote token
 @dev Verifies behavior with zero address quote
