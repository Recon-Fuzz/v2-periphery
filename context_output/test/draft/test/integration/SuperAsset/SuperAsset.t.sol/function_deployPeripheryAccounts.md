# Function: deployPeripheryAccounts()

**Contract**: [test/draft/test/integration/SuperAsset/SuperAsset.t.sol/contract_SuperAssetTest.md]

## Metadata

- **Contract**: SuperAssetTest
- **Signature**: `deployPeripheryAccounts()`
- **Visibility**: public
- **Source Range**: 374:286:667
- **Inherited From**: PeripheryHelpers

## Implementation

```solidity
function deployPeripheryAccounts() public {
    SV_MANAGER = _deployAccount(MANAGER_KEY, "SV_MANAGER");
    EMERGENCY_ADMIN = _deployAccount(EMERGENCY_ADMIN_KEY, "EMERGENCY_ADMIN");
    VALIDATOR = _deployAccount(VALIDATOR_KEY, "VALIDATOR");
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

## State Variable Writes

- **SV_MANAGER** (`address`)
- **EMERGENCY_ADMIN** (`address`)
- **VALIDATOR** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: PeripheryHelpers.deployPeripheryAccounts() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 1)
  │   💬 Args: [MANAGER_KEY, "SV_MANAGER"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 2)
  │   💬 Args: [EMERGENCY_ADMIN_KEY, "EMERGENCY_ADMIN"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 3)
      💬 Args: [VALIDATOR_KEY, "VALIDATOR"]
      👁️  Def: internal
```
