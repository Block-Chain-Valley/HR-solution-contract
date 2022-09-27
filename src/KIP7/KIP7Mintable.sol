pragma solidity 0.8.15;

import "./KIP7.sol";

contract KIP7Mintable is KIP7 {
    function mint(address account, uint256 amount) public returns (bool) {
        _mint(account, amount);
        return true;
    }
}
