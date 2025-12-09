# Function: setUp()

**Contract**: [test/unit/up/Up.t.sol/contract_UpTest.md]

## Metadata

- **Contract**: UpTest
- **Signature**: `setUp()`
- **Visibility**: public
- **Source Range**: 1128:579:663

## Implementation

```solidity
function setUp() public {
    owner = address(this);
    user1 = address(0x1);
    user2 = address(0x2);
    user3 = address(0x3);
    UpToken = Up(payable(VmContractHelper705(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/UP/Up.sol:Up", _args: encodeArgs536(DeployHelper536.FoundryPpConstructorArgs(owner))})));
    vm.label(owner, "Owner");
    vm.label(user1, "User1");
    vm.label(user2, "User2");
    vm.label(user3, "User3");
}
```

## External Calls

- **VmContractHelper705::deployCode(string,bytes)**
- **Vm::label(address,string)**

## State Variable Reads

- **owner** (`address`)
- **user1** (`address`)
- **user2** (`address`)
- **user3** (`address`)

## State Variable Writes

- **owner** (`address`)
- **user1** (`address`)
- **user2** (`address`)
- **user3** (`address`)
- **UpToken** (`contract Up`) [src/UP/Up.sol/contract_Up.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: UpTest.setUp() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
