#!/bin/bash
cmd_output=$(ibus engine 2>&1)

if [ "$cmd_output" == "Unikey" ]; then
	echo "VN"
else
	echo "EN"
fi
