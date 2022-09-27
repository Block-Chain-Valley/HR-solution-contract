pragma solidity 0.8.15;

import "./KIP7.sol";

contract KIP7Burnable is KIP7 {
    function burn(uint256 amount) public {
        _burn(msg.sender, amount);
    }

    function burnFrom(address account, uint256 amount) public {
        _burnFrom(account, amount);
    }
}
