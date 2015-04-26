#!/bin/sh

# for awscli
AWS_COMMAND_PATH=$(which aws)
if [ $? -eq 0 ]; then
  [ $(basename $SHELL) = 'bash' ] && complete -C aws_completer aws
fi
