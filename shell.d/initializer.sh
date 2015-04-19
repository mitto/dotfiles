#!/bin/bash

PATH=$HOME/.rbenv/bin:$HOME/bin:/usr/local/bin:/usr/local/sbin:$PATH

if [ -e $HOME/.rbenv ]; then
  eval "$(rbenv init -)"
fi

export PATH
