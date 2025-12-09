# Function: test_GetOracleAddress_RevertsOnUnregisteredProvider()

**Contract**: [test/oracles/SuperOracle.t.sol/contract_SuperOracleTest.md]

## Metadata

- **Contract**: SuperOracleTest
- **Signature**: `test_GetOracleAddress_RevertsOnUnregisteredProvider()`
- **Visibility**: public
- **Source Range**: 67825:380:624

## Implementation

```solidity
/// @notice Tests getOracleAddress reverts when provider is not registered
///  @dev Covers SuperOracleBase.sol:187 - INVALID_ORACLE_PROVIDER for unregistered provider
function test_GetOracleAddress_RevertsOnUnregisteredProvider() public {
    bytes32 neverRegistered = keccak256("NEVER_REGISTERED_PROVIDER");
    vm.expectRevert(ISuperOracle.INVALID_ORACLE_PROVIDER.selector);
    superOracle.getOracleAddress(address(mockETH), address(mockUSD), neverRegistered);
}
```

## External Calls

- **Vm::expectRevert(bytes4)**
- **SuperOracle::getOracleAddress(address,address,bytes32)**

## State Variable Reads

- **superOracle** (`contract SuperOracle`) [src/oracles/SuperOracle.sol/contract_SuperOracle.md]
- **mockETH** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **mockUSD** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleTest.test_GetOracleAddress_RevertsOnUnregisteredProvider() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests getOracleAddress reverts when provider is not registered
 @dev Covers SuperOracleBase.sol:187 - INVALID_ORACLE_PROVIDER for unregistered provider
