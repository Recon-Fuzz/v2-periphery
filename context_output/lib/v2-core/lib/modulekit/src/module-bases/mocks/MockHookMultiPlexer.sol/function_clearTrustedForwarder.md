# Function: clearTrustedForwarder()

**Contract**: [lib/v2-core/lib/modulekit/src/module-bases/mocks/MockHookMultiPlexer.sol/contract_MockHookMultiPlexer.md]

## Metadata

- **Contract**: MockHookMultiPlexer
- **Signature**: `clearTrustedForwarder()`
- **Visibility**: public
- **Source Range**: 552:98:230
- **Inherited From**: TrustedForwarder

## Implementation

```solidity
///  Clear the trusted forwarder for an account
function clearTrustedForwarder() public {
    trustedForwarder[msg.sender] = address(0);
}
```

## State Variable Writes

- **trustedForwarder** (`mapping(address => address)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TrustedForwarder.clearTrustedForwarder() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

 Clear the trusted forwarder for an account
