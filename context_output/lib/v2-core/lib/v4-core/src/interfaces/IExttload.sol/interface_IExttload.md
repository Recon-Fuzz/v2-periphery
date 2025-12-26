# Interface: IExttload

## Metadata

- **Name**: IExttload
- **Type**: Interface
- **Path**: lib/v2-core/lib/v4-core/src/interfaces/IExttload.sol
- **Documentation**: @notice Interface for functions to access any transient storage slot in a contract

## Public/External Functions

### exttload(bytes32)

- **Signature**: `exttload(bytes32)`
- **Visibility**: external
- **Source Range**: 356:70:326

**Signature:**
```solidity
/// @notice Called by external contracts to access transient storage of the contract
///  @param slot Key of slot to tload
///  @return value The value of the slot as bytes32
function exttload(bytes32 slot) external view returns (bytes32 value);;
```

### exttload(bytes32[])

- **Signature**: `exttload(bytes32[])`
- **Visibility**: external
- **Source Range**: 604:92:326

**Signature:**
```solidity
/// @notice Called by external contracts to access sparse transient pool state
///  @param slots List of slots to tload
///  @return values List of loaded values
function exttload(bytes32[] calldata slots) external view returns (bytes32[] memory values);;
```
