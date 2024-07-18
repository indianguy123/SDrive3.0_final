require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.9",
  networks: {
    hardhat: {
      chainId: 1337,
    },
  },
  paths: {
    artifacts: "./client/src/artifacts",//this is the address where everytime we compile our contract, then it will store the abi and bytecode at desired location.
  },
};

//to install Hardhat::npm i --save-dev hardhat
//then  do::npx hardhat,then select JS project.then install extra dependcies recommended by hardhat.
//to run local blockchain::npx hardhat node 
//command to deploy our contract on hardhat:npx hardhat run --network localhost scripts/deploy.js