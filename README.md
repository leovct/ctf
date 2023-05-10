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
| 20 | [VoteToken](src/QuillCTF/VoteToken.sol) | [VoteTokenExploit](test/QuillCTF/VoteTokenExploit.t.sol) | [VoteTokenReport](reports/QuillCTF/VoteToken.md) | - The contract doesn't update its state when users transfer tokens
| 21 | [PrivateClub](src/QuillCTF/PrivateClub.sol) | [PrivateClubExploit](test/QuillCTF/PrivateClubExploit.t.sol) | [PrivateClubReport](reports/QuillCTF/PrivateClub.md) | - Not enough check of the parameters (e.g. `becomeMember`)<br>- Too much power given to the contract owner

## 🛠️ Usage

<p align="center">
  <img src="doc/cmd-make.svg"  width="1000">
  <img src="doc/cmd-make-exploit.svg"  width="1000">
  <img src="doc/cmd-make-exploit-with-options.svg"  width="1000">
</p>
