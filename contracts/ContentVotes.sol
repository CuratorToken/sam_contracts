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
    Content[100] public topContent;
    EnumberableSet public allContentIds;
    uint private nextContentIndex = 0;

    constructor(address _voteAccountant){
        voteAccountant = IVotesAccountant(_voteAccountant);
    }

    // function insertTopContent(Content storage _content) private {
        
    // }
    function getTopN(uint memory _n) external view {
        //sort the set
        Content[] memory sortedContent = new Content[_n];

        initializes
        for (uint i = 0; i < allContentIds.length(); i+=1) {  //for loop example
            // uint j =0;
            // while (j<_n && votes[allContentIds.at(j)].totalVotes < sortedContent[j].totalVotes){
            //     j
            // }
            sortedContent[i] = votes[allContentIds.at(i)];      
        }

        

        // for each item in set, insert content

        return sortedContent[0:_n];

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
