#!/bin/bash

# Docker
service docker status | grep 'active (running)' > /dev/null 2>&1
if [ $? != 0 ]
then
    sudo service docker restart > /dev/null
fi

# Wings
service wings status | grep 'active (running)' > /dev/null 2>&1
if [ $? != 0 ]
then
    sudo service wings restart > /dev/null
fi

# Caddy
service caddy status | grep 'active (running)' > /dev/null 2>&1
if [ $? != 0 ]
then
    sudo service caddy restart > /dev/null
fi

# OpenVPN
service openvpn status | grep 'active (running)' > /dev/null 2>&1
if [ $? != 0 ]
then
    sudo service openvpn restart > /dev/null
fi

# VRify
service vrify status | grep 'active (running)' > /dev/null 2>&1
if [ $? != 0 ]
then
    sudo service vrify restart > /dev/null
fi

# VRChad
service vrchad status | grep 'active (running)' > /dev/null 2>&1
if [ $? != 0 ]
then
    sudo service vrchad restart > /dev/null
fi