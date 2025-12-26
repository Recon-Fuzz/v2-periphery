# Interface: IDistributor

## Metadata

- **Name**: IDistributor
- **Type**: Interface
- **Path**: lib/v2-core/src/vendor/merkl/IDistributor.sol

## Structs

### MerkleTree

```solidity
struct MerkleTree {
    bytes32 merkleRoot;
    bytes32 ipfsHash;
}
```

## Events

### Claimed

```solidity
event Claimed(address indexed user, address indexed token, uint256 amount);
```

## Public/External Functions

### claim(address[],address[],uint256[],bytes32[][])

- **Signature**: `claim(address[],address[],uint256[],bytes32[][])`
- **Visibility**: external
- **Source Range**: 1226:180:454

**Signature:**
```solidity
/// @notice Claims rewards for a given set of users
///  @dev Anyone may call this function for anyone else, funds go to destination regardless, it's just a question of
///  who provides the proof and pays the gas: `msg.sender` is used only for addresses that require a trusted operator
///  @param users Recipient of tokens
///  @param tokens ERC20 claimed
///  @param amounts Amount of tokens that will be sent to the corresponding users
///  @param proofs Array of hashes bridging from a leaf `(hash of user | token | amount)` to the Merkle root
function claim(address[] calldata users, address[] calldata tokens, uint256[] calldata amounts, bytes32[][] calldata proofs) external;;
```

### updateTree(struct IDistributor.MerkleTree)

- **Signature**: `updateTree(struct IDistributor.MerkleTree)`
- **Visibility**: external
- **Source Range**: 1448:56:454

**Signature:**
```solidity
/// @notice Updates Merkle Tree
function updateTree(MerkleTree calldata _tree) external;;
```

### setDisputePeriod(uint48)

- **Signature**: `setDisputePeriod(uint48)`
- **Visibility**: external
- **Source Range**: 1614:58:454

**Signature:**
```solidity
/// @notice Sets the dispute period
///  @param _disputePeriod The new dispute period in seconds
function setDisputePeriod(uint48 _disputePeriod) external;;
```

### getMerkleRoot()

- **Signature**: `getMerkleRoot()`
- **Visibility**: external
- **Source Range**: 1757:57:454

**Signature:**
```solidity
/// @notice Returns the MerkleRoot that is currently live for the contract
function getMerkleRoot() external view returns (bytes32);;
```

### claimed(address,address)

- **Signature**: `claimed(address,address)`
- **Visibility**: external
- **Source Range**: 1820:169:454

**Signature:**
```solidity
function claimed(address user, address token) external view returns (uint208 amount, uint48 timestamp, bytes32 merkleRoot);;
```
