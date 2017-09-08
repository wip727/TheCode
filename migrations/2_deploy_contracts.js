const TheCode = artifacts.require("./TheCode.sol");

module.exports = function(deployer) {
  deployer.deploy(TheCode, 9999, 'DummyToken', 2, 'DT');
};
