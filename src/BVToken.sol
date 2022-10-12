// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/extensions/ERC20BurnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/security/PausableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/AccessControlUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

import "./interface/IBVToken.sol";
import "./interface/IView.sol";
import "./interface/IVoteFactory.sol";

contract BVToken is
    Initializable,
    ERC20Upgradeable,
    ERC20BurnableUpgradeable,
    PausableUpgradeable,
    AccessControlUpgradeable,
    IBVToken
{
    bytes32 public constant PAUSER_ROLE = keccak256("PAUSER_ROLE");
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant BURNER_ROLE = keccak256("BURNER_ROLE");

    address public viewAddr;
    address public admin;

    modifier onlyMinter() {
        address voteFactoryAddr = IView(viewAddr).getVoteFactoryAddress();
        bool isVote = IVoteFactory(voteFactoryAddr).isVote(msg.sender);
        require(isVote == true || msg.sender == admin, "ACCESS_DENIED");
        _;
    }

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        // prevents initialization of the implementation contract itself
        _disableInitializers();
    }

    function initialize(address viewAddr_) public initializer {
        __ERC20_init("BVTTest3", "BVTT3");
        __ERC20Burnable_init();
        __Pausable_init();
        __AccessControl_init();

        viewAddr = viewAddr_;
        admin = msg.sender;

        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(PAUSER_ROLE, msg.sender);
        _grantRole(MINTER_ROLE, msg.sender);
    }

    function pause() public onlyRole(PAUSER_ROLE) {
        _pause();
    }

    function unpause() public onlyRole(PAUSER_ROLE) {
        _unpause();
    }

    function burn(uint256 value) public override onlyRole(BURNER_ROLE) {
        super._burn(msg.sender, value);
    }

    function mint(address to, uint256 amount) public onlyMinter {
        _mint(to, amount);
    }

    function multiMint(address[] calldata recipients, uint256[] calldata amounts) external {
        require(recipients.length == amounts.length, "array lengths are not equal");

        for (uint256 i = 0; i < recipients.length; i++) {
            mint(recipients[i], amounts[i]);
        }
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal override whenNotPaused {
        super._beforeTokenTransfer(from, to, amount);
    }

    function giveReward(address rewardAddress, uint256 reward) external {
        mint(rewardAddress, reward);
    }
}
