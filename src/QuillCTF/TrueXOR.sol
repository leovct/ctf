// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

interface IBoolGiver {
  // @audit The function is `view` so it can't modify the state.
  function giveBool() external view returns (bool);
}

contract TrueXOR {
  function callMe(address target) external view returns (bool) {
    bool p = IBoolGiver(target).giveBool();
    bool q = IBoolGiver(target).giveBool();
    //@audit Quick truth table to show that `(p && q) != (p || q)` is the same as `p XOR q`.
    // | p | q | AND | OR | XOR |
    // | 0 | 0 |   0 |  0 |   0 |
    // | 0 | 1 |   0 |  1 |   1 |
    // | 1 | 0 |   0 |  1 |   1 |
    // | 1 | 1 |   1 |  1 |   0 |
    // @audit Thus, our `BoolGiver` contract should return true or false the first time and then
    // the opposite the second time. We need to find a way to do this using a view function that
    // takes no parameter. Maybe something around the amount of gas left?
    require((p && q) != (p || q), 'bad bools');
    // @audit msg.sender has to be equal to tx.origin so we may need to use `delegatecall`.
    require(msg.sender == tx.origin, 'bad sender');
    return true;
  }
}
