// SPDX-License-Identifier: MIT
pragma solidity >0.6.0 <0.8.0;

interface IVotesAccountant {
    function getVotes(address account) external view returns (uint256);

    function spendVotes(address account, uint256 votes) external;

    function grantVotes(address account, uint256 votes) external;
}
