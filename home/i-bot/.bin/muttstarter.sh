#!/bin/bash

function syncaccount {
    while :
    do
        mbsync -qqa $1
        sleep 30
    done

}

syncaccount &
mutt
