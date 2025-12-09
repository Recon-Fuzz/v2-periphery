# Function: test_GasInfo_SetGasInfo_RevertsOnZeroOracle()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_GasInfo_SetGasInfo_RevertsOnZeroOracle()`
- **Visibility**: public
- **Source Range**: 73267:275:659

## Implementation

```solidity
/// @notice Tests reverting when setting gas info with zero address oracle
///  @dev Covers SuperGovernor.sol:523 - if (oracle == address(0)) revert INVALID_ADDRESS()
function test_GasInfo_SetGasInfo_RevertsOnZeroOracle() public {
    uint256 gasIncreasePerBatch = 1000;
    vm.prank(governor);
    vm.expectRevert(ISuperGovernor.INVALID_ADDRESS.selector);
    superGovernor.setGasInfo(address(0), gasIncreasePerBatch);
}
```

## External Calls

- **Vm::prank(address)**
- **Vm::expectRevert(bytes4)**
- **SuperGovernor::setGasInfo(address,uint256)**

## State Variable Reads

- **governor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_GasInfo_SetGasInfo_RevertsOnZeroOracle() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests reverting when setting gas info with zero address oracle
 @dev Covers SuperGovernor.sol:523 - if (oracle == address(0)) revert INVALID_ADDRESS()
