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
* Work with MIST
* Work with Truffle and WebPack

## Install Instructions

Developing for Ethereum is sometimes frustrating, because things change at fast pace. If something does not work as described here, please:

### Update October 2017
On all platforms it should be easier to install truffle now. The truffle team has put together a package that doesn't need compilation:
```
npm install -g truffle
npm install -g ethereumjs-testrpc
```

All code should be updated to the Solidity Version 0.4.15 and works with Truffle 3.4.11.

### Update End

### General

1. try a google search as you are 100% not alone with your problem
2. inform the instructors of the course so they can correct the problem
3. if you have the time, it would be awesome if you'd make a pull-request here

### Windows

~~1. Download Python:~~
 https://www.python.org/downloads/release/python-2712/

~~2. .Net Packages~~
 https://www.microsoft.com/en-US/download/details.aspx?id=49982

 https://www.microsoft.com/en-us/download/details.aspx?id=30653

~~3. SSL~~
 https://slproweb.com/products/Win32OpenSSL.html

~~4. and eventually you also need the Visual Studio, because of the C++ Compiler:~~
 https://www.visualstudio.com/vs/

 After downloading the Visual Studio make sure to open one time _a new c++ project_.

5. Install the Git-Bash as it comes with a mingw:
 https://git-scm.com/downloads

6. Install NodeJS and the Node Package Manager (NPM)
 https://nodejs.org/en/download/

7. Install Truffle and TestRPC
 npm install -g truffle
 npm install -g ethereumjs-testrpc

### Ubuntu

~~1. Install necessary packages:~~
```
sudo apt-get update && sudo apt-get upgrade
sudo apt-get install curl git vim build-essential
```

2. Install NodeJS and NPM
```
 curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
 sudo apt-get install -y nodejs
 sudo npm install -g express
```

3. Install Truffle and TestRPC
 npm install -g truffle
 npm install -g ethereumjs-testrpc
### Mac

1. Install node
https://nodejs.org/en/download/

~~2. Install a c++ compiler which typically comes with xCode.~~

3. Install truffle from the command line **as root/systems administrator**
```
npm install -g truffle
npm install -g ethereumjs-testrpc
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

### Error when running truffle test/migrate

If something like this pops up:
```
dependency_path = source.resolve_dependency_path(import_path, dependency_path);
```

or

```
/usr/lib/node_modules/truffle/node_modules/truffle-compile/profiler.js:120
        if (ancestors.length > 0) {
                     ^

TypeError: Cannot read property 'length' of undefined
    at walk_from (/usr/lib/node_modules/truffle/node_modules/truffle-compile/profiler.js:120:22)

```

then try to install truffle 3.1.9:

```
npm install -g truffle@3.1.9
```

### Error when installing truffle

Something like

 `... receive errors including "MSBUILD : error MSB3428: Could not load the Visual C++ component "VCBuild.exe".`

or

`... node_modules\truffle\node_modules\sha3\build\sha3.vcxproj(20,3): error MSB4019: The imported project "C:\Microsoft.Cpp.Default.props" was not found. Confirm that the path in the <Import> declaration is correct, and that the file exists on disk.".  `

When you have installed Visual Studio, make sure you have opened a c++ project once.

Then try `npm config set msvs_version 2015 --global` and in addition you can try to install the ms-build tools:
```
npm install --global --production windows-build-tools
```

### Geth Attach


On Windows its simply possible to do a `geth attach`, but on MacOS it seems that you need to provide the actual ipc file. `geth --datadir /media/user/sdcard/chaindata --ipcpath $HOME/.ethereum/geth.ipc console` which is a problem posed here: http://ethereum.stackexchange.com/questions/4472/port-30303-error-in-mist-when-i-run-geth-with-a-different-datadir


### Private Network
The way the private network is initialized changed in the past months and seems to keep changing. For better information on it, it is advised to directly see the correct instructions on:
https://github.com/ethereum/go-ethereum

_Usually_ it should work with:
```
geth init path/to/genesis.json --datadir=/path/to/some/folder
```


### Solidity Compilation Errors/Warnings
Solidity is in active maintenance and things change _all the time_! The code throughout the course was written for the current version (at the time this Readme was written) 0.4.8.

Any Solidity Program can be "forced" to use another compiler version (older one) by using as _first line in your program_
`pragma solidity ^0.4.0;` for version 0.4.0, change it to whatever version you might need.

The code here is updated to work with solidity 0.4.15.


## Contact
If you run into any problems, don't hesitate to contact us on the course-forum at any time. If you use the forum-search function, there is a high chance that you find the answer to your problem already.
