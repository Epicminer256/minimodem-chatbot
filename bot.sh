#!/bin/bash
command1="!help"
command2="!man"
command3="!google"
command4="!clear"

command1act="echo there is not one at the moment"
command2act="man minimodem"
command3act="w3m google.com"
command4act="clear"

echo pick channel from 1 to 6
read chchannel
let channel1=$chchannel*1000
let channel2=$chchannel*1000+300

echo Rate of speed
echo recommended is 140
read ratespeed

clear
while true; do
    test=$(minimodem --quiet --mark $channel1 --space $channel2 --stopbits 2.5 --ascii --rx --rx-one $ratespeed)
    echo Heard something
	if [ "$test" = "$command1" ]; then
        sleep 0.5
        echo Sending $test message...
        $command1act | minimodem --quiet --mark $channel1 --space $channel2 --stopbits 2.5 --ascii --tx $ratespeed
    fi
    
	if [ "$test" = "$command2" ]; then
        sleep 0.5
        echo Sending $test message...
        $command2act | minimodem --quiet --mark $channel1 --space $channel2 --stopbits 2.5 --ascii --tx $ratespeed
    fi
    
	if [ "$test" = "$command3" ]; then
        sleep 0.5
        echo Sending $test message...
        $command3act | minimodem --quiet --mark $channel1 --space $channel2 --stopbits 2.5 --ascii --tx $ratespeed
    fi
    
	if [ "$test" = "$command4" ]; then
        sleep 0.5
        echo Sending $test message...
        $command4act | minimodem --quiet --mark $channel1 --space $channel2 --stopbits 2.5 --ascii --tx $ratespeed
    fi
    sleep 0.1
done
