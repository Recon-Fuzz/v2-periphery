# Function: getNonce(address,uint192)

**Contract**: [lib/v2-core/lib/modulekit/src/deployment/predeploy/EntryPoint.sol/contract_EntryPointSimulationsPatch.md]

## Metadata

- **Contract**: EntryPointSimulationsPatch
- **Signature**: `getNonce(address,uint192)`
- **Visibility**: public
- **Source Range**: 394:175:93
- **Inherited From**: NonceManager

## Implementation

```solidity
/// @inheritdoc INonceManager
function getNonce(address sender, uint192 key) override public view returns (uint256 nonce) {
    return nonceSequenceNumber[sender][key] | (uint256(key) << 64);
}
```

## State Variable Reads

- **nonceSequenceNumber** (`mapping(address => mapping(uint192 => uint256))`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: NonceManager.getNonce(address,uint192) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@inheritdoc INonceManager

### Interface Documentation

 Return the next nonce for this sender.
 Within a given key, the nonce values are sequenced (starting with zero, and incremented by one on each userop)
 But UserOp with different keys can come with arbitrary order.
 @param sender the account address
 @param key the high 192 bit of the nonce
 @return nonce a full nonce to pass for next UserOp with this sender.
