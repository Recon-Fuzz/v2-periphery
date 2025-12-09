# Function: failed()

**Contract**: [test/unit/up/Up.t.sol/contract_UpTest.md]

## Metadata

- **Contract**: UpTest
- **Signature**: `failed()`
- **Visibility**: public
- **Source Range**: 1306:195:12
- **Inherited From**: StdAssertions

## Implementation

```solidity
function failed() public view returns (bool) {
    if (_failed) {
        return true;
    } else {
        return vm.load(address(vm), FAILED_SLOT) != bytes32(0);
    }
}
```

## External Calls

- **Vm::load(address,bytes32)**

## State Variable Reads

- **_failed** (`bool`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]
- **FAILED_SLOT** (`bytes32`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: StdAssertions.failed() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
