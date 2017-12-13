# Course Materials for DApp Development with Solidity
This is the official Repository for all the Code you write during our course.

The course can be found here for limited time for $15: https://www.udemy.com/blockchain-developer/?couponCode=REPO15

## Scope
The scope of the Code is to show what you can achieve in Solidity, Ethereum, Web3, Truffle, Ethereum Studio, etc. In Particular:

* demonstrate how to work with the Ethereum Blockchain 
* Web3 
* Listen and react to specific events
* Write Test Cases
* Deploy the DApp
* Work with Remix
* Work with MetaMask
* Work with Truffle and WebPack

## Install Instructions

### Geth
Download geth for your platform from https://geth.ethereum.org/downloads/

#### Geth Mac-OS:
Copy the "geth" file within the download zip into the following folder:

"/usr/local/bin"

### Truffle
Install NodeJS first: https://nodejs.org/en/

Then in the Terminal/PowerShell install Truffle:
```
npm install -g truffle
```

## Known Issues

### Fatal: Error starting protocol stack: listen udp :30303: bind: address already in use
When this pops up using Mist on Mac while opening your private network, then you have to specify the exact path to the ipc file. The exact path is printed when geth is started in the command line!

For GETH:
```
geth attach ipc:/path/to/the/file/geth.ipc
```

For MIST:
```
/Applications/Mist.app/Contents/MacOS/Mist --rpc <path to chaindata>/geth.ipc
```

## Contact
If you run into any problems, don't hesitate to contact us on the course-forum at any time. If you use the forum-search function, there is a high chance that you find the answer to your problem already.
