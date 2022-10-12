pragma solidity ^0.8.15;

interface IBVToken {
    function Attendance(
        address member,
        uint256 amount,
        string memory state,
        uint256 date
    ) external;

    function giveReward(address rewardAddress, uint256 reward) external;
}
