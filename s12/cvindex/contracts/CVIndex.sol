pragma solidity ^0.4.8;

import "./CVExtender.sol";


contract owned {
    address owner;

    modifier onlyowner() {
        /**
         * Update Exception Handling from Solidity 0.4.13!
         * See: https://vomtom.at/exception-handling-in-solidity/
         * If you have any questions, head over to the course Q&A!
         **/
        require(msg.sender == owner);
        _;
    }

    function owned() public {
        owner = msg.sender;
    }
}

contract mortal is owned {
    function kill() public {
        if (msg.sender == owner)
        selfdestruct(owner);
    }
}

contract CVIndex is mortal {

    uint i_cvindex = 0;

    uint i_cvindex_active = 0;

    struct CV {
    address _address;
    bool _active;
    address _added_by;
    uint _created_at;
    }

    mapping(uint => CV) map_cvs;
    mapping(uint => CV) map_cvs_active;
    mapping(address => uint) addressCVPosition;

    event ProposedCV(uint indexed cvindex, address indexed by, address cvaddress, uint date);
    event ActivatedCV(uint indexed cvindex_active, address cvaddress, uint date);

    function addCV(address cvAddress) public {
        i_cvindex++;
        CVExtender cv_dings = CVExtender(cvAddress);

        /**
         * UPDATED to new Exception Handling.
         * See https://vomtom.at/exception-handling-in-solidity/
         **/
        require(cv_dings.elementsAreSet() == true);

        map_cvs[i_cvindex] = CV(cvAddress, false, msg.sender, now);
        ProposedCV(i_cvindex, msg.sender, cvAddress, now);
        addressCVPosition[cvAddress] = i_cvindex;

    }

    function activateCV(uint cvIndex) public onlyowner {
        map_cvs[cvIndex]._active = true;
        i_cvindex_active++;
        map_cvs_active[i_cvindex_active] = map_cvs[cvIndex];
        ActivatedCV(i_cvindex_active, map_cvs[cvIndex]._address, now);
    }

    function deactivateCV(uint cvIndexActive) public onlyowner {
        if(address(map_cvs_active[cvIndexActive]._address) != 0x0) {
            map_cvs[addressCVPosition[map_cvs_active[cvIndexActive]._address]]._active = false;
            //move the last element over the one here
            map_cvs_active[cvIndexActive] = map_cvs_active[i_cvindex_active];

            //delete the last element
            delete map_cvs_active[i_cvindex_active];
            //make the whole index one element shorter
            i_cvindex_active--;
        }
    }

    function getNumCVs() public view returns (uint) {
        return i_cvindex_active;
    }

    function getAddressAtIndex(uint _index) public view returns (address) {
        assert(map_cvs_active[_index]._active == true);
        return (map_cvs_active[_index]._address);

    }

    function getAddressAtIndexUnconfirmed(uint _index) public view returns (address) {
        return (map_cvs[_index]._address);
    }

    function isCvActive(uint _index) public view returns (bool) {
        return (map_cvs[_index]._active);
    }

}
