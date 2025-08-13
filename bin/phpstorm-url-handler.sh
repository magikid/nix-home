#!/usr/bin/env osh

# PhpStorm URL Handler
# phpstorm://open?url=file://@file&line=@line
# phpstorm://open?file=@file&line=@line
#
# @license GPL
# @author Stefan Auditor <stefan.auditor@erdfisch.de>

function urldecode() { : "${*//+/ }"; echo -e "${_//%/\\x}"; }

arg=${1}
pattern=".*file(:\/\/|\=)(.*)&line=(.*)"

# Get the file path.
raw_file=$(echo "${arg}" | sed -r "s/${pattern}/\2/")
file=$(urldecode "$raw_file")

# Get the line number.
line=$(echo "${arg}" | sed -r "s/${pattern}/\3/")

# Check if phpstorm|pstorm command exist.
if type phpstorm > /dev/null; then
    /usr/bin/env phpstorm --line "${line}" "${file}"
elif type pstorm > /dev/null; then
    /usr/bin/env pstorm --line "${line}" "${file}"
fi
