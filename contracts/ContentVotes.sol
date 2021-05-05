// SPDX-License-Identifier: MIT
pragma solidity >0.6.0 <0.8.0;

import "./IVotesAccountant.sol";

struct Caption {
    string captionId;
    uint votes;
}

struct Content {
    uint totalVotes;
    Caption[] captions;
}

contract ContentVotes {
    mapping (string => Content) votes;
    IVotesAccountant public voteAccountant;
    uint private nextContentIndex = 0;

    constructor(address _voteAccountant){
        voteAccountant = IVotesAccountant(_voteAccountant);
    }

    function vote(string calldata _contentId, uint _amount, bool _withCaption, uint _captionIndex) external {
        voteAccountant.spendVotes(msg.sender, _amount);
        Content storage content = votes[_contentId];
        content.totalVotes += _amount;
        if (_withCaption) {
            content.captions[_captionIndex].votes += _amount;
        }
        // insertTopContent(content);
    }

    function proposeCaption(string calldata _contentId, string calldata _captionId) external {
        Content storage content = votes[_contentId];
        Caption memory caption = Caption(_captionId, 0);
        content.captions.push(caption);
    }
}
