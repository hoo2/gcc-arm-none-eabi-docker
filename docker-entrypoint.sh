#!/usr/bin/env bash

#
# entry point for gcc-arm-none-eabi container
# 
# Copyright (C) 2021 Christos Choutouridis <hoo2@hoo2.net>
#
# This program is distributed under the MIT licence
# You should have received a copy of the MIT licence along with this program.
# If not, see <https://www.mit.edu/~amini/LICENSE.md>.

set -Eeuo pipefail

# first arg is `-f` or `--some-option` or there are no args
if [ "$#" -eq 0 ] || [ "${1#-}" != "$1" ]; then
	# docker run gcc-arm-none-eabi -c 'echo hi'
	exec bash "$@"
fi

exec "$@"
