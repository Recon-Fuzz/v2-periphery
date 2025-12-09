# Function: deployAccounts()

**Contract**: [test/integration/SuperVault/BaseSuperVaultTest.t.sol/contract_BaseSuperVaultTest.md]

## Metadata

- **Contract**: BaseSuperVaultTest
- **Signature**: `deployAccounts()`
- **Visibility**: public
- **Source Range**: 649:378:500
- **Inherited From**: Helpers

## Implementation

```solidity
function deployAccounts() public {
    TREASURY = _deployAccount(TREASURY_KEY, "TREASURY");
    SUPER_BUNDLER = _deployAccount(SUPER_BUNDLER_KEY, "SUPER_BUNDLER");
    ACROSS_RELAYER = _deployAccount(ACROSS_RELAYER_KEY, "ACROSS_RELAYER");
    vm.label(ACROSS_RELAYER, "ACROSS_RELAYER");
    vm.makePersistent(ACROSS_RELAYER);
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

- **Vm::label(address,string)**
- **Vm::makePersistent(address)**

## State Variable Reads

- **ACROSS_RELAYER** (`address`)

## State Variable Writes

- **TREASURY** (`address`)
- **SUPER_BUNDLER** (`address`)
- **ACROSS_RELAYER** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Helpers.deployAccounts() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 1)
  │   💬 Args: [TREASURY_KEY, "TREASURY"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 2)
  │   💬 Args: [SUPER_BUNDLER_KEY, "SUPER_BUNDLER"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 3)
      💬 Args: [ACROSS_RELAYER_KEY, "ACROSS_RELAYER"]
      👁️  Def: internal
```
