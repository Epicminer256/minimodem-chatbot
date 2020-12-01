#!/bin/bash


# these define the commands
command1="!help"
command2="!man"
command3="!google"
command4="!clear"

# these define the actions that 
# happen when the command is typed

# also command1act is layed out 
# the way it is so you can add your 
# own commands

command1act="echo \
$command1 \
$command2 \
$command3 \
$command4 \
"
command2act="man minimodem"
command3act="w3m google.com"
command4act="clear"



# The channel and rate select menu
echo pick channel from 1 to 8
read chchannel
let channel1=$chchannel*200+400
let channel2=$chchannel*200+400+100

echo Rate of speed
echo recommended is 140
read ratespeed

# clears the screen
clear

# Everything below this is one big loop
#
# When it hears something, it will store
# what it heard into a value and say it 
# heard something, then afterwards it
# does if statements to see if what was said
# is a command. If it is, execute the function

while true; do

# stores what was being said into a value
# called test

    test=$(minimodem --quiet --sync-byte=0xAB --mark $channel1 --space $channel2 --stopbits 2.5 --ascii --rx --rx-one $ratespeed)
# after minimodem hears a message, this 
# script will execute the next line of 
# commands below it


# Just says to the console that it heard something
    echo Heard something
    
# Everything below this is a if statement
# Adding your own command should only take
# a copy and paste of a if statement, followed with
# changing and defining some values

	if [ "$test" = "$command1" ]; then
        sleep 0.5
        echo Sending $test message...
        $command1act | minimodem --quiet --sync-byte=0xAB --mark $channel1 --space $channel2 --stopbits 2.5 --ascii --tx $ratespeed
    fi
    
	if [ "$test" = "$command2" ]; then
        sleep 0.5
        echo Sending $test message...
        $command2act | minimodem --quiet --sync-byte=0xAB --mark $channel1 --space $channel2 --stopbits 2.5 --ascii --tx $ratespeed
    fi
    
	if [ "$test" = "$command3" ]; then
        sleep 0.5
        echo Sending $test message...
        $command3act | minimodem --quiet --sync-byte=0xAB --mark $channel1 --space $channel2 --stopbits 2.5 --ascii --tx $ratespeed
    fi
    
	if [ "$test" = "$command4" ]; then
        sleep 0.5
        echo Sending $test message...
        $command4act | minimodem --quiet --sync-byte=0xAB --mark $channel1 --space $channel2 --stopbits 2.5 --ascii --tx $ratespeed
    fi
    
    # this sleep statement is for slowing 
    # the rate that it would repeat the listen
    # command 
    sleep 0.1
    
    # Now this script loops back to
    # listening for a message
done
