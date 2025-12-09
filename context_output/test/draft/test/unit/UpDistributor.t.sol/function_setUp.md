# Function: setUp()

**Contract**: [test/draft/test/unit/UpDistributor.t.sol/contract_UpDistributorTest.md]

## Metadata

- **Contract**: UpDistributorTest
- **Signature**: `setUp()`
- **Visibility**: public
- **Source Range**: 704:1138:569

## Implementation

```solidity
function setUp() public {
    owner = address(this);
    user1 = address(0x1);
    user2 = address(0x2);
    user3 = address(0x3);
    UpToken = Up(payable(VmContractHelper540(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/UP/Up.sol:Up", _args: encodeArgs536(DeployHelper536.FoundryPpConstructorArgs(owner))})));
    distributor = new UpDistributor(address(UpToken), owner);
    (merkleRoot, merkleProof1) = _generateMerkleTree(MerkleReader.MerkleArgs(user1));
    (, merkleProof2) = _generateMerkleTree(MerkleReader.MerkleArgs(user2));
    distributor.setMerkleRoot(merkleRoot);
    UpToken.transfer(address(distributor), CLAIM_AMOUNT * 3);
    vm.label(owner, "Owner");
    vm.label(user1, "User1");
    vm.label(user2, "User2");
    vm.label(user3, "User3");
    vm.label(address(UpToken), "UpToken");
    vm.label(address(distributor), "Distributor");
}
```

## Related Implementations

### _generateMerkleTree(struct MerkleReader.MerkleArgs)

- **Kind**: internal
- **Source**: 1120:1220:664
- **Link**: `test/unit/up/merkle/helper/MerkleReader.sol:MerkleReader:_generateMerkleTree(struct MerkleReader.MerkleArgs)`

```solidity
/// @dev read the merkle root and proof from js generated tree
function _generateMerkleTree(MerkleArgs memory a) internal view returns (bytes32 root, bytes32[] memory proofsForIndex) {
    LocalVars memory v;
    v.rootJson = vm.readFile(string.concat(vm.projectRoot(), basePathForRoot, ".json"));
    v.encodedRoot = vm.parseJson(v.rootJson, ".root");
    root = abi.decode(v.encodedRoot, (bytes32));
    v.treeJson = vm.readFile(string.concat(vm.projectRoot(), basePathForTreeDump, ".json"));
    for (uint256 i; i < 2; ++i) {
        v.encodedClaimer = vm.parseJson(v.treeJson, string.concat(prepend, Strings.toString(i), claimerQueryAppend));
        v.encodedAmount = vm.parseJson(v.treeJson, string.concat(prepend, Strings.toString(i), amountQueryAppend));
        v.claimer = abi.decode(v.encodedClaimer, (address));
        v.amountClaimed = abi.decode(v.encodedAmount, (uint256));
        if ((a.claimer_ != address(0)) && (v.claimer == a.claimer_)) {
            v.encodedProof = vm.parseJson(v.treeJson, string.concat(prepend, Strings.toString(i), proofQueryAppend));
            proofsForIndex = abi.decode(v.encodedProof, (bytes32[]));
            break;
        }
    }
}
```

### toString(uint256)

- **Kind**: internal
- **Source**: 1308:634:56
- **Link**: `lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/Strings.sol:Strings:toString(uint256)`

```solidity
///  @dev Converts a `uint256` to its ASCII `string` decimal representation.
function toString(uint256 value) internal pure returns (string memory) {
    unchecked {
        uint256 length = Math.log10(value) + 1;
        string memory buffer = new string(length);
        uint256 ptr;
        assembly ("memory-safe") {
            ptr := add(add(buffer, 0x20), length)
        }
        while (true) {
            ptr--;
            assembly ("memory-safe") {
                mstore8(ptr, byte(mod(value, 10), HEX_DIGITS))
            }
            value /= 10;
            if (value == 0) break;
        }
        return buffer;
    }
}
```

### log10(uint256)

- **Kind**: internal
- **Source**: 29154:916:60
- **Link**: `lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:log10(uint256)`

```solidity
///  @dev Return the log in base 10 of a positive value rounded towards zero.
///  Returns 0 if given 0.
function log10(uint256 value) internal pure returns (uint256) {
    uint256 result = 0;
    unchecked {
        if (value >= (10 ** 64)) {
            value /= 10 ** 64;
            result += 64;
        }
        if (value >= (10 ** 32)) {
            value /= 10 ** 32;
            result += 32;
        }
        if (value >= (10 ** 16)) {
            value /= 10 ** 16;
            result += 16;
        }
        if (value >= (10 ** 8)) {
            value /= 10 ** 8;
            result += 8;
        }
        if (value >= (10 ** 4)) {
            value /= 10 ** 4;
            result += 4;
        }
        if (value >= (10 ** 2)) {
            value /= 10 ** 2;
            result += 2;
        }
        if (value >= (10 ** 1)) {
            result += 1;
        }
    }
    return result;
}
```

## External Calls

- **VmContractHelper540::deployCode(string,bytes)**
- **UpDistributor::setMerkleRoot(bytes32)**
- **Up::transfer(address,uint256)**
- **Vm::label(address,string)**

## Native Transfers

- **UpToken** (state variable) [src/UP/Up.sol/contract_Up.md]

## State Variable Reads

- **owner** (`address`)
- **UpToken** (`contract Up`) [src/UP/Up.sol/contract_Up.md]
- **user1** (`address`)
- **user2** (`address`)
- **distributor** (`contract UpDistributor`) [test/draft/src/UP/UpDistributor.sol/contract_UpDistributor.md]
- **merkleRoot** (`bytes32`)
- **CLAIM_AMOUNT** (`uint256`)
- **user3** (`address`)
- **basePathForRoot** (`string`)
- **basePathForTreeDump** (`string`)
- **prepend** (`string`)
- **claimerQueryAppend** (`string`)
- **amountQueryAppend** (`string`)
- **proofQueryAppend** (`string`)

## State Variable Writes

- **owner** (`address`)
- **user1** (`address`)
- **user2** (`address`)
- **user3** (`address`)
- **UpToken** (`contract Up`) [src/UP/Up.sol/contract_Up.md]
- **distributor** (`contract UpDistributor`) [test/draft/src/UP/UpDistributor.sol/contract_UpDistributor.md]
- **merkleRoot** (`bytes32`)
- **merkleProof1** (`bytes32[]`)
- **merkleProof2** (`bytes32[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: UpDistributorTest.setUp() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: MerkleReader._generateMerkleTree(struct MerkleReader.MerkleArgs) (NodeID: 1)
  │   💬 Args: [MerkleReader.MerkleArgs(user1)]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 2)
  │ │   💬 Args: [i]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 3)
  │ │     💬 Args: [value]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 4)
  │ │   💬 Args: [i]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 5)
  │ │     💬 Args: [value]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 6)
  │     💬 Args: [i]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 7)
  │       💬 Args: [value]
  │       👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: MerkleReader._generateMerkleTree(struct MerkleReader.MerkleArgs) (NodeID: 8)
      💬 Args: [MerkleReader.MerkleArgs(user2)]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 9)
    │   💬 Args: [i]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 10)
    │     💬 Args: [value]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 11)
    │   💬 Args: [i]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 12)
    │     💬 Args: [value]
    │     👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 13)
        💬 Args: [i]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 14)
          💬 Args: [value]
          👁️  Def: internal
```
