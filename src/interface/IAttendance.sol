pragma solidity ^0.8.15;

interface IAttendance {
    // enum AttendanceState {
    //     Absent,
    //     Late,
    //     Attend
    // }

    // function getAttendance(address member, uint256 date) public view returns (attendanceStatus);

    function setAttendance(
        address member,
        string memory state,
        uint256 date
    ) external;
}
