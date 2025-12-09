# Function: test_ValidatorManagement_OffchainConfigEmission()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_ValidatorManagement_OffchainConfigEmission()`
- **Visibility**: public
- **Source Range**: 62824:711:659

## Implementation

```solidity
/// @notice Tests offchain config parameter emission (not stored)
function test_ValidatorManagement_OffchainConfigEmission() public {
    address[] memory validators = new address[](1);
    validators[0] = validator1;
    bytes[] memory validatorPublicKeys = new bytes[](1);
    validatorPublicKeys[0] = "";
    bytes memory offchainConfig = hex"deadbeef";
    vm.prank(governor);
    vm.expectEmit(true, false, false, true);
    emit ISuperGovernor.ValidatorConfigSet(1, validators, validatorPublicKeys, 1, offchainConfig);
    superGovernor.setValidatorConfig(1, validators, validatorPublicKeys, 1, offchainConfig);
}
```

## External Calls

- **Vm::prank(address)**
- **Vm::expectEmit(bool,bool,bool,bool)**
- **SuperGovernor::setValidatorConfig(uint256,address[],bytes[],uint256,bytes)**

## State Variable Reads

- **validator1** (`address`)
- **governor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_ValidatorManagement_OffchainConfigEmission() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests offchain config parameter emission (not stored)
