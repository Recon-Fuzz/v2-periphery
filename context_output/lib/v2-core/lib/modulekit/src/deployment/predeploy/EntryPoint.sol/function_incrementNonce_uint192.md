# Function: incrementNonce(uint192)

**Contract**: [lib/v2-core/lib/modulekit/src/deployment/predeploy/EntryPoint.sol/contract_EntryPointSimulationsPatch.md]

## Metadata

- **Contract**: EntryPointSimulationsPatch
- **Signature**: `incrementNonce(uint192)`
- **Visibility**: public
- **Source Range**: 830:108:93
- **Inherited From**: NonceManager

## Implementation

```solidity
function incrementNonce(uint192 key) override public {
    nonceSequenceNumber[msg.sender][key]++;
}
```

## State Variable Writes

- **nonceSequenceNumber** (`mapping(address => mapping(uint192 => uint256))`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: NonceManager.incrementNonce(uint192) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Interface Documentation

 Manually increment the nonce of the sender.
 This method is exposed just for completeness..
 Account does NOT need to call it, neither during validation, nor elsewhere,
 as the EntryPoint will update the nonce regardless.
 Possible use-case is call it with various keys to "initialize" their nonces to one, so that future
 UserOperations will not pay extra for the first transaction with a given key.
