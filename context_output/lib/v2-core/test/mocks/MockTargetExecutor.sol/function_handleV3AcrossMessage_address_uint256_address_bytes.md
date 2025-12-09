# Function: handleV3AcrossMessage(address,uint256,address,bytes)

**Contract**: [lib/v2-core/test/mocks/MockTargetExecutor.sol/contract_MockTargetExecutor.md]

## Metadata

- **Contract**: MockTargetExecutor
- **Signature**: `handleV3AcrossMessage(address,uint256,address,bytes)`
- **Visibility**: external
- **Source Range**: 3278:1098:487

## Implementation

```solidity
function handleV3AcrossMessage(address tokenSent, uint256 amount, address, bytes memory message) external {
    (bytes memory initData, bytes32 initSalt) = abi.decode(message, (bytes, bytes32));
    address computedAddress = nexusFactory.computeAccountAddress(initData, initSalt);
    address deployedAddress = nexusFactory.createAccount(initData, initSalt);
    if (deployedAddress != computedAddress) revert NEXUS_ADDRESS_MISMATCH();
    nexusCreatedAccount = deployedAddress;
    emit HappyAccountCreated(deployedAddress);
    IERC20(tokenSent).transfer(deployedAddress, amount);
}
```

## External Calls

- **INexusFactory::computeAccountAddress(bytes,bytes32)**
- **INexusFactory::createAccount(bytes,bytes32)**
- **IERC20::transfer(address,uint256)**

## Native Transfers

- **unknown** (computed)

## State Variable Reads

- **nexusFactory** (`contract INexusFactory`) [lib/v2-core/src/vendor/nexus/INexusFactory.sol/interface_INexusFactory.md]

## State Variable Writes

- **nexusCreatedAccount** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockTargetExecutor.handleV3AcrossMessage(address,uint256,address,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
