// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './ERC721.sol';
import './interfaces/IERC721Enumerable.sol';


contract ERC721Enumerable is IERC721Enumerable, ERC721 {

  uint256[] private _allTokens;


  mapping(uint256 => uint256) private _allTokensIndex;

  mapping(address => uint256[]) private _ownedTokens;

  mapping(uint256 => uint256) private  _ownedTokensIndex;

  //function tokenByIndex(uint256 _index) external view returns (uint256) {}

  //function tokenOfOwnerByIndex(address _owner, uint256 _index) external view returns (uint256) {}

  constructor() {
    _registerInterface(bytes4(
      keccak256('balanceOf(bytes4)')^
      keccak256('ownerOf(bytes4)')^
      keccak256('balanceOf(bytes4)')^
      keccak256('transferFrom(bytes4)')
    ));
  }

  function _mint(address to, uint256 tokenId) internal override(ERC721) {
    super._mint(to, tokenId);
    _addTokensToAllTokenEnumeration(tokenId);
    _addTokensToOwnerEnumeration(to, tokenId);
  }

  function _addTokensToAllTokenEnumeration(uint256 tokenId) private {
    _allTokensIndex[tokenId] = _allTokens.length;
    _allTokens.push(tokenId);
  }

  function _addTokensToOwnerEnumeration(address to, uint256 tokenId) private {
    _ownedTokensIndex[tokenId] = _ownedTokens[to].length;
    _ownedTokens[to].push(tokenId);
  }

  function tokenByIndex(uint256 index) public override view returns(uint256) {
    require(index < totalSupply(), 'global index is out of bounds!');
    return _allTokens[index];
  }

  function tokenOfOwnerByIndex(address owner, uint index) public override view returns(uint256) {
    require(index < balanceOf(owner), 'owner index is out of bounds!');
    return _ownedTokens[owner][index];
  }

  function totalSupply() public override view returns(uint256) {
    return _allTokens.length;
  }
}