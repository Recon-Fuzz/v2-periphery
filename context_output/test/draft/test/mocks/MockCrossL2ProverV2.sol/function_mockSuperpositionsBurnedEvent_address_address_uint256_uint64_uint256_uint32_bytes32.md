# Function: mockSuperpositionsBurnedEvent(address,address,uint256,uint64,uint256,uint32,bytes32)

**Contract**: [test/draft/test/mocks/MockCrossL2ProverV2.sol/contract_MockCrossL2ProverV2.md]

## Metadata

- **Contract**: MockCrossL2ProverV2
- **Signature**: `mockSuperpositionsBurnedEvent(address,address,uint256,uint64,uint256,uint32,bytes32)`
- **Visibility**: external
- **Source Range**: 1448:1356:567

## Implementation

```solidity
function mockSuperpositionsBurnedEvent(address account, address token, uint256 amount, uint64 targetChainId, uint256 nonce, uint32 chainId_, bytes32 yieldSourceOracleId) external {
    _chainId = chainId_;
    bytes memory topics = new bytes(128);
    bytes32 eventSelector = IVaultBank.SuperpositionsBurned.selector;
    bytes32 encodedAccount = bytes32(uint256(uint160(account)));
    bytes32 encodedToken = keccak256(abi.encodePacked(token));
    assembly {
        mstore(add(topics, 32), eventSelector)
        mstore(add(topics, 64), yieldSourceOracleId)
        mstore(add(topics, 96), encodedAccount)
        mstore(add(topics, 128), encodedToken)
    }
    bytes memory data = abi.encode(amount, targetChainId, nonce);
    _topics = topics;
    _unindexedData = data;
}
```

## State Variable Writes

- **_chainId** (`uint32`)
- **_topics** (`bytes`)
- **_unindexedData** (`bytes`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockCrossL2ProverV2.mockSuperpositionsBurnedEvent(address,address,uint256,uint64,uint256,uint32,bytes32) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
