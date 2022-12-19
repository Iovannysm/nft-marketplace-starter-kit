// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './ERC721.sol';
import './interfaces/IERC721Enumerable.sol';

contract ERC721Enumerable is IERC721Enumerable, ERC721 {

    uint256[] private _allTokens;

    // mapping from tokenId to position in _allTokens array
    mapping(uint256 => uint256) private _allTokensIndex;  
    
    // mapping of owner to list of all owner tokens ids
    mapping(address => uint256[]) private _ownedTokens;

    //mapping from token ID index of the owner token list
    mapping(uint256 => uint256) private _ownedTokenIndex;


    constructor() {
      _registerInterface(bytes4(keccak256('totalSupply(bytes4)')^ keccak256('tokenByIndex(bytes4)')^keccak256('tokenOfOwnerByIndex(bytes4)')));
    }

    

    function _mint(address to, uint256 tokenId) internal override(ERC721) {
      super._mint(to, tokenId);
      //add tokens to the owners
      //add tokens to the total supply- to allTokens.
      _addTokensToAllTokenEnumeration(tokenId);
      _addTokensToOwnerEnumration(to, tokenId);
    }
    // add tokens to the _allTokens array and set the position of the tokens 
    function _addTokensToAllTokenEnumeration(uint256 tokenId) private {
      _allTokensIndex[tokenId] = _allTokens.length;
      _allTokens.push(tokenId);
    }


    function _addTokensToOwnerEnumration(address to, uint256 tokenId) private {
      // add address and tokenId to the _ownenToken 
      // _ownedTokenIndex  tokenId set to address of ownedTokens position
      // we want to execute thsi fucntion with minting 
      _ownedTokenIndex[tokenId] = _ownedTokens[to].length;
      _ownedTokens[to].push(tokenId);
    }

    function tokenByIndex(uint256 index) public override view returns(uint256){
      require(index < totalSupply(), 'global index is out of bounds! ');
      return _allTokens[index];
    }

    function tokenOfOwnerByIndex(address owner, uint256 index) public override view returns(uint256){
      require(index < balanceOf(owner), 'owner index out of bounds!');
      return _ownedTokens[owner][index];
    }
    // Return the total supply of the _allToken array 
    function totalSupply() public override view returns(uint256){
      return _allTokens.length;
    }

}