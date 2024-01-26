// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract Confidential {
  string public firstUser = 'ALICE';
  uint public alice_age = 24;
  // @audit This variable is not really private since it's possible to read its value from storage.
  // All we need is to guess the 32-byte location (slot) where the variable is stored. For example,
  // `string firstUser` will take the first slot, `uint alice_age` the second slot and
  // `bytes32 ALICE_PRIVATE_KEY` the third slot.
  // Also, private hashes are stored on slots 4 and 9, for alice and bob respectively.
  bytes32 private ALICE_PRIVATE_KEY; //Super Secret Key
  bytes32 public ALICE_DATA = 'QWxpY2UK';
  bytes32 private aliceHash = hash(ALICE_PRIVATE_KEY, ALICE_DATA);

  string public secondUser = 'BOB';
  uint public bob_age = 21;
  // @audit Same thing for this variable stored on slot 7.
  bytes32 private BOB_PRIVATE_KEY; // Super Secret Key
  bytes32 public BOB_DATA = 'Qm9iCg';
  bytes32 private bobHash = hash(BOB_PRIVATE_KEY, BOB_DATA);

  constructor() {}

  // @audit Keccak256 algorithm computes the hash of an input to a fixed length output.
  // It is a one-way cryptographic hash function, which cannot be decoded in reverse.
  function hash(bytes32 key1, bytes32 key2) public pure returns (bytes32) {
    return keccak256(abi.encodePacked(key1, key2));
  }

  function checkthehash(bytes32 _hash) public view returns (bool) {
    require(_hash == hash(aliceHash, bobHash));
    return true;
  }
}
