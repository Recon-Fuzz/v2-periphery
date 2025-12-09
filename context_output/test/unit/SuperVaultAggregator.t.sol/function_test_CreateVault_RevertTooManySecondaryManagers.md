# Function: test_CreateVault_RevertTooManySecondaryManagers()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_CreateVault_RevertTooManySecondaryManagers()`
- **Visibility**: public
- **Source Range**: 20646:1065:661

## Implementation

```solidity
/// @notice Tests that createVault reverts when too many secondary managers are provided
function test_CreateVault_RevertTooManySecondaryManagers() public {
    address[] memory tooManyManagers = new address[](6);
    for (uint256 i = 0; i < 6; i++) {
        tooManyManagers[i] = _deployAccount(0x100 + i, string(abi.encodePacked("SecondaryManager", i)));
    }
    vm.prank(manager);
    vm.expectRevert(ISuperVaultAggregator.TOO_MANY_SECONDARY_MANAGERS.selector);
    superVaultAggregator.createVault(ISuperVaultAggregator.VaultCreationParams({asset: address(asset), name: "Test Vault", symbol: "TEST", mainManager: manager, secondaryManagers: tooManyManagers, minUpdateInterval: 5, maxStaleness: 300, feeConfig: ISuperVaultStrategy.FeeConfig({performanceFeeBps: 1000, managementFeeBps: 0, recipient: manager})}));
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

- **Vm::prank(address)**
- **Vm::expectRevert(bytes4)**
- **SuperVaultAggregator::createVault(struct ISuperVaultAggregator.VaultCreationParams)**

## State Variable Reads

- **manager** (`address`)
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **asset** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_CreateVault_RevertTooManySecondaryManagers() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 1)
      💬 Args: [0x100 + i, string(abi.encodePacked("SecondaryManager", i))]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests that createVault reverts when too many secondary managers are provided
