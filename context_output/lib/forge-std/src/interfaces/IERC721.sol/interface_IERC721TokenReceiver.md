# Interface: IERC721TokenReceiver

## Metadata

- **Name**: IERC721TokenReceiver
- **Type**: Interface
- **Path**: lib/forge-std/src/interfaces/IERC721.sol
- **Documentation**: @dev Note: the ERC-165 identifier for this interface is 0x150b7a02.

## Public/External Functions

### onERC721Received(address,address,uint256,bytes)

- **Signature**: `onERC721Received(address,address,uint256,bytes)`
- **Visibility**: external
- **Source Range**: 6671:142:30

**Signature:**
```solidity
/// @notice Handle the receipt of an NFT
///  @dev The ERC721 smart contract calls this function on the recipient
///  after a `transfer`. This function MAY throw to revert and reject the
///  transfer. Return of other than the magic value MUST result in the
///  transaction being reverted.
///  Note: the contract address is always the message sender.
///  @param _operator The address which called `safeTransferFrom` function
///  @param _from The address which previously owned the token
///  @param _tokenId The NFT identifier which is being transferred
///  @param _data Additional data with no specified format
///  @return `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`
///   unless throwing
function onERC721Received(address _operator, address _from, uint256 _tokenId, bytes calldata _data) external returns (bytes4);;
```
