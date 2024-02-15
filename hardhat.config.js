require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: {
    version: "0.8.17",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200,
      },
    },
  },
  networks: {
    goerli: {
      url: "https://rpc.ankr.com/eth_goerli",
      chainId: 5,
      accounts: [""],
    },
    mainnet: {
      url: "https://rpc.ankr.com/eth",
      chainId: 1,
      accounts: [""],
    },
    sepolia: {
      url: "https://1rpc.io/sepolia",
      chainId: 11155111,
      accounts: [""],
    },
  },
  etherscan: {
    apiKey: "",
    timeout: 60000, 
  },
};
