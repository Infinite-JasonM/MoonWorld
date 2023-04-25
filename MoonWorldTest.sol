//SPDX-License-Identifier: MIT
//CowEye.sol
//Enable optimization
pragma solidity ^0.8.18;

import "./TRC20.sol";
import "./ITRC20.sol";
import "./LockableToken.sol";
import "./Owned.sol";
import "./BasicToken.sol";
import "./SafeMath.sol";

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
    /**
    * @dev Hook that is called before any token transfer. This includes minting and burning.
    *      The function signature was changed after version 0.8.0.
    *      For backwards compatibility, versions of Solidity before 0.8.0 will not receive the new function signature.
    *
    * @param from The address that is transferring the tokens.
    * @param to The address that is receiving the tokens.
    * @param amount The amount of tokens being transferred.
    */
    function _beforeTokenTransfer(address from, address to, uint256 amount) internal virtual
    {
        if (from == address(0)) { // When minting tokens
            require(totalSupply() + amount <= _cap, "ERC20Capped: cap exceeded");
        }
    }
}
