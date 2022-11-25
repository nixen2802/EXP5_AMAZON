const Amazon_Migrate = artifacts.require("EXP5_AMAZON_BCT");

module.exports = function(deployer) {
  deployer.deploy(Amazon_Migrate);
};