# Interface: IERC1404

## Metadata

- **Name**: IERC1404
- **Type**: Interface
- **Path**: test/mocks/centrifuge/ITranch.sol

## Public/External Functions

### detectTransferRestriction(address,address,uint256)

- **Signature**: `detectTransferRestriction(address,address,uint256)`
- **Visibility**: external
- **Source Range**: 566:106:621

**Signature:**
```solidity
/// @notice Detects if a transfer will be reverted and if so returns an appropriate reference code
///  @param from Sending address
///  @param to Receiving address
///  @param value Amount of tokens being transferred
///  @return Code by which to reference message for rejection reasoning
///  @dev Overwrite with your custom transfer restriction logic
function detectTransferRestriction(address from, address to, uint256 value) external view returns (uint8);;
```

### messageForTransferRestriction(uint8)

- **Signature**: `messageForTransferRestriction(uint8)`
- **Visibility**: external
- **Source Range**: 957:100:621

**Signature:**
```solidity
/// @notice Returns a human-readable message for a given restriction code
///  @param restrictionCode Identifier for looking up a message
///  @return Text showing the restriction's reasoning
///  @dev Overwrite with your custom message and restrictionCode handling
function messageForTransferRestriction(uint8 restrictionCode) external view returns (string memory);;
```
