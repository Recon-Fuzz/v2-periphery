# Contract: MockERC721

## Metadata

- **Name**: MockERC721
- **Type**: Contract
- **Path**: lib/v2-core/lib/modulekit/src/mocks/MockERC721.sol
- **Documentation**: @notice This is a mock contract of the ERC721 standard for testing purposes only, it SHOULD NOT
   be used in production.
   @dev Forked from:
   https://github.com/transmissions11/solmate/blob/0384dbaaa4fcb5715738a9254a7c0a4cb62cf458/src/tokens/ERC721.sol

## Implements Interfaces

- **IERC721Metadata** [lib/forge-std/src/interfaces/IERC721.sol/interface_IERC721Metadata.md]
- **IERC721** [lib/forge-std/src/interfaces/IERC721.sol/interface_IERC721.md]
- **IERC165** [lib/forge-std/src/interfaces/IERC165.sol/interface_IERC165.md]

## State Variables

### _name

```solidity
string internal _name
```

### _symbol

```solidity
string internal _symbol
```

### _ownerOf

```solidity
mapping(uint256 => address) internal _ownerOf
```

### _balanceOf

```solidity
mapping(address => uint256) internal _balanceOf
```

### _getApproved

```solidity
mapping(uint256 => address) internal _getApproved
```

### _isApprovedForAll

```solidity
mapping(address => mapping(address => bool)) internal _isApprovedForAll
```

### initialized

```solidity
/// @dev A bool to track whether the contract has been initialized.
bool private initialized
```

## Events

### Transfer (inherited from IERC721)

```solidity
/// @dev This emits when ownership of any NFT changes by any mechanism.
///  This event emits when NFTs are created (`from` == 0) and destroyed
///  (`to` == 0). Exception: during contract creation, any number of NFTs
///  may be created and assigned without emitting Transfer. At the time of
///  any transfer, the approved address for that NFT (if any) is reset to none.
event Transfer(address indexed _from, address indexed _to, uint256 indexed _tokenId);
```

### Approval (inherited from IERC721)

```solidity
/// @dev This emits when the approved address for an NFT is changed or
///  reaffirmed. The zero address indicates there is no approved address.
///  When a Transfer event emits, this also indicates that the approved
///  address for that NFT (if any) is reset to none.
event Approval(address indexed _owner, address indexed _approved, uint256 indexed _tokenId);
```

### ApprovalForAll (inherited from IERC721)

```solidity
/// @dev This emits when an operator is enabled or disabled for an owner.
///  The operator can manage all NFTs of the owner.
event ApprovalForAll(address indexed _owner, address indexed _operator, bool _approved);
```

## Public/External Functions

### name()

- **Signature**: `name()`
- **Visibility**: external
- **Source Range**: 711:92:197
- **Details**: [function_name.md](./function_name.md)

**Signature:**
```solidity
function name() override external view returns (string memory);
```

### symbol()

- **Signature**: `symbol()`
- **Visibility**: external
- **Source Range**: 809:96:197
- **Details**: [function_symbol.md](./function_symbol.md)

**Signature:**
```solidity
function symbol() override external view returns (string memory);
```

### tokenURI(uint256)

- **Signature**: `tokenURI(uint256)`
- **Visibility**: public
- **Source Range**: 911:86:197
- **Details**: [function_tokenURI_uint256.md](./function_tokenURI_uint256.md)

**Signature:**
```solidity
function tokenURI(uint256 id) virtual override public view returns (string memory);
```

### ownerOf(uint256)

- **Signature**: `ownerOf(uint256)`
- **Visibility**: public
- **Source Range**: 1299:158:197
- **Details**: [function_ownerOf_uint256.md](./function_ownerOf_uint256.md)

**Signature:**
```solidity
function ownerOf(uint256 id) virtual override public view returns (address owner);
```

### balanceOf(address)

- **Signature**: `balanceOf(address)`
- **Visibility**: public
- **Source Range**: 1463:177:197
- **Details**: [function_balanceOf_address.md](./function_balanceOf_address.md)

**Signature:**
```solidity
function balanceOf(address owner) virtual override public view returns (uint256);
```

### getApproved(uint256)

- **Signature**: `getApproved(uint256)`
- **Visibility**: public
- **Source Range**: 1968:120:197
- **Details**: [function_getApproved_uint256.md](./function_getApproved_uint256.md)

**Signature:**
```solidity
function getApproved(uint256 id) virtual override public view returns (address);
```

### isApprovedForAll(address,address)

- **Signature**: `isApprovedForAll(address,address)`
- **Visibility**: public
- **Source Range**: 2094:227:197
- **Details**: [function_isApprovedForAll_address_address.md](./function_isApprovedForAll_address_address.md)

**Signature:**
```solidity
function isApprovedForAll(address owner, address operator) virtual override public view returns (bool);
```

### initialize(string,string)

- **Signature**: `initialize(string,string)`
- **Visibility**: public
- **Source Range**: 2821:212:197
- **Details**: [function_initialize_string_string.md](./function_initialize_string_string.md)

**Signature:**
```solidity
/// @dev To hide constructor warnings across solc versions due to different constructor
///  visibility requirements and
///  syntaxes, we add an initialization function that can be called only once.
function initialize(string memory name_, string memory symbol_) public;
```

### approve(address,uint256)

- **Signature**: `approve(address,uint256)`
- **Visibility**: public
- **Source Range**: 3221:301:197
- **Details**: [function_approve_address_uint256.md](./function_approve_address_uint256.md)

**Signature:**
```solidity
function approve(address spender, uint256 id) virtual override public payable;
```

### setApprovalForAll(address,bool)

- **Signature**: `setApprovalForAll(address,bool)`
- **Visibility**: public
- **Source Range**: 3528:213:197
- **Details**: [function_setApprovalForAll_address_bool.md](./function_setApprovalForAll_address_bool.md)

**Signature:**
```solidity
function setApprovalForAll(address operator, bool approved) virtual override public;
```

### transferFrom(address,address,uint256)

- **Signature**: `transferFrom(address,address,uint256)`
- **Visibility**: public
- **Source Range**: 3747:709:197
- **Details**: [function_transferFrom_address_address_uint256.md](./function_transferFrom_address_address_uint256.md)

**Signature:**
```solidity
function transferFrom(address from, address to, uint256 id) virtual override public payable;
```

### safeTransferFrom(address,address,uint256)

- **Signature**: `safeTransferFrom(address,address,uint256)`
- **Visibility**: public
- **Source Range**: 4462:452:197
- **Details**: [function_safeTransferFrom_address_address_uint256.md](./function_safeTransferFrom_address_address_uint256.md)

**Signature:**
```solidity
function safeTransferFrom(address from, address to, uint256 id) virtual override public payable;
```

### safeTransferFrom(address,address,uint256,bytes)

- **Signature**: `safeTransferFrom(address,address,uint256,bytes)`
- **Visibility**: public
- **Source Range**: 4920:481:197
- **Details**: [function_safeTransferFrom_address_address_uint256_bytes.md](./function_safeTransferFrom_address_address_uint256_bytes.md)

**Signature:**
```solidity
function safeTransferFrom(address from, address to, uint256 id, bytes memory data) virtual override public payable;
```

### supportsInterface(bytes4)

- **Signature**: `supportsInterface(bytes4)`
- **Visibility**: public
- **Source Range**: 5589:332:197
- **Details**: [function_supportsInterface_bytes4.md](./function_supportsInterface_bytes4.md)

**Signature:**
```solidity
function supportsInterface(bytes4 interfaceId) virtual override public view returns (bool);
```
