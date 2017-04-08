pragma solidity ^0.4.8;

import "./CVExtender.sol";

contract owned {
    address owner;

    modifier onlyowner() {
        if (msg.sender == owner) {
            _;
        }
    }

    function owned() {
        owner = msg.sender;
    }
}

contract mortal is owned {
    function kill() {
        if (msg.sender == owner)
            selfdestruct(owner);
    }
}

contract CVIndex is mortal {
    
    uint cvindex = 0;
    
    uint cvindex_active = 0;
    
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

    function addCV(address cvAddress) {
        cvindex++;
        CVExtender cv_dings = CVExtender(cvAddress);
        if(cv_dings.elementsAreSet()) {
            map_cvs[cvindex] = CV(cvAddress, false, msg.sender, now);
            ProposedCV(cvindex, msg.sender, cvAddress, now);
            addressCVPosition[cvAddress] = cvindex;
        } else {
           throw;
        }
    }
    
    function activateCV(uint cvIndex) onlyowner {
        map_cvs[cvIndex]._active = true;
        cvindex_active++;
        map_cvs_active[cvindex_active] = map_cvs[cvIndex];
        ActivatedCV(cvindex_active, map_cvs[cvIndex]._address, now);
    }
    
    function deactivateCV(uint cvIndexActive) onlyowner {
        if(address(map_cvs_active[cvIndexActive]._address) != 0x0) {
            map_cvs[addressCVPosition[map_cvs_active[cvIndexActive]._address]]._active = false;
            //move the last element over the one here
            map_cvs_active[cvIndexActive] = map_cvs_active[cvindex_active];

            //delete the last element
            delete map_cvs_active[cvindex_active];
            //make the whole index one element shorter
            cvindex_active--;
        }
    }
    
    function getNumCVs() constant returns (uint) {
        return cvindex_active;
    }
    
    function getAddressAtIndex(uint _index) constant returns (address) {
        if(map_cvs_active[_index]._active) {
            return (map_cvs_active[_index]._address);
        }
        throw;
    }

    function getAddressAtIndexUnconfirmed(uint _index) constant returns (address) {
        return (map_cvs[_index]._address);
    }
    function isCvActive(uint _index) constant returns (bool) {
        return (map_cvs[_index]._active);
    }
    
}
