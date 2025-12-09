# Function: setUp()

**Contract**: [test/draft/test/unit/SuperRegistry.t.sol/contract_SuperRegistryTest.md]

## Metadata

- **Contract**: SuperRegistryTest
- **Signature**: `setUp()`
- **Visibility**: public
- **Source Range**: 833:530:568

## Implementation

```solidity
/// @notice Sets up the test environment before each test case.
function setUp() public {
    superRegistryAdmin = _deployAccount(0x1, "SuperRegistryAdmin");
    registryAdmin = _deployAccount(0x2, "RegistryAdmin");
    user = _deployAccount(0x4, "User");
    superRegistry = new SuperRegistry(superRegistryAdmin, registryAdmin, address(this));
    SUPER_REGISTRY_ADMIN_ROLE = superRegistry.SUPER_REGISTRY_ADMIN_ROLE();
    REGISTRY_ADMIN_ROLE = superRegistry.REGISTRY_ADMIN_ROLE();
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

- **SuperRegistry::SUPER_REGISTRY_ADMIN_ROLE()**
- **SuperRegistry::REGISTRY_ADMIN_ROLE()**

## State Variable Reads

- **superRegistryAdmin** (`address`)
- **registryAdmin** (`address`)

## State Variable Writes

- **superRegistryAdmin** (`address`)
- **registryAdmin** (`address`)
- **user** (`address`)
- **SUPER_REGISTRY_ADMIN_ROLE** (`bytes32`)
- **REGISTRY_ADMIN_ROLE** (`bytes32`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperRegistryTest.setUp() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 1)
  │   💬 Args: [0x1, "SuperRegistryAdmin"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 2)
  │   💬 Args: [0x2, "RegistryAdmin"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 3)
      💬 Args: [0x4, "User"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Sets up the test environment before each test case.
