
//this is the code for deployment of smart contract on hardhat.
const hre = require("hardhat");

async function main() {
  const Upload = await hre.ethers.getContractFactory("Upload");
  const upload = await Upload.deploy();

  await upload.deployed();

  console.log("Library deployed to:", upload.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});

//command to deploy our contract on hardhat:npx hardhat run --network localhost scripts/deploy.js