# 🔐 A collection of CTF challenges

## 📌 Table of Contents

- [⛳️ List of CTFs](#⛳️-list-of-ctfs)  
  1. [QuillCTF](#quillctf)
- [🛠️ Usage](#🛠️-usage)

## ⛳️ List of CTFs

### 1. QuillCTF

<https://quillctf.super.site/challenges>

| N° | Contract                                  | Exploit                                                    | Topic                                                                                                                                |
|----|-------------------------------------------|------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------|
| 01 | [RoadClosed](src/QuillCTF/RoadClosed.sol) | [RoadClosedExploit](test/QuillCTF/RoadClosedExploit.t.sol) | - Use of `extcodesize` to check if an address is an EOA<br>- Lack of access control for some critical methods (e.g `addToWhitelist`) |
| 02 | [Confidential](src/QuillCTF/Confidential.sol) | [ConfidentialExploit](test/QuillCTF/ConfidentialExploit.t.sol) | - Read private variables from storage

## 🛠️ Usage

<p align="center">
  <img src="doc/cmd-make.svg"  width="1000">
  <img src="doc/cmd-make-exploit.svg"  width="1000">
  <img src="doc/cmd-make-exploit-with-options.svg"  width="1000">
</p>
