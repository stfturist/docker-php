#!/bin/bash

# Retries a command on failure.
# $1 - the max number of attempts
# $2... - the command to run
max_attempts="$1"; shift
cmd="$@"
attempt_num=1

until $cmd
    do
        if (( attempt_num == max_attempts ))
        then
            echo "Attempt $attempt_num failed and there are no more attempts left!"
            exit
    else
        echo "Attempt $attempt_num failed! Trying again in $attempt_num seconds..."
        sleep $(( attempt_num++ ))
    fi
done
