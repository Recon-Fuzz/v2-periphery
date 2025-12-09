# Function: test_RevertIfNoOraclesConfigured()

**Contract**: [test/oracles/SuperOracle.t.sol/contract_SuperOracleTest.md]

## Metadata

- **Contract**: SuperOracleTest
- **Signature**: `test_RevertIfNoOraclesConfigured()`
- **Visibility**: public
- **Source Range**: 21631:363:624

## Implementation

```solidity
function test_RevertIfNoOraclesConfigured() public {
    vm.expectRevert(ISuperOracle.INVALID_ORACLE_PROVIDER.selector);
    superOracle.getOracleAddress(address(mockBTC), address(mockUSD), NEW_PROVIDER);
}
```

## External Calls

- **Vm::expectRevert(bytes4)**
- **SuperOracle::getOracleAddress(address,address,bytes32)**

## State Variable Reads

- **superOracle** (`contract SuperOracle`) [src/oracles/SuperOracle.sol/contract_SuperOracle.md]
- **mockBTC** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **mockUSD** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **NEW_PROVIDER** (`bytes32`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleTest.test_RevertIfNoOraclesConfigured() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
