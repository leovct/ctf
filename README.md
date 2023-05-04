# 🔐 A collection of CTF challenges

## QuillCTF

https://quillctf.super.site/challenges

| N° | Contract                                      | Exploit                                                        | Topic                                                                                                                                |
|----|-----------------------------------------------|----------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------|
| 01 | [RoadClosed](src/QuillCTF/RoadClosed.sol)     | [RoadClosedExploit](test/QuillCTF/RoadClosedExploit.t.sol)     | - Use of `extcodesize` to check if an address is an EOA<br>- Lack of access control for some critical methods (e.g `addToWhitelist`) |
| 02 | [Confidential](src/QuillCTF/Confidential.sol) | [ConfidentialExploit](test/QuillCTF/ConfidentialExploit.t.sol) | - Read private variables from storage                                                                                                |
