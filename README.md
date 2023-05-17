# 🔐 A collection of CTF challenges

## 📌 Table of Contents

- [⛳️ List of CTFs](#%EF%B8%8F-list-of-ctfs)  
  1. [QuillCTF](#1-quillctf)
- [🛠️ Usage](#%EF%B8%8F-usage)

## ⛳️ List of CTFs

### 1. QuillCTF

<https://academy.quillaudits.com/challenges>

| N° | Contract                                  | Exploit                                                    | Report | Topic                                                                                                                                |
|----|-------------------------------------------|------------------------------------------------------------|--------|--------------------------------------------------------------------------------------------------------------------------------------|
| 01 | [RoadClosed](src/QuillCTF/RoadClosed.sol) | [RoadClosedExploit](test/QuillCTF/RoadClosedExploit.t.sol) |        | - Use of `extcodesize` to check if an address is an EOA<br>- Lack of access control for some critical methods (e.g `addToWhitelist`) |
| 02 | [Confidential](src/QuillCTF/Confidential.sol) | [ConfidentialExploit](test/QuillCTF/ConfidentialExploit.t.sol) | | - Read private variables from storage
| 03 | [VIPBank](src/QuillCTF/VIPBank.sol) | [VIPBankExploit](test/QuillCTF/VIPBankExploit.t.sol) | | - Wrong check of parameter to prevent users from withdrawing too many ethers at a time which leads to funds locked forever in the contract.
| 04 | [SafeNFT](src/QuillCTF/SafeNFT.sol) | [SafeNFTExploit](test/QuillCTF/SafeNFTExploit.t.sol) | | - OpenZeppelin's ERC721 implementation of `safeMint` is not safe and performs an external call to the receiver address.
| 20 | [VoteToken](src/QuillCTF/VoteToken.sol) | [VoteTokenExploit](test/QuillCTF/VoteTokenExploit.t.sol) | [VoteTokenReport](reports/QuillCTF/VoteToken.md) | - The contract doesn't update its state when users transfer tokens
| 21 | [PrivateClub](src/QuillCTF/PrivateClub.sol) | [PrivateClubExploit](test/QuillCTF/PrivateClubExploit.t.sol) | [PrivateClubReport](reports/QuillCTF/PrivateClub.md) | - Not enough check of the parameters (e.g. `becomeMember`)<br>- Too much power given to the contract owner

## 🛠️ Usage

```bash
$ make
Usage:
  make <target>

Help
  help             Display this help.

Build
  build            Build the contracts

Exploit
  exploit          Run exploits. Set CONTRACT to only run the exploit of a specific contract and DEBUG to true to show traces: `make exploit CONTRACT=RoadClosed DEBUG=true`.

Lint
  install          Install npm dependencies.
  lint             Lint Solidity code and `README.md`.
```
