# Function: isTrustedForwarder(address,address)

**Contract**: [lib/v2-core/lib/modulekit/src/module-bases/mocks/MockHookMultiPlexer.sol/contract_MockHookMultiPlexer.md]

## Metadata

- **Contract**: MockHookMultiPlexer
- **Signature**: `isTrustedForwarder(address,address)`
- **Visibility**: public
- **Source Range**: 906:153:230
- **Inherited From**: TrustedForwarder

## Implementation

```solidity
///  Check if a forwarder is trusted for an account
///  @param forwarder The address of the forwarder
///  @param account The address of the account
///  @return true if the forwarder is trusted for the account
function isTrustedForwarder(address forwarder, address account) public view returns (bool) {
    return forwarder == trustedForwarder[account];
}
```

## State Variable Reads

- **trustedForwarder** (`mapping(address => address)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TrustedForwarder.isTrustedForwarder(address,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

 Check if a forwarder is trusted for an account
 @param forwarder The address of the forwarder
 @param account The address of the account
 @return true if the forwarder is trusted for the account
