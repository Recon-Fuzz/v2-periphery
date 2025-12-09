# Interface: IBeacon

## Metadata

- **Name**: IBeacon
- **Type**: Interface
- **Path**: lib/v2-core/lib/openzeppelin-contracts/contracts/proxy/beacon/IBeacon.sol
- **Documentation**:  @dev This is the interface that {BeaconProxy} expects of its beacon.

## Public/External Functions

### implementation()

- **Signature**: `implementation()`
- **Visibility**: external
- **Source Range**: 412:58:266

**Signature:**
```solidity
///  @dev Must return an address that can be used as a delegate call target.
///  {UpgradeableBeacon} will check that this address is a contract.
function implementation() external view returns (address);;
```
