// Import the page's CSS. Webpack will know what to do with it.
import "../stylesheets/app.css";

// Import libraries we need.
import { default as Web3} from 'web3';
import { default as contract } from 'truffle-contract'

// Import our contract artifacts and turn them into usable abstractions.
import cv_extender_artifact from '../../build/contracts/CVExtender.json'
import cv_index_artifact from '../../build/contracts/CVIndex.json'

// MetaCoin is our usable abstraction, which we'll use through the code below.
var CVExtender = contract(cv_extender_artifact);
var CVIndex = contract(cv_index_artifact);

// The following code is simple to show off interacting with your contracts.
// As your needs grow you will likely need to change its form and structure.
// For application bootstrapping, check out window.addEventListener below.
var accounts;
var account;

window.App = {
  start: function() {
    var self = this;

    // Bootstrap the MetaCoin abstraction for Use.
    CVExtender.setProvider(web3.currentProvider);
    CVIndex.setProvider(web3.currentProvider);

    // Get the initial account balance so it can be displayed.
    web3.eth.getAccounts(function(err, accs) {
      if (err != null) {
        alert("There was an error fetching your accounts.");
        return;
      }

      if (accs.length == 0) {
        alert("Couldn't get any accounts! Make sure your Ethereum client is configured correctly.");
        return;
      }

      accounts = accs;
      account = accounts[0];

      self.refreshBalance();
    });
  },


  refreshBalance: function() {
    var self = this;

    var cvIndex;
    CVIndex.deployed().then(function(instance) {
      cvIndex = instance;
      return cvIndex.getNumCVs.call({from: account});
    }).then(function(value) {
      var balance_element = document.getElementById("activeCVs");
      balance_element.innerHTML = value;
    }).catch(function(e) {
      console.error(e);
    });
  },

  addCV: function() {
    var self = this;

    var new_cv_address = document.getElementById("address").value;

    var cvindex;
    CVIndex.deployed().then(function(instance) {
      cvindex = instance;
      console.log(new_cv_address);
      return cvindex.addCV(new_cv_address,{from: account});
    }).then(function(result) {
      console.log(result);
      self.refreshBalance();
    }).catch(function(e) {
      console.error(e);
    });
  },

  activateCV: function(cv_index) {
    var self = this;
    var cvindex_instance;
    CVIndex.deployed().then(function(instance) {
      cvindex_instance = instance;
      return cvindex_instance.activateCV(cv_index,{from: account});
    }).then(function(result) {
      self.refreshBalance();
    }).catch(function(e) {
      console.error(e);
    });
  },

  listenProposed: function() {
    CVIndex.deployed().then(function(instance) {
      var cvextender_instance_global;
      var cvindex_instance;
      var _author;

      var _address;
      var _about;
      document.getElementById("submitted").innerHTML = '';
      return instance.ProposedCV({by:account.address},{fromBlock:0, toBlock:'latest'}).watch(function(error, result) {
        CVExtender.at(result.args.cvaddress).then(function(cvextender_instance) {
          cvextender_instance_global = cvextender_instance;
          return cvextender_instance.getAuthor();
        }).then(function(author) {
          _author = author;
          return cvextender_instance_global.getAddress();
        }).then(function(address) {
          _address = address;
          return cvextender_instance_global.getTitle();
        }).then(function(title) {
          _about = title;
          return instance.isCvActive(result.args.cvindex);
        }).then(function(is_active) {
          document.getElementById("submitted").innerHTML += '<a href="'+_address+'" target="_blank">'+_about+'</a> by '+_author[0]+" - "+_author[1]+" [active:"+is_active+"]";
        });
      });
    })
  },

  listNotActive: function() {
    CVIndex.deployed().then(function(instance) {
      document.getElementById("noActive").innerHTML = '';
      return instance.ProposedCV({},{fromBlock:0, toBlock:'latest'}).get(function(error, result) {
        for(var i = result.length-1; i >= 0; i--) {
          var cur_result = result[i];
          App.listNotActiveInner(cur_result);
        }
      });
    })
  },
  listNotActiveInner: function(result) {
    CVIndex.deployed().then(function(instance) {
      var cvextender_instance_global;
      var _author;

      var _address;
      var _about;
      CVExtender.at(result.args.cvaddress).then(function (cvextender_instance) {
        cvextender_instance_global = cvextender_instance;
        return cvextender_instance.getAuthor();
      }).then(function (author) {
        _author = author;
        return cvextender_instance_global.getAddress();
      }).then(function (address) {
        _address = address;
        return cvextender_instance_global.getTitle();
      }).then(function (title) {
        _about = title;
        return instance.isCvActive(result.args.cvindex);
      }).then(function (is_active) {
        if (!is_active) {
          document.getElementById("noActive").innerHTML += '<a href="' + _address + '" target="_blank">' + _about + '</a> by ' + _author[0] + " - " + _author[1] + " [active:" + is_active + "] <button onclick='App.activateCV(" + result.args.cvindex + ")'>Activate</button><br />";
        }
      });
    });
  },
  listActive: function() {
    var cvindex_instance;
    var _num_cvs;

    CVIndex.deployed().then(function(instance) {
      cvindex_instance = instance;
      return instance.getNumCVs();
    }).then(function(num_cvs) {
      for(var i = num_cvs; i >= 1; i--) {
        cvindex_instance.getAddressAtIndex(i).then(function(cvaddress) {

          var _author;
          var _address;
          var _about;
          var _description;
          var cvextender_instance_global;
          CVExtender.at(cvaddress).then(function (cvextender_instance) {
            cvextender_instance_global = cvextender_instance;
            return cvextender_instance.getAuthor();
          }).then(function (author) {
            _author = author;
            return cvextender_instance_global.getAddress();
          }).then(function (address) {
            _address = address.replace(/[^a-z0-9:/?\s.,-_]/gi,"*hidden*");
            return cvextender_instance_global.getDescription();
          }).then(function (description) {
            _description = description.replace(/[^a-z0-9:/?\s.,-_@]/gi,"*hidden*");
            return cvextender_instance_global.getTitle();
          }).then(function (title) {
            _about = title.replace(/[^a-z0-9:/?\s.,-_@]/gi,"*hidden*");
            document.getElementById("submitted").innerHTML += '<h3><a href="' + _address + '" target="_blank">' + _about + '</a></h3><p>'+_description+'</p><p><small> ' + _author[0].replace(/[^a-z0-9:/?\s@.,]/gi,"*hidden*") + " - " + _author[1].replace(/[^a-z0-9:/?\s@.,]/gi,"*hidden*") + "</small></p><hr/><br />";
          });
        })
      }
    });
  }
};

window.addEventListener('load', function() {
  // Checking if Web3 has been injected by the browser (Mist/MetaMask)
  if (typeof web3 !== 'undefined') {
    console.warn("Using web3 detected from external source. If you find that your accounts don't appear or you have 0 MetaCoin, ensure you've configured that source properly. If using MetaMask, see the following link. Feel free to delete this warning. :) http://truffleframework.com/tutorials/truffle-and-metamask")
    // Use Mist/MetaMask's provider
    window.web3 = new Web3(web3.currentProvider);
  } else {
    console.warn("No web3 detected. Falling back to http://localhost:8545. You should remove this fallback when you deploy live, as it's inherently insecure. Consider switching to Metamask for development. More info here: http://truffleframework.com/tutorials/truffle-and-metamask");
    // fallback - use your fallback strategy (local node / hosted node + in-dapp id mgmt / fail)
    window.web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"));
  }

  App.start();
});
