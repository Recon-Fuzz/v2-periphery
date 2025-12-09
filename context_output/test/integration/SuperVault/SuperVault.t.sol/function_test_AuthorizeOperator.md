# Function: test_AuthorizeOperator()

**Contract**: [test/integration/SuperVault/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_AuthorizeOperator()`
- **Visibility**: public
- **Source Range**: 38453:1251:580

## Implementation

```solidity
function test_AuthorizeOperator() public {
    bool approved = true;
    bytes32 nonce = keccak256("test_nonce");
    uint256 deadline = block.timestamp + 1 hours;
    bytes32 digest = keccak256(abi.encodePacked("\u0019\u0001", vault.DOMAIN_SEPARATOR(), keccak256(abi.encode(vault.AUTHORIZE_OPERATOR_TYPEHASH(), userAddress, operator, approved, nonce, deadline))));
    (uint8 v, bytes32 r, bytes32 s) = vm.sign(userPrivateKey, digest);
    bytes memory signature = abi.encodePacked(r, s, v);
    console2.log("User Address:", userAddress);
    console2.log("Operator:", operator);
    console2.log("Digest:", uint256(digest));
    vm.prank(operator);
    bool success = vault.authorizeOperator(userAddress, operator, approved, nonce, deadline, signature);
    assertTrue(success, "Authorization failed");
    assertTrue(vault.isOperator(userAddress, operator), "Operator not authorized");
    assertTrue(vault.authorizations(userAddress, nonce), "Nonce not marked as used");
}
```

## Related Implementations

### log(string,address)

- **Kind**: internal
- **Source**: 7740:145:26
- **Link**: `lib/forge-std/src/console.sol:console:log(string,address)`

```solidity
function log(string memory p0, address p1) internal pure {
    _sendLogPayload(abi.encodeWithSignature("log(string,address)", p0, p1));
}
```

### _sendLogPayload(bytes)

- **Kind**: internal
- **Source**: 8891:133:23
- **Link**: `lib/forge-std/src/StdUtils.sol:StdUtils:_sendLogPayload(bytes)`

```solidity
function _sendLogPayload(bytes memory payload) internal pure {
    _castLogPayloadViewToPure(_sendLogPayloadView)(payload);
}
```

### _castLogPayloadViewToPure(function (bytes)

- **Kind**: internal
- **Source**: 8650:235:23
- **Link**: `lib/forge-std/src/StdUtils.sol:StdUtils:_castLogPayloadViewToPure(function (bytes) view)`

```solidity
function _castLogPayloadViewToPure(function(bytes memory) internal view fnIn) internal pure returns (function(bytes memory) internal pure fnOut) {
    assembly {
        fnOut := fnIn
    }
}
```

### log(string,uint256)

- **Kind**: internal
- **Source**: 7139:145:26
- **Link**: `lib/forge-std/src/console.sol:console:log(string,uint256)`

```solidity
function log(string memory p0, uint256 p1) internal pure {
    _sendLogPayload(abi.encodeWithSignature("log(string,uint256)", p0, p1));
}
```

### assertTrue(bool,string)

- **Kind**: internal
- **Source**: 1894:148:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertTrue(bool,string)`

```solidity
function assertTrue(bool data, string memory err) virtual internal pure {
    if (!data) {
        vm.assertTrue(data, err);
    }
}
```

## External Calls

- **SuperVault::DOMAIN_SEPARATOR()**
- **SuperVault::AUTHORIZE_OPERATOR_TYPEHASH()**
- **Vm::sign(uint256,bytes32)**
- **Vm::prank(address)**
- **SuperVault::authorizeOperator(address,address,bool,bytes32,uint256,bytes)**
- **SuperVault::isOperator(address,address)**
- **SuperVault::authorizations(address,bytes32)**

## State Variable Reads

- **userAddress** (`address`)
- **operator** (`address`)
- **userPrivateKey** (`uint256`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_AuthorizeOperator() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: console.log(string,address) (NodeID: 1)
  │   💬 Args: ["User Address:", userAddress]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 2)
  │     💬 Args: [abi.encodeWithSignature("log(string,address)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 3)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,address) (NodeID: 4)
  │   💬 Args: ["Operator:", operator]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 5)
  │     💬 Args: [abi.encodeWithSignature("log(string,address)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 6)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 7)
  │   💬 Args: ["Digest:", uint256(digest)]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 8)
  │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 9)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 10)
  │   💬 Args: [success, "Authorization failed"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 11)
  │   💬 Args: [vault.isOperator(userAddress, operator), "Operator not authorized"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 12)
      💬 Args: [vault.authorizations(userAddress, nonce), "Nonce not marked as used"]
      👁️  Def: internal
```
