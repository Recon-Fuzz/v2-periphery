# Interface: IERC721

## Metadata

- **Name**: IERC721
- **Type**: Interface
- **Path**: lib/forge-std/src/interfaces/IERC721.sol
- **Documentation**: @title ERC-721 Non-Fungible Token Standard
   @dev See https://eips.ethereum.org/EIPS/eip-721
   Note: the ERC-165 identifier for this interface is 0x80ac58cd.

## Implements Interfaces

- **IERC165** [lib/forge-std/src/interfaces/IERC165.sol/interface_IERC165.md]

## Events

### Transfer

```solidity
/// @dev This emits when ownership of any NFT changes by any mechanism.
///  This event emits when NFTs are created (`from` == 0) and destroyed
///  (`to` == 0). Exception: during contract creation, any number of NFTs
///  may be created and assigned without emitting Transfer. At the time of
///  any transfer, the approved address for that NFT (if any) is reset to none.
event Transfer(address indexed _from, address indexed _to, uint256 indexed _tokenId);
```

### Approval

```solidity
/// @dev This emits when the approved address for an NFT is changed or
///  reaffirmed. The zero address indicates there is no approved address.
///  When a Transfer event emits, this also indicates that the approved
///  address for that NFT (if any) is reset to none.
event Approval(address indexed _owner, address indexed _approved, uint256 indexed _tokenId);
```

### ApprovalForAll

```solidity
/// @dev This emits when an operator is enabled or disabled for an owner.
///  The operator can manage all NFTs of the owner.
event ApprovalForAll(address indexed _owner, address indexed _operator, bool _approved);
```

## Public/External Functions

### balanceOf(address)

- **Signature**: `balanceOf(address)`
- **Visibility**: external
- **Source Range**: 1710:67:30

**Signature:**
```solidity
/// @notice Count all NFTs assigned to an owner
///  @dev NFTs assigned to the zero address are considered invalid, and this
///  function throws for queries about the zero address.
///  @param _owner An address for whom to query the balance
///  @return The number of NFTs owned by `_owner`, possibly zero
function balanceOf(address _owner) external view returns (uint256);;
```

### ownerOf(uint256)

- **Signature**: `ownerOf(uint256)`
- **Visibility**: external
- **Source Range**: 2034:67:30

**Signature:**
```solidity
/// @notice Find the owner of an NFT
///  @dev NFTs assigned to zero address are considered invalid, and queries
///  about them do throw.
///  @param _tokenId The identifier for an NFT
///  @return The address of the owner of the NFT
function ownerOf(uint256 _tokenId) external view returns (address);;
```

### safeTransferFrom(address,address,uint256,bytes)

- **Signature**: `safeTransferFrom(address,address,uint256,bytes)`
- **Visibility**: external
- **Source Range**: 2946:110:30

**Signature:**
```solidity
/// @notice Transfers the ownership of an NFT from one address to another address
///  @dev Throws unless `msg.sender` is the current owner, an authorized
///  operator, or the approved address for this NFT. Throws if `_from` is
///  not the current owner. Throws if `_to` is the zero address. Throws if
///  `_tokenId` is not a valid NFT. When transfer is complete, this function
///  checks if `_to` is a smart contract (code size > 0). If so, it calls
///  `onERC721Received` on `_to` and throws if the return value is not
///  `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`.
///  @param _from The current owner of the NFT
///  @param _to The new owner
///  @param _tokenId The NFT to transfer
///  @param data Additional data with no specified format, sent in call to `_to`
function safeTransferFrom(address _from, address _to, uint256 _tokenId, bytes calldata data) external payable;;
```

### safeTransferFrom(address,address,uint256)

- **Signature**: `safeTransferFrom(address,address,uint256)`
- **Visibility**: external
- **Source Range**: 3414:89:30

**Signature:**
```solidity
/// @notice Transfers the ownership of an NFT from one address to another address
///  @dev This works identically to the other function with an extra data parameter,
///  except this function just sets data to "".
///  @param _from The current owner of the NFT
///  @param _to The new owner
///  @param _tokenId The NFT to transfer
function safeTransferFrom(address _from, address _to, uint256 _tokenId) external payable;;
```

### transferFrom(address,address,uint256)

- **Signature**: `transferFrom(address,address,uint256)`
- **Visibility**: external
- **Source Range**: 4084:85:30

**Signature:**
```solidity
/// @notice Transfer ownership of an NFT -- THE CALLER IS RESPONSIBLE
///  TO CONFIRM THAT `_to` IS CAPABLE OF RECEIVING NFTS OR ELSE
///  THEY MAY BE PERMANENTLY LOST
///  @dev Throws unless `msg.sender` is the current owner, an authorized
///  operator, or the approved address for this NFT. Throws if `_from` is
///  not the current owner. Throws if `_to` is the zero address. Throws if
///  `_tokenId` is not a valid NFT.
///  @param _from The current owner of the NFT
///  @param _to The new owner
///  @param _tokenId The NFT to transfer
function transferFrom(address _from, address _to, uint256 _tokenId) external payable;;
```

### approve(address,uint256)

- **Signature**: `approve(address,uint256)`
- **Visibility**: external
- **Source Range**: 4529:71:30

**Signature:**
```solidity
/// @notice Change or reaffirm the approved address for an NFT
///  @dev The zero address indicates there is no approved address.
///  Throws unless `msg.sender` is the current NFT owner, or an authorized
///  operator of the current owner.
///  @param _approved The new approved NFT controller
///  @param _tokenId The NFT to approve
function approve(address _approved, uint256 _tokenId) external payable;;
```

### setApprovalForAll(address,bool)

- **Signature**: `setApprovalForAll(address,bool)`
- **Visibility**: external
- **Source Range**: 4993:71:30

**Signature:**
```solidity
/// @notice Enable or disable approval for a third party ("operator") to manage
///  all of `msg.sender`'s assets
///  @dev Emits the ApprovalForAll event. The contract MUST allow
///  multiple operators per owner.
///  @param _operator Address to add to the set of authorized operators
///  @param _approved True if the operator is approved, false to revoke approval
function setApprovalForAll(address _operator, bool _approved) external;;
```

### getApproved(uint256)

- **Signature**: `getApproved(uint256)`
- **Visibility**: external
- **Source Range**: 5335:71:30

**Signature:**
```solidity
/// @notice Get the approved address for a single NFT
///  @dev Throws if `_tokenId` is not a valid NFT.
///  @param _tokenId The NFT to find the approved address for
///  @return The approved address for this NFT, or the zero address if there is none
function getApproved(uint256 _tokenId) external view returns (address);;
```

### isApprovedForAll(address,address)

- **Signature**: `isApprovedForAll(address,address)`
- **Visibility**: external
- **Source Range**: 5707:90:30

**Signature:**
```solidity
/// @notice Query if an address is an authorized operator for another address
///  @param _owner The address that owns the NFTs
///  @param _operator The address that acts on behalf of the owner
///  @return True if `_operator` is an approved operator for `_owner`, false otherwise
function isApprovedForAll(address _owner, address _operator) external view returns (bool);;
```

### supportsInterface(bytes4) (inherited from IERC165)

- **Signature**: `supportsInterface(bytes4)`
- **Visibility**: external
- **Source Range**: 458:76:28

**Signature:**
```solidity
/// @notice Query if a contract implements an interface
///  @param interfaceID The interface identifier, as specified in ERC-165
///  @dev Interface identification is specified in ERC-165. This function
///  uses less than 30,000 gas.
///  @return `true` if the contract implements `interfaceID` and
///  `interfaceID` is not 0xffffffff, `false` otherwise
function supportsInterface(bytes4 interfaceID) external view returns (bool);;
```
