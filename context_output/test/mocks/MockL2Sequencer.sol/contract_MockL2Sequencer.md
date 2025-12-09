# Contract: MockL2Sequencer

## Metadata

- **Name**: MockL2Sequencer
- **Type**: Contract
- **Path**: test/mocks/MockL2Sequencer.sol
- **Documentation**:  @title MockL2Sequencer
   @dev Mocks Chainlink's L2 Sequencer Uptime Feed
   When answer is 0: Sequencer is up
   When answer is 1: Sequencer is down

## State Variables

### _answer

```solidity
int256 private _answer
```

### _startedAt

```solidity
uint256 private _startedAt
```

## Public/External Functions

### constructor()

- **Signature**: `constructor()`
- **Visibility**: public
- **Source Range**: 311:110:596
- **Details**: [function_constructor.md](./function_constructor.md)

**Signature:**
```solidity
constructor();
```

### setLatestAnswer(int256)

- **Signature**: `setLatestAnswer(int256)`
- **Visibility**: external
- **Source Range**: 427:82:596
- **Details**: [function_setLatestAnswer_int256.md](./function_setLatestAnswer_int256.md)

**Signature:**
```solidity
function setLatestAnswer(int256 answer) external;
```

### setStartedAt(uint256)

- **Signature**: `setStartedAt(uint256)`
- **Visibility**: external
- **Source Range**: 515:89:596
- **Details**: [function_setStartedAt_uint256.md](./function_setStartedAt_uint256.md)

**Signature:**
```solidity
function setStartedAt(uint256 startedAt) external;
```

### latestRoundData()

- **Signature**: `latestRoundData()`
- **Visibility**: external
- **Source Range**: 610:160:596
- **Details**: [function_latestRoundData.md](./function_latestRoundData.md)

**Signature:**
```solidity
function latestRoundData() external view returns (uint80, int256, uint256, uint256, uint80);
```
