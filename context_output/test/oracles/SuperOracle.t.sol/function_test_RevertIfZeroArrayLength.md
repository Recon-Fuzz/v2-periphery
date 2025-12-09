# Function: test_RevertIfZeroArrayLength()

**Contract**: [test/oracles/SuperOracle.t.sol/contract_SuperOracleTest.md]

## Metadata

- **Contract**: SuperOracleTest
- **Signature**: `test_RevertIfZeroArrayLength()`
- **Visibility**: public
- **Source Range**: 37946:603:624

## Implementation

```solidity
function test_RevertIfZeroArrayLength() public {
    bytes32[] memory emptyArray = new bytes32[](0);
    vm.expectRevert(ISuperOracle.ZERO_ARRAY_LENGTH.selector);
    superOracle.queueProviderRemoval(emptyArray);
    address[] memory emptyAddresses = new address[](0);
    uint256[] memory emptyValues = new uint256[](0);
    vm.expectRevert(ISuperOracle.ZERO_ARRAY_LENGTH.selector);
    superOracle.setFeedMaxStalenessBatch(emptyAddresses, emptyValues);
}
```

## External Calls

- **Vm::expectRevert(bytes4)**
- **SuperOracle::queueProviderRemoval(bytes32[])**
- **SuperOracle::setFeedMaxStalenessBatch(address[],uint256[])**

## State Variable Reads

- **superOracle** (`contract SuperOracle`) [src/oracles/SuperOracle.sol/contract_SuperOracle.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleTest.test_RevertIfZeroArrayLength() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
