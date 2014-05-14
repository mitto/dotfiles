#!/bin/bash

exec ssh -o IdentityFile="~/.ssh/id_rsa.github" "$@"
