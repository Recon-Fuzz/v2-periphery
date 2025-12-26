# Interface: IExtsload

## Metadata

- **Name**: IExtsload
- **Type**: Interface
- **Path**: lib/v2-core/lib/v4-core/src/interfaces/IExtsload.sol
- **Documentation**: @notice Interface for functions to access any storage slot in a contract

## Public/External Functions

### extsload(bytes32)

- **Signature**: `extsload(bytes32)`
- **Visibility**: external
- **Source Range**: 331:70:325

**Signature:**
```solidity
/// @notice Called by external contracts to access granular pool state
///  @param slot Key of slot to sload
///  @return value The value of the slot as bytes32
function extsload(bytes32 slot) external view returns (bytes32 value);;
```

### extsload(bytes32,uint256)

- **Signature**: `extsload(bytes32,uint256)`
- **Visibility**: external
- **Source Range**: 652:101:325

**Signature:**
```solidity
/// @notice Called by external contracts to access granular pool state
///  @param startSlot Key of slot to start sloading from
///  @param nSlots Number of slots to load into return value
///  @return values List of loaded values.
function extsload(bytes32 startSlot, uint256 nSlots) external view returns (bytes32[] memory values);;
```

### extsload(bytes32[])

- **Signature**: `extsload(bytes32[])`
- **Visibility**: external
- **Source Range**: 928:92:325

**Signature:**
```solidity
/// @notice Called by external contracts to access sparse pool state
///  @param slots List of slots to SLOAD from.
///  @return values List of loaded values.
function extsload(bytes32[] calldata slots) external view returns (bytes32[] memory values);;
```
