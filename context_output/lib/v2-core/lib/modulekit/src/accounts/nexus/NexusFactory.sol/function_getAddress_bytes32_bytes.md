# Function: getAddress(bytes32,bytes)

**Contract**: [lib/v2-core/lib/modulekit/src/accounts/nexus/NexusFactory.sol/contract_NexusFactory.md]

## Metadata

- **Contract**: NexusFactory
- **Signature**: `getAddress(bytes32,bytes)`
- **Visibility**: public
- **Source Range**: 1395:694:169

## Implementation

```solidity
function getAddress(bytes32 salt, bytes memory initCode) override public view returns (address) {
    bytes32 hash = keccak256(abi.encodePacked(bytes1(0xff), address(this), salt, keccak256(abi.encodePacked(NEXUS_PROXY_BYTECODE, abi.encode(address(nexusImpl), abi.encodeCall(INexus.initializeAccount, initCode))))));
    return address(uint160(uint256(hash)));
}
```

## State Variable Reads

- **nexusImpl** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: NexusFactory.getAddress(bytes32,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
