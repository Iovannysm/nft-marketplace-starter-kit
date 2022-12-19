// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './ERC165.sol';
import './interfaces/IERC721.sol';

contract ERC721 is ERC165, IERC721 {

  //Mapping from the token Id to the owner
  mapping(uint256 => address) private _tokenOwner;

  //Mapping from onwer to the number of owned tokens
  mapping(address => uint256) private _OwnedTokenCount;

  //Mapping from token id to aprove addresses 
  mapping(uint256 => address) private  _tokenApprovals;



    /// @notice Count all NFTs assigned to an owner
    /// @dev NFTs assigned to the zero address are considered invalid, and this
    ///  function throws for queries about the zero address.
    /// @param _owner An address for whom to query the balance
    /// @return The number of NFTs owned by `_owner`, possibly zero
  function balanceOf(address _owner) public override view returns(uint256){
    require(_owner != address(0), 'owner query for non-existent token');
    return _OwnedTokenCount[_owner];
  }
    /// @notice Find the owner of an NFT
    /// @dev NFTs assigned to zero address are considered invalid, and queries
    ///  about them do throw.
    /// @param _tokenId The identifier for an NFT
    /// @return The address of the owner of the NFT
  function ownerOf(uint256 _tokenId) public override view returns(address){
    address owner = _tokenOwner[_tokenId];
    require(owner != address(0), 'owner query for non-existent token');
    return owner;
  }

  function _exist(uint256 tokenId) internal view returns(bool){
    // setting the address of nft owner to check the mapping
    // of the address from tokenOwner at the tokenId 
    address owner = _tokenOwner[tokenId];
    // return truthiness that the address is not zero 
    return owner != address(0);
  }

  function _mint(address to, uint256 tokenId) internal virtual {
    // requires that the addres isn't zero
    require(to != address(0), 'ERC721: minting to the zero address');
    // requires thay the token doesn not already exist
    require(!_exist(tokenId), 'ERC721: token already minted');
    // we are addding a new address with a token Id for minting 
    _tokenOwner[tokenId] = to;
    // keeping track of each address that is minting and adding one  
    _OwnedTokenCount[to] += 1;

    emit Transfer(address(0), to, tokenId);
  }

    /// @notice Transfer ownership of an NFT 
    /// @dev Throws unless `msg.sender` is the current owner, an authorized
    ///  operator, or the approved address for this NFT. Throws if `_from` is
    ///  not the current owner. Throws if `_to` is the zero address. Throws if
    ///  `_tokenId` is not a valid NFT.
    /// @param _from The current owner of the NFT
    /// @param _to The new owner
    /// @param _tokenId The NFT to transfer
    function _transferFrom(address _from, address _to, uint256 _tokenId) internal {
      require(_to != address(0), 'Error - ERC721 Transfer to the zero adddres');
      require(ownerOf(_tokenId) == _from, 'Trying to transfer a token the address deos not own!');
      _OwnedTokenCount[_from] -= 1;
      _OwnedTokenCount[_to] += 1;
      _tokenOwner[_tokenId] = _to;

      emit Transfer(_from, _to, _tokenId);
    }

    function transferFrom(address _from, address _to, uint256 _tokenId) override public {
      _transferFrom(_from, _to, _tokenId);

    }

}