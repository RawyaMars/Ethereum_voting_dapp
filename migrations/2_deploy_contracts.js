var Election = artifacts.require("./Election.sol");

module.exports = (deployer, network, accounts) => {
const admins=[accounts[0],accounts[1],accounts[2],accounts[3],accounts[4]];
  deployer.deploy(Election,admins);
};
