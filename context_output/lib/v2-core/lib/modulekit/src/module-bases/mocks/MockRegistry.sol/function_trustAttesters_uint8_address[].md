# Function: trustAttesters(uint8,address[])

**Contract**: [lib/v2-core/lib/modulekit/src/module-bases/mocks/MockRegistry.sol/contract_MockRegistry.md]

## Metadata

- **Contract**: MockRegistry
- **Signature**: `trustAttesters(uint8,address[])`
- **Visibility**: external
- **Source Range**: 1426:83:225

## Implementation

```solidity
function trustAttesters(uint8 threshold, address[] calldata attesters) external {}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockRegistry.trustAttesters(uint8,address[]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

 Allows Smart Accounts - the end users of the registry - to appoint
 one or many attesters as trusted.
 @dev this function reverts, if address(0), or duplicates are provided in attesters[]
 @param threshold The minimum number of attestations required for a module
                  to be considered secure.
 @param attesters The addresses of the attesters to be trusted.
