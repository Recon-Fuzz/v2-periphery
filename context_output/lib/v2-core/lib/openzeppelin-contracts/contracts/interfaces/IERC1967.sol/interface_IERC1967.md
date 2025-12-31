# Interface: IERC1967

## Metadata

- **Name**: IERC1967
- **Type**: Interface
- **Path**: lib/v2-core/lib/openzeppelin-contracts/contracts/interfaces/IERC1967.sol
- **Documentation**:  @dev ERC-1967: Proxy Storage Slots. This interface contains the events defined in the ERC.

## Events

### Upgraded

```solidity
///  @dev Emitted when the implementation is upgraded.
event Upgraded(address indexed implementation);
```

### AdminChanged

```solidity
///  @dev Emitted when the admin account has changed.
event AdminChanged(address previousAdmin, address newAdmin);
```

### BeaconUpgraded

```solidity
///  @dev Emitted when the beacon is changed.
event BeaconUpgraded(address indexed beacon);
```
