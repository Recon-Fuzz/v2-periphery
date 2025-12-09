# Function: test_ValidatorManagement_PublicKeysStorage()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_ValidatorManagement_PublicKeysStorage()`
- **Visibility**: public
- **Source Range**: 61955:793:659

## Implementation

```solidity
/// @notice Tests public keys storage and retrieval
function test_ValidatorManagement_PublicKeysStorage() public {
    address[] memory validators = new address[](2);
    validators[0] = validator1;
    validators[1] = validator2;
    bytes[] memory validatorPublicKeys = new bytes[](2);
    validatorPublicKeys[0] = hex"abcdef";
    validatorPublicKeys[1] = hex"123456";
    vm.prank(governor);
    superGovernor.setValidatorConfig(1, validators, validatorPublicKeys, 2, "");
    (, , bytes[] memory storedKeys, ) = superGovernor.getValidatorConfig();
    assertEq(storedKeys.length, 2, "Should have 2 public keys");
    assertEq(storedKeys[0], validatorPublicKeys[0], "First public key should match");
    assertEq(storedKeys[1], validatorPublicKeys[1], "Second public key should match");
}
```

## Related Implementations

### assertEq(uint256,uint256,string)

- **Kind**: internal
- **Source**: 2823:177:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256,string)`

```solidity
function assertEq(uint256 left, uint256 right, string memory err) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right, err);
    }
}
```

### assertEq(bytes,bytes,string)

- **Kind**: internal
- **Source**: 5456:144:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(bytes,bytes,string)`

```solidity
function assertEq(bytes memory left, bytes memory right, string memory err) virtual internal pure {
    vm.assertEq(left, right, err);
}
```

## External Calls

- **Vm::prank(address)**
- **SuperGovernor::setValidatorConfig(uint256,address[],bytes[],uint256,bytes)**
- **SuperGovernor::getValidatorConfig()**

## State Variable Reads

- **validator1** (`address`)
- **validator2** (`address`)
- **governor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_ValidatorManagement_PublicKeysStorage() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [storedKeys.length, 2, "Should have 2 public keys"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(bytes,bytes,string) (NodeID: 2)
  │   💬 Args: [storedKeys[0], validatorPublicKeys[0], "First public key should match"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(bytes,bytes,string) (NodeID: 3)
      💬 Args: [storedKeys[1], validatorPublicKeys[1], "Second public key should match"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests public keys storage and retrieval
