# Contribute

Here is a simple template to write your own exploit under `test/`.

Make sure to update `FOLDER_CHANGE_ME` and `TARGET_CONTRACT_CHANGE_ME`.

```solidity
// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

import '../../src/FOLDER_CHANGE_ME/TARGET_CONTRACT_CHANGE_ME.sol';
import '@forge-std/Test.sol';
import '@forge-std/console2.sol';

contract TARGET_CONTRACT_CHANGE_MEExploit is Test {
  TARGET_CONTRACT_CHANGE_ME target;
  address deployer = makeAddr('deployer');
  address exploiter = makeAddr('exploiter');

  function setUp() public {
    vm.startPrank(deployer);
    target = new TARGET_CONTRACT_CHANGE_ME();
    console2.log('Target contract deployed');
    vm.stopPrank();
  }

  function testExploit() public {
    // TODO
  }
}
```
