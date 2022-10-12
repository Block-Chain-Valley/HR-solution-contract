pragma solidity ^0.8.15;

import "./interface/IVote.sol";
import "./interface/IView.sol";

import "./interface/IBVToken.sol";

contract Vote is IVote {
    VoteState public vote;
    address public viewAddr;
    bool public isInitialized = false;
    event Success(bool result);

    function initialize(
        address viewAddr_,
        uint256 totalAudience,
        uint256 rewardPresenter,
        uint256 rewardAudience,
        address[] memory memberList,
        address presenter
    ) external {
        require(isInitialized == false, "Can be Initialized only once");
        VoteState memory voteLocal;

        viewAddr = viewAddr_;
        voteLocal._state = State.Ongoing;
        voteLocal._totalAudience = totalAudience;
        voteLocal._rewardPresenter = rewardPresenter;
        voteLocal._rewardAudience = rewardAudience;
        voteLocal._memberList = memberList;
        voteLocal._presenter = presenter;
        voteLocal._startTime = block.timestamp;
        // TODO: 테스팅 시 시간 확인 필요
        voteLocal._endTime = block.timestamp + 10800;

        vote = voteLocal;
        isInitialized = true;
    }

    function getVote() external returns (VoteState memory) {
        return vote;
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

        if (block.timestamp >= voteLocal._endTime) {
            if (voteLocal._approvedAudience < (voteLocal._totalAudience * 2) / 3) {
                voteLocal._state = State.Rejected;
            }
        } else {
            voteLocal._approvedAudience = voteLocal._approvedAudience + 1;
            emit Success(true);

            address bvTokenAddr = IView(viewAddr).getBVTokenAddress();
            IBVToken(bvTokenAddr).giveReward(msg.sender, voteLocal._rewardAudience);
            if (voteLocal._approvedAudience >= (voteLocal._totalAudience * 2) / 3) {
                IBVToken(bvTokenAddr).giveReward(voteLocal._presenter, voteLocal._rewardPresenter);
                voteLocal._state = State.Approved;
            } else if (voteLocal._approvedAudience < (voteLocal._totalAudience * 2) / 3) {
                voteLocal._state = State.Ongoing;
            }
        }

        vote = voteLocal;
    }
}
