# Function: getInitData(address,bytes)

**Contract**: [lib/v2-core/lib/modulekit/src/accounts/safe/SafeFactory.sol/contract_SafeFactory.md]

## Metadata

- **Contract**: SafeFactory
- **Signature**: `getInitData(address,bytes)`
- **Visibility**: public
- **Source Range**: 2692:1303:173

## Implementation

```solidity
function getInitData(address validator, bytes memory initData) override public view returns (bytes memory _init) {
    ModuleInit[] memory validators = new ModuleInit[](1);
    validators[0] = ModuleInit({module: address(validator), initData: initData});
    ModuleInit[] memory executors = new ModuleInit[](0);
    ModuleInit[] memory fallbacks = new ModuleInit[](0);
    ModuleInit[] memory hooks = new ModuleInit[](0);
    ISafe7579Launchpad.InitData memory initDataSafe = ISafe7579Launchpad.InitData({singleton: address(safeSingleton), owners: Solarray.addresses(makeAddr("owner1")), threshold: 1, setupTo: address(launchpad), setupData: abi.encodeCall(ISafe7579Launchpad.initSafe7579, (address(safe7579), executors, fallbacks, hooks, Solarray.addresses(makeAddr("attester1"), makeAddr("attester2")), 2)), safe7579: ISafe7579(safe7579), validators: validators, callData: ""});
    _init = abi.encode(initDataSafe);
}
```

## Related Implementations

### addresses(address)

- **Kind**: internal
- **Source**: 30902:161:248
- **Link**: `lib/v2-core/lib/nexus/node_modules/solarray/src/Solarray.sol:Solarray:addresses(address)`

```solidity
function addresses(address a) internal pure returns (address[] memory) {
    address[] memory arr = new address[](1);
    arr[0] = a;
    return arr;
}
```

### makeAddr(string)

- **Kind**: free-function
- **Source**: 415:217:244
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Vm.sol:makeAddr(string)`

```solidity
function makeAddr(string memory name) pure returns (address addr) {
    uint256 privateKey = uint256(keccak256(abi.encodePacked(name)));
    addr = Vm(VM_ADDR).addr(privateKey);
}
```

### addresses(address,address)

- **Kind**: internal
- **Source**: 31070:185:248
- **Link**: `lib/v2-core/lib/nexus/node_modules/solarray/src/Solarray.sol:Solarray:addresses(address,address)`

```solidity
function addresses(address a, address b) internal pure returns (address[] memory) {
    address[] memory arr = new address[](2);
    arr[0] = a;
    arr[1] = b;
    return arr;
}
```

## State Variable Reads

- **safeSingleton** (`address`)
- **launchpad** (`contract ISafe7579Launchpad`) [lib/v2-core/lib/modulekit/src/accounts/safe/interfaces/ISafe7579Launchpad.sol/interface_ISafe7579Launchpad.md]
- **safe7579** (`contract ISafe7579`) [lib/v2-core/lib/modulekit/src/accounts/safe/interfaces/ISafe7579.sol/interface_ISafe7579.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SafeFactory.getInitData(address,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: Solarray.addresses(address) (NodeID: 1)
  │   💬 Args: [makeAddr("owner1")]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Unknown.makeAddr(string) (NodeID: 2)
  │     💬 Args: ["owner1"]
  │     👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: Solarray.addresses(address,address) (NodeID: 3)
      💬 Args: [makeAddr("attester1"), makeAddr("attester2")]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: Unknown.makeAddr(string) (NodeID: 4)
    │   💬 Args: ["attester1"]
    │   👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: Unknown.makeAddr(string) (NodeID: 5)
        💬 Args: ["attester2"]
        👁️  Def: internal
```
