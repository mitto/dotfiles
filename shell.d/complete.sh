#!/bin/sh

if [ -f /usr/bin/aws ]; then
  complete -C aws_completer aws
fi
