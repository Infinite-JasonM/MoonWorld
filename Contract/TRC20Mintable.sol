// SPDX-License-Identifier: MIT
// TRC20Mintable.sol
// pragma solidity ^0.5.0;

pragma solidity ^0.5.8;

import "./TRC20.sol";
import "./MinterRole.sol";

/**
 * @dev Extension of {TRC20} that adds a set of accounts with the {MinterRole},
 * which have permission to mint (create) new tokens as they see fit.
 *
 * At construction, the deployer of the contract is the only minter.
 */
contract TRC20Mintable is TRC20, MinterRole {
    /**
     * @dev See {TRC20-_mint}.
     *
     * Requirements:
     *
     * - the caller must have the {MinterRole}.
     */
    function mint(address account, uint256 amount) public onlyMinter returns (bool) {
        _mint(account, amount);
        return true;
    }
}