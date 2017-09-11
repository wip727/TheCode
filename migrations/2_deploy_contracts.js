const TheCode = artifacts.require("./TheCode.sol");
const ItemBank = artifacts.require("./ItemBank.sol");

module.exports = function(deployer) {
  deployer.deploy(TheCode, 9999, 'DummyToken', 2, 'DT');
  deployer.deploy(ItemBank);
};
