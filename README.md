![Lint workflow status](https://img.shields.io/github/actions/workflow/status/leovct/puzzl3s/lint.yml?branch=main&label=ci-lint)
![Exploit workflow status](https://img.shields.io/github/actions/workflow/status/leovct/puzzl3s/exploit.yml?branch=main&label=ci-exploit)

## What is Puzzl3s?

Puzzl3s 🧩 is an engaging collection of web3-based puzzles and Capture The Flag (CTF) challenges. While I didn't create the CTFs themselves, this repository showcases my solutions and serves as a comprehensive resource for other developers and security enthusiasts.

## Challenges

The following challenges have been solved:

- [QuillCTF](doc/QuillCTF.md)

## Build and Exploit

First, make sure [Foundry](https://book.getfoundry.sh/getting-started/installation) is installed. We're going to use [Forge](https://book.getfoundry.sh/forge/), an Ethereum testing framework, to build the contracts and run the exploits.

In order to build and run the exploits, first clone the Github repository:

```sh
git clone https://github.com/leovct/puzzl3s
cd puzzl3s
```

In order to build the contracts, you can run the following command:

```sh
make build
```

In order to run all the exploits, you can use:

```sh
make exploit
```

Note that you can run the exploit of a specific contract using `CONTRACT=<CONTRACT_NAME>` and you can show traces using `DEBUG=TRUE`. Here's an example:

```sh
make exploit CONTRACT=<CONTRACT_NAME> DEBUG=TRUE
```

To discover all the possible commands, you can type:

```sh
make
```
