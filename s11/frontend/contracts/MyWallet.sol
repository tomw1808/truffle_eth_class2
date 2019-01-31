pragma solidity ^0.5.0;

import "./mortal.sol";

contract MyWallet is mortal {
    event receivedFunds(address _from, uint256 _amount);
    event proposalReceived(address indexed _from, address indexed _to, string _reason);
    event sendMoneyPlain(address _from, address _to);
    struct Proposal {
        address _from;
        address payable _to;
        uint256 _value;
        string _reason;
        bool sent;
    }
    
    uint proposal_counter;
    
    mapping(uint => Proposal) m_proposals;

    function spendMoneyOn(address payable _to, uint256 _value, string memory _reason) public returns (uint256) {
        if(owner == msg.sender) {
            require(_to.send(_value));
            emit sendMoneyPlain(msg.sender, _to);
        } else {
            proposal_counter++;
            m_proposals[proposal_counter] = Proposal(msg.sender, _to, _value, _reason, false);
            emit proposalReceived(msg.sender, _to, _reason);
            return proposal_counter;
        }
    }
    
    function confirmProposal(uint proposal_id) public onlyowner returns (bool) {
        Proposal memory proposal = m_proposals[proposal_id];
        if(proposal._from != address(0)) {
            if(proposal.sent != true) {
                proposal.sent = true;
                if(proposal._to.send(proposal._value)) {
                    return true;
                }
                proposal.sent = false;
                return false;
            }
        }
    }
    
   function() external payable {
       if(msg.value > 0) {
           emit receivedFunds(msg.sender, msg.value);
       }
   }
}