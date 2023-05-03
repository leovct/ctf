// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.7;

contract RoadClosed {
  bool hacked;
  address owner;
  address pwner;
  mapping(address => bool) whitelistedMinters;

  // Audit: relying on extcodesize to check if an address is an EOA is a very bad practice.
  // Indeed, a contract does not have source code available during construction.
  // For reference: https://consensys.github.io/smart-contract-best-practices/development-recommendations/solidity-specific/extcodesize-checks/
  function isContract(address addr) public view returns (bool) {
    uint size;
    assembly {
      size := extcodesize(addr)
    }
    return size > 0;
  }

  // Audit: this function could be shortened to `return msg.sender == owner`.
  function isOwner() public view returns (bool) {
    if (msg.sender == owner) {
      return true;
    } else return false;
  }

  constructor() {
    owner = msg.sender;
  }

  // Audit: anyone can add an EOA to the whitelist since the visibility is public.
  function addToWhitelist(address addr) public {
    require(!isContract(addr), 'Contracts are not allowed');
    whitelistedMinters[addr] = true;
  }

  // Audit: anyone can become the owner if they meet the following conditions:
  // - being whitelisted (which anyone can do)
  // - the new owner address must not be 0x0 and should be the same as the one from which you send the transaction
  function changeOwner(address addr) public {
    require(whitelistedMinters[addr], 'You are not whitelisted');
    require(msg.sender == addr, 'address must be msg.sender');
    require(addr != address(0), 'Zero address');
    owner = addr;
  }

  function pwn(address addr) external payable {
    require(!isContract(msg.sender), 'Contracts are not allowed');
    require(msg.sender == addr, 'address must be msg.sender');
    require(msg.sender == owner, 'Must be owner');
    hacked = true;
  }

  function pwn() external payable {
    require(msg.sender == pwner);
    hacked = true;
  }

  function isHacked() public view returns (bool) {
    return hacked;
  }
}
