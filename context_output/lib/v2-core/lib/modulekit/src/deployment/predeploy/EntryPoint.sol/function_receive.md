# Function: receive()

**Contract**: [lib/v2-core/lib/modulekit/src/deployment/predeploy/EntryPoint.sol/contract_EntryPointSimulationsPatch.md]

## Metadata

- **Contract**: EntryPointSimulationsPatch
- **Signature**: `receive()`
- **Visibility**: external
- **Source Range**: 1279:65:95
- **Inherited From**: StakeManager

## Implementation

```solidity
receive() external payable {
    depositTo(msg.sender);
}
```

## Related Implementations

### depositTo(address)

- **Kind**: internal
- **Source**: 6417:386:90
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@ERC4337/account-abstraction/contracts/core/EntryPointSimulations.sol:EntryPointSimulations:depositTo(address)`

```solidity
function depositTo(address account) override(IStakeManager, StakeManager) public payable {
    unchecked {
        uint256 x = 1;
        while (x < 5) {
            x++;
        }
        StakeManager.depositTo(account);
    }
}
```

### depositTo(address)

- **Kind**: internal
- **Source**: 1935:179:95
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@ERC4337/account-abstraction/contracts/core/StakeManager.sol:StakeManager:depositTo(address)`

```solidity
///  Add to the deposit of the given account.
///  @param account - The account to add to.
function depositTo(address account) virtual public payable {
    uint256 newDeposit = _incrementDeposit(account, msg.value);
    emit Deposited(account, newDeposit);
}
```

### _incrementDeposit(address,uint256)

- **Kind**: internal
- **Source**: 1559:259:95
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@ERC4337/account-abstraction/contracts/core/StakeManager.sol:StakeManager:_incrementDeposit(address,uint256)`

```solidity
///  Increments an account's deposit.
///  @param account - The account to increment.
///  @param amount  - The amount to increment by.
///  @return the updated deposit of this account
function _incrementDeposit(address account, uint256 amount) internal returns (uint256) {
    DepositInfo storage info = deposits[account];
    uint256 newAmount = info.deposit + amount;
    info.deposit = newAmount;
    return newAmount;
}
```

## State Variable Reads

- **deposits** (`mapping(address => struct IStakeManager.DepositInfo)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: StakeManager.receive() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: EntryPointSimulations.depositTo(address) (NodeID: 1)
      💬 Args: [msg.sender]
      👁️  Def: public
    └─ [2] ⚙️ FUNCTION: StakeManager.depositTo(address) (NodeID: 2)
        💬 Args: [account]
        👁️  Def: public
      └─ [3] ⚙️ FUNCTION: StakeManager._incrementDeposit(address,uint256) (NodeID: 3)
          💬 Args: [account, msg.value]
          👁️  Def: internal
```
