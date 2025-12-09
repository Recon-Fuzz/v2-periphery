# Function: setUp()

**Contract**: [test/unit/SuperVaultEscrow.t.sol/contract_SuperVaultEscrowTest.md]

## Metadata

- **Contract**: SuperVaultEscrowTest
- **Signature**: `setUp()`
- **Visibility**: public
- **Source Range**: 575:368:662

## Implementation

```solidity
/// @notice Sets up the test environment before each test case.
function setUp() public {
    vault = _deployAccount(0x1, "Vault");
    user = _deployAccount(0x2, "User");
    escrow = SuperVaultEscrow(payable(VmContractHelper704(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/SuperVault/SuperVaultEscrow.sol:SuperVaultEscrow"})));
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

## External Calls

- **VmContractHelper704::deployCode(string)**

## State Variable Writes

- **vault** (`address`)
- **user** (`address`)
- **escrow** (`contract SuperVaultEscrow`) [src/SuperVault/SuperVaultEscrow.sol/contract_SuperVaultEscrow.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultEscrowTest.setUp() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 1)
  │   💬 Args: [0x1, "Vault"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 2)
      💬 Args: [0x2, "User"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Sets up the test environment before each test case.
