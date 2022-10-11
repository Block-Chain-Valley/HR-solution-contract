import { HardhatRuntimeEnvironment } from "hardhat/types";
import { DeployFunction } from "hardhat-deploy/types";
import { View } from "../../../typechain";
import { wallet } from "../../../scripts/provider";
import { ethers } from "hardhat";

const func: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
    const { deployments, getNamedAccounts } = hre;
    const { deploy } = deployments;
    const { deployer } = await getNamedAccounts();

    // 배포 및 세팅 순서: View 컨트랙트 -> Voting 관련 컨트랙트 -> View에 각 컨트랙트 주소 저장

    const View = await deploy("View", {
        contract: "View",
        from: deployer,
        args: [],
        log: true,
        autoMine: true,
    });

    console.log("View 컨트랙트 배포 완료 🚀");

    const VoteFactory = await deploy("VoteFactory", {
        contract: "VoteFactory",
        from: deployer,
        args: [View.address],
        log: true,
        autoMine: true,
    });

    console.log("VoteFactory 컨트랙트 배포 완료 🚀");

    const view = (await ethers.getContractAt(View.abi, View.address)).connect(wallet) as View;
    await (await view.setVoteFactoryAddress(VoteFactory.address)).wait();

    console.log("View setVoteFactory 완료 🚀");
};

export default func;

func.tags = ["deploy_contract"];
