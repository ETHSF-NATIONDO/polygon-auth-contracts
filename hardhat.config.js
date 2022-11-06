require('dotenv').config();
require("@nomiclabs/hardhat-truffle5")
require("@nomiclabs/hardhat-ethers")
require("hardhat-deploy")

module.exports = {
  solidity: "0.8.17",
  networks: {
    mumbai: {
      url: `${process.env.ALCHEMY_MUMBAI_URL}`,
      accounts: [`0x${process.env.MUMBAI_PRIVATE_KEY}`],
    }
  },
  etherscan: {
    apiKey: process.env.POLYGONSCAN_API_KEY
  },
};
