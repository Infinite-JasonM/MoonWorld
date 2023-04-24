//SPDX-License-Identifier: MIT
//CowEye.sol
//Enable optimization
pragma solidity ^0.8.18;

import "./TRC20.sol";
import "./LockableToken.sol";
import "./Owned.sol";

/**
 * @title SimpleToken
 * @dev Very simple TRC20 Token example, where all tokens are pre-assigned to the creator.
 * Note they can later distribute these tokens as they wish using `transfer` and other
 * `TRC20` functions.
 */
 
contract MoonWorldTest is LockableToken 
{
    uint8 public constant DECIMALS = 18;
    uint256 public constant INITIAL_SUPPLY = 1000000000 * (10 ** uint256(DECIMALS));

    constructor () public LockableToken(INITIAL_SUPPLY, "MoonWorldTest", "MWT", DECIMALS) 
    {
        _mint(msg.sender, INITIAL_SUPPLY);
    }
}
