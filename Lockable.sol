// SPDX-License-Identifier: MIT
// Lockable.sol

pragma solidity ^0.8.19;

import "./TRC20.sol";
import "./Owned.sol";

/**
 * @title LockableToken
 * @dev TRC20 token with lockable accounts
 */
contract LockableToken is TRC20, Owned {
    mapping(address => bool) internal _lockedAccounts;

    event AccountLocked(address indexed account);
    event AccountUnlocked(address indexed account);

    /**
     * @dev Throws if account is locked.
     */
    modifier onlyUnlocked(address account) {
        require(!_lockedAccounts[account], "Account is locked");
        _;
    }

    /**
     * @dev Locks account.
     */
    function lockAccount(address account) public onlyOwner {
        require(!_lockedAccounts[account], "Account is already locked");
        _lockedAccounts[account] = true;
        emit AccountLocked(account);
    }

    /**
     * @dev Unlocks account.
     */
    function unlockAccount(address account) public onlyOwner {
        require(_lockedAccounts[account], "Account is already unlocked");
        _lockedAccounts[account] = false;
        emit AccountUnlocked(account);
    }

    /**
     * @dev Returns if account is locked.
     */
    function isAccountLocked(address account) public view returns (bool) {
        return _lockedAccounts[account];
    }

    /**
     * @dev Overrides transfer function to check if sender account is locked.
     */
    function _transfer(address sender, address recipient, uint256 amount) internal virtual override onlyUnlocked(sender) {
        super._transfer(sender, recipient, amount);
    }
}
