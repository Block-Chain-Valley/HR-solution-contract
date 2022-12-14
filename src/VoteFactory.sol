//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.15;

import "./interface/IVoteFactory.sol";
import "./Vote.sol";

contract VoteFactory is IVoteFactory {
    address viewAddr;
    // 투표 index -> 투표 컨트랙트 주소
    mapping(uint256 => address) public getVote;
    // 투표 컨트랙트 주소 => 컨트랙 존재 유무 //
    mapping(address => bool) public isVote;
    address[] public allVotes;
    address public admin;

    // event PairCreated(address indexed token0, address indexed token1, address pair, uint256);

    constructor(address viewAddr_) {
        admin = msg.sender;
        viewAddr = viewAddr_;
    }

    modifier onlyAdmin() {
        require(admin == msg.sender, "ACCESS_DENIED");
        _;
    }

    function setAdmin() private onlyAdmin {
        admin = msg.sender;
    }

    function setViewAddr(address newViewAddr) external onlyAdmin {
        viewAddr = newViewAddr;
    }

    function allVotesLength() external returns (uint256 length) {
        length = allVotes.length;
    }

    function createVote(
        uint256 totalAudience,
        uint256 rewardPresenter,
        uint256 rewardAudience,
        address[] memory memberList,
        address presenter,
        uint256 date
    ) external {
        address voteAddr;
        bytes memory bytecode = type(Vote).creationCode;
        bytes32 salt = keccak256(abi.encodePacked(date));
        assembly {
            voteAddr := create2(0, add(bytecode, 32), mload(bytecode), salt)
        }

        IVote(voteAddr).initialize(viewAddr, totalAudience, rewardPresenter, rewardAudience, memberList, presenter);

        getVote[date] = voteAddr;
        isVote[voteAddr] = true;
        allVotes.push(voteAddr);

        // emit VoteCreated();
    }

    function getVoteAddress(uint256 date) external returns (address) {
        return getVote[date];
    }
}
