# Function: test_AuthorizeOperator_ReturnsTrue()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_AuthorizeOperator_ReturnsTrue()`
- **Visibility**: public
- **Source Range**: 238744:1731:661

## Implementation

```solidity
/// @notice Tests that authorizeOperator returns true and correctly authorizes an operator
function test_AuthorizeOperator_ReturnsTrue() public {
    (address vaultAddress, , ) = ISuperVaultStrategy(strategy).getVaultInfo();
    SuperVault vault = SuperVault(vaultAddress);
    uint256 controllerPrivateKey = 0x12345;
    address controller = vm.addr(controllerPrivateKey);
    address operator_ = _deployAccount(0xB, "Operator");
    bool approved = true;
    bytes32 nonce = keccak256("test_nonce_authorize_operator");
    uint256 deadline = block.timestamp + 1 hours;
    bytes32 structHash = keccak256(abi.encode(vault.AUTHORIZE_OPERATOR_TYPEHASH(), controller, operator_, approved, nonce, deadline));
    bytes32 digest = keccak256(abi.encodePacked("\u0019\u0001", vault.DOMAIN_SEPARATOR(), structHash));
    (uint8 v, bytes32 r, bytes32 s) = vm.sign(controllerPrivateKey, digest);
    bytes memory signature = abi.encodePacked(r, s, v);
    vm.prank(operator_);
    bool result = vault.authorizeOperator(controller, operator_, approved, nonce, deadline, signature);
    assertTrue(result, "authorizeOperator should return true");
    assertTrue(vault.isOperator(controller, operator_), "Operator should be authorized");
    assertTrue(vault.authorizations(controller, nonce), "Nonce should be marked as used");
}
```

## Related Implementations

### _deployAccount(uint256,string)

- **Kind**: internal
- **Source**: 3858:217:500
- **Link**: `lib/v2-core/test/utils/Helpers.sol:Helpers:_deployAccount(uint256,string)`

```solidity
function _deployAccount(uint256 key_, string memory name_) internal returns (address) {
    address _user = vm.addr(key_);
    vm.deal(_user, LARGE);
    vm.label(_user, name_);
    return _user;
}
```

### assertTrue(bool,string)

- **Kind**: internal
- **Source**: 1894:148:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertTrue(bool,string)`

```solidity
function assertTrue(bool data, string memory err) virtual internal pure {
    if (!data) {
        vm.assertTrue(data, err);
    }
}
```

## External Calls

- **ISuperVaultStrategy::getVaultInfo()**
- **Vm::addr(uint256)**
- **SuperVault::AUTHORIZE_OPERATOR_TYPEHASH()**
- **SuperVault::DOMAIN_SEPARATOR()**
- **Vm::sign(uint256,bytes32)**
- **Vm::prank(address)**
- **SuperVault::authorizeOperator(address,address,bool,bytes32,uint256,bytes)**
- **SuperVault::isOperator(address,address)**
- **SuperVault::authorizations(address,bytes32)**

## State Variable Reads

- **strategy** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_AuthorizeOperator_ReturnsTrue() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 1)
  │   💬 Args: [0xB, "Operator"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 2)
  │   💬 Args: [result, "authorizeOperator should return true"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 3)
  │   💬 Args: [vault.isOperator(controller, operator_), "Operator should be authorized"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 4)
      💬 Args: [vault.authorizations(controller, nonce), "Nonce should be marked as used"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests that authorizeOperator returns true and correctly authorizes an operator
