# Function: test_GetOracleAddress_WithZeroAddressBase()

**Contract**: [test/oracles/SuperOracle.t.sol/contract_SuperOracleTest.md]

## Metadata

- **Contract**: SuperOracleTest
- **Signature**: `test_GetOracleAddress_WithZeroAddressBase()`
- **Visibility**: public
- **Source Range**: 74666:467:624

## Implementation

```solidity
/// @notice Tests getOracleAddress with zero address for base token
///  @dev Verifies behavior with zero address (should reach provider check first)
function test_GetOracleAddress_WithZeroAddressBase() public {
    vm.expectRevert(ISuperOracle.NO_ORACLES_CONFIGURED.selector);
    superOracle.getOracleAddress(address(0), address(mockUSD), PROVIDER_1);
}
```

## External Calls

- **Vm::expectRevert(bytes4)**
- **SuperOracle::getOracleAddress(address,address,bytes32)**

## State Variable Reads

- **superOracle** (`contract SuperOracle`) [src/oracles/SuperOracle.sol/contract_SuperOracle.md]
- **mockUSD** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **PROVIDER_1** (`bytes32`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleTest.test_GetOracleAddress_WithZeroAddressBase() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests getOracleAddress with zero address for base token
 @dev Verifies behavior with zero address (should reach provider check first)
