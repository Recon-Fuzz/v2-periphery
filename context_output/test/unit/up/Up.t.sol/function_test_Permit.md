# Function: test_Permit()

**Contract**: [test/unit/up/Up.t.sol/contract_UpTest.md]

## Metadata

- **Contract**: UpTest
- **Signature**: `test_Permit()`
- **Visibility**: public
- **Source Range**: 5621:958:663

## Implementation

```solidity
///  ERC20 Permit Tests
function test_Permit() public {
    uint256 privateKey = 1;
    address signer = vm.addr(privateKey);
    vm.prank(address(this));
    UpToken.transfer(signer, 1000);
    uint256 deadline = block.timestamp + 1 days;
    uint256 nonce = UpToken.nonces(signer);
    bytes32 structHash = keccak256(abi.encode(keccak256("Permit(address owner,address spender,uint256 value,uint256 nonce,uint256 deadline)"), signer, user1, 1000, nonce, deadline));
    bytes32 digest = keccak256(abi.encodePacked("\u0019\u0001", UpToken.DOMAIN_SEPARATOR(), structHash));
    (uint8 v, bytes32 r, bytes32 s) = vm.sign(privateKey, digest);
    UpToken.permit(signer, user1, 1000, deadline, v, r, s);
    assertEq(UpToken.allowance(signer, user1), 1000);
    assertEq(UpToken.nonces(signer), 1);
}
```

## Related Implementations

### assertEq(uint256,uint256)

- **Kind**: internal
- **Source**: 2664:153:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256)`

```solidity
function assertEq(uint256 left, uint256 right) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right);
    }
}
```

## External Calls

- **Vm::addr(uint256)**
- **Vm::prank(address)**
- **Up::transfer(address,uint256)**
- **Up::nonces(address)**
- **Up::DOMAIN_SEPARATOR()**
- **Vm::sign(uint256,bytes32)**
- **Up::permit(address,address,uint256,uint256,uint8,bytes32,bytes32)**
- **Up::allowance(address,address)**

## Native Transfers

- **UpToken** (state variable) [src/UP/Up.sol/contract_Up.md]

## State Variable Reads

- **UpToken** (`contract Up`) [src/UP/Up.sol/contract_Up.md]
- **user1** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: UpTest.test_Permit() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 1)
  │   💬 Args: [UpToken.allowance(signer, user1), 1000]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 2)
      💬 Args: [UpToken.nonces(signer), 1]
      👁️  Def: internal
```

## Documentation

### Function Documentation

 ERC20 Permit Tests
