# Function: getAddress(bytes32,bytes)

**Contract**: [lib/v2-core/lib/modulekit/src/accounts/erc7579/ERC7579Factory.sol/contract_ERC7579Factory.md]

## Metadata

- **Contract**: ERC7579Factory
- **Signature**: `getAddress(bytes32,bytes)`
- **Visibility**: public
- **Source Range**: 3448:722:151

## Implementation

```solidity
function getAddress(bytes32 salt, bytes memory initCode) override public view returns (address) {
    bytes32 hash = keccak256(abi.encodePacked(bytes1(0xff), address(this), salt, keccak256(abi.encodePacked(MSAPROXY_BYTECODE, abi.encode(address(implementation), abi.encodeCall(IMSA.initializeAccount, initCode))))));
    return address(uint160(uint256(hash)));
}
```

## State Variable Reads

- **implementation** (`contract IERC7579Account`) [lib/v2-core/lib/modulekit/src/accounts/common/interfaces/IERC7579Account.sol/interface_IERC7579Account.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC7579Factory.getAddress(bytes32,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
