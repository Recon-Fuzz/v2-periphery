# Interface: IHook

## Metadata

- **Name**: IHook
- **Type**: Interface
- **Path**: test/mocks/centrifuge/IHook.sol

## Implements Interfaces

- **IERC165** [lib/v2-core/lib/openzeppelin-contracts/contracts/utils/introspection/IERC165.sol/interface_IERC165.md]

## Public/External Functions

### onERC20Transfer(address,address,uint256,struct HookData)

- **Signature**: `onERC20Transfer(address,address,uint256,struct HookData)`
- **Visibility**: external
- **Source Range**: 599:174:613

**Signature:**
```solidity
/// @notice Callback on standard ERC20 transfer.
///  @dev    MUST return bytes4(keccak256("onERC20Transfer(address,address,uint256,(bytes16,bytes16))"))
///          if successful
function onERC20Transfer(address from, address to, uint256 value, HookData calldata hookdata) external returns (bytes4);;
```

### onERC20AuthTransfer(address,address,address,uint256,struct HookData)

- **Signature**: `onERC20AuthTransfer(address,address,address,uint256,struct HookData)`
- **Visibility**: external
- **Source Range**: 984:202:613

**Signature:**
```solidity
/// @notice Callback on authorized ERC20 transfer.
///  @dev    MUST return bytes4(keccak256("onERC20AuthTransfer(address,address,address,uint256,(bytes16,bytes16))"))
///          if successful
function onERC20AuthTransfer(address sender, address from, address to, uint256 value, HookData calldata hookdata) external returns (bytes4);;
```

### checkERC20Transfer(address,address,uint256,struct HookData)

- **Signature**: `checkERC20Transfer(address,address,uint256,struct HookData)`
- **Visibility**: external
- **Source Range**: 1249:188:613

**Signature:**
```solidity
/// @notice Check if given transfer can be performed
function checkERC20Transfer(address from, address to, uint256 value, HookData calldata hookData) external view returns (bool);;
```

### updateRestriction(address,bytes)

- **Signature**: `updateRestriction(address,bytes)`
- **Visibility**: external
- **Source Range**: 1591:72:613

**Signature:**
```solidity
/// @notice Update a set of restriction for a token
///  @dev    MAY be user specific, which would be included in the encoded `update` value
function updateRestriction(address token, bytes memory update) external;;
```

### supportsInterface(bytes4) (inherited from IERC165)

- **Signature**: `supportsInterface(bytes4)`
- **Visibility**: external
- **Source Range**: 792:76:293

**Signature:**
```solidity
///  @dev Returns true if this contract implements the interface defined by
///  `interfaceId`. See the corresponding
///  https://eips.ethereum.org/EIPS/eip-165#how-interfaces-are-identified[ERC section]
///  to learn more about how these ids are created.
///  This function call must use less than 30 000 gas.
function supportsInterface(bytes4 interfaceId) external view returns (bool);;
```
