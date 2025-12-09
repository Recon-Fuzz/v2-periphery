# Function: test_MaxMint_AddressParameterIgnored()

**Contract**: [test/unit/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_MaxMint_AddressParameterIgnored()`
- **Visibility**: public
- **Source Range**: 16843:792:660

## Implementation

```solidity
/// @notice Tests maxMint with different addresses returns same value
function test_MaxMint_AddressParameterIgnored() public {
    address testUser1 = _deployAccount(0xABC, "TestUser1");
    address testUser2 = _deployAccount(0xDEF, "TestUser2");
    address testUser3 = address(0);
    uint256 maxMint1 = vault.maxMint(testUser1);
    uint256 maxMint2 = vault.maxMint(testUser2);
    uint256 maxMint3 = vault.maxMint(testUser3);
    assertEq(maxMint1, type(uint256).max, "TestUser1 should get max value");
    assertEq(maxMint1, maxMint2, "Address parameter should be ignored - same result for different addresses");
    assertEq(maxMint1, maxMint3, "Address parameter should be ignored - even zero address returns same result");
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

## External Calls

- **SuperVault::maxMint(address)**

## State Variable Reads

- **vault** (`contract SuperVault`) [src/SuperVault/SuperVault.sol/contract_SuperVault.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_MaxMint_AddressParameterIgnored() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 1)
  │   💬 Args: [0xABC, "TestUser1"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 2)
  │   💬 Args: [0xDEF, "TestUser2"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 3)
  │   💬 Args: [maxMint1, type(uint256).max, "TestUser1 should get max value"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 4)
  │   💬 Args: [maxMint1, maxMint2, "Address parameter should be ignored - same result for different addresses"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 5)
      💬 Args: [maxMint1, maxMint3, "Address parameter should be ignored - even zero address returns same result"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests maxMint with different addresses returns same value
