pragma solidity ^0.4.15;

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

contract MyWallet is mortal {
    event receivedFunds(address _from, uint256 _amount);
    event proposalReceived(address indexed _from, address indexed _to, string _reason);

    struct Proposal {
    address _from;
    address _to;
    uint256 _value;
    string _reason;
    bool sent;
    }

    uint proposal_counter;

    mapping(uint => Proposal) m_proposals;

    function spendMoneyOn(address _to, uint256 _value, string _reason) public returns (uint256) {
        if(owner == msg.sender) {
            /**
             * Update From Solidtiy 0.4.13, where .transfer was introduced!
             * Checkout https://vomtom.at/exception-handling-in-solidity/
             * .send() as shown in the video is depricated.
             **/
            _to.transfer(_value);
        } else {
            proposal_counter++;
            m_proposals[proposal_counter] = Proposal(msg.sender, _to, _value, _reason, false);
            proposalReceived(msg.sender, _to, _reason);
            return proposal_counter;
        }
    }

    function confirmProposal(uint proposal_id) public onlyowner returns (bool) {
        if(m_proposals[proposal_id]._from != address(0)) {
            if(m_proposals[proposal_id].sent != true) {
                m_proposals[proposal_id].sent = true;
                m_proposals[proposal_id]._to.transfer(m_proposals[proposal_id]._value);
                return true;
            }
        }
        return false;
    }

    function() payable public {
        if(msg.value > 0) {
            receivedFunds(msg.sender, msg.value);
        }
    }
}