#!/bin/bash

PATH=$HOME/.rbenv/bin:$HOME/bin:$PATH:/usr/local/bin:/usr/local/sbin

if [ -e $HOME/.rbenv ]; then
  eval "$(rbenv init -)"
fi

export PATH
