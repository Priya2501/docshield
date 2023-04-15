//SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.6.0;

contract DStorage {
  string public name = 'DStorage'; // Name
  uint public fileCount = 0; // Number of files
  mapping(uint => File) public files; // Mapping fileId=>Struct 
  
  struct File {
    uint fileId;
    string fileHash;
    uint fileSize;
    string fileType;
    string fileName;
    string fileDescription;
    uint uploadTime;
    address payable uploader;
  } //struct File

  event FileUploaded(
    uint fileId,
    string fileHash,
    uint fileSize,
    string fileType,
    string fileName, 
    string fileDescription,
    uint uploadTime,
    address payable uploader
  ); //declare event

  constructor() public{
  }

  function uploadFile(string memory _fileHash, uint _fileSize, string memory _fileType, string memory _fileName, string memory _fileDescription) public {

    // Make sure the file hash exists
    require(bytes(_fileHash).length > 0);

    // Make sure file type exists
    require(bytes(_fileType).length > 0);

    // Make sure file description exists
    require(bytes(_fileDescription).length > 0);

    // Make sure file fileName exists
    require(bytes(_fileName).length > 0);

    // Make sure uploader address exists
    require(msg.sender!=address(0));

    // Make sure file size is more than 0
    require(_fileSize>0);

    // Increment file id
    fileCount ++;

    //add file to the contract
    files[fileCount] = File(fileCount, _fileHash, _fileSize, _fileType, _fileName, _fileDescription, block.timestamp, payable(msg.sender));

    //trigger event of fileuploaded
    emit FileUploaded(fileCount, _fileHash, _fileSize, _fileType, _fileName, _fileDescription, block.timestamp, payable(msg.sender));
  }
} //upload file function