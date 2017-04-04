var myWallet = artifacts.require("./MyWallet.sol");

module.exports = function(deployer) {
  deployer.deploy(myWallet);
};
