# Function: envOr(string,string)

**Contract**: [lib/v2-core/test/BaseTest.t.sol/contract_BaseTest.md]

## Metadata

- **Contract**: BaseTest
- **Signature**: `envOr(string,string)`
- **Visibility**: public
- **Source Range**: 4081:166:500
- **Inherited From**: Helpers

## Implementation

```solidity
function envOr(string memory name, string memory defaultValue) public view returns (string memory value) {
    return Vm(VM_ADDR).envOr(name, defaultValue);
}
```

## External Calls

- **Vm::envOr(string,string)**

## State Variable Reads

- **VM_ADDR** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Helpers.envOr(string,string) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
