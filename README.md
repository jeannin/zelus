# Method for Automated Refinement-type Verification of Lustre (MARVeLus)

MARVeLus extends the Zélus programming language (https://zelus.di.ens.fr/) with support for refinement types. 

This code demonstration contains the source code for Zélus and the additional MARVeLus files.

The MARVeLus contribution to the project can be found on the following paths:

- ./test/marvelus                  : unit tests for the refinement type checker
- ./compiler/verif/z3refinement.ml : source code for the refinement type checker
- ./examples/marvelus              : folder with programs tested and verified
- ./examples/rob_lcm_sim           : folder with test examples for the robot drivers

The following files were modified from the original Zélus repository to allow for MARVeLus integration

- ./compiler/parsing/zparser.mly
- ./compiler/parsing/zlexer.mll
- ./compiler/parsing/zparsetree.ml
- ./compiler/main/compiler.ml

## Installing MARVeLus

To build and install MARVeLus the computer requires [Opam](https://opam.ocaml.org/), the OCaml package manager.

### Download Dependencies
MARVeLus requires a few dependencies to run properly, which can be downloaded using:

```
opam install -y graphics ocamlfind menhir z3
```

### Update environment
To make sure the opam environment is updated with the installations run:

```
eval $(opem env)
```

### Build and Install MARVeLus
After redirecting to the project path `/marvelus` run the following commands:

```
./configure
dune build @install
dune install
```

### Testing MARVeLus

A suit of simple test cases was writte in `marvelus/test/marvelus`. 

`refinement_variable_test.zls`: contains unit tests for variables with refinement types

`refinement_function_test.zls`: contains unit tests for functions with refinement types

Each test has a brief descrption of the feature being tested and the expected outcome.

To run the tests:
`
zeluc -verify -ref_v -s main test_filename.zls
`

The `-verify` flag tells the Zelus compiler to run the MARVeLus refinement type checker. `-ref_v` enables the debug message mode for MARVeLus and can be omitted. `-s` is a Zelus native flag required for compilation.