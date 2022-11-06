async function main() {
  const verifierContract = "DorseContract";
  const verifierName = "Dorse";
  const DorseContract = await ethers.getContractFactory(verifierContract);
  const dorseContract = await DorseContract.deploy(
    verifierName
  );

  await dorseContract.deployed();
  console.log(dorseContract);
}
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
