#!/bin/bash

service docker stop > /dev/null 2>&1
service wings stop > /dev/null 2>&1
service vrify stop > /dev/null 2>&1
service vrchad stop > /dev/null 2>&1

sleep 5

shutdown -r