const { artifacts } = require('truffle');

const KryptoBird = artifacts.require('Kryptobird');

module.exports = function(deployer) {
  deployer.deploy(KryptoBird);
}