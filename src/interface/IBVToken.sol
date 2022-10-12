pragma solidity ^0.8.15;

interface IBVToken {
    function giveReward(address rewardAddress, uint256 reward) external;
}
