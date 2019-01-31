pragma solidity ^0.5.0;

//the contract disappeared from the web. I manually added it below
//import "github.com/ethereum/solidity/std/mortal.sol";

contract owned {
    address payable owner;

    modifier onlyowner() {
        if (msg.sender == owner) {
            _;
        }
    }

    constructor() public {
        owner = msg.sender;
    }
}

contract mortal is owned {
    function kill() public {
        if (msg.sender == owner)
            selfdestruct(owner);
    }
}

contract SimpleWallet is mortal {

    mapping(address => Permission) myAddressMapping;

    struct Permission {
        bool isAllowed;
        uint maxTransferAmount;
    }

    function addAddressToSendersList(address permitted, uint maxTransferAmount) public onlyowner {
        myAddressMapping[permitted] = Permission(true, maxTransferAmount);
    }

    function sendFunds(address payable receiver, uint amountInWei) public {
        require(myAddressMapping[msg.sender].isAllowed);
        require(myAddressMapping[msg.sender].maxTransferAmount <= amountInWei);
        receiver.transfer(amountInWei);
    }


    function () external payable {}

}
