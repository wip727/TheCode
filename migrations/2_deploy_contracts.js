const MyToken = artifacts.require("./TheCode.sol");

module.exports = function(deployer) {
  deployer.deploy(MyToken, 9999, 'DummyToken', 2, 'DT');
};
