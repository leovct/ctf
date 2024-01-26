// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

import '@openzeppelin/access/Ownable.sol';
import '@openzeppelin/utils/ReentrancyGuard.sol';

contract PrivateClub is ReentrancyGuard, Ownable {
  uint private registerEndDate;
  event setRegEndDate(uint registerEndDate);
  event memberWithdrawevent(address member, address to, uint amount);
  address[] public members_;
  mapping(address => bool) public members;

  constructor(address _initialOwner) Ownable(_initialOwner) {}

  receive() external payable {}

  uint public membersCount;

  // @audit The owner can set the registration end date and prevent users to become members.
  function setRegisterEndDate(uint _newRegisterEndDate) external onlyOwner {
    registerEndDate = _newRegisterEndDate;
    emit setRegEndDate(registerEndDate);
  }

  // @audit There's no check of the members list. A malicous actor could craft a members list that
  // only contains its address to become a member without paying any ether.
  function becomeMember(
    address[] calldata _members
  ) external payable nonReentrant {
    require(block.timestamp < registerEndDate, 'registration closed');
    require(_members.length == membersCount, 'wrong members length');
    require(msg.value == membersCount * 1 ether, 'need more ethers');
    bool success;
    for (uint i = 0; i < _members.length; i++) {
      (success, ) = _members[i].call{value: 1 ether}('');
      require(success, 'Low-level call failed');
    }
    membersCount += 1;
    members[msg.sender] = true;
    members_.push(msg.sender);
  }

  modifier onlyMember() {
    bool member;
    for (uint i = 0; i < membersCount; i++) {
      if (members_[i] == msg.sender) {
        member = true;
      }
    }

    require(member == true, 'you are not a member');
    _;
  }

  // @audit The owner of the contract can withdraw all the funds.
  function adminWithdraw(address to, uint amount) external onlyOwner {
    (bool success, ) = payable(to).call{value: amount}('');
    require(success, 'Low-level call failed');
  }

  // @audit The owner can add any member for free and after the registration has closed.
  function addMemberByAdmin(address newMember) external onlyOwner {
    membersCount += 1;
    members[newMember] = true;
    members_.push(newMember);
  }

  // @audit Any member can become a new owner by sending 10 ether to the contract.
  function buyAdminRole(address newAdmin) external payable onlyMember {
    require(msg.value == 10 ether, 'need 10 ethers');
    _transferOwnership(newAdmin);
  }
}
