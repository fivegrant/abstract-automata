#!/usr/bin/env bash

# Build the projects cabal file
nix-shell --pure -p cabal2nix --run "cabal2nix ." > abstract-automata.nix

