var cvindex = artifacts.require("./CVIndex.sol");
var cvextender = artifacts.require("./CVExtender.sol");
var exampleContract = artifacts.require("./MyExampleContract.sol");

contract('CVIndex', function(accounts) {
  it("should be empty at the beginning", function() {
    return cvindex.deployed().then(function(instance) {
      return instance.getNumCVs.call();
    }).then(function(amount_active_cvs) {
      assert.equal(amount_active_cvs, 0, "CVIndex wasn't empty!");
    });
  });

  it("should be possible to add a contract", function() {
    var cvindex_instance;
    return cvindex.deployed().then(function(instance) {
      cvindex_instance = instance;
      return exampleContract.new();
    }).then(function(exampleContractInstance) {
      return cvindex_instance.addCV(exampleContractInstance.address);
    }).then(function(result) {
      assert.equal(result.logs.length, 1, "One Log should be emitted");
      return cvindex_instance.getNumCVs.call();
    }).then(function(num_cvs) {
      assert.equal(num_cvs, 0, "CVIndex wasn't empty!");
      return cvindex_instance.activateCV(1);
    }).then(function(result) {

      assert.equal(result.logs.length, 0, "No Log should be emitted");
      return cvindex_instance.getNumCVs.call();
    }).then(function(num_cvs) {
      assert.equal(num_cvs, 1, "CVIndex wasn't 1!");
    });
  });

});
