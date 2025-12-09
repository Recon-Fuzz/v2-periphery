# Function: deposit(uint256,address,address)

**Contract**: [test/recon/mocks/MockERC7540Tester.sol/contract_MockERC7540Tester.md]

## Metadata

- **Contract**: MockERC7540Tester
- **Signature**: `deposit(uint256,address,address)`
- **Visibility**: public
- **Source Range**: 6374:1082:641

## Implementation

```solidity
function deposit(uint256 assets, address receiver, address controller) public returns (uint256 shares) {
    require((msg.sender == controller) || operators[controller][msg.sender], "Not authorized");
    for (uint256 i = 1; i < _nextRequestId; i++) {
        DepositRequestStruct storage request = depositRequests[i];
        if ((((request.controller == controller) && (!request.fulfilled)) && (!request.canceled)) && (request.assets >= assets)) {
            shares = previewDeposit(assets);
            request.fulfilled = true;
            _mint(receiver, shares);
            if (request.assets > assets) {
                asset.transfer(controller, request.assets - assets);
            }
            emit Deposit(msg.sender, receiver, assets, shares);
            return shares;
        }
    }
    return super.deposit(assets, receiver);
}
```

## Related Implementations

### previewDeposit(uint256)

- **Kind**: internal
- **Source**: 1795:125:641
- **Link**: `test/recon/mocks/MockERC7540Tester.sol:ERC7575:previewDeposit(uint256)`

```solidity
function previewDeposit(uint256 assets) virtual public view returns (uint256) {
    return convertToShares(assets);
}
```

### convertToShares(uint256)

- **Kind**: internal
- **Source**: 909:197:641
- **Link**: `test/recon/mocks/MockERC7540Tester.sol:ERC7575:convertToShares(uint256)`

```solidity
function convertToShares(uint256 assets) virtual public view returns (uint256) {
    uint256 supply = totalSupply;
    return (supply == 0) ? assets : ((assets * supply) / totalAssets());
}
```

### totalAssets()

- **Kind**: internal
- **Source**: 788:115:641
- **Link**: `test/recon/mocks/MockERC7540Tester.sol:ERC7575:totalAssets()`

```solidity
function totalAssets() virtual public view returns (uint256) {
    return asset.balanceOf(address(this));
}
```

### _mint(address,uint256)

- **Kind**: internal
- **Source**: 7079:471:73
- **Link**: `lib/setup-helpers/src/MockERC20.sol:ERC20:_mint(address,uint256)`

```solidity
function _mint(address to, uint256 amount) virtual internal {
    uint256 newTotalSupply = totalSupply + amount;
    if (newTotalSupply < totalSupply) revert MintOverflow(totalSupply, amount);
    totalSupply = newTotalSupply;
    unchecked {
        balanceOf[to] += amount;
    }
    emit Transfer(address(0), to, amount);
}
```

### deposit(uint256,address)

- **Kind**: internal
- **Source**: 2458:295:641
- **Link**: `test/recon/mocks/MockERC7540Tester.sol:ERC7575:deposit(uint256,address)`

```solidity
function deposit(uint256 assets, address receiver) virtual public returns (uint256 shares) {
    shares = previewDeposit(assets);
    asset.transferFrom(msg.sender, address(this), assets);
    _mint(receiver, shares);
    emit Deposit(msg.sender, receiver, assets, shares);
}
```

## External Calls

- **MockERC20::transfer(address,uint256)**

## Native Transfers

- **asset** (computed)

## State Variable Reads

- **operators** (`mapping(address => mapping(address => bool))`)
- **_nextRequestId** (`uint256`)
- **depositRequests** (`mapping(uint256 => struct MockERC7540Tester.DepositRequestStruct)`)
- **asset** (`contract MockERC20`) [lib/setup-helpers/src/MockERC20.sol/contract_MockERC20.md]
- **totalSupply** (`uint256`)

## State Variable Writes

- **totalSupply** (`uint256`)
- **balanceOf** (`mapping(address => uint256)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockERC7540Tester.deposit(uint256,address,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: ERC7575.previewDeposit(uint256) (NodeID: 1)
  │   💬 Args: [assets]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: ERC7575.convertToShares(uint256) (NodeID: 2)
  │     💬 Args: [assets]
  │     👁️  Def: public
  │   └─ [3] ⚙️ FUNCTION: ERC7575.totalAssets() (NodeID: 3)
  │       💬 Args: [no args]
  │       👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: ERC20._mint(address,uint256) (NodeID: 4)
  │   💬 Args: [receiver, shares]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: ERC7575.deposit(uint256,address) (NodeID: 5)
      💬 Args: [assets, receiver]
      👁️  Def: public
    ├─ [2] ⚙️ FUNCTION: ERC7575.previewDeposit(uint256) (NodeID: 6)
    │   💬 Args: [assets]
    │   👁️  Def: public
    │ └─ [3] ⚙️ FUNCTION: ERC7575.convertToShares(uint256) (NodeID: 7)
    │     💬 Args: [assets]
    │     👁️  Def: public
    │   └─ [4] ⚙️ FUNCTION: ERC7575.totalAssets() (NodeID: 8)
    │       💬 Args: [no args]
    │       👁️  Def: public
    └─ [2] ⚙️ FUNCTION: ERC20._mint(address,uint256) (NodeID: 9)
        💬 Args: [receiver, shares]
        👁️  Def: internal
```
