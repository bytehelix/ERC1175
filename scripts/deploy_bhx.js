const { ethers } = require("hardhat");
let tx;

const main = async () => {
  [deployer] = await ethers.getSigners();
  
  const NumberCalculatorFactory = await ethers.getContractFactory("NumberCalculator", deployer);
  const NumberCalculator = await NumberCalculatorFactory.deploy();
  await NumberCalculator.deployed();
  console.log("=> NumberCalculator =", NumberCalculator.address);
  const ByteHelixFactory = await ethers.getContractFactory("ByteHelix", {
    signer:deployer,
    libraries: {
        NumberCalculator: NumberCalculator.address,
    }
  });
  const ByteHelix = await ByteHelixFactory.deploy();
  await ByteHelix.deployed();
  console.log("=> ByteHelix =", ByteHelix.address, "owner =", await ByteHelix.owner());
};

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
