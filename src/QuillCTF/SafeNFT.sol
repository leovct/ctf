// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.7;

import '@openzeppelin/token/ERC721/extensions/ERC721Enumerable.sol';

contract SafeNFT is ERC721Enumerable {
  uint256 price;
  mapping(address => bool) public canClaim;

  constructor(
    string memory tokenName,
    string memory tokenSymbol,
    uint256 _price
  ) ERC721(tokenName, tokenSymbol) {
    price = _price;
  }

  function buyNFT() external payable {
    require(price == msg.value, 'INVALID_VALUE');
    canClaim[msg.sender] = true;
  }

  function claim() external {
    require(canClaim[msg.sender], 'CANT_MINT');
    // @audit _safeMint isn't safe because it performs an external call to the receiving address
    // (see ERC721:_checkOnERC721Received). If the receiver of _safeMint is a contract, it check the
    // value returned by the onERC721Received function. An attacker can easily use this vulnerability
    // to execute arbitrary code.
    _safeMint(msg.sender, totalSupply());
    // @audit The state update is done after the external call so an attacker can execute arbitrary
    // code with the value canClaim[msg.sender] still equal to true.
    canClaim[msg.sender] = false;
  }
}
