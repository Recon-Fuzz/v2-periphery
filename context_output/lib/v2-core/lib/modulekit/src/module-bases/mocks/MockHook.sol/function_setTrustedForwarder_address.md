# Function: setTrustedForwarder(address)

**Contract**: [lib/v2-core/lib/modulekit/src/module-bases/mocks/MockHook.sol/contract_MockHook.md]

## Metadata

- **Contract**: MockHook
- **Signature**: `setTrustedForwarder(address)`
- **Visibility**: external
- **Source Range**: 366:114:230
- **Inherited From**: TrustedForwarder

## Implementation

```solidity
///  Set the trusted forwarder for an account
///  @param forwarder The address of the trusted forwarder
function setTrustedForwarder(address forwarder) external {
    trustedForwarder[msg.sender] = forwarder;
}
```

## State Variable Writes

- **trustedForwarder** (`mapping(address => address)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TrustedForwarder.setTrustedForwarder(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

 Set the trusted forwarder for an account
 @param forwarder The address of the trusted forwarder
