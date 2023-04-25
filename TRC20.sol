// SPDX-License-Identifier: MIT
// TRC20.sol

pragma solidity ^0.8.19;

import "./ITRC20.sol";
import "./SafeMath.sol";

/**
 * @title TRC20 token contract
 * @dev Implementation of the basic standard token.
 */
contract TRC20 is ITRC20 {
    using SafeMath for uint256;

    mapping (address => uint256) private _balances;
    mapping (address => mapping (address => uint256)) private _allowances;

    uint256 private _totalSupply;
    string private _name;
    string private _symbol;
    uint8 private _decimals;

    /**
     * @dev Constructor for TRC20 token contract
     * @param name The name of the token
     * @param symbol The symbol of the token
     * @param decimals The number of decimals for the token
     * @param totalSupply The initial supply of tokens
     */
    constructor(string memory name, string memory symbol, uint8 decimals, uint256 totalSupply) {
        _name = name;
        _symbol = symbol;
        _decimals = decimals;
        _totalSupply = totalSupply;
        _balances[msg.sender] = totalSupply;
        emit Transfer(address(0), msg.sender, totalSupply);
    }

    /**
     * @dev Returns the name of the token.
     */
    function name() public view returns (string memory) {
        return _name;
    }

    /**
     * @dev Returns the symbol of the token.
     */
    function symbol() public view returns (string memory) {
        return _symbol;
    }

    /**
     * @dev Returns the number of decimals for the token.
     */
    function decimals() public view returns (uint8) {
        return _decimals;
    }

    /**
     * @dev Returns the total supply of the token.
     */
    function totalSupply() public view override returns (uint256) {
        return _totalSupply;
    }

    /**
     * @dev Returns the balance of the specified address.
     * @param owner The address to query the balance of.
     */
    function balanceOf(address owner) public view override returns (uint256) {
        return _balances[owner];
    }

    /**
     * @dev Transfers tokens for a specified address.
     * @param to The address to transfer to.
     * @param value The amount to be transferred.
     */
    function transfer(address to, uint256 value) public override returns (bool) {
        require(to != address(0), "TRC20: transfer to the zero address");
        require(value <= _balances[msg.sender], "TRC20: insufficient balance");

        _balances[msg.sender] = _balances[msg.sender].sub(value);
        _balances[to] = _balances[to].add(value);
        emit Transfer(msg.sender, to, value);
        return true;
    }

    /**
     * @dev Returns the amount of tokens that an owner allowed to a spender.
     * @param owner The address which owns the funds.
     * @param spender The address which will spend the funds.
     */
    function allowance(address owner, address spender) public view override returns (uint256) {
        return _allowances[owner][spender];
    }

    /**
     * @dev Approve the passed address to spend the specified amount of tokens on behalf of msg.sender.
     * @param spender The address which will spend the funds.
     * @param value The amount of tokens on behalf of msg.sender.
     * @return True if the operation was successful.
     */
    function approve(address spender, uint256 value) public virtual override returns (bool) {
    _approve(msg.sender, spender, value);
    return true;
    }

    /**
    * @dev Transfers tokens from one address to another.
    * @param from The address which you want to send tokens from.
    * @param to The address which you want to transfer to.
    * @param value The amount of tokens to be transferred.
    * @return A boolean that indicates whether the operation was successful.
    */
    function transferFrom(address from, address to, uint256 value) public override returns (bool) {
        require(to != address(0), "TRC20: transfer to the zero address");
        require(value <= _balances[from], "TRC20: insufficient balance");
        require(value <= _allowances[from][msg.sender], "TRC20: insufficient allowance");

        _balances[from] = _balances[from].sub(value);
        _balances[to] = _balances[to].add(value);
        _allowances[from][msg.sender] = _allowances[from][msg.sender].sub(value);
        emit Transfer(from, to, value);
        return true;
    }

    /**
    * @dev Internal function to approve the passed address to spend the specified amount of tokens on behalf of msg.sender.
    * @param owner The address which owns the funds.
    * @param spender The address which will spend the funds.
    * @param value The amount of tokens on behalf of msg.sender.
    */
    function _approve(address owner, address spender, uint256 value) internal virtual {
    require(owner != address(0), "TRC20: approve from the zero address");
    require(spender != address(0), "TRC20: approve to the zero address");
    _allowances[owner][spender] = value;
    emit Approval(owner, spender, value);
    }

    /**
    * @dev Internal function called before any token transfer.
    * This function can be used to enforce a specific business logic.
    * For example, requiring certain conditions to be met for a transfer to occur.
    *
    * The default implementation is empty.
    */
    function _beforeTokenTransfer(address from, address to, uint256 amount) internal virtual { }

    /**
    * @dev Internal function called after any token transfer.
    * This function can be used to enforce a specific business logic.
    * For example, requiring certain conditions to be met for a transfer to occur.
    *
    * The default implementation is empty.
    */
    function _afterTokenTransfer(address from, address to, uint256 amount) internal virtual { }
}