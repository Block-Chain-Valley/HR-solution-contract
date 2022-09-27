pragma solidity 0.8.15;

import "./KIP7Mintable.sol";
import "./KIP7Burnable.sol";
import "./KIP7Detailed.sol";

contract TestToken is KIP7Mintable, KIP7Burnable, KIP7Detailed {
    constructor(
        string memory name_,
        string memory symbol_,
        uint8 decimals_
    ) public KIP7Detailed(name_, symbol_, decimals_) {}

    // mint amount of tokens for test
    function mintFor(address for_, uint256 amount_) external {
        _mint(for_, amount_);
    }
}
