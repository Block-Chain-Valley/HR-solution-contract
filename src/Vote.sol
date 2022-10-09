pragma solidity ^0.8.15;

import "./interface/IVote.sol";

// struct VoteState {
//         State _state;
//         uint256 _totalAudience;
//         uint256 _approvedAudience;
//         uint256 _startTime;
//         uint256 _endTime;
//         uint256 _rewardPresenter;
//         uint256 _rewardAudience;
//         address[] _memberList;
//         address _presenter;
//     }

contract Vote is IVote {
    VoteState vote;
    bool isInitialized = false;
    event Success(bool result);

    function initialize(
        uint256 totalAudience,
        uint256 rewardPresenter,
        uint256 rewardAudience,
        address[] memory memberList,
        address presenter
    ) external {
        require(isInitialized == false, "Can be Initialized only once");
        VoteState memory voteLocal;

        voteLocal._state = State.Ongoing;
        voteLocal._totalAudience = totalAudience;
        voteLocal._rewardPresenter = rewardPresenter;
        voteLocal._rewardAudience = rewardAudience;
        voteLocal._memberList = memberList;
        voteLocal._presenter = presenter;
        voteLocal._startTime = block.timestamp;
        // TODO: 테스팅 시 시간 확인 필요
        voteLocal._endTime = block.timestamp + 300;

        vote = voteLocal;
        isInitialized = true;
    }

    function voteAudience() external {
        VoteState memory voteLocal = vote;
        uint256 memberListLength = voteLocal._memberList.length;
        bool isInMemberList = false;

        for (uint256 i = 0; i < memberListLength; i += 1) {
            if (voteLocal._memberList[i] == msg.sender) {
                isInMemberList = true;
                break;
            }
        }

        if (isInMemberList == false) {
            emit Success(false);
            revert("msg.sender must be audience");
        }
        require(block.timestamp <= voteLocal._endTime, "vote finished");

        voteLocal._approvedAudience = voteLocal._approvedAudience + 1;
        emit Success(true);

        // TODO: 토큰 컨트랙트 구현 후 추가 필요
        // BvTokenContractInstance.giveReward(msg.sender, voteLocal._rewardAudience);
        if (voteLocal._approvedAudience == (voteLocal._totalAudience * 2) / 3) {
            // BvTokenContractInstance.giveReward(voteLocal._presenter, voteLocal._rewardPresenter);
        }

        vote = voteLocal;
    }
}
