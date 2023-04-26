// SPDX-License-Identifier: MIT
// TRC20Burnable.sol
// pragma solidity ^0.5.0;

pragma solidity ^0.5.8;

import "./Context.sol";
import "./TRC20.sol";

/**
 * @dev Extension of {TRC20} that allows token holders to destroy both their own
 * tokens and those that they have an allowance for, in a way that can be
 * recognized off-chain (via event analysis).
 */
contract TRC20Burnable is Context, TRC20 {
    /**
     * @dev Destroys `amount` tokens from the caller.
     *
     * See {TRC20-_burn}.
     */
    function burn(uint256 amount) public {
        _burn(_msgSender(), amount);
    }

    /**
     * @dev See {TRC20-_burnFrom}.
     */
    function burnFrom(address account, uint256 amount) public {
        _burnFrom(account, amount);
    }
}