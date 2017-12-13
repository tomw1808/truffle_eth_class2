// Import the page's CSS. Webpack will know what to do with it.
import "../stylesheets/app.css";

import Bootstrap from 'bootstrap/dist/css/bootstrap.css';

// Import libraries we need.
import { default as Web3} from 'web3';
import { default as contract } from 'truffle-contract'

// Import our contract artifacts and turn them into usable abstractions.
import mywallet_artifacts from '../../build/contracts/MyWallet.json'

// MetaCoin is our usable abstraction, which we'll use through the code below.
var MyWallet = contract(mywallet_artifacts);

// The following code is simple to show off interacting with your contracts.
// As your needs grow you will likely need to change its form and structure.
// For application bootstrapping, check out window.addEventListener below.
var accounts;
var account;
var e_receivedFunds;
var e_proposalReceived;
var e_sendMoneyPlain;

window.App = {
  start: function() {
    var self = this;

    // Bootstrap the MetaCoin abstraction for Use.
    MyWallet.setProvider(web3.currentProvider);

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

      self.listenToEvents();
      self.setAddressList();
      self.updateWalletBalance();
    });
  },

  setAddressList: function() {
    document.getElementById("addresses").innerHTML = accounts.join("<br/>");

  },
  setStatus: function(message) {
    var status = document.getElementById("status");
    status.innerHTML = message;
  },
  updateWalletBalance: function() {
    MyWallet.deployed().then(function(instance) {

      document.getElementById("walletAddress").innerHTML = instance.address;
      document.getElementById("walletEther").innerHTML = web3.eth.getBalance(instance.address);
    })
  },

  listenToEvents: function() {
    var self = this;

    var meta;
    MyWallet.deployed().then(function(instance) {
      meta = instance;
      e_receivedFunds = meta.receivedFunds().watch(function(error, event) {
        console.log(event);
      });
      e_proposalReceived = meta.proposalReceived().watch(function(error, event) {
        console.log(event);
      });
      e_sendMoneyPlain = meta.sendMoneyPlain().watch(function(error, event) {
        console.log(event);
      });

    });
  },

  submitTransaction: function() {
    var self = this;

    var amount = parseInt(document.getElementById("amount").value);
    var receiver = document.getElementById("to").value;
    var reason = document.getElementById("reason").value;

    this.setStatus("Initiating transaction... (please wait)");

    var wallet;
    MyWallet.deployed().then(function(instance) {
      wallet = instance;
      return wallet.spendMoneyOn(receiver, web3.toWei(amount, 'finney'), reason, {from: accounts[1], gas: 500000});
    }).then(function() {
      self.setStatus("Transaction complete!");
    }).catch(function(e) {
      console.log(e);
      self.setStatus("Error sending coin; see log.");
    });
  },

  submitEtherToWallet: function() {
    var self = this;
    MyWallet.deployed().then(function(instance) {

      return instance.sendTransaction({from: accounts[0], value: web3.toWei(5, "ether"), to: instance.address});
    }).then(function() {
      self.updateWalletBalance();
    })
  }
};

window.addEventListener('load', function() {
  // Checking if Web3 has been injected by the browser (Mist/MetaMask)
  if (typeof web3 !== 'undefined') {
    console.warn("Using web3 detected from external source. If you find that your accounts don't appear or you have 0 MetaCoin, ensure you've configured that source properly. If using MetaMask, see the following link. Feel free to delete this warning. :) http://truffleframework.com/tutorials/truffle-and-metamask")
    // Use Mist/MetaMask's provider
    window.web3 = new Web3(web3.currentProvider);
  } else {
    console.warn("No web3 detected. Falling back to http://localhost:9545. You should remove this fallback when you deploy live, as it's inherently insecure. Consider switching to Metamask for development. More info here: http://truffleframework.com/tutorials/truffle-and-metamask");
    // fallback - use your fallback strategy (local node / hosted node + in-dapp id mgmt / fail)
    window.web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:9545"));
  }

  App.start();
});
