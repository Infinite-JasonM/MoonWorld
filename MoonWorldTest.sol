// SPDX-License-Identifier: MIT
// MoonWorldTest.sol

pragma solidity ^0.8.19;

import "./TRC20.sol";

/**
 * @title MoonWorldTest
 * @dev TRC20 token with lockable and owner functionalities
 */
contract MoonWorldTest is TRC20 {
    mapping(address => bool) private _lockedAccounts;
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
    event AccountLocked(address indexed account, bool locked);

    constructor(uint256 initialSupply) TRC20("MoonWorldTest", "MWT") {
        _owner = msg.sender;
        _mint(msg.sender, initialSupply);
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(msg.sender == _owner, "MoonWorldTest: caller is not the owner");
        _;
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0), "MoonWorldTest: new owner is the zero address");
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }

    /**
     * @dev Gets the current owner of the contract.
     * @return An address representing the owner of the contract.
     */
    function owner() public view returns (address) {
        return _owner;
    }

    /**
     * @dev Locks or unlocks the account. 
     * Can only be called by the current owner.
     */
    function lockAccount(address account, bool locked) public onlyOwner {
        emit AccountLocked(account, locked);
        _lockedAccounts[account] = locked;
    }

    /**
     * @dev Returns whether the account is locked or not.
     * @return A boolean indicating whether the account is locked or not.
     */
    function isLocked(address account) public view returns (bool) {
        return _lockedAccounts[account];
    }

    /**
     * @dev Overrides the transfer function to add lockable feature.
     */
    function _transfer(address sender, address recipient, uint256 amount) internal virtual override {
        require(!_lockedAccounts[sender], "MoonWorldTest: account is locked");
        super._transfer(sender, recipient, amount);
    }
}

/**
 * @dev Approve the passed address to spend the specified amount of tokens on behalf of msg.sender.
 * @param spender The address which will spend the funds.
 * @param amount The amount of tokens to be spent.
 * @return A boolean value indicating whether the operation succeeded.
 */
function approve(address spender, uint256 amount) public virtual override returns (bool) {
    _approve(msg.sender, spender, amount);
    return true;
}

/**
 * @dev Function to check the amount of tokens that an owner has allowed to a spender.
 * @param owner The address which owns the funds.
 * @param spender The address which will spend the funds.
 * @return The number of tokens still available for the spender.
 */
function allowance(address owner, address spender) public view virtual override returns (uint256) {
    return _allowances[owner][spender];
}

/**
 * @dev Increase the amount of tokens that an owner has allowed to a spender.
 *
 * This method should be used instead of {approve} to avoid the double approval vulnerability
 * described in https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
 * The function emits an {Approval} event indicating the updated allowance.
 *
 * @param spender The address which will spend the funds.
 * @param addedValue The amount of tokens to increase the allowance by.
 */
function increaseAllowance(address spender, uint256 addedValue) public virtual returns (bool) {
    _approve(msg.sender, spender, _allowances[msg.sender][spender] + addedValue);
    return true;
}

/**
 * @dev Decrease the amount of tokens that an owner has allowed to a spender.
 *
 * This method should be used instead of {approve} to avoid the double approval vulnerability
 * described in https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
 * The function emits an {Approval} event indicating the updated allowance.
 *
 * @param spender The address which will spend the funds.
 * @param subtractedValue The amount of tokens to decrease the allowance by.
 */
function decreaseAllowance(address spender, uint256 subtractedValue) public virtual returns (bool) {
    uint256 currentAllowance = _allowances[msg.sender][spender];
    require(currentAllowance >= subtractedValue, "TRC20: decreased allowance below zero");
    _approve(msg.sender, spender, currentAllowance - subtractedValue);
    return true;
}

/**
 * @dev Moves tokens `amount` from `sender` to `recipient`.
 *
 * This is internal function is equivalent to {transfer}, and can be used to e.g.
 * implement automatic token fees, slashing mechanisms, etc.
 *
 * Emits a {Transfer} event.
 *
 * Requirements:
 *
 * - `sender` cannot be the zero address.
 * - `recipient` cannot be the zero address.
 * - `sender` must have a balance of at least `amount`.
 */
function _transfer(address sender, address recipient, uint256 amount) internal virtual override {
    require(!_lockedAccounts[sender], "MoonWorldTest: account is locked");
    super._transfer(sender, recipient, amount);
}
