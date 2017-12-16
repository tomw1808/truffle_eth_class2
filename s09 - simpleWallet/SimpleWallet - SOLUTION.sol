pragma solidity ^0.4.18;

import "github.com/ethereum/solidity/std/mortal.sol";

contract SimpleWallet is mortal {

    mapping(address => Permission) myAddressMapping;

    struct Permission {
    bool isAllowed;
    uint maxTransferAmount;
    }

    function SimpleWallet() public {
        //Automatically add the creator of the wallet to the permitted senders list. Makes things easier.
        myAddressMapping[msg.sender] = Permission(true, 5000 ether);
    }

    function addAddressToSendersList(address permitted, uint maxTransferAmount) public onlyowner {
        myAddressMapping[permitted] = Permission(true, maxTransferAmount);
    }

    function removeAddressFromSendersList(address theAddress) public onlyowner {
        //a simple delete solves our problem
        delete myAddressMapping[theAddress];
        /**
         * Different solution:
         * myAddressMapping[theAddress].isAllowed = false;
         * */
    }

    function sendFunds(address receiver, uint amountInWei) public {
        require(myAddressMapping[msg.sender].isAllowed);
        require(myAddressMapping[msg.sender].maxTransferAmount >= amountInWei); //the amount in "the bank" must be larger than the amount taken out.
        receiver.transfer(amountInWei);
    }


    function () public payable {}

}
